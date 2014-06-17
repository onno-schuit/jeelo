<?php
require_once("class.base.php");
require_once("config.php");
// For debugging:
error_reporting(E_ALL);
ini_set('display_errors','On');
set_time_limit(0);

class client extends base {
    
    static $client_name = 'client'; // probably not necessary ('for' is always 'client', so not useful)
    static $prefix = 'mdl_';

    static $host = 'localhost';

    static $server_url = 'http://localhost/jeelo/local/cs_scripts/server.php';
    static $target_folder =  '/home/jeelos26';
    static $log_file =  '/var/log/jeelo26/client.txt';



    public static function parent_test() {
        echo "Okay from client::parent_test";        
    } // function parent_test


    static public function run() {
        require_once("class.csv.php");
        
        //self::log("Checking for available clients.");
        
        $response = self::get_server_response( $request = array('request' => 'get_available_clients') );
        if ($response) {
            $csv = new csv();
            $moodle_clients = $csv->build_csv_object($response, 'client_moodles');
    
            while($moodle_clients_line = $csv->nextline()) {
                self::process_client_from_csv($moodle_clients_line);
            }
        }
        
        //self::log("Checking for upgrade.");
        $response = self::get_server_response( $request = array('request' => 'get_next_upgrade') );
        if (!$response) die(); // no clients available for processing.. do nothing
        self::process_upgrade($response);
        die();
        
    } // function run


    public static function process_client_from_csv($csv_line) {
        self::log("Processing id {$csv_line->id}, status {$csv_line->status}");
        switch($csv_line->status) {
            case 'prepaired_school':
                self::update_server_status($csv_line->id, 'being_processed', $csv_line->domain);
                self::process_new_client($csv_line);
                break;
            case 'to_be_deleted':
                self::update_server_status($csv_line->id, 'being_deleted', $csv_line->domain);
                static::delete_client($csv_line);
                break;
        }
    } // function process_client_from_csv


    public static function delete_client($csv_line) {
        static::remove_all_client_folders($csv_line);
        static::remove_from_apache($csv_line->domain);
        static::remove_from_buffer($csv_line->id);
        static::remove_database($database_name = $csv_line->shortcode);
        static::remove_database_account($username = $csv_line->shortcode);
    } // function delete_client


    // Removes client_moodle entries from buffer_db on central server
    public static function remove_from_buffer($client_moodle_id) {
        $request = array(
            'request'	=> 'remove_from_buffer',
            'client_moodle_id'		=> $client_moodle_id
        );
        self::get_server_response($request);
    } // function remove_from_buffer


    public static function remove_database($database_name) {
        global $cs_dbuser, $cs_dbpass;
        $sql = "DROP DATABASE `$database_name`;";
        self::log($sql);
        shell_exec("mysql -u{$cs_dbuser} -p{$cs_dbpass} -e '$sql'");
        //self::$db->query($sql);
    } // function remove_database


    public static function remove_database_account($username) {
        global $cs_dbuser, $cs_dbpass;
        $sql = "DROP USER '$username'@'localhost';";
        self::log($sql);
        shell_exec("mysql -u{$cs_dbuser} -p{$cs_dbpass} -e '$sql'");
        //self::$db->query($sql);
        $sql = "FLUSH PRIVILEGES;";
        shell_exec("mysql -u{$cs_dbuser} -p{$cs_dbpass} -e '$sql'");
        //self::$db->query($sql);
    } // function remove_database_account


    public static function remove_all_client_folders($csv_line) {
        foreach($csv_line as $column) {
            if (strpos($column, 'filename') === false) continue;
            shell_exec("rm -Rf $column");
        }
        $homefolder = static::get_or_create_home_folder($csv_line->domain);
        shell_exec("rm -Rf $homefolder");    
    } // function remove_all_client_folders


    public static function process_upgrade($line) {
        $info = csv::to_object($line, 'client_moodles');

        // download code base to tmp file
        $request = array(
            'request' => 'get_upgrade_codebase'
        );
        $target = '/tmp/codebase_upgrade.tgz';
        $info->codebase_upgrade = $target;
        
        $cmd = sprintf("wget -O $target '%s'", self::get_request_url($request));
        self::log($cmd);
        shell_exec( $cmd );
        
        // let the client_upgrade class handle the rest
        require_once(dirname(__FILE__) . "/class.client_upgrade.php");
        client_upgrade::run($info);
        
        self::update_server_status($info->id, 'upgraded', $info->domain, $end_of_process = 1); // all done!               
    }


    public static function process_new_client($csv_line) {
		self::log("Starting the creation of a new moodle school.");
        self::create_codebase($csv_line);
        $database_account = self::create_database($csv_line);
        self::create_moodle_config($database_name = $csv_line->shortcode,
            $database_user = $database_account['username'],
            $database_pass = $database_account['password'],
            $home_directory = static::get_or_create_home_folder($csv_line->domain)
        );
        self::create_moodle_datadir($csv_line->id, $home_directory);
        self::add_to_apache($csv_line);
        self::update_server_status($csv_line->id, 'first_install', $csv_line->domain);
    } // function process_new_client

    
    public static function create_database($csv_line) {
        $target_path = self::get_or_create_home_folder($csv_line->domain) . '/' . basename($csv_line->sql_filename);
        self::get_database_from_server($csv_line->id, $target_path);
        self::install_database($csv_line->shortcode, $target_path);
        self::truncate_logs($csv_line->shortcode);
        return self::create_database_account($csv_line->shortcode);
    } // function create_database 


    public static function truncate_logs($database_name) {
        global $cs_dbuser, $cs_dbpass;
        $sql = "TRUNCATE TABLE `" . self::$prefix . "log`;";
        shell_exec(sprintf("mysql -u%s -p%s -e '$sql' {$database_name}", $cs_dbuser, $cs_dbpass));
    } // function truncate_logs


    public static function get_database_from_server($client_moodle_id, $target) {
        self::log("Getting db from server for moodle_client id {$client_moodle_id}");
        $request = array(
            'request' => 'get_database',
            'id' => $client_moodle_id
        );
        $command =  sprintf("wget -O $target '%s'", self::get_request_url($request));
        print "\nclient::get_database_from_server shell_exec: $command\n";
        shell_exec($command);               
    } // function get_database_from_server


    /**
     * Reads variable apache conf file, replaces vars and writes to /apache/conf/domain.conf
     * /apache/conf path is set in config.php in $cs_apache_config_dir
     * 
     * @param mixed $csv_line
     * @return void
     */
    public static function add_to_apache($csv_line) {
        $destination = static::get_apache_conf_filename($csv_line->domain);
        self::log("Creating apache config file $destination");
        $contents = file_get_contents(dirname(__FILE__) . '/apache_vhost_file.txt');
        $contents = str_replace('{domain}', $csv_line->domain, $contents);
        $contents = str_replace('{shortcode}', $csv_line->shortcode, $contents);

        file_put_contents($destination, $contents);  
        self::log("File $destination created");
        static::restart_apache($csv_line->domain);
    } // function add_to_apache


    public static function remove_from_apache($domain) {
        $destination = static::get_apache_conf_filename($domain);
        shell_exec("rm -Rf $destination");
        static::restart_apache($domain);
    } // function remove_from_apache


    public static function restart_apache($domain) {
        self::log("Restarting apache for {$domain}");
        shell_exec('apachectl graceful');
        self::log("Apache restarted");
    } // function restart_apache


    public static function get_apache_conf_filename($domain) {
        global $cs_apache_conf_dir;
        $filename = preg_replace('/[^A-Za-z0-9_\.+]/', '', $domain);
        $filename = str_replace('.', '_', $filename);
        return $cs_apache_conf_dir  . '/' . $filename;
    } // function get_apache_conf_filename


    /* @param   string     $zip        Filename and path of the zip containing the database dump
     */
    public static function install_database($database_name, $zip) {
        global $cs_dbuser, $cs_dbpass;
        $sql = "CREATE DATABASE `$database_name` CHARACTER SET utf8 COLLATE utf8_general_ci;";
        self::log($sql);
        self::$db->query($sql);
        $command = sprintf("gunzip -c {$zip} | mysql -u%s -p%s {$database_name}", $cs_dbuser, $cs_dbpass);
        print "\nclient::install_database_from_server shell_exec: $command\n";
        shell_exec(sprintf("gunzip -c {$zip} | mysql -u%s -p%s {$database_name}", $cs_dbuser, $cs_dbpass));
    } // function install_database
    

    public static function create_database_account($database_name) {
        $username = $database_name;
        $password = md5("SomeSalt" . $username); // Unsafe...
        
		self::$db->query("CREATE USER '$username'@'localhost' IDENTIFIED BY '$password'");
		self::$db->query("GRANT USAGE ON $database_name . * TO '$username'@'localhost' IDENTIFIED BY '$password'");
		self::$db->query("GRANT ALL PRIVILEGES ON $database_name . * TO '$username'@'localhost';");
        self::log("Created database user for client database.");
		
        return array(
            'username' => $username,
            'password' => $password
        );
    } // function create_database_account
    

    public static function create_codebase($csv_line) {
        $target_path = self::get_or_create_home_folder($csv_line->domain) . '/' . basename($csv_line->codebase_filename);
        echo "\nclient::create_codebase - target path for codebase: $target_path\n";
		self::get_codebase_from_server($csv_line->id, $target_path);
        self::extract_codebase_contents($target_path);
        self::remove_codebase_from_server($csv_line->id);
    } // function create_codebase

    
    public static function get_or_create_home_folder($domain) {
        $home_folder = static::$target_folder . '/' . $domain;
        if (!file_exists($home_folder)) {
            self::log("Creating folder: " . $home_folder);
            mkdir($home_folder, 0755);
        }
        return $home_folder;
	} // function get_or_create_home_folder

	
    public static function extract_codebase_contents($zip_path) {
        $cmd = sprintf("tar -xz -C %s -f %s", dirname($zip_path), $zip_path);
        self::log($cmd);
        shell_exec($cmd);
        $master26 = dirname($zip_path) . '/master26';
        if (file_exists($master26)) {
            shell_exec(sprintf("mv $master26 %s", dirname($zip_path) . '/public_html'));
        }
        unlink($zip_path);
    } // function extract_codebase_contents


    public static function get_codebase_from_server($client_moodle_id, $target) {
        self::log("Getting codebase from server for moodle_client id {$client_moodle_id}");
        $request = array(
            'request' => 'get_codebase',
            'id'      => $client_moodle_id
        );
        shell_exec( $log = sprintf("wget -O $target '%s'", self::get_request_url($request)) );
        self::log($log);
    } // function get_codebase_from_server


    public static function remove_codebase_from_server($moodle_client_id) {
        $request = array(
            'request'	=> 'remove_codebase',
            'id'		=> $moodle_client_id
        );
        self::get_server_response($request);
    } // function remove_codebase_from_server
    

    public static function get_config_content($database_name, $database_user, $database_pass, $home_directory) {
        $domain = basename($home_directory);
        return "<?PHP
unset(\$CFG);
global \$CFG;
\$CFG = new stdClass();
\$CFG->dbtype    = 'mysqli';   
\$CFG->dblibrary = 'native';   
\$CFG->dbhost    = 'localhost';
\$CFG->dbname    = '$database_name';    
\$CFG->dbuser    = '$database_user';
\$CFG->dbpass    = '$database_pass';   
\$CFG->prefix    = '" . self::$prefix . "';
\$CFG->dboptions = array( 'dbpersist' => false, 'dbsocket'  => false, 'dbport'    => '',   );
\$CFG->dataroot  = '$home_directory/moodledata';
\$CFG->dirroot  = '$home_directory/public_html';
\$CFG->wwwroot  = 'http://$domain';
\$CFG->directorypermissions = 0777;
\$CFG->admin = 'admin';
require_once(dirname(__FILE__) . '/lib/setup.php');";
    } // function get_config_content

    
    public static function create_moodle_config($database_name, $database_user, $database_pass, $home_directory) {
        $configphp = static::get_config_content($database_name, $database_user, $database_pass, $home_directory);
        $filename = $home_directory . '/public_html/config.php';
        if (($fh = @fopen($filename, 'w')) !== false) {
            fwrite($fh, $configphp);
            fclose($fh);
            chmod($filename, 0644); // rw-r--r--
        }
    } // function create_moodle_config


    public static function create_moodle_datadir($client_moodle_id, $home_directory) {
        $dirname = $home_directory . '/moodledata';
        mkdir($dirname, 0777);
        chmod($dirname, 0777);
        $dirname = $home_directory . '/moodledata/temp/backup';
        mkdir($dirname, 0777, true); // recursive;

        $dirname = $home_directory . '/moodledata/lang';
        mkdir($dirname, 0777, true); // recursive;
        static::install_language_files($client_moodle_id, $home_directory);
        shell_exec("chmod -R 777 $home_directory/moodledata");
    }


    public static function install_language_files($client_moodle_id, $home_directory) {
        self::log("Installing language files into $home_directory/moodledata/lang");               
        $request = array(
            'client_moodle_id' => $client_moodle_id,
            'request' => 'get_language_zip'
        );
        $target_directory = $home_directory . '/moodledata/lang';
        if (!file_exists($target_directory)) {
            mkdir($target_directory , 0777, true); // recursive;
        }
        shell_exec( sprintf("wget -O {$target_directory}/lang.tgz '%s'", self::get_request_url($request)) );
        shell_exec( "cd $target_directory; tar -xzf lang.tgz; rm lang.tgz; chmod -R 777 *");
        shell_exec( "cd $home_directory; rm lang.tgz");
    } // function install_language_files


    static public function email_school_created($csv_line, $user_and_pass) {
        $query = "SELECT * FROM ".self::$prefix."user WHERE username = 'admin'";
        $result = self::remote_execute($csv_line, $query);
        $user = mysql_fetch_object($result);

        $subject = "Jeelo School aangemaakt";
        $body = "
            Hallo,<br /><br />
            Een nieuwe school is zojuist succesvol aangemaakt. De gegevens van de school staan hier onder.<br /><br />
            <table border-collapse='collapse'>

                <tr><td colspan='2'><hr /></td></tr>
                <tr><td colspan='2'><b>Website</b></td></tr>

                <tr>
                    <td>Naam</td>
                    <td>{$csv_line->name}</td>
                </tr>
                <tr>
                    <td>Link</td>
                    <td>http://{$csv_line->domain}</td>
                </tr>

                <tr><td colspan='2'><hr /></td></tr>
                <tr><td colspan='2'><b>Moodle Admin</b></td></tr>

                <tr>
                    <td>Gebruikersnaam</td>
                    <td>{$user->username}</td>
                </tr>
                <tr>
                </tr>
                
                <tr><td colspan='2'><hr /></td></tr>
            </table>
            <br /><br />
            Met vriendelijke groet,<br /><br />
            Jeelo Launcher 1.9";

        return (self::mail_with_headers($user->email, $body, $subject));
    } // function email_school_created


    static public function mail_with_headers($email_to, $body, $subject) {
        // To send HTML mail, the Content-type header must be set
        $headers  = 'MIME-Version: 1.0' . "\r\n";
        $headers .= '' . "\r\n";
        $headers .= 'From: Jeelo Launcher 1.9 <noreply@jeelo.nl>' . "\r\n";

        // Mail it
        mail($email_to, $subject, $body, $headers);
    } // function mail_with_headers


    static public function update_server_status($record_id, $status, $domain, $end_of_process = 0) {
        $request = array(
            'request' => 'set_status',
            'id' => $record_id,
            'status' => $status,
            'end_of_process' => $end_of_process,
        );
        $response = self::get_server_response($request);
        // TODO: see if we can make this more transparant, human readable. E.g.: include school name.
        self::log("Updated status for $domain with id $record_id to $status: $response");
    } // function update_server_status

    
    public static function get_server_response($request, $debug = false) {
		$request_url = self::get_request_url($request);
        //print_object($request_url);
        if ($debug) echo die(var_dump($request_url));
        $response = file_get_contents($request_url);
        
        return $response;
    } // function get_server_response


    public static function get_request_url($request) {
        global $cs_server_url;
        if (!is_array($request)) {
            throw new Exception("Parameter should be an associative array");
        }
        $request['for'] = self::$client_name;
 
        $pairs = array();
        foreach ($request as $varname=>$value) {
            $pairs[] = "$varname=$value";
        }
        $query_string = join('&', $pairs);
 
        // add hash to the $query_string
        $hash = self::create_hash_from_query_string($query_string);
        $query_string .= "&hash=$hash";
        
        $request_url = $cs_server_url . '?' . $query_string;
        //self::log($request_url);
        
        return $request_url; 
    } // function get_request_url


} // class client 

