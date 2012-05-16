<?php
require_once($CFG->dirroot.'/local/soda/class.user.php');
class school extends user {

    //static $table_name = 'launcher_moodles';

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

        $this->add_rule('site_name', get_string('required'), function($site_name) { return ( trim($site_name) != '' ); });
        $this->add_rule('site_shortname', get_string('required'), function($site_shortname) { return ( trim($site_shortname) != '' ); });
        $this->add_rule('admin_email', get_string('error_email', 'launcher'), function($admin_email) { return (validate_email($admin_email)); });
        $this->add_rule('server_name', get_string('required'), function($server_name) { return ( trim($server_name) != '' ); });
        $this->add_rule('domain', get_string('required'), function($domain) { return ( trim($domain) != '' ); });

        /* Not sure what we're going to do with this yet
        $this->add_rule('logo', get_string('error_jpg_extension', 'launcher'), function($logo) {
            return ($logo['name'] != '') ? (end(explode(".", $logo['name'])) == 'jpg') : true;
        */

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
    

    function create_school() {
        
    }

}
?>
