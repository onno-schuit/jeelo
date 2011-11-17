<?php
class moodle extends model {

    static $table_name = 'launcher_moodles';

    function define_validation_rules() {
        $this->add_rule('name', get_string('required'), function($name) { return ( trim($name) != '' ); });
        $this->add_rule('shortname', get_string('required'), function($shortname) { return ( trim($shortname) != '' ); });
        $this->add_rule('shortname', get_string('unique', 'launcher'), function($shortname) {
            global $DB;
            return ( !$DB->get_record('launcher_moodles', array('shortname'=>$shortname)) );
        });
    } // function define_validation_rules


    function insert() {
        global $CFG, $launcher;
        $this->launcher_id = $launcher->id;
        
        if (!$this->validate()) return false;//return false; // Validate form
        if (!$this->save()) return false; // Save new moodle environment
        if (!$this->copy_moodle()) print_error('launcher', 'Didn\'t work'); //return false;

        return true;
    } // function insert


    function copy_moodle() {
        global $CFG, $DB;
        
        require_once($CFG->dirroot.'/mod/launcher/lib.js');

        $source = "{$CFG->dirroot}";
        $root = "/home/menno/php_projects/";

        $start_time = $this->get_page_time();

        $this->recursive_copy($source, $root, $this->shortname);
        $query = "CREATE DATABASE {$this->shortname}";
        $DB->execute($query);

        passthru("mysql -u root -pmenno {$this->shortname} < /home/menno/php_projects/jeelo/mdl_fresh.sql");

        $this->upgrade_modules($root);
        
        $this->store_load_time($start_time);

        return true;
    } // function copy_moodle


    function get_page_time() {

        $starttime = microtime();
        $startarray = explode(" ", $starttime);
        $starttime = $startarray[1] + $startarray[0];

        return $starttime;
    } // function start_page_timer


    function store_load_time($start_time) {
        global $DB, $launcher;
        $oldtime = $DB->get_record('launcher', array('id'=>$launcher->id));
        $end_time = $this->get_page_time();
        $obj->id = $launcher->id;
        $obj->average_loadtime = $oldtime->average_loadtime + ($end_time - $start_time);
        $obj->installed = $oldtime->installed + 1;

        return ($DB->update_record('launcher', $obj));
    } // function store_load_time


    function get_average_loadtime() {
        global $DB, $CFG, $launcher;

        $sql = "
            SELECT (
                average_loadtime / installed
            ) as loadtime
            FROM {$CFG->prefix}launcher
            WHERE id = {$launcher->id}";
        $average_load_time = $DB->get_record_sql($sql);

        return round($average_load_time->loadtime);
    } // function get_average_loadtime


    function upgrade_modules($root) {

        if (!$upgrade_file = $this->create_upgrade_file($root)) print_error('launcher', 'Failed to create upgrade file');
        if (!$this->execute_upgrade($upgrade_file)) print_error('launcher', 'Failed to execute upgrade');
        if (!$this->delete_upgrade_file($upgrade_file)) print_error('launcher', 'Failed to delete upgrade file');
        
        return true;
    } // function upgrade_modules


    function execute_upgrade($upgrade_file) {
        global $CFG;
        require_once($upgrade_file);
        return true;
    } // function execute_upgrade


    function delete_upgrade_file($upgrade_file) {
        return (unlink($upgrade_file));
    } // function delete_upgrade_file


    function create_upgrade_file($root) {
        global $CFG;

        $filename = "$root/{$this->shortname}/upgrade.php";
        $upgrade_file = fopen($filename, 'w');
        $string = "<?php";
        $string .= "\n".'require_once("{$CFG->libdir}/upgradelib.php");';
        $string .= "\nupgrade_noncore(true)";
        $string .= "\n?>";
        fwrite($upgrade_file, $string);
        fclose($upgrade_file); // Now the file has been created

        return $filename;
    } // function create_upgrade_file


    function recursive_copy($source, $dest, $diffDir){
        $sourceHandle = opendir($source);
        if(!$diffDir)
                $diffDir = $source;
       
        mkdir($dest . '/' . $diffDir);
       
        while($res = readdir($sourceHandle)){
            if($res == '.' || $res == '..')
                continue;
           
            if(is_dir($source . '/' . $res)){
                $this->recursive_copy($source . '/' . $res, $dest, $diffDir . '/' . $res);
            } else {
                copy($source . '/' . $res, $dest . '/' . $diffDir . '/' . $res);
               
            }
        }
    } 
}
?>
