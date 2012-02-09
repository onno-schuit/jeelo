<?php
class moodle_controller extends controller
{

    function index() {
        $this->has_access_rights();
        
        $this->edit();
	} // function index

	
    function edit($moodle = false) {
        global $CFG;

        $this->has_access_rights();

        $this->get_view(array('moodle'=>$moodle), 'edit');
    } // function edit


    function show($moodle) {
        $this->has_access_rights();
        
        if (!$moodle) error(launcher_helper::print_error("1000"));
        if (!$moodle->send_feedback_mails()) $this->create_messages(array('no_feedback_send'=>get_string('no_feedbackmail_send', 'launcher')));
        
        $this->get_view(array('moodle'=>$moodle), 'show');
    } // function show


    function create($moodle = false) {
        $this->has_access_rights();

        $moodle = new moodle(required_param('moodle', PARAM_RAW));
        if (!$moodle->validate_and_create()) return $this->edit($moodle);

        /*$_SESSION['pw_db'] = $moodle->db->password;
        $_SESSION['pw_user'] = $moodle->user->password;*/

        $this->show($moodle);
    } // function create

}
?>
