<?php

require_once("class.db.php");

class base {

    static $db;
    //static $log_file = 'default_log.txt'; // probably not used!
    static $server_url = 'http://localhost/jeelo/local/cs_scripts/server.php';
    static $target_folder =  '/home/jeelos';
    static $log_file =  '/var/log/jeelo/client.txt';
    
    public static function init_db($host=false, $user=false, $pass=false, $database_name=false) {
        $host = ($host) ? $host : static::$host;
        $user = ($user) ? $user : static::$user;
        $pass = ($pass) ? $pass : static::$pass;

        static::$db = new Database_Mysql();
        static::$db->connect($host, $user, $pass, $database_name);
    }
    
    public static function create_hash_from_query_string($query_string) {
        $salt = "Solin's Secret Here!"; // something random
        $hash = md5($salt . $query_string);
        return $hash;
    }
    
    public static function log($message) {
        // error_reporting(0);
        //return; // TEMP TEST
        if (!$fp = fopen(static::$log_file, 'a')) exit("Could not open log file " . static::$log_file . " for class base!");
        fputs($fp, date("Y-m-d H:i:s") . " " . $message . "\n");
        fclose($fp);
    } // function log

    
}

?>
