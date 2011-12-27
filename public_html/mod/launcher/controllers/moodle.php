<?php
class moodle_controller extends controller
{

    function index() {
        global $CFG;
        
        $this->edit();
	} // function index

	
    function edit($moodle = false) {

        if (!$moodle) $moodle = new moodle(false);

        $this->get_view(array('moodle'=>$moodle), 'edit');
    } // function edit


    function show($moodle = false) {
        
        if (!$moodle) $moodle = new moodle(required_param('moodle', PARAM_RAW));
        if (!$moodle->send_feedback_mails()) $this->create_messages(get_string('send_feedback_mails', 'launcher')); // Error in sending feedback mails

        $this->get_view(array('moodle'=>$moodle), 'show');
    } // function show


    function create($moodle = false) {
        global $CFG;
        $moodle = new moodle(required_param('moodle', PARAM_RAW));
        if (!$moodle->insert()) return $this->edit($moodle);

        return $this->show($moodle);
        // return redirect($CFG->wwwroot, get_string('msg_success', 'launcher'));
    } // function create

}
?>
