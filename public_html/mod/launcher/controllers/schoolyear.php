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
        $school = new schoolyear(array('dummy' => true)); // remove array after refreshing git submodule soda
		$this->get_view(array('school' => $school), 'select_school');
    } // function select_school


    function add_schoolyear($school = false) {
        if (!$school) $school = $this->get_school();
		$this->get_view(array('school' => $school), 'add_schoolyear');
    }


    function get_school() {
        global $BUFFER_DB;
        $school_id = (isset($_REQUEST['school_id'])) ? $_REQUEST['school_id'] : (int) $_POST['school']['environment'];
        if (!$school_id) $this->redirect_to('select_school');

        launcher_helper::set_buffer_db();
        if (!$client_moodle = $BUFFER_DB->get_record('client_moodles', array('id' => $school_id))) {
            $this->redirect_to('error');
        }
        $school = new schoolyear($client_moodle);
        $school->site_name = $client_moodle->fullname;
        $school->admin_email = $client_moodle->email;               
        return $school;
    } // function get_school


    // this obviously needs improvement
    function error() {
        echo "Sorry, something went wrong. Most likely: client moodle record no longer exists.";        
    } // function error


    function create_schoolyear() {
        global $id;
		$this->has_access_rights();

        $school = new schoolyear($_POST['school']);
        //print_object($school);
        if (!$school->validate_and_save()) return $this->add_schoolyear($school);
        $this->redirect_to('finished');
    }


    function finished() {
        $this->get_view();
    } // function finished
}

?>
