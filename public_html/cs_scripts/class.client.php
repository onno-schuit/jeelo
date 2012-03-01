<?php

require_once("class.base.php");

class client extends base {
    
    static $client_name = 'client';
    static $server_url = 'http://127.0.0.1/jeelo19/cs_scripts/server.php';
    static $target_folder = '/home/jeelos/';
    static $log_file = './client_log.txt';
    static $log_echo = true;
 
    public static function create_database($short_code) {
        $sql = "CREATE DATABASE `$short_code`";
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
    
    public static function create_codebase($domain, $short_code) {
        $target = self::$target_folder . $domain;
        self::log("Creating folder: $target");
        mkdir($target, 0755); // without the public_html folder

        // symlink the subdomain (demo.jeelo.nl);
        symlink($target, self::$target_folder . $short_code . ".jeelo.nl");
        // $cmd = sprintf("ln -s %s %s", $target, self::$target_folder . $short_code . ".jeelo.nl");
        self::log($cmd);
        shell_exec($cmd);
    }
    
    public static function get_codebase_from_server($record_id, $domain) {
        $request = array(
            'request' => 'get_codebase',
            'id' => $record_id
        );
        
        $response = self::get_server_response($request);
        // check if we have file contents or maybe an error
        if (strlen($response) < 100 && strstr($response, 'error')) {
            self::log($response);
            die();
        }
        
        // write contents to temp file
        $tmpfile = self::$target_folder . $domain . '/site.tgz';
        self::log("Creating file " . $tmpfile);
        file_put_contents($tmpfile, $response);
        
        // extract contents
        $cmd = sprintf("tar -xz -C %s -f %s", dirname($tmpfile), $tmpfile);
        self::log($cmd);
        shell_exec($cmd); 
    }
    
    public static function get_db_from_server($record_id, $short_code) {
        $request = array(
            'request' => 'get_database',
            'id' => $record_id
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
        $dbname = '' . $short_code; // no prefix
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
    
    public static function process_client_from_csv($csv_line) {
        self::log("Processing: $csv_line");
        list($id, $datetime, $domain, $short_code) = explode(';', $csv_line);
        
        self::update_server_status($id, 'being_processed'); 
        self::create_database($short_code);
        $user_and_pass = self::create_database_user($short_code);
        self::get_db_from_server($id, $short_code);
        
        self::create_codebase($domain, $short_code);
        self::get_codebase_from_server($id, $domain);
        self::update_moodle_config($domain, $user_and_pass); 
        
        
        
    }


    static public function run() {
        $request = array(
            'request' => 'get_available_clients',
        );
        $response = self::get_server_response($request);
        
        if (!$response) {
           die(); // no clients available for processing.. do nothing 
        }
        
        foreach (explode("\n", $response) as $csv_line) {
            if (strstr($csv_line, ';')) {
                self::process_client_from_csv($csv_line);
            }
        }
        
    }
    
    static public function update_moodle_config($domain, $user_and_pass) {
        $folder = self::$target_folder . $domain;
        list($username, $password) = $user_and_pass;
        // 2do: open config file and replace user and password
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


/*

- create database
- create database user + pw
- get database sql
- unzip and import db sql
- create www root folder
- get code base
- unzip code base
- create apache vhost file
- restart apache


*/
