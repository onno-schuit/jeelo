<?php

class client_upgrade {
    
    static $info; // csv info from server
    
    function run($info) {
        self::$info = $info;
        self::backup_database();
        self::backup_codebase();
        self::backup_config();
        self::extract_codebase();
        self::restore_config();
        self::fire_moodle_cli_upgrade();
    }
    
    static public function backup_database() {
        global $mysql_dump_bin, $cs_dbuser, $cs_dbpass;
        
        $dbname = self::$info->shortcode;
        $target = '/tmp/djfsdfd';
        
        $cmd = sprintf($mysql_dump_bin . " -Qu %s %s --add-drop-table %s > %s",
            $cs_dbuser, $cs_dbpass ? '-p' . $cs_dbpass : '', $dbname, $target);
        die($cmd); 
    }
    
    static public function backup_codebase() {}
    static public function backup_config() {}
    static public function extract_codebase() {}
    static public function restore_config() {}
    static public function fire_moodle_cli_upgrade() {}
    
}