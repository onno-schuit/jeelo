<?php
require_once($CFG->dirroot.'/mod/soda/class.user.php');
class moodle extends user {

    static $table_name = 'launcher_moodles';


    function validate_and_create() {
        global $CFG;
	
        //if (!$this->validate()) return false; // Validate form
        if (!$this->set_defaults()) return false; // Set all default variables
        if (!$this->create_moodle()) return false; // Start the create moodle processes

        return true;
    }


    function set_defaults() {
        global $CFG;

        // Site variables
        $this->site->shortname   = $this->site_shortname;
        $this->site->name        = $this->site_name;

        // DB variables
        $this->db->host          = $CFG->dbhost;
        $this->db->name          = $this->get_site_real_name();
        $this->db->username      = $this->get_site_real_name();
        $this->db->password      = $this->create_password();
        
        // Config variables
        $this->cfg->wwwroot      = "http://{$this->domain}";
        $this->cfg->dirroot      = "{$this->get_global_root()}/{$this->get_site_real_name()}/public_html";
        $this->cfg->dataroot     = "{$this->get_global_root()}/{$this->get_site_real_name()}/moodle_data";

        // User variables
        $this->user->username    = 'admin';
        $this->user->password    = $this->create_password();
        $this->user->firstname   = 'Admin';
        $this->user->lastname    = 'user';
        $this->user->email       = $this->admin_email;
        $this->user->city        = 'Changeme';

        // Server variables
        $this->server->server    = $this->server_name;
        $this->server->domain    = $this->domain;

        $this->layout->navbar    = $this->navbar;
        $this->layout->logo      = $this->logo;

        $this->dumps_location    = '/etc/moodle_clients';
        $this->sql_filename      = "{$this->server->domain}_sql_" . date("Ymd") . ".tgz";
        $this->codebase_filename = "{$this->server->domain}_codebase_" . date("Ymd") . ".tgz";
        $this->csv_filename      = "{$this->server->domain}_csv_" . date("Ymd") . ".tgz";
        $this->courses_filename  = "{$this->server->domain}_courses_" . date("Ymd") . ".tgz";
        $this->logo_filename	 = "{$this->server->domain}_logo_" . date("Ymd") . ".tgz";

        return true;
    }


    function define_validation_rules() {

        $this->add_uploaded_files();

        $this->add_rule('site_name', get_string('required'), function($site_name) { return ( trim($site_name) != '' ); });
        $this->add_rule('site_shortname', get_string('required'), function($site_shortname) { return ( trim($site_shortname) != '' ); });
        $this->add_rule('admin_email', get_string('error_email', 'launcher'), function($admin_email) { return (validate_email($admin_email)); });
        $this->add_rule('server_name', get_string('required'), function($server_name) { return ( trim($server_name) != '' ); });
        $this->add_rule('domain', get_string('required'), function($domain) { return ( trim($domain) != '' ); });

        $this->add_rule('logo', get_string('error_jpg_extension', 'launcher'), function($logo) {
            return ($logo['name'] != '') ? (end(explode(".", $logo['name'])) == 'jpg') : true;
        });

        // $this->validate_files_received();

        $this->add_rule('upload_users', get_string('error_file_extension', 'launcher'), function($upload_users) {
            return ($upload_users['name'] != '') ? (end(explode(".", $upload_users['name'])) == 'csv') : true;
        });
        $this->add_rule('upload_groups', get_string('error_file_extension', 'launcher'), function($upload_groups) {
            return ($upload_groups['name'] != '') ? (end(explode(".", $upload_groups['name'])) == 'csv') : true;
        });

        $shortname_stripped = $this->get_site_real_name();
        if (!$obj->msg = $this->get_site_real_name()) return false;
        $this->add_rule('site_shortname', get_string('maxlength', 'launcher', $obj), function($shortname_stripped) {
            return ( strlen($shortname_stripped) <= 16 );
        });
        $this->add_rule('site_shortname', get_string('unique', 'launcher', $obj), function($shortname_stripped) {
            return (!get_records_sql("SELECT * FROM jeelo_buffer.client_moodles WHERE short_code = '$shortname_stripped'")); // 'launcher_moodles', 'shortname', $shortname_stripped) );
        });
    }


    function create_moodle() {
        global $CFG;

		if (!$this->prepair_codebase_transfer()) launcher_helper::print_error('2000');
		if (!$this->prepair_database_transfer()) launcher_helper::print_error('2001');
		if (!$this->prepair_csv_transfer()) launcher_helper::print_error('2002');
		if (!$this->prepair_logo_transfer()) launcher_helper::print_error('2003');
		
		
		if (!$buffer_id = $this->insert_client_in_buffer_db()) launcher_helper::print_error('2004');
		if (!$this->prepair_projects_transfer($buffer_id)) launcher_helper::print_error('2005');
		if (!$this->compress_and_remove_course_backups()) launcher_helper::print_error('2006');

		// All done? Green light for the cron!
		if (!$this->update_buffer_status($buffer_id)) launcher_helper::print_error('2007');

        return true;

		/* Old code
		  * 
        if (!$this->create_codebase()) launcher_helper::print_error('2000');
        
        if (!$this->set_up_database()) launcher_helper::print_error('2001');

        // Make sure a bufferdb record exists before the courses are created, we need to log the courses
        if (!$this->buffer_client_id = $this->insert_client_in_buffer_db()) error("Can't save in buffer db");

        if (!$this->insert_child_content()) launcher_helper::print_error('2002');

        if (!$this->set_layout_functions()) launcher_helper::print_error('2010');

        // Finally prepair for transfer to the client
        if (!$this->prepair_transfer_to_client()) launcher_helper::print_error('2009');
        */
 
    }


	function prepair_codebase_transfer() {
		
        $dir = getcwd();
        chdir("{$this->get_global_root()}/moeder");
        shell_exec("tar -czv --exclude=moodle_data/* --exclude=config.php --exclude=launcher/* -f {$this->dumps_location}/code/{$this->codebase_filename} *");
        chdir($dir);
        
        return true;
	}
	
	function prepair_database_transfer() {
		global $CFG;

		// Make sure we have an actual database dump
		if (!file_exists($CFG->dataroot . "/moodle.sql.tgz")) error("The database dump on which the client moodle environments will be based could not be found.");

		// Move the database dump
        copy("{$CFG->dataroot}/moodle.sql.tgz", "{$this->dumps_location}/db/{$this->sql_filename}");
        
        return true;
	}

	function prepair_csv_transfer() {

        // Move uploaded csv files to /etc/moodle_clients
        if(!move_uploaded_file($this->upload_users['tmp_name'], "{$this->dumps_location}/csv/users.csv")) return false;
        if(!move_uploaded_file($this->upload_groups['tmp_name'], "{$this->dumps_location}/csv/groups.csv")) return false;

        // Compress them into 1 file
        $dir = getcwd();
        chdir("{$this->dumps_location}/csv");
        shell_exec("tar -cz -f {$this->dumps_location}/csv/{$this->csv_filename} users.csv groups.csv");
        
        // Finally delete the created csv files, we now got them compressed anyway
        unlink("{$this->dumps_location}/csv/users.csv");
        unlink("{$this->dumps_location}/csv/groups.csv");
        chdir($dir);
        
        return true;
	}

	function prepair_logo_transfer() {
		
        // Move uploaded csv files to /etc/moodle_clients
        if(!move_uploaded_file($this->logo['tmp_name'], "{$this->dumps_location}/logo/banner.jpg")) return false;

        // Compress them into 1 file
        $dir = getcwd();
        chdir("{$this->dumps_location}/logo");
        shell_exec("tar -cz -f {$this->dumps_location}/logo/{$this->logo_filename} banner.jpg");
        
        // Finally delete the created csv files, we now got them compressed anyway
        unlink("{$this->dumps_location}/logo/banner.jpg");
        chdir($dir);
        
        return true;
	}
	
    function insert_client_in_buffer_db() {
        global $CFG;

        $query = "INSERT INTO jeelo_buffer.client_moodles (
            timecreated, domain, short_code, name, sql_filename, codebase_filename, csv_filename, logo_filename, courses_filename, navbar_color, is_for_client, status, exit_code, timemodified ) VALUES (
                '".date('Y-m-d H:i:s')."',
                '{$this->domain}',
                '{$this->site->shortname}',
                '{$this->site->name}',
                '{$this->dumps_location}/db/{$this->sql_filename}',
                '{$this->dumps_location}/code/{$this->codebase_filename}',
                '{$this->dumps_location}/csv/{$this->csv_filename}',
                '{$this->dumps_location}/logo/{$this->logo_filename}',
                '{$this->dumps_location}/course_imports/{$this->courses_filename}',
                '{$this->layout->navbar}',
                'client',
                'creating',
                '0',
                '".time()."'
		)";
        if (!mysql_query($query)) return false;

        return (mysql_insert_id());
    }
    
    function prepair_projects_transfer($buffer_id) {
		
		foreach($this->categories as $category_id) {
			
			$category = get_record('course_categories', 'id', $category_id);
			$buffer_category_id = $this->insert_category_in_buffer($category);
			
			if (!$this->prepair_courses_transfer($buffer_id, $category_id, $buffer_category_id)) error("Failed to prepair courses for transfer.");
		}
		
		return true;
	}
	
	function prepair_courses_transfer($buffer_id, $category_id, $buffer_category_id) {

		$courses = get_records('course', 'category', $category_id);
		foreach($courses as $course) {
			
			if (!$backup_name = $this->backup_course($course)) error("Failed to create a backup from course in category id $category_id.");
			$this->insert_course_in_buffer($course, $backup_name, $buffer_id, $buffer_category_id);
			
		}
		
		return true;
	}

	function insert_category_in_buffer($category) {
		
		$query = $this->build_insert_query('jeelo_buffer', 'client_categories', $category);
		if (!mysql_query($query)) return false;
		
		return (mysql_insert_id());
	}
	
	function insert_course_in_buffer($course, $backup_name, $buffer_id, $buffer_category_id) {
		
		$new_course = new stdClass();
		$new_course->backup_name = $backup_name;
		$new_course->course_fullname = $course->fullname;
		$new_course->course_shortname = $course->shortname;
		$new_course->course_groupyear = $course->groupyear;
		$new_course->buffer_id = $buffer_id;
		$new_course->category_id = $buffer_category_id;
		
		$query = $this->build_insert_query('jeelo_buffer', 'client_courses', $new_course);
		
		return (mysql_query($query));
	}

	function backup_course($course) {
        require_once('class.backup_course.php');

        $backup_course = new backup_course();
                
        return ($backup_course->course_backup($this->dumps_location . '/course_imports', $course));
	}

	function compress_and_remove_course_backups() {
        $dir = getcwd();

        chdir("{$this->dumps_location}/course_imports");
        // Tar the files
        shell_exec("tar -cz -f {$this->dumps_location}/course_imports/{$this->courses_filename}.tgz *.zip");
        // Finally delete the created zip files, we now got them compressed anyway
        shell_exec("rm *.zip");
        chdir($dir);
        
        return true;
	}

	/* This function will return an insert query based on the parameters inside the object
	 * It will skip over id and any other parameters that aren't actually in the table */
	function build_insert_query($db = 'jeelo_moeder', $table, $object) {
		
		$real_columns = get_records_sql("SHOW COLUMNS FROM $db.$table");
		$query = "INSERT INTO $db.$table (";
		$max_params = count(get_object_vars($object));
		$count = 0;
		
		// Prepair column names
		foreach($object as $column => $value) {
			$count ++;
			
			if ($column == 'id') continue; // Skip primary ids
			if (!isset($real_columns[$column])) continue; // Skip non-existing columns
			
			$query .= ($count != $max_params) ? "$column, " : "$column";
		}
		
		$query .= ") VALUES (";
		$count = 0;
		
		// Prepair column values
		foreach($object as $column => $value) {
			$count ++;
			
			if ($column == 'id') continue; // Skip primary ids
			if (!isset($real_columns[$column])) continue; // Skip non-existing columns
			
			$query .= ($count != $max_params) ? "'$value', " : "'$value'";
		}
		
		$query .= ")";
		
		return $query;
	}
	
    function update_buffer_status($buffer_id) {
		
        $query = "
            UPDATE jeelo_buffer.client_moodles SET
				status				= 'new'
            WHERE id = '{$buffer_id}'";
            
        return (execute_sql($query, false));
    }

    function get_site_real_name() {

        if (!isset($this->site_shortname)) return false;
        return strtolower(preg_replace("/[^a-z_0-9]+/i", "", $this->site_shortname));
    }
	
    function get_global_root() { 
        global $CFG;

		$new_dirroot = '/home/jeelos';

        return $new_dirroot;
    }
	
    function create_db_user() {
        global $CFG;
        
        $query = "
        CREATE USER
            '{$this->db->name}'@'{$this->db->host}'
            IDENTIFIED BY '".$this->get_password($this->db->password)."'";
        if (!execute_sql($query, false)) return false;

        $query = "
        GRANT ALL PRIVILEGES
            ON {$this->db->name} . *
            TO '{$this->db->username}'@'{$this->db->host}'
            IDENTIFIED BY '".$this->get_password($this->db->password)."'
            WITH GRANT OPTION";
        if (!execute_sql($query, false)) return false;

        return true;
    }

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	





/*		BELOW IS OLD		*/



    function set_layout_functions() {

        if (!empty($this->layout->navbar)) $this->set_navbar_color();
        if (!empty($this->layout->logo)) $this->set_logo();

        return true;
    }

    function set_logo() {
        $file = "{$this->get_global_root()}/{$this->get_site_real_name()}/public_html/theme/children-education/pix/banner.jpg";
        if (file_exists($file)) unlink($file);

        return (move_uploaded_file($this->layout->logo['tmp_name'], $file));
    }

    function set_navbar_color() {

        $file = "{$this->get_global_root()}/{$this->get_site_real_name()}/public_html/theme/children-education/styles_layout.css";
        $handler = file($file);

        $str_search = "background:url(pix/navbar_bg.jpg) top right no-repeat;";
        $str_replace = "  background-color: #{$this->layout->navbar};\n";

        foreach($handler as $key=>$data) {
            if (trim($data) == $str_search) $handler[$key] = $str_replace;
        }

        return (file_put_contents($file, $handler));
    }

    function prepair_transfer_to_client() {
        
        if (!$this->copy_codebase_and_database()) error("Failed process at copy_codebase_and_database");
        if (!$this->remove_unneccesary_db_and_codebase()) error("Failed process at remove_unneccesary_db_and_codebase");
        if (!$this->update_buffer_db()) error("Failed process at update_buffer_db");

        return true;
    }


    function compress_codebase() {
        global $CFG;

        // Zip codebase
        chdir("{$this->get_global_root()}/{$this->site->shortname}");
        shell_exec("tar -czv --exclude=backupdata/* -f {$this->dumps_location}/code/{$this->codebase_filename}.tgz *");

        return true;
    }


    function copy_codebase_and_database() {
        global $CFG;

        // Dump and zip database
        shell_exec("mysqldump -Qu {$CFG->dbuser} -p{$CFG->dbpass} --add-drop-table --no-create-db {$this->db->name} > {$this->dumps_location}/db/{$this->sql_filename}.sql");
        shell_exec("gzip {$this->dumps_location}/db/{$this->sql_filename}.sql -c > {$this->dumps_location}/db/{$this->sql_filename}.gz");
        // Delete .sql file, we got it zipped now anyway
        shell_exec("rm {$this->dumps_location}/db/{$this->sql_filename}.sql");

        // Zip codebase
        chdir("{$this->get_global_root()}/{$this->site->shortname}");
        shell_exec("tar -czv --exclude=backupdata/* -f {$this->dumps_location}/code/{$this->codebase_filename}.tgz *");

        return true;
    }


    function remove_unneccesary_db_and_codebase() {
        global $CFG;

        // Delete user and database
        $query = "DROP USER '{$this->db->username}'@'{$this->db->host}'";
        execute_sql($query, false);
        $query =  "DROP DATABASE {$this->db->name}";
        execute_sql($query, false);

        // Remove old codebase and symlink
        shell_exec("rm -R {$this->get_global_root()}/{$this->get_site_real_name()}");
        shell_exec("rm /var/www/{$this->get_site_real_name()}");

        return true;
    }


    /* Update the buffer db
     * This function will update the status of
     * the client buffer db, setting it to new*/
    function update_buffer_db_OOOOOOOOOOOOOLLLLLLLLLLLDDDDDDDDDD() {
        $query = "
            UPDATE jeelo_buffer.client_moodles SET
            status = 'new',
            codebase_filename = '{$this->dumps_location}/code/{$this->codebase_filename}.tgz',
            sql_filename = '{$this->dumps_location}/db/{$this->sql_filename}.gz',
            timemodified = '".time()."'
            WHERE id = '{$this->buffer_client_id}'";
        return (execute_sql($query, false));
    }


    function insert_client_in_buffer_db_OLLLLLDDDDDDDD() {
        global $CFG;

        $query = "INSERT INTO jeelo_buffer.client_moodles (
            timecreated, domain, short_code, name, sql_filename, codebase_filename, csv_filename, logo_filename, navbar_color, is_for_client, status, exit_code, timemodified ) VALUES (
                '".date('Y-m-d H:i:s')."',
                '{$this->domain}',
                '{$this->site->shortname}',
                '{$this->site->name}',
                '{$this->sql_filename}'
                'client',
                'creating',
                '0',
                '".time()."')";

        execute_sql($query, false);
        return (get_record_sql("SELECT * FROM jeelo_buffer.client_moodles WHERE short_code = '{$this->site->shortname}'")->id);
    }


    function set_up_database() {

        if (!$this->create_database()) error("Operation cancelled at create database");
        if (!$this->create_db_user()) error("Operation cancelled at create_db_user");
        if (!$this->insert_database()) error("Operation cancelled at insert_database");
        if (!$this->create_site_admin()) error("Operation cancelled at create_site_admin");

        return true;
    }


    function create_database() {
        $query = "CREATE DATABASE {$this->db->name}";

        return execute_sql($query, false);
    }


    function insert_database() {
        global $CFG;
        // Inserting database using sudo command
        $cmd = "mysql -u{$CFG->dbuser} -p{$CFG->dbpass} {$this->db->name} < {$CFG->dataroot}/moodle.sql";
        shell_exec($cmd);

        $query = "SHOW TABLES";
        $result = launcher_helper::remote_execute($this, $query);

        return (mysql_num_rows($result) > 0) ? true : false;  
    }


    function insert_child_content() {
        global $CFG;
        require_once("{$CFG->dirroot}/class.content_uploader.php");

        $content_uploader = new content_uploader($this);
        $content_uploader->upload();

        return ($this->update_sitewide_course());
    }


    function update_sitewide_course() {
        global $CFG;

        $this->site->shortname   = $this->site_shortname;
        $this->site->name        = $this->site_name;
        $query = "UPDATE {$CFG->prefix}course SET
                    fullname = '{$this->site->name}',
                    shortname = '{$this->site->shortname}'
                  WHERE category = 0";

        return (launcher_helper::remote_execute($this, $query));
    }


    function add_uploaded_files() {
        if (!isset($_FILES)) return true;
        foreach($_FILES as $key=>$file) {
            $this->$key = $file;
        }
    }

	/*	Not in use anymore. The csv file uploads should be optional.
	 * 
    function validate_files_received() {
    
        if ((isset($this->upload_users['name']) && $this->upload_users['name']) == '') {
            soda_error::add_error($this, 'upload_users', get_string('required'));
        }
        if ((isset($this->upload_groups['name']) && $this->upload_groups['name']) == '') {
            soda_error::add_error($this, 'upload_groups', get_string('required'));
        }

        return true;
    }
    */




    function create_site_admin() {
        global $CFG;

        $query = "
            UPDATE {$CFG->prefix}user SET
                username   = '{$this->user->username}',
                password   = '{$this->get_password_hash($this->user->password)}',
                email      = '{$this->user->email}',
                firstname  = '{$this->user->firstname}',
                lastname   = '{$this->user->lastname}',
                city       = '{$this->user->city}'
            WHERE username = 'admin'";

        return (launcher_helper::remote_execute($this, $query));
    }


    function create_config() {
        global $CFG;

        $error = false;
        // First create config_clean.php
        if (!$config_clean = fopen("{$this->cfg->dirroot}/config_clean.php", "w")) return false;
        $config_clean_input = '<?php // Clean Configuration File
$CFG->dbhost    = "'.$this->db->host.'";
$CFG->dbname    = "'.$this->db->name.'";
$CFG->dbuser    = "'.$this->db->username.'";
$CFG->dbpass    = "'.$this->get_password($this->db->password).'";';
// Use the password salt for new moodle if it exists
if (isset($CFG->passwordsaltmain)) {
    $config_clean_input .= '
$CFG->passwordsaltmain = "'.$CFG->passwordsaltmain.'";';
}
$config_clean_input .= '
?>';
        if (!fwrite($config_clean, trim($config_clean_input))) return false;
        if (!fclose($config_clean)) return false;

        // Now create config.php
        if (!$config = fopen("{$this->cfg->dirroot}/config.php", "w")) return false;
        // Avoiding whitespaces in config file
        $config_input = '<?php // Moodle Configuration File

unset($CFG);

$CFG = new stdClass();
$CFG->dbtype    = "mysql";
require_once("config_clean.php");
$CFG->dbpersist = false;
$CFG->prefix    = "'.$CFG->prefix.'";

$CFG->wwwroot   = "'.$this->cfg->wwwroot.'";
$CFG->dirroot   = "'.$this->cfg->dirroot.'";
$CFG->dataroot  = "'.$this->cfg->dataroot.'";
$CFG->admin     = "admin";

$CFG->directorypermissions = 00777;  // try 02777 on a server in Safe Mode';
$config_input .= '
require_once("$CFG->dirroot/lib/setup.php");';

        if (!fwrite($config, trim($config_input))) return false;
        if (!fclose($config)) return false;

        return true;
    }

    function recursive_copy($source, $dest, $diffDir, $folder = false){
        global $CFG;

        $sourceHandle = opendir($source);
        if(!$diffDir) $diffDir = $source;
        
        // Only create global child folder if the function's called for public_html
        if ($folder != 'moodle_data') {
            if (!mkdir($dest . '/' . $diffDir)) return false;
        }

        if ($folder) return ($this->recursive_copy($source, $dest . '/' . $diffDir, $folder));
       
        while($resource = readdir($sourceHandle)){

            if (is_dir($source . '/' . $resource) && ($resource == 'launcher' || $resource == 'soda')) continue;
            if ($source == 'phpymadmin' || $resource == 'phpmyadmin') continue;

            if($resource == '.' || $resource == '..'
                || $source . '/' . $resource == "{$CFG->dirroot}/config.php"
                || $source == "{$CFG->dataroot}") continue;
           
            if(is_dir($source . '/' . $resource)){
                $this->recursive_copy($source . '/' . $resource, $dest, $diffDir . '/' . $resource);
            } else {
                if (!copy($source . '/' . $resource, $dest . '/' . $diffDir . '/' . $resource)) return false;
            }
        }
        return true;
    }


    function send_feedback_mails() {
        global $CFG;

        $email_to = new stdClass();
        $email_to->mailformat = 1;
        $email_to->email = $this->user->email;
        $email_to->name = $this->user->firstname;

        $body = get_string('mail_feedback_body_start', 'launcher', $email_to);
        $body .= $this->get_feedback_body();
        $body .= get_string('mail_feedback_body_end', 'launcher', $email_to);
        $subject = get_string('mail_feedback_subject', 'launcher');

        return (email_to_user($email_to, $CFG->noreplyaddress, $subject, $body, $body));
    }
    
    
    function get_feedback_body() {
        $body = "
            <table border-collapse='collapse'>
                <tr><td><b>Database information</b></td></tr>
                <tr>
                    <td>Username</td>
                    <td>{$this->db->username}</td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td>".$this->get_password($this->db->password)."</td>
                </tr>
                <tr>
                    <td>Database name</td>
                    <td>{$this->db->name}</td>
                </tr>
                <tr><td>&nbsp;</td></tr><tr><td><b>Moodle Admin information</b></td></tr>
                <tr>
                    <td>Username</td>
                    <td>{$this->user->username}</td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td>".$this->get_password($this->user->password)."</td>
                </tr>
                <tr><td>&nbsp;</td></tr><tr><td><b>Website information</b></td></tr>
                <tr>
                    <td>URL</td>
                    <td>{$this->cfg->wwwroot}</td>
                </tr>
            </table>";
        
        // exit(print_object($body));
        return $body;
    }
}
?>
