<?php
class moodle_controller extends controller
{

	function index() {
        
        $this->edit();
	} // function index

	
    function edit() {

        $this->get_view(array('moodle'));
    } // function edit


    function show() {

    } // function show


    function create() {

    } // function create
}
?>
