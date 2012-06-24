<?php

include_once('launcher.php');
class school_controller extends launcher_controller
{

	function index() {
		$this->has_access_rights();
        //$this->get_view(array('schools' => school::load_all("status NOT LIKE '%deleted%'")));
        $this->get_view(array('schools' => school::load_all()));
	} // function index


	function add_school($school = false) {
        global $CFG;

		$this->has_access_rights();
        
        $school = new school(array(
            'customcss' => static::get_theme_setting('customcss', 'theme_' . $CFG->theme),
            'logo' => static::get_theme_setting('logo', 'theme_' . $CFG->theme)
        ));
		$this->get_view(array('school'=>$school), 'add_school');
	}

	
	function create_school() {
        global $id;
		$this->has_access_rights();
		
        $school = new school($_POST['school']);
        if (!$school->validate_and_save()) return $this->add_school($school);
        
        // If all done
        $buffer_id_hash = md5("3nv!r0nm3nt {$school->buffer_id}");
        $url = "{$_SERVER['PHP_SELF']}?id=$id&controller=school&action=confirm&env=$buffer_id_hash";
        redirect($url);
	}


    function confirm() {
        $buffer_id_hash = required_param('env', PARAM_RAW);
        $this->get_view(array('buffer_id_hash'=>$buffer_id_hash), 'confirmed');
    }


    function delete() {
		$this->has_access_rights();
        school::save_all_without_validation(
            school::instantiate_all($_POST['schools']),
            $constants = array('status' => 'to_be_deleted')
        );
        $this->redirect_to('index');
    } // function delete
}

?>
