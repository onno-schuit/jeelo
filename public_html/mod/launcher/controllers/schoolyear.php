<?php
require_once($CFG->dirroot.'/mod/launcher/models/school.php');

include_once('launcher.php');
class schoolyear_controller extends launcher_controller
{

	function index() {
		$this->has_access_rights();
        $schoolyear = new school(array('fake' => 0));
		
        //$BUFFER_DB->get_record('client_moodles', array());
        $this->add_schoolyear();
    }

    function add_schoolyear($schoolyear = false) {

		$this->get_view(array('schoolyear'=>$schoolyear), 'add_schoolyear');

    }

    function create_schoolyear() {
        
        //if (!$schoolyear) $schoolyear = new schoolyear();
    }
}

?>
