<?php
global $CFG;

require_once($CFG->dirroot.'/mod/soda/class.model.php');
require_once($CFG->dirroot.'/mod/launcher/models/moodle.php');

class schoolyear extends moodle {

    static $table_name = 'launcher_moodles';


    function validate_environment_and_set_errors() {

        $query = "SELECT * FROM jeelo_buffer.client_moodles WHERE id = '{$this->environment_id}'";
        if ($environment = get_record_sql($query)) return $environment;

        // The following only happens when someone selected the 'select' option, or if someone's screwing with my POST variables (:@)
        foreach($this as $key=>$property) {
            if ($key != 'validation_rules') {
                unset($this->$key);
                soda_error::$validation_errors = array();
            } else {
                $this->$key = array();
            }
        }

        return false;
    }
    
    
    function get_site_email() {
        global $CFG;
        $query = "SELECT * FROM {$CFG->prefix}user WHERE username = 'admin'";
        $result = launcher_helper::execute_from_client($this->environment, $query);
        $user = mysql_fetch_object($result);
        return $user->email;
    }


    function set_environment_details() {
        global $CFG;
        // Prevents executing further code if the environment is not set
        if (!$this->environment = $this->validate_environment_and_set_errors()) return true;
        
        $this->site_name            = $this->environment->name;
        $this->environment->admin_email = $this->get_site_email();
        if (!isset($this->jeelo_buffer_id)) $this->jeelo_buffer_id = $this->environment->id;

        $this->server->server_name  = $this->environment->name;
        $this->server->domain       = $this->environment->domain;
        
        $this->dumps_location       = '/etc/moodle_clients';
        $this->logo_filename        = "{$this->server->domain}_logo_" . date("Ymd") . "." . end(explode(".", $this->logo['name']));
        $this->csv_filename         = "{$this->server->domain}_csv_" . date("Ymd");
        $this->courses_filename     = "{$this->server->domain}_course_imports_" . date("Ymd");

        unset($this->environment_id);
        return true;
    }


    function validate_and_create() {

        $this->set_environment_details();
        if (!$this->validate()) return false;
        if (count($this->validation_rules) <= 1) return false; // Don't go further if there's no validation yet

        if (!$this->ready_schoolyear_for_child()) launcher_helper::print_error('4000');

        return true;
    }


    function define_validation_rules() {
        global $CFG;

/*        $this->add_rule('site_name', get_string('error_already_busy', 'launcher'), function($site_name) {
            $query = "SELECT * FROM jeelo_buffer.client_moodles WHERE short_code = '{$site_name}' AND status = 'processed'";
            return($environment = get_record_sql($query));
        });
 */
        if (empty($this->site_shortname)) return false;

        $this->add_uploaded_files();
        $this->validate_files_received();

        $this->add_rule('logo', get_string('error_jpg_extension', 'launcher'), function($logo) {
            return ($logo['name'] != '') ? (end(explode(".", $logo['name'])) == 'jpg') : true;
        });

        $this->add_rule('site_name', get_string('required'), function($site_name) { return ( trim($site_name) != '' ); });
        $this->add_rule('admin_email', get_string('error_email', 'launcher'), function($admin_email) { return (validate_email($admin_email)); });
        $this->add_rule('upload_users', get_string('error_file_extension', 'launcher'), function($upload_users) {
            return ($upload_users['name'] != '') ? (end(explode(".", $upload_users['name'])) == 'csv') : false;
        });
        $this->add_rule('upload_groups', get_string('error_file_extension', 'launcher'), function($upload_groups) {
            return ($upload_groups['name'] != '') ? (end(explode(".", $upload_groups['name'])) == 'csv') : false;
        });
    }


    function ready_schoolyear_for_child() {
        $error = false;

        if (!$this->copy_logo_to_child()) $error = true;
        if (!$this->copy_csv_files_to_child()) $error = true;
        if (!$this->create_course_backups()) $error = true;

        // if (!$this->update_launcher_moodles()) $error = true;
        if (!$this->update_jeelo_buffer()) $error = true;
        
        return (!$error);
    }
    
    
    function copy_logo_to_child() {
		
		$target = "{$this->dumps_location}/logo";
		
		if (file_exists("$target/{$this->logo_filename}")) unlink("$target/{$this->logo_filename}"); // This should never happen...
		move_uploaded_file($this->logo['tmp_name'], "{$this->dumps_location}/logo/{$this->logo_filename}"); // Not gonne end the script on a failed copy of a logo...
		
		return true;
	}


    function create_course_backups() {
        global $CFG;

        foreach($this->categories as $category) {
            // Save category in buffer db, will be used to recover categories in child
            $new_category_id = $this->save_category_in_buffer_db($category);

            $courses = get_records('course', 'category', $category);
            // Loop through all courses in the specified category
            foreach($courses as $course) {
                require_once("{$CFG->dirroot}/mod/launcher/class.backup_course.php");

                $backup_restore = new backup_course('/etc/moodle_clients', 'course_imports');

                if (!$backup_name = $backup_restore->course_backup($category, $course)) return false;
                if (!$this->save_course_in_buffer_db($backup_name, $course, $new_category_id)) error("Failed to add course to jeelo buffer database");
            }
        }
        // Compress them into 1 file
        chdir("{$this->dumps_location}/course_imports");
        // Tar the files
        shell_exec("tar -cz -f {$this->dumps_location}/course_imports/{$this->courses_filename}.tgz *.zip");
        // Finally delete the created zip files, we now got them compressed anyway
        shell_exec("rm *.zip");

        return true;
    }


    function save_course_in_buffer_db($backup_name, $course, $category_id) {
        $query = "
            INSERT INTO jeelo_buffer.client_courses (
                backup_name, course_fullname, course_shortname, course_groupyear, client_moodle_id, parent_category_id
            ) VALUES (
                '$backup_name',
                '{$course->fullname}',
                '{$course->shortname}',
                '{$course->groupyear}',
                '{$this->jeelo_buffer_id}',
                '{$category_id}'
            )";
        return (execute_sql($query, false));
    }


    function save_category_in_buffer_db($category_id) {
        $category = get_record('course_categories', 'id', $category_id);

        $query = "
            INSERT INTO jeelo_buffer.client_categories (
                name, parent, sortorder, coursecount, visible, timemodified, depth, path, theme, client_moodle_id
            ) VALUES (
                '{$category->name}',
                '{$category->parent}',
                '{$category->sortorder}',
                '{$category->coursecount}',
                '1',
                '".time()."',
                '{$category->depth}',
                '{$category->path}',
                '{$category->theme}',
                '{$this->jeelo_buffer_id}'
            )";
        if (!execute_sql($query, false)) return false;

        // Get last inserted id
        $query = "SELECT * FROM jeelo_buffer.client_categories
                  WHERE name = '{$category->name}'
                  AND client_moodle_id = '{$this->jeelo_buffer_id}'";
        if (!$new_category = get_record_sql($query)) return false;
        return ($new_category->id);
    }



    /* copy_csv_files_to_child
     * This function will copy all the neccesary
     * csv files to /etc/moodle_clients,
     * ready to be updated. */
    function copy_csv_files_to_child() {

        $error = false;

        // Move uploaded csv files to /etc/moodle_clients
        if(!move_uploaded_file($this->upload_users['tmp_name'], "{$this->dumps_location}/csv/users.csv")) return false;
        if(!move_uploaded_file($this->upload_groups['tmp_name'], "{$this->dumps_location}/csv/groups.csv")) return false;

        // Compress them into 1 file
        chdir("{$this->dumps_location}/csv");
        shell_exec("tar -cz -f {$this->dumps_location}/csv/{$this->csv_filename}.tgz users.csv groups.csv");
        
        // Finally delete the created csv files, we now got them compressed anyway
        unlink("{$this->dumps_location}/csv/users.csv");
        unlink("{$this->dumps_location}/csv/groups.csv");
        
        return (!$error);
    }


    function update_jeelo_buffer() {
        $jeelo_buffer = new stdClass();

        $csv_filename = "{$this->dumps_location}/csv/{$this->csv_filename}.tgz";
        $courses_filename = "{$this->dumps_location}/course_imports/{$this->courses_filename}.tgz";
        $logo_filename = "{$this->dumps_location}/logo/{$this->logo_filename}";

        $query = "UPDATE jeelo_buffer.client_moodles SET
            name = '{$this->site_name}',
            csv_filename = '{$csv_filename}',
            courses_filename = '{$courses_filename}',
            logo_filename = '{$logo_filename}',
            navbar_color = '{$this->navbar}',
            status = 'update',
            timemodified = '".time()."'
        WHERE id='{$this->jeelo_buffer_id}'";
        
        return (execute_sql($query, false));
    }
}

?>
