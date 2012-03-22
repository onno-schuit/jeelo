<?php

error_reporting(E_ALL);
ini_set('display_errors','On');

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
        
        /* include config.php
         * update course 1                                      ***DONE***
         * update all course categories, set them invisible     ***DONE***
         * extract csv tar                                      ***DONE***
         * insert / update / delete users                       ***DONE***
         * insert categories                                    ***DONE***
         * insert new courses & groups
         * Create enrollments
         */

        // Update course 1
        // self::update_sitewide_course();

        // Update all course categories
        // $this->set_existing_categories_invisible();
        // Extract all files to be used
        // $this->extract_files();

        // Update users
        // $this->update_all_users();
        $this->create_categories();
        exit('Done?');
        // Finally, add the side-wide enrollments (for admin users)
        // if (!$this->add_sidewide_enrollment()) error("Failed to create side-wide roles");
    }


    function create_categories() {
        global $CFG;
        
        /* Extract courses              ***DONE***
         * Create categories            ***DONE***
         * Create courses               ***DONE***
         * Create groups                ***DONE***
         * Create course enrollments    ***DONE***
         * Create side-wide enrollments
         */

        // Been there, done that...
        // $this->extract_course_files(); // Before we go through any loop we'll want to extract backup files

        $request = array(
            'request' => 'get_categories',
            'client_moodle_id' => $this->csv_line->id
        );
        $response = self::get_server_response($request);

        $csv = new csv();
        $categories = $csv->build_csv_object($response, 'client_categories');

        while($category = $csv->nextline()) { // Loop through categories

            // $child_category_id = $this->create_category($category);
            $child_category_id = 2; // For test purposes
            $this->create_courses_and_groups($category->id, $child_category_id);

            break; // For testing, don't wanne wait all the time
        }

        return true;
    }


    /* We probably wont need this script anymore
    function get_dir_contents($folder) {
        $files = array();
        $folder_handler = opendir($folder);

        while($file = readdir($folder_handler)) {
            $files[] = $file;
        }

        return $files;
    }
     */


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
        // $category_id = self::remote_execute($this->csv_line, $query, true);
        $category_id = 2;

        $context_id = $this->get_or_create_context(40, $category_id); // Creates the context

        return $category_id;
    }


    function get_or_create_context($context_level, $instance_id) {
        $target = self::$target_folder . $this->csv_line->domain;

        $data = array('context_level'=>$context_level, 'instance_id'=>$instance_id);
        $curl = curl_init($target . '/public_html/get_or_create_context.php');

        curl_setopt($curl,CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        $context_id = curl_exec($curl);
        curl_close ($curl);

        if ($context_id == 'false') die('Failed to create context for context level ' . $context_level . ' and instance id ' . $instance_id);

        return $context_id;
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

            $parent_courses = $this->get_courses_by_groupyear($parent_category_id, $child_group->year);

            // Loop over courses
            foreach($parent_courses as $parent_course) {

                // Restore earlier backuped course
                $child_course_id = $this->restore_course($child_category_id, $child_group, $parent_course);
                // Create group
                $child_group_id = $this->create_group($child_course_id, $child_group);
                // Add users to groups
                $this->add_group_members($child_course_id, $child_group_id, $child_group->name);
            }



            /*

                // If not set yet: create array from parent groupyears
                if (!is_array($parent_course->groupyear)) $parent_course->groupyear = $this->groupyears_to_array($parent_course->groupyear);

                // Possible groups: 1/2, 3/4, 5/6, 7/8
                foreach($this->possible_groups as $possible_group) {

                    // Possibly there are more years assigned to 1 group
                    foreach($child_group->year as $child_group_year) {
                        if (!in_array($child_group_year, $possible_group)) continue;
                        if (!in_array($child_group_year, $parent_course->groupyear)) continue;

                        // Restore earlier backuped course
                        if (!$child_course_id = $this->restore_course($category_id, $child_group, $parent_course)) error("Couldn't create course");
                        echo "<br />Restored course id $child_course_id<br />";
                        // $child_course_id = 12;
                        // Create group
                        if (!$child_group_id = $this->create_group($child_course_id, $child_group)) error("Couldn't create group.");
                        echo "<br />Created group id $child_group_id<br />";
                        // $child_group_id = 9;
                        // Add users to groups
                        if (!$this->add_group_members($child_course_id, $child_group_id, $child_group->name)) error("Couldn't add group members.");

                        // Everything went well, break to avoid copying the course another time
                        break;
                    }
                }
            */


        }
        return true;
    }

    function get_courses_by_groupyear($category_id, $groupyears) {

        $request = array(
            'request' => 'get_courses',
            'groupyear' => $str_groupyears = implode($groupyears, '/'),
            'category_id' => $category_id,
            'client_moodle_id' => $this->csv_line->id
        );
        $response = self::get_server_response($request);

        $csv = new csv();
        $csv_courses = $csv->build_csv_object($response, 'client_courses');
        $parent_courses = array();

        while($csv_course = $csv->nextline()) {
            $parent_courses[] = $csv_course;
        }

        return $parent_courses;
    }

    /*
    function get_courses_by_groupyea($category_id, $groupyears) {
        global $CFG;
        
        $courses_to_call = array();
        // Get all the groups in an array for a join
        foreach($groupyears as $groupyear) {
            foreach($this->possible_groups as $key=>$possible_group) {
                if (in_array($groupyear, $possible_group)) $courses_to_call[$key] = join('/', $possible_group); // $courses_to_call[$key] = $possible_group;
            }
        }

        $sql_extra = '';
        $count = 0;
        foreach($courses_to_call as $key => $course_to_call) {
            $count ++;
            $sql_extra .= "'$course_to_call'";
            if ($count != count($courses_to_call)) $sql_extra .= ','; // Make sure we wont have a comma at the end
        }

        $query = "
            SELECT * FROM {$CFG->prefix}course
            WHERE category = '$category_id'
            AND groupyear IN ($sql_extra)";

        return (get_records_sql($query));
    }
     */


    function add_group_members($course_id, $group_id, $group_name) {
        
        $handler = fopen("{$this->tmp_csv_folder}/users.csv", 'r');
        $line = 0;
        while($data = fgetcsv($handler, 0, ';')) {
            $line ++;
            if ($line == 1) continue;

            // Continue with the groups
            $csv_user = new stdClass();
            $csv_user = $this->assign_column_names($data, 'fields_users');

            // Assign userid to csv user record
            $csv_user->userid = get_record('user', 'username', $csv_user->email)->id;
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
        
        $handler = fopen("{$this->tmp_csv_folder}/users.csv", 'r');
        $line = 0;
        while($data = fgetcsv($handler, 0, ';')) {
            $line ++;
            if ($line == 1) continue;

            // Continue with the groups
            $csv_user = new stdClass();
            $csv_user = $this->assign_column_names($data, 'fields_users');
            
            if ($csv_user->rol1 != 'beheerder') continue; // If not admin, continue

            $role_assignment = new stdClass();
            $role_assignment->userid = get_record('user', 'username', $csv_user->email)->id;
            $role_assignment->roleid = get_record('role', 'shortname', 'admin')->id;
            $role_assignment->contextid = get_context_instance(CONTEXT_SYSTEM, 1)->id; // Get course context id
            $role_assignment->timemodified = time();
            $role_assignment->courseid = 1;

            if (!insert_record('role_assignments', $role_assignment)) return false;
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
        $role_assignment = new stdClass();
        $role_assignment->roleid = get_record('role', 'shortname', $role_shortname)->id;
        $role_assignment->contextid = get_context_instance(CONTEXT_COURSE, $course_id)->id; // Get course context id
        $role_assignment->userid = $user->userid;
        $role_assignment->timemodified = time();
        echo "<br />Created role assignment user {$user->userid} {$course_id}<br />";

        return (insert_record('role_assignments', $role_assignment));
    }


    function add_group_member($user, $group_id) {
        $group_member = new stdClass();
        $group_member->groupid = $group_id;
        $group_member->timeadded = time();
        $group_member->userid = $user->userid;

        $error = false;
        if (!insert_record('groups_members', $group_member)) $error = true;
        echo "<br />Added group member user {$group_member->userid} to group {$group_member->groupid}<br />";
        return (!$error);
    }

    function create_group($course_id, $group) {
        $group->courseid = $course_id;
        return (@insert_record('groups', $group));
    }


    function assemble_data_string_for_restore($course, $group, $category_id) {

        $new_course = new stdClass();
        $new_course->category = $category_id;
        $new_course->shortname = $course->shortname;
        $new_course->fullname = $course->fullname;


        $data_string = "backup_name=$course->backup_name&group_name={$group->name}&";
        foreach($course_new as $key=>$value) {
            $data_string .= "course[$key]=$value&";
        }
        rtrim($data_string,'&');
        unset($course_new);
        exit(var_dump($data_string));

        return $data_string;
    } // assemble_data_string_for_restore


    function execute_course_restore($moodle, $data_string) {
        
        $curl = curl_init($moodle->cfg->wwwroot.'/class.restore_backup.php');

        curl_setopt($curl,CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data_string);
        $result = curl_exec($curl);
        curl_close ($curl);

        return ($result == 'false') ? false : $result;
    }


    function restore_course($category_id, $child_group, $parent_course) {
        $target = self::$target_folder . $this->csv_line->domain;

        $data_string = $this->assemble_data_string_for_restore($parent_course, $child_group, $category_id);
        if (!$new_course_id = trim($this->execute_course_restore($moodle, $data_string))) error("Failed to execute course restore for parent course {$course->id}");

        $data = array('parent_course'=>$parent_course, 'category_id'=>$category_id, 'group_name'=>$child_group->name);
        $curl = curl_init($target . '/public_html/class.restore_backup.php');
        exit(var_dump($data));

        curl_setopt($curl,CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        $course_id = curl_exec($curl);
        curl_close ($curl);

        if ($context_id == 'false') die('Failed to create context for context level ' . $context_level . ' and instance id ' . $instance_id);
        exit(var_dump($course_id));

        // return $context_id;
        /*
        $restore_course = new restore_backup();
        if (!$course_id = $restore_course->course_restore($parent_course, $child_group->name, $category_id)) return false;
        unset($restore_course);
         */

        return $course_id;
    }


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

        $query = "UPDATE ".self::$prefix."course_categories SET visible='0'";
        self::log($query);
        if (!self::remote_execute($this->csv_line, $query)) $error = true;

        $query = "UPDATE ".self::$prefix."course SET visible='0' WHERE category != '0'";
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
                description = '{$this->csv_line->description}'
            WHERE id = {$site_wide_course_id}";

        self::log("Update side-wide course.");

        return (self::remote_execute($this->csv_line, $query));
    } // function FunctionName

}

?>

