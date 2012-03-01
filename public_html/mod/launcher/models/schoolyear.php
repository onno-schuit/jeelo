<?php
global $CFG;

require_once($CFG->dirroot.'/mod/soda/class.model.php');
require_once($CFG->dirroot.'/mod/launcher/models/moodle.php');

class schoolyear extends moodle {

    static $table_name = 'launcher_moodles';


    function set_environment_details() {
        // Set the right properties
        if (!$environment = get_record('launcher_moodles', 'id', $this->environment_id)) { // Only happens when someone re-selected the 'select' option
            $this->site_name = '';
            $this->site_description = '';
            $this->admin_email = '';
            return true;
        }
        $this->environment = $environment;

        $this->site_name = $this->environment->name;
        $this->site_description = $this->environment->description;
        $this->admin_email = $this->environment->admin_email;

        unset($this->environment_id);
        return true;
    } // function set_environment_details


    function validate_and_create() {

        $this->set_environment_details();
        if (!$this->validate()) return false;

        return false;
    } // function insert


    function define_validation_rules() {
        global $CFG;

        if (empty($this->site_shortname)) return false;

        $this->add_uploaded_files();
        $this->validate_files_received();

        $this->add_rule('site_name', get_string('required'), function($site_name) { return ( trim($site_name) != '' ); });
/*        $this->add_rule('db_password' get_string('required'), function($db_password) {
            $query = "SELECT * FROM {$CFG->prefix}user"; // Any query would do
            return ( trim($site_name) != '' );
        });
 */
        $this->add_rule('admin_email', get_string('error_email', 'launcher'), function($admin_email) { return (validate_email($admin_email)); });
        $this->add_rule('upload_users', get_string('error_file_extension', 'launcher'), function($upload_users) {
            return ($upload_users['name'] != '') ? (end(explode(".", $upload_users['name'])) == 'csv') : true;
        });
        $this->add_rule('upload_groups', get_string('error_file_extension', 'launcher'), function($upload_groups) {
            return ($upload_groups['name'] != '') ? (end(explode(".", $upload_groups['name'])) == 'csv') : true;
        });

    }

}



?>

