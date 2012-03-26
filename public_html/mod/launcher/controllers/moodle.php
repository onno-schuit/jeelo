<?php
class moodle_controller extends controller
{

    function index() {
        $this->has_access_rights();
        
        $this->add_school();
	}


    function add_school($moodle = false) {
        global $CFG;

        $this->has_access_rights();

        $this->get_view(array('moodle'=>$moodle), 'add_school');
    }


    function add_schoolyear($schoolyear = false) {
        global $CFG;

        $this->has_access_rights();

        $this->get_view(array('schoolyear'=>$schoolyear), 'add_schoolyear');
    }


    function show_school_created($moodle) {
        $this->has_access_rights();
        
        if (!$moodle) error(launcher_helper::print_error("1000"));
        // if (!$moodle->send_feedback_mails()) $this->create_messages(array('no_feedback_send'=>get_string('no_feedbackmail_send', 'launcher')));
        
        $this->get_view(array('moodle'=>$moodle), 'show_school_created');
    }


    function show_schoolyear_created($moodle) {
        $this->has_access_rights();

        if (!$moodle) error(launcher_helper::print_error("1000"));

        $this->get_view(array('moodle'=>$moodle), 'show_schoolyear_created');
    }


    function create_school($moodle = false) {
        $this->has_access_rights();


        require_once('models/moodle.php');
        $moodle = new moodle(required_param('moodle', PARAM_RAW));
        if (!$moodle->validate_and_create()) return $this->add_school($moodle);

        $this->show_school_created($moodle);
    }


    function create_schoolyear($schoolyear = false) { // Create schoolyear
        $this->has_access_rights();

        require_once('models/schoolyear.php');
        $schoolyear = new schoolyear(required_param('moodle', PARAM_RAW));

        if (!$schoolyear->validate_and_create()) return $this->add_schoolyear($schoolyear);

        $this->show_schoolyear_created($schoolyear);
    }
}
?>
