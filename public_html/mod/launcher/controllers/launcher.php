<?php
class launcher_controller extends controller
{
	function index()
	{
		$this->redirect_to('index', array('controller'=>'school'));
	} // function index


    public static function get_theme_setting($key, $theme = 'theme_formal_white') {
        global $DB;
        if (! $setting = $DB->get_record('config_plugins', array('plugin' => $theme, 'name' => $key))) return '';
        return $setting->value;
    } // function get_theme_setting
}
?>
