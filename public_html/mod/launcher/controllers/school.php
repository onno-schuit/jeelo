<?php

class school_controller extends controller
{

	function index() {
		$this->has_access_rights();
		
        $this->add_school();

	}

	function add_school($school = false) {
		$this->has_access_rights();
		
		$this->get_view(array('school'=>$school), 'add_school');
		
	}
	
	function create_school() {
		$this->has_access_rights();
		
        require_once('models/school.php');
        $school = new school(required_param('school', PARAM_RAW));

        if (!$school->validate_and_create()) return $this->add_school($school);
        
        // If all done
		exit("Redirect to confirm action");
        // $this->confirm($school);
	}
}

?>
