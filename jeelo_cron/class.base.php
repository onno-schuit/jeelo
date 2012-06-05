<?php

require_once("class.db.php");

class base {

    static $db;
    //static $log_file = 'default_log.txt'; // probably not used!
    
    public static function init_db($host=false, $user=false, $pass=false, $database_name=false) {

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
