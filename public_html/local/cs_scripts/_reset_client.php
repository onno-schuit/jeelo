<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);

require_once("class.base.php");
require_once("config.php");

class base_ext extends base {
    
    function reset() {
        $db = self::$db;
        
        $db->query("UPDATE client_moodles SET status='prepaired_school'");
    }
}
base_ext::init_db($cs_dbhost, $cs_dbuser, $cs_dbpass, $cs_dbname); // from config.php
base_ext::reset();

?>
