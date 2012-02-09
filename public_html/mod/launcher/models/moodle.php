<?php
require_once($CFG->dirroot.'/mod/soda/class.user.php');
class moodle extends user {

    static $table_name = 'launcher_moodles';


    function validate_and_create() {
        global $CFG, $launcher;
        $this->launcher_id = $launcher->id;

//        if (!$this->validate()) return false; // Validate form
        if (!$this->set_defaults()) return false; // set all default variables
        if (!$this->create_moodle()) return false; // Start the create moodle processes

        return true;
    } // function insert


    function set_defaults() {
        global $CFG;

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
        $this->cfg->wwwroot      = "http://localhost/{$this->get_site_real_name()}";
        $this->cfg->dirroot      = "{$this->get_global_root()}/{$this->get_site_real_name()}/public_html";
        $this->cfg->dataroot     = "{$this->get_global_root()}/{$this->get_site_real_name()}/moodle_data";

        // User variables
        $this->user->username    = 'admin';
        $this->user->password    = $this->create_password();
        $this->user->firstname   = 'Admin';
        $this->user->lastname    = 'user';
        $this->user->email       = $this->admin_email;
        $this->user->city        = 'Changeme';

        return true;
    } // function set_defaults


    function define_validation_rules() {

        $this->add_uploaded_files();

        $this->add_rule('site_name', get_string('required'), function($site_name) { return ( trim($site_name) != '' ); });
        $this->add_rule('site_shortname', get_string('required'), function($site_shortname) { return ( trim($site_shortname) != '' ); });
        $this->add_rule('admin_email', get_string('error_email', 'launcher'), function($admin_email) { return (validate_email($admin_email)); });

        $this->validate_files_received();

        $this->add_rule('upload_users', get_string('error_file_extension', 'launcher'), function($upload_users) {
            return ($upload_users['name'] != '') ? (end(explode(".", $upload_users['name'])) == 'csv') : true;
        });
        $this->add_rule('upload_groups', get_string('error_file_extension', 'launcher'), function($upload_groups) {
            return ($upload_groups['name'] != '') ? (end(explode(".", $upload_groups['name'])) == 'csv') : true;
        });

        if (!$obj->msg = $this->get_site_real_name()) return false;
        $this->add_rule('site_shortname', get_string('maxlength', 'launcher', $obj), function($shortname_stripped) {
            return ( strlen($shortname_stripped) <= 16 );
        });
        $this->add_rule('site_shortname', get_string('unique', 'launcher', $obj), function($shortname_stripped) {
            return ( !get_record('launcher_moodles', 'shortname', $shortname_stripped) );
        });
    } // function define_validation_rules


    function create_moodle() {
        global $CFG;

//        if (!$this->create_codebase()) launcher_helper::print_error('2000');
//        if (!$this->set_up_database()) launcher_helper::print_error('2001');
        if (!$this->insert_child_content()) launcher_helper::print_error('2002');
        
        // Set up static lin
        if (!$this->set_up_website()) launcher_helper::print_error('2003');

        // Finally, store key variables in the mother database
        if (!$this->save_child_in_mother_database()) launcher_helper::print_error('2004');

        return true;
    } // function create_moodle


    function create_codebase() {
        global $CFG;

        if (!$this->recursive_copy($CFG->dirroot, $this->get_global_root(), $this->get_site_real_name())) return false;
        if (!$this->create_config()) return false;

        return true;
    } // function create_codebase


    function set_up_database() {

        if (!$this->create_database()) return false;
        if (!$this->create_db_user()) return false;
        if (!$this->insert_database()) return false;
        if (!$this->create_site_admin()) return false;

        return true;
    } // function set_up_database


    function create_database() {
        $query = "CREATE DATABASE {$this->db->name}";

        return execute_sql($query, false);
    } // function create_database


    function insert_database() {
        global $CFG;
        // Inserting database using sudo command
        passthru("mysql -u root -pmenno {$this->db->name} < {$CFG->dataroot}/moodle_fresh.sql");

        $query = "SHOW TABLES";
        $result = launcher_helper::remote_execute($this, $query);

        return (mysql_num_rows($result) > 0) ? true : false;  
    } // function insert_database


    function insert_child_content() {
        require_once('class.content_uploader.php');

        $content_uploader = new content_uploader($this);
        $content_uploader->upload();

        $this->site->shortname   = $this->site_shortname;
        $this->site->name        = $this->site_name;
        $this->site->description = $this->site_description;
        $query = "UPDATE {$CFG->prefix}course SET
                    fullname = '{$this->site->name}',
                    shortname = '{$this->site->shortname}',
                    summary = '{$this->site->description}'
                  WHERE category = 0";

        return (launcher_helper::remote_execute($this, $query));
    } // function insert_child_content


    function set_up_website() {

        passthru("ln -s {$this->cfg->dirroot} /var/www/{$this->get_site_real_name()}");
        return ($this->website_is_linked());
    } // function set_up_website


    function website_is_linked() {
        exec(sprintf('ping -c 1 -W 5 %s', escapeshellarg($this->cfg->wwwroot)), $output, $result);
        return ($result === 0);
    }


    function add_uploaded_files() {
        if (!isset($_FILES)) return true;
        foreach($_FILES as $key=>$file) {
            $this->$key = $file;
        }
    } // function FunctionName


    function validate_files_received() {
        
        if ($this->upload_users['name'] == '' && $this->upload_groups['name'] != '') {
            soda_error::add_error($this, 'upload_users', get_string('error_groups_without_users', 'launcher'));
        }
        if ($this->upload_users['name'] != '' && $this->upload_groups['name'] == '') {
            soda_error::add_error($this, 'upload_groups', get_string('error_users_without_groups', 'launcher'));
        }

    } // function validate_files


    function get_site_real_name() {

        if (!isset($this->site_shortname)) return false;
        return strtolower(preg_replace("/[^a-z_0-9]+/i", "", $this->site_shortname));
    } // function get_stripped_shortname


    function get_global_root() { 
        global $CFG;

		$new_dirroot = '/home/menno/php_projects/jeelos';

        return $new_dirroot;
    } // function get_dirroot_stripped


    function save_child_in_mother_database() {
        global $CFG, $id;

        $child_site = new stdClass();
        $child_site->name          = $this->site->name;
        $child_site->shortname     = $this->site->shortname;
        $child_site->description   = (isset($this->site->description)) ? $this->site->description : '';
        $child_site->launcher_id   = $id;

        return (insert_record('launcher_moodles', $child_site));
    } // function save_child_in_mother_database

    
    function create_db_user() {
        global $CFG;
        
        $query = "
        CREATE USER
            '{$this->db->name}'@'{$this->db->host}'
            IDENTIFIED BY '".$this->get_password($this->db->password)."'";
        if (!execute_sql($query, false)) return false;

        $query = "
        GRANT ALL PRIVILEGES
            ON {$this->db->name} . *
            TO '{$this->db->username}'@'{$this->db->host}'
            IDENTIFIED BY '".$this->get_password($this->db->password)."'
            WITH GRANT OPTION";
        if (!execute_sql($query, false)) return false;

        return true;
    } // function create_db_user


    function create_site_admin() {
        global $CFG;

        $query = "
            UPDATE {$CFG->prefix}user SET
                username   = '{$this->user->username}',
                password   = '{$this->get_password_hash($this->user->password)}',
                email      = '{$this->user->email}',
                firstname  = '{$this->user->firstname}',
                lastname   = '{$this->user->lastname}',
                city       = '{$this->user->city}'
            WHERE username = 'admin'";

        return (launcher_helper::remote_execute($this, $query));
    } // function create_site_admin


    function create_config() {
        global $CFG;

        $error = false;
        if (!$config = fopen("{$this->cfg->dirroot}/config.php", "w")) return false;
        // Avoiding whitespaces in config file
        $config_input = '<?php // Moodle Configuration File

unset($CFG);

$CFG = new stdClass();
$CFG->dbtype    = "mysql";
$CFG->dbhost    = "'.$this->db->host.'";
$CFG->dbname    = "'.$this->db->name.'";
$CFG->dbuser    = "'.$this->db->username.'";
$CFG->dbpass    = "'.$this->get_password($this->db->password).'";
$CFG->dbpersist = false;
$CFG->prefix    = "'.$CFG->prefix.'";

$CFG->wwwroot   = "'.$this->cfg->wwwroot.'";
$CFG->dirroot   = "'.$this->cfg->dirroot.'";
$CFG->dataroot  = "'.$this->cfg->dataroot.'";
$CFG->admin     = "admin";

$CFG->directorypermissions = 00777;  // try 02777 on a server in Safe Mode';
if (isset($CFG->passwordsaltmain)) {
    $config_input .= '
$CFG->passwordsaltmain = "'.$CFG->passwordsaltmain.'";';
}
$config_input .= '
require_once("$CFG->dirroot/lib/setup.php");';

        if (!fwrite($config, trim($config_input))) return false;
        if (!fclose($config)) return false;

        return true;
    } // function create_config

/*    function get_page_time() {

        $starttime = microtime();
        $startarray = explode(" ", $starttime);
        $starttime = $startarray[1] + $startarray[0];

        return $starttime;
    } // function start_page_timer
 */

    function recursive_copy($source, $dest, $diffDir){
        global $CFG;

        $sourceHandle = opendir($source);
        if(!$diffDir) $diffDir = $source;
        if (!mkdir($dest . '/' . $diffDir)) return false;

        if ($dest == $this->get_global_root()) {
            return ($this->recursive_copy($source, $dest . '/' . $diffDir, 'public_html'));
        }
       
        while($resource = readdir($sourceHandle)){

            if (is_dir($source . '/' . $resource) && ($resource == 'launcher' || $resource == 'soda')) continue;

            if($resource == '.' || $resource == '..'
                || $source . '/' . $resource == "{$CFG->dirroot}/config.php"
                || $resource == 'moodle_fresh.sql') continue;
           
            if(is_dir($source . '/' . $resource)){
                $this->recursive_copy($source . '/' . $resource, $dest, $diffDir . '/' . $resource);
            } else {
                if (!copy($source . '/' . $resource, $dest . '/' . $diffDir . '/' . $resource)) return false;
            }
        }
        return true;
    }


    function send_feedback_mails() {
        global $CFG;

        $email_to = new stdClass();
        $email_to->mailformat = 1;
        $email_to->email = $this->user->email;
        $email_to->name = $this->user->firstname;

        $body = get_string('mail_feedback_body_start', 'launcher', $email_to);
        $body .= $this->get_feedback_body();
        $body .= get_string('mail_feedback_body_end', 'launcher', $email_to);
        $subject = get_string('mail_feedback_subject', 'launcher');

        return (email_to_user($email_to, $CFG->noreplyaddress, $subject, $body, $body));
    } // function sendmails
    
    
    function get_feedback_body() {
        $body = "
            <table border-collapse='collapse'>
                <tr><td><b>Database information</b></td></tr>
                <tr>
                    <td>Username</td>
                    <td>{$this->db->username}</td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td>".$this->get_password($this->db->password)."</td>
                </tr>
                <tr>
                    <td>Database name</td>
                    <td>{$this->db->name}</td>
                </tr>
                <tr><td>&nbsp;</td></tr><tr><td><b>Moodle Admin information</b></td></tr>
                <tr>
                    <td>Username</td>
                    <td>{$this->user->username}</td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td>".$this->get_password($this->user->password)."</td>
                </tr>
                <tr><td>&nbsp;</td></tr><tr><td><b>Website information</b></td></tr>
                <tr>
                    <td>URL</td>
                    <td>{$this->cfg->wwwroot}</td>
                </tr>
            </table>";
        
        // exit(print_object($body));
        return $body;
    } // function get_feedback_body
}
?>
