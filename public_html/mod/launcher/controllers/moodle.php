<?php
class moodle_controller extends controller
{

    function index() {
        global $CFG;
        
        //$this->has_access_rights();
        $this->edit();
	} // function index

	
    function edit($moodle = false) {

        //$this->has_access_rights();
        $this->get_view(array('moodle'=>$moodle), 'edit');
    } // function edit


    function show($moodle) {
        
        //$this->has_access_rights();
        if (!$moodle) error("Mag niet...");
        // if (!$moodle) $moodle = new moodle(required_param('moodle', PARAM_RAW));
        if (!$moodle->send_feedback_mails()) $this->create_messages(get_string('send_feedback_mails', 'launcher')); // Error in sending feedback mails

        $this->get_view(array('moodle'=>$moodle), 'show');
    } // function show


    function create($moodle = false) {
        global $CFG;
        //$this->has_access_rights();
        $moodle = new moodle(required_param('moodle', PARAM_RAW));
        if (!$moodle->insert()) return $this->edit($moodle);

        //return $this->show($moodle);
        // return redirect($CFG->wwwroot, get_string('msg_success', 'launcher'));
    } // function create

}
?>
