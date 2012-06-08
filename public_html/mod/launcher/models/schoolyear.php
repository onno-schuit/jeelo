<?php
require_once($CFG->dirroot.'/local/soda/class.user.php');
require_once($CFG->dirroot.'/mod/launcher/models/school.php');

class schoolyear extends school {


    function validate_and_save() {
        if (!$this->validate()) return false;
        $this->prepair_school();
        return true;
    } // function validate_and_save


    function prepair_school() {
        $this->buffer_id = $this->id;
        $this->set_dump_locations();
        $this->dump_csv_files();
        $this->dump_projects();
        $this->update_complete_buffer('needs_update');
    } // function prepair_school


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


    function update_complete_buffer($status) {
        global $BUFFER_DB;

        $buffer = new stdClass();
        $buffer->id = $this->buffer_id;
        $buffer->status = $status;

        $buffer->fullname       = $this->site_name;
        $buffer->email          = $this->admin_email;
        $buffer->is_for_client  = 'client';
        $buffer->logo      = $this->logo;
        $buffer->customcss      = $this->customcss;

        if ($this->get_dump_file('csv')) $buffer->csv_filename   = $this->get_dump_file('csv');
        if ($this->get_dump_file('courses')) $buffer->courses_filename   = $this->get_dump_file('courses');

        $BUFFER_DB->update_record('client_moodles', $buffer);               
    } // function update_complete_buffer
} // class schoolyear 

?>
