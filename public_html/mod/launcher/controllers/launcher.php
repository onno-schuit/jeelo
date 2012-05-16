<?php
class launcher_controller extends controller
{
	function index()
	{
		$this->redirect_to('index', array('controller'=>'school'));
	} // function index
}
?>
