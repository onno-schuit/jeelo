<?php
class moodle_helper extends helper
{

 	function has_access_rights()
	{
		global $context;
		require_login();
        
        return (has_capability('mod/launcher:access', $context));
	} // function has_assess_rights()
}

?>
