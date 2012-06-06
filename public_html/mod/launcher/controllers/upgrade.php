<?php

class code_dumper {
    
    static $_path = '/etc/moodle_clients';
    
    function dump_codebase() {
        global $CFG;
        $target = self::$_path . '/upgrade_codebase.tgz';
        
        $siteroot = str_replace('/public_html', '', $CFG->dirroot);
        $cmd = "cd $siteroot ; tar -czp --exclude='public_html/config.php' -f {$target} public_html/*";
        return shell_exec($cmd);
    } // function dump_codebase

    
}

class upgrade_controller extends controller
{

	function index() {
		$this->has_access_rights();
		
        $this->add_upgrade();
    }

    function add_upgrade($upgrade = false) {
        global $DB;
        
        if (isset($_POST['confirm'])) {
            $DB->execute("UPDATE jeelo_buffer.client_moodles SET to_be_upgraded=1");
            code_dumper::dump_codebase();
        }
        $this->get_view(array(
            'upgrade' => $upgrade,
            'to_be_upgraded' => $DB->get_field_sql("SELECT COUNT(id) FROM jeelo_buffer.client_moodles
                WHERE status='processed' AND to_be_upgraded=1"),
            'being_upgraded' => $DB->get_field_sql("SELECT COUNT(id) FROM jeelo_buffer.client_moodles
                WHERE status='being_upgraded'"),
            'total_clients' => $DB->get_field_sql("SELECT COUNT(id) FROM jeelo_buffer.client_moodles
                WHERE 1"),
            'upgrade_site_shortname' => $DB->get_field_sql("SELECT shortname FROM jeelo_buffer.client_moodles
                WHERE status='being_upgraded'")
        ), 'upgrade');
    }

}
?>
