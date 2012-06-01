<?php
//require_once($CFG->dirroot.'/local/soda/class.user.php');

class schoolyear_controller extends controller
{

	function index() {
		$this->has_access_rights();
		
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
