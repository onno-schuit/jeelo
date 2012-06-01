<?php

class upgrade_controller extends controller
{

	function index() {
		$this->has_access_rights();
		
        $this->add_upgrade();
    }

    function add_upgrade($upgrade = false) {
        $this->get_view(array('upgrade'=>$upgrade), 'upgrade');
    }

}
?>
