<?php
require_once($CFG->dirroot.'/mod/launcher/models/school.php');

include_once('launcher.php');
class schoolyear_controller extends launcher_controller
{

	function index() {
		$this->has_access_rights();
        $this->select_school();
    }


    function select_school() {
        $school = new school(array('dummy' => true)); // remove array after refreshing git submodule soda
		$this->get_view(array('school' => $school), 'select_school');
    } // function select_school


    function add_schoolyear($schoolyear = false) {
		$this->get_view(array('schoolyear'=>$schoolyear), 'add_schoolyear');
    }


    function create_schoolyear() {
        //if (!$schoolyear) $schoolyear = new schoolyear();
    }
}

?>
