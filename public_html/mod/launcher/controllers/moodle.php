<?php
class moodle_controller extends controller
{

    function index() {
        global $CFG;
        $this->has_access_rights();
        
        $this->edit();
	} // function index

	
    function edit($moodle = false) {
        $this->has_access_rights();

        $this->get_view(array('moodle'=>$moodle), 'edit');
    } // function edit


    function show($moodle) {
        $this->has_access_rights();
        
        if (!$moodle) error("A required parameter ('moodle') was missing.");
        if (!$moodle->send_feedback_mails()) $this->create_messages(array('no_feedback_send'=>get_string('no_feedbackmail_send', 'launcher')));
        
        $this->get_view(array('moodle'=>$moodle), 'show');
    } // function show


    function create($moodle = false) {
        global $CFG;
        $this->has_access_rights();
        
        $moodle = new moodle(required_param('moodle', PARAM_RAW));
        if (!$moodle->insert()) return $this->edit($moodle);

        $this->show($moodle);
    } // function create

}
?>
