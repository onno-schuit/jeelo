<?php

error_reporting(E_ALL);
ini_set('display_errors','On');
set_time_limit(0);

class client_updater extends client {

    function __construct($csv_line) {
		
        $this->csv_line = $csv_line;
        $this->target_folder = '/home/jeelos';
        $this->tmp_updater_folder = "{$this->target_folder}/{$this->csv_line->domain}/moodle_data/temp/updater";
        
        // Set variables for csv files
        $this->fields_users = array(
                'firstname'=>'voornaam',
                'lastname'=>'achternaam',
                'email'=>'email',
                'city'=>'woonplaats',
                'country'=>'land',
                'rol1'=>'rol1',
                'rol2'=>'rol2',
                'group1'=>'groep1',
                'group2'=>'groep2',
                'group3'=>'groep3'
            );
        $this->fields_groups = array('name'=>'naam', 'year'=>'jaar');
        // Possible group combinations
        $this->possible_groups = array(array('1', '2'), array('3', '4'), array('5', '6'), array('7', '8'));
    }

    function start_updater() {
        self::log("Starting the update...");
        
        $this->backup_database();
        
        $this->update_sitewide_course();
        
		// Prepair for adding a new schoolyear
        $this->set_existing_categories_invisible();
        $this->extract_files();
        $this->update_all_users();

        // Update logo and navbar
        $this->add_layout();

		// Everything done, now we'll handle the projects, users and groups
		
        $this->create_projects();

        $this->add_sidewide_enrollment();
        
		// Finally, we finish with confirming the schoolyear has been created by sending an email
        $this->email_schoolyear_created();
    }
    
    
    function add_layout() {
		if (!empty($this->layout->navbar)) $this->set_navbar_color();
        if (!empty($this->layout->logo)) $this->set_logo();
        $this->change_site_template();
        
        return true;
	}
	
	
	function set_logo() {
        $file = "{$this->target_folder}/{$this->csv_line->domain}/public_html/theme/children-education/pix/banner.jpg";
        if (file_exists($file)) unlink($file);

        return (cp($this->logo_filename, $file));
	}
	
	
	function set_navbar_color() {

        $file = "{$this->target_folder}/{$this->csv_line->domain}/public_html/theme/children-education/styles_layout.css";
        $handler = file($file);

        $str_search = "background:url(pix/navbar.png) top repeat-x;";
        $str_replace = "  background-color: {$this->navbar};\n";

        foreach($handler as $key=>$data) {
            if (trim($data) == $str_search) $handler[$key] = $str_replace;
        }

        return (file_put_contents($file, $handler));
	}
    
    
    /* Before we do anything we'll want to backup
     * the database. This is to be sure we can
     * revert changes if something goes wrong. */
    function backup_database() {
		self::log("Creating backup database");
		
		$cfg_clean = self::get_clean_config($this->csv_line);
		
		$target = self::$target_folder . "{$this->csv_line->domain}/moodle_data/launcher_dbs";
		if (!is_dir($target)) mkdir($target);
		
		$filename = $this->uniquify_filename($target, $this->csv_line->domain . "_" . date("Ymd"), '.sql.gz');
		
		$cmd = "mysqldump -h{$cfg_clean->dbhost} -u{$cfg_clean->dbuser} -p{$cfg_clean->dbpass} {$cfg_clean->dbname}| gzip -9 > $target/$filename.sql.gz";
		self::log($cmd);
		shell_exec($cmd);
	}

	/* In case we need to make sure a filename is
	 * unique we will run it through this loop. It
	 * returns the filename without increment if the
	 * filename is already unique. */
	function uniquify_filename($target, $file_base_name, $extension) {
		
		if (!file_exists($target . '/' . $file_base_name . $extension)) return $file_base_name;
		
		$count = 1;
		while(file_exists($filename = $target . '/' . $file_base_name . $count . $extension)) {
			$count ++;
		}

		return ($file_base_name . $count);
	}


    function create_projects() {
        global $CFG;
        
        $request = array(
            'request' => 'get_categories',
            'client_moodle_id' => $this->csv_line->id
        );
        $response = self::get_server_response($request);
        
        $csv = new csv();
        $categories = $csv->build_csv_object($response, 'client_categories');

        while($category = $csv->nextline()) { // Loop through categories

            $child_category_id = $this->create_category($category);
            echo "cat id: $child_category_id";
            $this->create_courses_and_groups($category->id, $child_category_id);
		}
        
        // $this->clean_buffer_db();

        return true;
    }
    
    function change_site_template() {
		$query = "UPDATE " . self::$prefix . "config SET value = 'children-education' WHERE name = 'theme'";
		return (self::remote_execute($this->csv_line, $query));
	}

    function clean_buffer_db() {
        $request = array(
            'request' => 'clean_buffer_db',
            'id' => $this->csv_line->id
        );
        
        $response = self::get_server_response($request);
        // check if we have file contents or maybe an error
        if (strstr($response, 'error')) {
            self::log($response);
            die();
        }

        return true;
    }

    function email_schoolyear_created() {
        $query = "SELECT * FROM ".self::$prefix."user WHERE username = 'admin'";
        $result = self::remote_execute($this->csv_line, $query);
        $user = mysql_fetch_object($result);

        $subject = "Jeelo Schooljaar toegevoegd";
        $body = "
            Hallo,<br /><br />
            Een nieuw schooljaar is zojuist succesvol aangemaakt. De gebruikers die in het aangeleverde gebruikersbestand staan zullen vanaf nu
            toegang hebben tot de nieuwe projecten.
            <br /><br />
            Met vriendelijke groet,<br /><br />
            Jeelo Launcher 1.9";

        return (self::mail_with_headers($user->email, $body, $subject));
    }

    function create_category($category) {

        $category->name = $category->name.' - '.date("m/Y"); // Add month and year to keep names unique

        $query = "INSERT INTO ". self::$prefix ."course_categories (
                    name, description, parent, sortorder, coursecount, visible, timemodified, depth, path, theme
                ) VALUES (
                    '{$category->name}',
                    '{$category->description}',
                    '{$category->parent}',
                    '{$category->sortorder}',
                    '{$category->coursecount}',
                    '{$category->visible}',
                    '{$category->timemodified}',
                    '{$category->depth}',
                    '{$category->path}',
                    '{$category->theme}'
                )";
        
        self::log("Creating course category and context");
        $category_id = self::remote_execute($this->csv_line, $query, true);
        $context_id = $this->get_or_create_context(40, $category_id); // Creates the context

        return $category_id;
    }

    function get_or_create_context($context_level, $instance_id) {
		// First create file
		if (!$context_file = $this->create_context_file($context_level, $instance_id)) return false;

		$get_or_create_context	= self::$target_folder . "{$this->csv_line->domain}/public_html/launcher_scripts/get_or_create_context.php";
		$context_settings_file		= self::$target_folder . "{$this->csv_line->domain}/moodle_data/$context_file";
		$cmd = "php -f $get_or_create_context $context_settings_file";

		self::log($cmd);
		if (!$context_id = shell_exec($cmd)) {
			self::log("Failed to create context lvl $context_level for instance $instance_id");
			die("Failed to create context lvl $context_level for instance $instance_id");
		}
		unlink($context_settings_file);
		
        return ($context_id == 'false') ? false : $context_id;
    }

    function create_context_file($context_level, $instance_id) {
		$target					= self::$target_folder . "{$this->csv_line->domain}/moodle_data";
		$context_filename		= "context_data_".time().".txt";
		$context_settings = new stdClass();

		$context_settings->context_level	= $context_level;
		$context_settings->instance_id		= $instance_id;
		$context_data						= serialize($context_settings);

		if (file_exists("$target/$context_filename")) unlink("$target/$context_filename");
		
		$handler = fopen("$target/$context_filename", "w");
		fwrite($handler, $context_data);
		fclose($handler);
		
		return $context_filename;
	}

    function create_courses_and_groups($parent_category_id, $child_category_id) {

        $handler = fopen("{$this->tmp_updater_folder}/csv/groups.csv", 'r');
        $line = 0;
        while($data = fgetcsv($handler, 0, ';')) {
            $line ++;
            if ($line == 1) continue;

            // Set variables
            $child_group = new stdClass();
            $child_group = $this->assign_column_names($data, 'fields_groups');
            $child_group->year = $this->groupyears_to_array($child_group->year);
			
			if (!$response = $this->get_courses_by_groupyear_and_category($parent_category_id, $child_group->year)) continue;
			$parent_courses = $this->build_course_objects($response);
            
            // Loop over courses
            foreach($parent_courses as $parent_course) {
                // Restore earlier backuped course
                $child_course_id = $this->restore_course($child_category_id, $child_group, $parent_course);
                // Create group
                $child_group_id = $this->create_group($child_course_id, $child_group);
                // Add users to groups
                $this->add_group_members($child_course_id, $child_group_id, $child_group->name);
            }
        }
        return true;
    }

    function get_courses_by_groupyear_and_category($category_id, $groupyears) {

        $request = array(
            'request' => 'get_courses',
            'groupyear' => $str_groupyears = implode($groupyears, '/'),
            'category_id' => $category_id,
            'client_moodle_id' => $this->csv_line->id
        );
        $response = self::get_server_response($request);
        
        return (!empty($response)) ? $response : false;
    }
    
    function build_course_objects($response) {
		$csv = new csv();
        $csv_courses = $csv->build_csv_object($response, 'client_courses');
        $parent_courses = array();

        while($csv_course = $csv->nextline()) {
            $parent_courses[] = $csv_course;
        }
        
        return $parent_courses;
	}

    function add_group_members($course_id, $group_id, $group_name) {
        
        $handler = fopen("{$this->tmp_updater_folder}/csv/users.csv", 'r');
        $line = 0;
        
        while($data = fgetcsv($handler, 0, ';')) {
            $line ++;
            if ($line == 1) continue;

            // Continue with the groups
            $csv_user = new stdClass();
            $csv_user = $this->assign_column_names($data, 'fields_users');

            // Assign userid to csv user record
            $db_user = self::remote_execute($this->csv_line, "SELECT * FROM ".self::$prefix."user WHERE username = '{$csv_user->email}'");
            $csv_user->userid = mysql_result($db_user, 0, 0);
            $csv_user->groups = array($csv_user->group1, $csv_user->group2, $csv_user->group3);
            
            // If user is not in the same group AND doesn't need to be
            // assigned to all courses we've got nothing to do
            if (!in_array($group_name, $csv_user->groups) && (!$this->needs_all_course_enrollments($csv_user->rol1))) continue;

            if (!$this->add_group_member($csv_user, $group_id)) return false;
            if (!$this->create_course_role_assignment($csv_user, $course_id)) return false;
        }
        return true;
    }


    function needs_all_course_enrollments($rol) {
        $global_roles = array('invalkracht', 'schoolleider');
        return (in_array($rol, $global_roles));
    }


    function add_sidewide_enrollment() {
        
        $handler = fopen("{$this->tmp_updater_folder}/csv/users.csv", 'r');
        $line = 0;
        while($data = fgetcsv($handler, 0, ';')) {
            $line ++;
            if ($line == 1) continue;

            // Continue with the groups
            $csv_user = new stdClass();
            $csv_user = $this->assign_column_names($data, 'fields_users');
            
            if ($csv_user->rol1 != 'beheerder') continue; // If not admin, continue

            // Assign values
            $user = self::remote_execute($this->csv_line, "SELECT * FROM ".self::$prefix."user WHERE username = '{$csv_user->email}'");
            $userid = mysql_result($user, 0, 0);
            $role = self::remote_execute($this->csv_line, "SELECT * FROM ".self::$prefix."role WHERE shortname = 'admin'");
            $roleid = mysql_result($user, 0, 0);
            $contextid = $this->get_or_create_context(10, 1);

			// Check if it already exists
			$query = "SELECT * FROM " . self::$prefix . "role_assignments WHERE roleid = '$roleid' AND userid = '$userid' AND contextid = '$contextid'";
			$result = self::remote_execute($this->csv_line, $query);
			if (mysql_num_rows($result) > 0) return true; // Enrollment already exists

            // Execute query
            $query = "INSERT INTO ".self::$prefix."role_assignments (
                            userid, roleid, contextid, timemodified, enrol
                        ) VALUES (
                            '$userid', '$roleid', '$contextid', '".time()."', 'manual'
                        )";
            if (!self::remote_execute($this->csv_line, $query)) return false;
        }
        return true;
    }


    function create_course_role_assignment($user, $course_id) {

        switch($user->rol1) {
            case 'leerling':
                $role_shortname = 'student';
                break;
            case 'leerkracht':
                $role_shortname = 'teacher';
                break;
            case 'invalkracht':
                $role_shortname = 'substitute';
                break;
            case 'schoolleider':
                $role_shortname = 'schoolleader';
                break;

            default:
                return true; // Return if role is something else, shouldn't happen though...
                break;
        }
        $context_id = $this->get_or_create_context(50, $course_id); // Creates the context

        $role = self::remote_execute($this->csv_line, "SELECT * FROM ".self::$prefix."role WHERE shortname = '$role_shortname'");

		// Check if it already exists
		$query = "SELECT * FROM " . self::$prefix . "role_assignments WHERE roleid = '" . mysql_result($role, 0, 0) . "' AND contextid = '$context_id' AND userid = '{$user->userid}'";
		$result = self::remote_execute($this->csv_line, $query);
		if (mysql_num_rows($result) > 0) return true; // Enrollment already exists

        $query = "INSERT INTO ".self::$prefix."role_assignments (
                    roleid, contextid, userid, timemodified, enrol
                ) VALUES (
                    '".mysql_result($role, 0, 0)."',
                    '$context_id',
                    '{$user->userid}',
                    '".time()."',
                    'manual'
                )";

        return (self::remote_execute($this->csv_line, $query));
    }


    function add_group_member($user, $group_id) {
        $query = "INSERT INTO ".self::$prefix."groups_members (
                        groupid, userid, timeadded
                    ) VALUES (
                        '$group_id', '{$user->userid}', '".time()."'
                    )";
        return (self::remote_execute($this->csv_line, $query));
    }

    function create_group($course_id, $group) {
        $query = "INSERT INTO ".self::$prefix."groups ( courseid, name ) VALUES ( '$course_id', '{$group->name}')";
        return (self::remote_execute($this->csv_line, $query, true));
    }


    function restore_course($category_id, $child_group, $parent_course) {

		$restore_file = $this->create_data_file_for_restore($category_id, $child_group, $parent_course);
		$new_course_id = $this->execute_course_restore($restore_file);

        return ($this->fix_category_id($new_course_id, $category_id)) ? $new_course_id : false;
    }

    function fix_category_id($course_id, $category_id) {
        $query = "UPDATE ".self::$prefix."course SET category = '$category_id' WHERE id = '$course_id'";
		self::log($query);
        return (self::remote_execute($this->csv_line, $query));
	}
    
	function execute_course_restore($backup_filename) {

		$target_restore_file	= self::$target_folder . "{$this->csv_line->domain}/public_html/class.restore_backup.php";
		$target_backup_file		= self::$target_folder . "{$this->csv_line->domain}/moodle_data/$backup_filename";

		$cmd = "php -f $target_restore_file $target_backup_file";
		self::log($cmd);
		if (!$course_id = shell_exec($cmd)) die("Failed to restore course");
		unlink($target_backup_file);
		
		self::log("Return of restore script: $course_id");
		
        return ($course_id == 'false') ? false : $course_id;
    }


    function create_data_file_for_restore($category_id, $child_group, $parent_course) {
		$course = new stdClass();
		$course->group_name		= $child_group->name;
		$course->category		= $category_id;
		$course->fullname		= $parent_course->course_fullname;
		$course->shortname		= $parent_course->course_shortname;
		$course->backup_name	= $parent_course->backup_name;
		$course_data			= serialize($course);
		
		$target					= self::$target_folder . "{$this->csv_line->domain}/moodle_data";
		$backup_filename		= "course_data_".time().".txt";
		
		if (file_exists("$target/$backup_filename")) unlink("$target/$backup_filename");
		
		$handler = fopen("$target/$backup_filename", "w");
		fwrite($handler, $course_data);
		fclose($handler);

        return $backup_filename;
    } // assemble_data_string_for_restore


    function extract_files() {
        if (is_dir($this->tmp_updater_folder)) shell_exec("rm -R {$this->tmp_updater_folder}");
        mkdir($this->tmp_updater_folder);

        $this->extract_course_files();
        $this->extract_csv_files();
    }



    function extract_course_files() {

        mkdir($this->tmp_updater_folder . '/courses');
        $cmd = sprintf("tar -xz -C %s -f %s", $this->tmp_updater_folder . '/courses', $this->csv_line->courses_filename);
        self::log($cmd);
        shell_exec($cmd);

        return true;
    }

    function extract_csv_files() {

        mkdir($this->tmp_updater_folder . '/csv');
        $cmd = sprintf("tar -xz -C %s -f %s", $this->tmp_updater_folder . '/csv', $this->csv_line->csv_filename);
        self::log($cmd);
        shell_exec($cmd);

        return true;
    }


    function groupyears_to_array($groupyear) {
        return array_filter(explode('/', $groupyear));
    } // function groupyear_to_array


    function set_existing_categories_invisible() {
        $error = false;

        $query = "UPDATE ".self::$prefix."course_categories SET visible='0' WHERE id != '1'";
        self::log($query);
        if (!self::remote_execute($this->csv_line, $query)) $error = true;

        $query = "UPDATE ".self::$prefix."course SET visible='0' WHERE category != '1'";
        self::log($query);
        if (!self::remote_execute($this->csv_line, $query)) $error = true;

        if ($error) {
            self::log("Failed to set the categories and courses invisible on client.");
            die();
        }
        return;
    }


    function assign_column_names($data, $fields_type) {
        $count = 0;

        $obj = new stdClass();
        foreach($this->$fields_type as $key => $column) { // Assign column names to $group
            $obj->$key = $data[$count];
            $count ++;
        }

        return $obj;
    }


    function update_all_users() {

        $query = "UPDATE ".self::$prefix."user SET deleted = 1 WHERE username != 'guest' && username != 'admin'";
        self::log($query);
        self::remote_execute($this->csv_line, $query); // Set all users deleted, we'll update them again later

        $handler = fopen("{$this->tmp_updater_folder}/csv/users.csv", 'r');
        $line = 0;
        while($data = fgetcsv($handler, 0, ';')) {
            $line ++;
            if ($line == 1) continue;

            $child_user = new stdClass();
            $child_user = $this->assign_column_names($data, 'fields_users');

            if (!$this->create_and_update_user($child_user)) die('Failed to edit users');
            unset($child_user);
        }
    }

    function create_user($user) {
        
        $query = "
            INSERT INTO ".self::$prefix."user (
                username, password, firstname, lastname, email, city, country, mnethostid, confirmed, deleted, timemodified
            ) VALUES (
                '{$user->email}',
                '".$this->hash_internal_user_password(strtolower($user->firstname))."',
                '{$user->firstname}',
                '{$user->lastname}',
                '{$user->email}',
                '{$user->city}',
                '{$user->country}',
                '1',
                '1',
                '1',
                '".time()."'
            )";

        self::log("Create new user {$user->email}");
        return (self::remote_execute($this->csv_line, $query));
    }

    function hash_internal_user_password($password) {
        $cfg_clean = self::get_clean_config($this->csv_line);

        if (isset($cfg_clean->passwordsaltmain)) {
            return md5($password.$cfg_clean->passwordsaltmain);
        } else {
            return md5($password);
        }
    }

    function update_user($result) {
    
        // Update user
        $existing_user = mysql_fetch_object($result);

        $query = "UPDATE ".self::$prefix."user SET deleted = 0 WHERE id = {$existing_user->id}";
        self::log("Update existing user {$existing_user->id}");
        return (self::remote_execute($this->csv_line, $query));
    }

    function create_and_update_user($user) {
        global $CFG;

        // Check if user exists
        $query = "SELECT * FROM ".self::$prefix."user WHERE username = '{$user->email}'";
        if (!$result = self::remote_execute($this->csv_line, $query)) return false;

        // If exists update the user, else create it
        return (mysql_num_rows($result) > 0) ? $this->update_user($result) : $this->create_user($user);
    }


    function update_sitewide_course() {

        $query = "SELECT * FROM ".self::$prefix."course WHERE category = 0";
        $result = self::remote_execute($this->csv_line, $query);
        $site_wide_course_id = mysql_result($result, 0, 0);

        $query = "
            UPDATE ".self::$prefix."course SET
                fullname = '{$this->csv_line->name}',
                shortname = '{$this->csv_line->short_code}'
            WHERE id = {$site_wide_course_id}";

        self::log("Update side-wide course.");

        return (self::remote_execute($this->csv_line, $query));
    } // function FunctionName

}

?>

