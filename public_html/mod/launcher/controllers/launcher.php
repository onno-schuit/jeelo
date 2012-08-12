<?php
class launcher_controller extends controller
{
    static $_path = '/etc/moodle_clients';

	function index()
	{
		$this->redirect_to('index', array('controller'=>'school'));
	} // function index


    public static function get_theme_setting($key, $theme = 'theme_formal_white') {
        global $DB;
        if (! $setting = $DB->get_record('config_plugins', array('plugin' => $theme, 'name' => $key))) return '';
        return $setting->value;
    } // function get_theme_setting

    
    function dump_codebase() {
        global $CFG;
        $target = self::$_path . '/upgrade_codebase.tgz';
        
        $siteroot = str_replace('/public_html', '', $CFG->dirroot);
        $cmd = "cd $siteroot ; tar -czp --exclude='public_html/config.php' -f {$target} public_html/*";
        return shell_exec($cmd);
    } // function dump_codebase
}
?>
