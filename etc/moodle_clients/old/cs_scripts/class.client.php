<?php
require_once("class.base.php");
// For debugging:
error_reporting(E_ALL);
ini_set('display_errors','On');

class client extends base {
    
    static $client_name = 'client';
    static $server_url = 'http://127.0.0.1/jeelo19/cs_scripts/server.php';
    static $target_folder = '/home/jeelos/';
    static $log_file = './client_log.txt';
    static $log_echo = true;
    
 
    public static function create_database($csv_line) {
        $sql = "CREATE DATABASE `{$csv_line->short_code}`";
        self::log($sql);
        self::$db->query($sql);
    }
    
    public static function create_database_user($short_code) {
        $dbname = '' . $short_code; // no prefix
        $username = $short_code;
        $password = md5("SomeSalt" . $username);
        
        $sql = sprintf("CREATE USER '%s'@'localhost' IDENTIFIED BY '%s'", $username, $password);
        self::log($sql); // NEEDS TO BE DISABLED ON LIVE SERVER
        self::$db->query($sql);

        $sql = sprintf("GRANT USAGE ON * . * TO '%s'@'localhost' IDENTIFIED BY '%s' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0", $username, $password);
        self::log($sql); // NEEDS TO BE DISABLED ON LIVE SERVER
        self::$db->query($sql);

        $sql = sprintf("GRANT SELECT , INSERT , UPDATE , DELETE , CREATE , DROP , INDEX , ALTER , CREATE TEMPORARY TABLES , CREATE VIEW , EVENT, TRIGGER, SHOW VIEW , CREATE ROUTINE, ALTER ROUTINE, EXECUTE ON `%s` . * TO '%s'@'localhost'", $dbname, $username);
        self::log($sql);
        self::$db->query($sql);

        return array(
            'username' => $username,
            'password' => $password
        );

    }
    
    public static function create_codebase($csv_line) {
        $target = self::$target_folder . $csv_line->domain;
        self::log("Creating folder: $target");
        mkdir($target, 0755); // without the public_html folder

        // symlink the subdomain (demo.jeelo.nl);
        symlink("$target/public_html", "/var/www/{$csv_line->domain}");
        self::log("Creating symlink: $target/public_html, /var/www/{$csv_line->short_code}.jeelo.nl");
    }
    
    public static function get_codebase_from_server($csv_line) {
        $request = array(
            'request' => 'get_codebase',
            'id' => $csv_line->id
        );
        
        $response = self::get_server_response($request);
        // check if we have file contents or maybe an error
        if (strlen($response) < 100 && strstr($response, 'error')) {
            self::log($response);
            die();
        }
        
        // write contents to temp file
        $tmpfile = self::$target_folder . $csv_line->domain . '/site.tgz';
        self::log("Creating file " . $tmpfile);
        file_put_contents($tmpfile, $response);
        
        // extract contents
        $cmd = sprintf("tar -xz -C %s -f %s", dirname($tmpfile), $tmpfile);
        self::log($cmd);
        shell_exec($cmd); 
    }
    
    public static function get_db_from_server($csv_line) {
        $request = array(
            'request' => 'get_database',
            'id' => $csv_line->id
        );
        
        $response = self::get_server_response($request);
        // check if we have file contents or maybe an error
        if (strlen($response) < 100 && strstr($response, 'error')) {
            self::log($response);
            die();
        }
        
        // write contents to temp file
        $tmpfile = tempnam('/tmp', 'jmdl'); // prefix jmdl (jeelo moodle)
        self::log("Creating file " . $tmpfile . '.gz');
        file_put_contents($tmpfile . '.gz', $response);
        
        unset($response); // clear memory ?

        $cmd = sprintf("gunzip -c %s > %s", $tmpfile . '.gz' , $tmpfile);
        self::log($cmd);
        $output = shell_exec($cmd);

        // import into mysql
        $dbname = '' . $csv_line->short_code; // no prefix
        $add_password_switch = !empty(self::$db->pass) ? ("-p" . self::$db->pass) : ''; 
        $cmd = sprintf("mysql -u %s %s %s < %s", self::$db->user, $add_password_switch, $dbname, $tmpfile);
        self::log($cmd); 
        
        $output = shell_exec($cmd); // command line execute
        self::log("Mysql ouput: [$output]"); // put mysql output into log file
        
    }
 
    public static function get_server_response($request) {
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
        
        $request_url = self::$server_url . '?' . $query_string;
        self::log($request_url);
        
        $response = file_get_contents($request_url);
        return $response;
    }
    

	public static function get_config_file($domain) {
		// Include neccesary config.php
        // exit(self::$target_folder."$domain/public_html/config.php");
        require_once(self::$target_folder."$domain/public_html/config.php");
        // include(self::$target_folder."$domain/public_html/config.php");
	}


    public static function process_client_from_csv($csv_line) {
        self::log("Processing id {$csv_line->id}, status {$csv_line->status}");
        
        // Update status FIRST
        // self::update_server_status($csv_line->id, 'being_processed');

        switch($csv_line->status) {
            case 'new':
                self::process_new_client($csv_line);
                break;
            case 'update':
                self::process_update_client($csv_line);
                break;
        }

        self::update_server_status($csv_line->id, 'processed', 0); // everything ok! 
    }


    public static function process_update_client($csv_line) {
		
		// self::get_config_file($csv_line->domain);
		
        include("class.client_updater.php");
        $client_updater = new client_updater();
        $client_updater->start_updater($csv_line);
    }


    public static function process_new_client($csv_line) {
        
        self::create_database($csv_line);
        $user_and_pass = self::create_database_user($csv_line->short_code);
        self::get_db_from_server($csv_line);
        
        self::create_codebase($csv_line);
        self::get_codebase_from_server($csv_line);

        self::update_moodle_config($csv_line, $user_and_pass);

        /*
        $user_and_pass = array("Admin", "blabla");
        self::email_school_created($csv_line, $user_and_pass);
         */
    }


    static public function email_school_created($csv_line, $user_and_pass) {

		self::get_config_file($csv_line->domain);
		
        $body = "School created blabla";
        $subject = "School created blabla";

        $admin = get_record('user', 'username', 'admin');

        return (email_to_user($admin, $CFG->noreplyaddress, $subject, $body, $body));
    }


    static public function run() {
        require_once("class.csv.php");
        
        $request = array(
            'request' => 'get_available_clients'
        );
        $response = self::get_server_response($request);
        
        if (!$response) {
           die(); // no clients available for processing.. do nothing 
        }
        
        $csv = new csv();
        $moodle_clients = $csv->build_csv_object($response, 'client_moodles');


        while($moodle_clients_line = $csv->nextline()) {
            self::process_client_from_csv($moodle_clients_line);
        }
    }
    
    static public function update_moodle_config($csv_line, $user_and_pass) {
        $folder = self::$target_folder . $csv_line->domain;

        $username = $user_and_pass['username'];
        $password = $user_and_pass['password'];
        
        $config_contents = file_get_contents($folder . '/public_html/config.php');

        $fields_to_change = array(
            '$CFG->dbpass'=>$password,
            '$CFG->dirroot'=>'/home/jeelos/'.$csv_line->domain.'/public_html',
            '$CFG->wwwroot'=>'http://localhost/'.$csv_line->domain,
            '$CFG->dataroot'=>'/home/jeelos/'.$csv_line->domain.'/moodle_data'
        );
        foreach($fields_to_change as $field=>$value) {

            $config_contents = self::set_config_contents($config_contents, $field, $value);
        
        }
        
        file_put_contents($folder .'/public_html/config.php', $config_contents);
    }


    function set_config_contents($config_contents, $field, $value) {

        $offset = strpos($config_contents, $field); // find the line with CFG->dbpass

        $start = strpos($config_contents, '"', $offset); // find first double quote from there
        $end = strpos($config_contents, '"', $start+1); // find next double quote

        $config_contents = substr($config_contents, 0, $start+1) . $value . substr($config_contents, $end);
        
        return $config_contents;
    }
    
    static public function update_server_status($record_id, $status, $exit_code=0) {
        $request = array(
            'request' => 'set_status',
            'id' => $record_id,
            'status' => $status,
            'exit_code' => $exit_code,
        );
        $response = self::get_server_response($request);
        self::log("Updated status for record $record_id to $status: $response");
    }
    
}

