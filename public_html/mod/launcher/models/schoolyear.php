<?php
global $CFG;

require_once($CFG->dirroot.'/mod/soda/class.model.php');
require_once($CFG->dirroot.'/mod/launcher/models/moodle.php');

class schoolyear extends moodle {

    static $table_name = 'launcher_moodles';


    function validate_environment_and_set_errors() {

        if ($environment = get_record('launcher_moodles', 'id', $this->environment_id)) return $environment;

        // The following only happens when someone selected the 'select' option, or if someone's screwing with my POST variables
        foreach($this as $key=>$property) {
            if ($key != 'validation_rules') {
                unset($this->$key);
                soda_error::$validation_errors = array();
            } else {
                $this->$key = array();
            }
        }

        return false;

    } // function validate_environment_and_set_errors

    function set_environment_details() {

        // Prevents executing further code if the environment is not set
        if (!$environment = $this->validate_environment_and_set_errors()) return true;
        
        // Set the right properties
        $this->environment = $environment;

        $this->site_name            = $this->environment->name;
        $this->site_description     = $this->environment->description;
        $this->admin_email          = $this->environment->admin_email;

        $this->server->server_name  = $this->environment->server_name;
        $this->server->domain       = $this->environment->domain;
        
        $this->dumps_location       = '/etc/moodle_clients';
        $this->csv_filename         = "{$this->server->domain}_csv_".date("Ymd");

        unset($this->environment_id);
        return true;
    } // function set_environment_details


    function validate_and_create() {

        $this->set_environment_details();
        if (!$this->validate()) return false;
        if (count($this->validation_rules) <= 1) return false; // Don't go further if there's no validation yet

        if (!$this->ready_schoolyear_for_child()) launcher_helper::print_error('4000');

        return true;
    } // function insert


    function define_validation_rules() {
        global $CFG;

        $this->add_rule('site_name', get_string('error_already_busy', 'launcher'), function($site_name) {
            $query = "SELECT * FROM jeelo_buffer.client_moodles WHERE short_code = '{$site_name}' AND status = 'processed'";
            return($environment = get_record_sql($query));
        });

        if (empty($this->site_shortname)) return false;

        $this->add_uploaded_files();
        $this->validate_files_received();

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

        if (!$this->copy_csv_files_to_child()) $error = true;
        if (!$this->create_course_backups()) $error = true;

        if (!$this->update_launcher_moodles()) $error = true;
        if (!$this->update_jeelo_buffer()) $error = true;
        
        return (!$error);
    } // function ready_update_for_child


    function create_course_backups() {
        global $CFG;

        foreach($this->categories as $category) {
            $courses = get_records('course', 'category', $category);
            // Loop through all courses in the specified category
            foreach($courses as $course) {
                require_once("{$CFG->dirroot}/mod/launcher/class.backup_course.php");

                $backup_restore = new backup_course('/etc/moodle_clients');

                if (!$backup_restore->course_backup($category, $course)) return false;
            }
        }

        return true;
    } // function create_course_backups


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
    } // function copy_csv_files_to_child


    function update_launcher_moodles() {
        global $CFG;

        $query = "SELECT * FROM {$CFG->prefix}launcher_moodles WHERE shortname = '{$this->site_shortname}'";
        $environment = get_record_sql($query);
        $environment->name = $this->site_name;
        $environment->admin_email = $this->admin_email;

        return (update_record('launcher_moodles', $environment));
    } // function update_launcher_moodles


    function update_jeelo_buffer() {

        // Get ID
        $query = "SELECT * FROM jeelo_buffer.client_moodles WHERE short_code = '{$this->site_shortname}'";
        $environment = get_record_sql($query);
        $environment->csv_filename = "{$this->dumps_location}/csv/{$this->csv_filename}.tgz";
        $environment->status = "update";
        $environment->timemodified = time();

        $query = "UPDATE jeelo_buffer.client_moodles SET ";
        foreach($environment as $key=>$property) {
            if ($property == 'id') continue;
            $query .= "$key = '$property', ";
        }
        $query = substr(trim($query), 0, -1)." WHERE id='{$environment->id}'";
        
        return (mysql_query($query));
    } // function update_jeelo_buffer
}

?>
