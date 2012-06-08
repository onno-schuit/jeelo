<?php
require_once($CFG->dirroot.'/local/soda/class.user.php');
require_once($CFG->dirroot.'/mod/launcher/class.school.php');

class schoolyear extends school {

    function define_validation_rules() {

        $this->add_rule('site_name', get_string('required'), function($site_name) { return ( trim($site_name) != '' ); });
        $this->add_rule('admin_email', get_string('error_email', 'launcher'), function($admin_email) { return (validate_email($admin_email)); });

        // Check file extensions
        $this->add_rule('upload_users', get_string('error_file_extension', 'launcher'), function($upload_users) {
            return (end(explode(".", $upload_users['name'])) == 'csv');
        });

        $this->add_rule('upload_groups', get_string('error_file_extension', 'launcher'), function($upload_groups) {
            return (end(explode(".", $upload_groups['name'])) == 'csv');
        });

    } // function define_validation_rules

}

?>

