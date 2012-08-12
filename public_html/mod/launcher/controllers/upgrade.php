<?php


include_once('launcher.php');

class upgrade_controller extends launcher_controller
{

	function index() {
        global $DB;

		$this->has_access_rights($upgrade = false);
        $this->get_view(array(
            'upgrade' => $upgrade,
            'to_be_upgraded' => $DB->get_field_sql("SELECT COUNT(id) FROM jeelo_buffer.client_moodles
                WHERE status='processed' AND to_be_upgraded=1"),
            'being_upgraded' => $DB->get_field_sql("SELECT COUNT(id) FROM jeelo_buffer.client_moodles
                WHERE status='being_upgraded'"),
            'total_clients' => $DB->get_field_sql("SELECT COUNT(id) FROM jeelo_buffer.client_moodles
                WHERE 1"),
            'upgrade_site_shortname' => $DB->get_field_sql("SELECT shortname FROM jeelo_buffer.client_moodles
                WHERE status='being_upgraded'")));
        //$this->add_upgrade();
    }

    function save($upgrade = false) {
        global $DB;
		$this->has_access_rights();
        if (isset($_POST['confirm'])) {
            $DB->execute("UPDATE jeelo_buffer.client_moodles SET to_be_upgraded=1");
            static::dump_codebase();
        }
        $this->redirect_to('index');

    }

}
?>
