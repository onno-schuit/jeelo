<?php
global $CFG;

require_once($CFG->dirroot.'/mod/soda/class.model.php');
class schoolyear extends model {

    static $table_name = 'launcher_moodles';


    function set_environment_details() {
        // Set the right properties
        if (!$environment = get_record('launcher_moodles', 'id', $this->environment_id)) { // Only happens when someone re-selected the 'select' option
            $this->site_name = '';
            $this->site_description = '';
            return true;
        }
        $this->environment = $environment;

        $this->site_name = $this->environment->name;
        $this->site_description = $this->environment->description;

        unset($this->environment_id);
        return true;
    } // function set_environment_details


    function validate_and_create() {

        $this->set_environment_details();

        return false;
    } // function insert


    function define_validation_rules() {


    }

}



?>

