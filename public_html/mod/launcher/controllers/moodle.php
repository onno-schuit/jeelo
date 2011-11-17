<?php
class moodle_controller extends controller
{

    function index() {
        global $CFG;
        
        $this->edit();


        /* Script to upgrade modules
         * Create a file, place it on the child moodle environment. Run the file, then delete it.
         * Inside the file have these two files:
         * require_once($CFG->libdir.'/upgradelib.php');
         * upgrade_noncore(true));*/

	} // function index

	
    function edit($moodle = false) {

        if (!$moodle) $moodle = new moodle(false);

        $this->get_view(array('moodle'=>$moodle), 'edit');
    } // function edit


    function show() {

    } // function show



    function create() {
        global $CFG;
        $moodle = new moodle(required_param('moodle', PARAM_RAW));
        if (!$moodle->insert()) return $this->edit($moodle);
        
        return redirect($CFG->wwwroot, get_string('msg_success', 'launcher'));
    } // function create

//
//    function loading() {
//        $this->get_view();
//    } // function loading
}
?>
