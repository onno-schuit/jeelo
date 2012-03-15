<?php

require_once("class.db.php");

class base {

    static $db;
    static $log_file = 'default_log.txt';
    
    public static function init_db($host, $user, $pass, $db) {
        self::$db = new Database_Mysql();
        self::$db->connect($host, $user, $pass, $db);
    }
    
    public static function create_hash_from_query_string($query_string) {
        $salt = "Solin's Secret Here!"; // something random
        $hash = md5($salt . $query_string);
        return $hash;
    }
    
    public static function log($message) {
        // error_reporting(0);
        $fp = fopen(static::$log_file, 'a');
        fputs($fp, date("Y-m-d H:i:s") . " " . $message . "\n");
        fclose($fp);
    }

    
}

?>
