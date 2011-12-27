<?php
require_once($CFG->dirroot.'/mod/soda/class.user.php');
class moodle extends user {

    static $table_name = 'launcher_moodles';

    function set_defaults() {
        global $CFG;

        if (!isset($this->site_shortname) || $this->site_shortname == '') print_error('Key variables not found.', 'launcher');

        // Site variables
        $this->site->shortname   = $this->site_shortname;
        $this->site->name        = $this->site_name;
        $this->site->description = $this->site_description;

        // DB variables
        $this->db->host          = $CFG->dbhost;
        $this->db->name          = $this->get_site_real_name();
        $this->db->username      = $this->get_site_real_name();
        $this->db->password      = $this->create_password();
        
        // Config variables
        $this->cfg->wwwroot      = "http://{$this->db->host}/{$this->get_site_real_name()}";
        $this->cfg->dirroot      = "{$this->get_global_root()}/{$this->get_site_real_name()}/public_html";
        $this->cfg->dataroot     = "{$this->get_global_root()}/{$this->get_site_real_name()}/moodledata";

        // User variables
        $this->user->username    = 'admin';
        $this->user->password    = $this->create_password();
        $this->user->firstname   = 'Admin';
        $this->user->lastname    = 'user';
        $this->user->email       = $this->user_email;
        $this->user->city        = 'Changeme';

        return true;
    } // function load_defaults


    function define_validation_rules() {
        $this->add_rule('site_name', get_string('required'), function($site_name) { return ( trim($site_name) != '' ); });
        $this->add_rule('site_shortname', get_string('required'), function($site_shortname) { return ( trim($site_shortname) != '' ); });

        if (!$obj->msg = $this->get_site_real_name()) $obj->msg = '';
        $this->add_rule('site_shortname', get_string('maxlength', 'launcher', $obj), function($shortname_stripped) { return ( strlen($shortname_stripped) <= 16 ); });
        $this->add_rule('site_shortname', get_string('unique', 'launcher', $obj), function($shortname_stripped) {
            return ( !get_record('launcher_moodles', 'shortname', $shortname_stripped) );
        });
    } // function define_validation_rules


    function get_site_real_name() {

        if (!isset($this->site_shortname)) return false;
        return strtolower(preg_replace("/[^a-z_0-9]+/i", "", $this->site_shortname));
    } // function get_stripped_shortname


    function get_global_root() { 
        global $CFG;

        $dirroot = '';
        $dirroot_stripped = explode('/', $CFG->dirroot, -2);
        for($i = 0; $i < count($dirroot_stripped); $i ++)
        {
            if ($dirroot_stripped[$i] == '') continue;
            $dirroot .= '/'.$dirroot_stripped[$i];
        }

        return $dirroot;
    } // function get_dirroot_stripped


    function insert() {
        global $CFG, $launcher;
        $this->launcher_id = $launcher->id;

        if (!$this->validate()) return false; // Validate form
        if (!$this->set_defaults()) return false; // set all default variables
        if (!$this->create_moodle()) return false; // Copy the moodle codebase & database

        return true;
    } // function insert


    function insert_moodle() {
        global $CFG, $id;

        $obj->name          = $this->site->name;
        $obj->shortname     = $this->site->shortname;
        $obj->description   = (isset($this->site->description) && $this->site->description != '') ? $this->site->description : '';
        $obj->launcher_id   = $id;

        return (insert_record('launcher_moodles', $obj));
    } // function insert_moodle

    
    function create_dbuser() {
        global $CFG;
        
        $error = false;
        $query = "
        CREATE USER
            '{$this->db->name}'@'{$this->db->host}'
            IDENTIFIED BY '".key($this->db->password)."'";
        if (!execute_sql($query, false)) $error = true;

        $query = "
        GRANT ALL PRIVILEGES
            ON {$this->db->name} . *
            TO '{$this->db->name}'@'{$this->db->host}'
            IDENTIFIED BY '".key($this->db->password)."'
            WITH GRANT OPTION";
        if (!execute_sql($query, false)) $error = true;

        return (!$error);
    } // function create_dbuser_and_admin


    function create_admin() {
        global $CFG;
        $error = false;

        $con = mysql_connect($this->db->host, $this->db->name, key($this->db->password));
        mysql_select_db($this->db->name);
        $query = "
            UPDATE {$CFG->prefix}user SET
                username   = '{$this->user->username}',
                password   = '{$this->user->password[key($this->user->password)]}',
                email      = '{$this->user->email}',
                firstname  = '{$this->user->firstname}',
                lastname   = '{$this->user->lastname}',
                city       = '{$this->user->city}'
            WHERE username = 'admin'";
        if (!mysql_query($query)) die(mysql_error());
        mysql_close($con);
        return (!$error);
    } // function create_admin


    function create_moodle() {
        global $CFG;

        $start_time = $this->get_page_time();

        $this->recursive_copy($this->get_global_root(), $this->cfg->dirroot, $this->db->name);

        $query = "CREATE DATABASE {$this->db->name}";
        execute_sql($query, false);

        passthru("mysql -u root -pmenno {$this->db->name} < {$CFG->dataroot}/moodle_fresh.sql");
        passthru("ln -s {$this->cfg->dirroot}/{$this->db->name}/public_html /var/www/{$this->db->name}");

        if (!$this->create_dbuser()) print_error('launcher', 'Failed to create database user for the new moodle environment.');
        if (!$this->create_admin()) print_error('launcher', 'Failed to create admin user for the new moodle environment.');
        if (!$this->create_config()) print_error('launcher', 'Failed to edit config.php.');
        include('test.php');
        if ($error) echo "Something went wrong. Please try to upload the remaining users manually.";
        unset($error);
 
        $this->upgrade_modules($this->cfg->dataroot);

        if (!$this->insert_moodle()) return false; // Save new moodle environment in database

        $this->store_load_time($start_time);
 
        return true;
    } // function create_moodle


    function create_config() {
        global $CFG;

        $error = false;
        if (!$config = fopen("{$this->cfg->dirroot}/{$this->db->name}/public_html/config.php", "w")) return false;
        // Avoiding whitespaces in config file
        $config_input = '<?php
unset($CFG);
global $CFG;
$CFG = new stdClass();
$CFG->dbtype    = "mysqli";
$CFG->dblibrary = "native";
$CFG->dbhost    = "'.$this->db->host.'";
$CFG->dbname    = "'.$this->db->name.'";
$CFG->dbuser    = "'.$this->db->name.'";
$CFG->dbpass    = "'.key($this->db->password).'";
$CFG->prefix    = "'.$CFG->prefix.'";
$CFG->dboptions = array (
"dbpersist" => 0,
"dbsocket" => 0,
);
$CFG->wwwroot   = "'.$this->cfg->wwwroot.'";
$CFG->dataroot  = "'.$this->cfg->dirroot.'/'.$this->db->name.'/public_html";
$CFG->admin     = "admin";
require_once(dirname(__FILE__) . "/lib/setup.php");';
        if (!fwrite($config, trim($config_input))) return false;
        if (!fclose($config)) return false;

        return true;
    } // function create_config


    function get_page_time() {

        $starttime = microtime();
        $startarray = explode(" ", $starttime);
        $starttime = $startarray[1] + $startarray[0];

        return $starttime;
    } // function start_page_timer


    function store_load_time($start_time) {
        global $launcher;
        $oldtime = get_record('launcher', 'id', $launcher->id);
        $end_time = $this->get_page_time();
        $obj->id = $launcher->id;
        $obj->average_loadtime = $oldtime->average_loadtime + ($end_time - $start_time);
        $obj->installed = $oldtime->installed + 1;

        return (update_record('launcher', $obj));
    } // function store_load_time


    function get_average_loadtime() {
        global $CFG, $launcher;

        $sql = "
            SELECT (
                average_loadtime / installed
            ) as loadtime
            FROM {$CFG->prefix}launcher
            WHERE id = {$launcher->id}";
        $average_load_time = get_record_sql($sql);

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

        $filename = "$root/upgrade.php";
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
        if(!$diffDir) $diffDir = $source;
        mkdir($dest . '/' . $diffDir);
       
        while($resource = readdir($sourceHandle)){

            if (is_dir($source . '/' . $resource) && $resource == 'launcher') continue;

            if($resource == '.' || $resource == '..'
                || $source . '/' . $resource == "{$this->cfg->dirroot}{$this->db->name}/public_html/config.php"
                || $resource == 'moodle_fresh.sql') continue;
           
            if(is_dir($source . '/' . $resource)){
                $this->recursive_copy($source . '/' . $resource, $dest, $diffDir . '/' . $resource);
            } else {
                copy($source . '/' . $resource, $dest . '/' . $diffDir . '/' . $resource);
            }
        }
    }


    function send_feedback_mails() {

        // email_to_user();
        return true;
    } // function sendmails

}
?>
