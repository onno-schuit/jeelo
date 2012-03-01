<?php

require_once("class.db.php");

class base {

    static $db;
    
    static public function init_db($host, $user, $pass, $db) {
        self::$db = new Database_Mysql();
        self::$db->connect($host, $user, $pass, $db);
    }
    
}

class server extends base {
    
    /**
     * Echos csv of all available records
     * 
     * @param string $query_string
     * @return void
     */
    static public function handle_request_get_available_clients($query_string) {
        // create vars: $request,$for,$hash from query_string
        //server.php?request=get_available_clients&for=client
        extract(self::_export_query_string($query_string, 'for')); // puts query string into separate variables
        
        $db = self::$db; // makes it easier to use
        $for = str_replace("'", '', $for); // sanitize user input

        // use sprintf to replace variables
        $query = sprintf("SELECT * FROM client_moodles WHERE is_for_client='%s' AND status='new'", $for);
        // run the query
        $rows = $db->fetch_rows($query); 
        // output all rows as csv
        foreach ($rows as $row) {
            echo $row['id'] . ';' . $row['timecreated'] . ';' . $row['domain'] . "\n";
        }
        // halt
        die();
    }
    
    /**
     * Converts query_string to indexed array 
     * 
     * @param string $query_string
     * @param string $required fields
     * @return array
     */
    static protected function _export_query_string($query_string, $required_fields='') {
        // break string on the &-character
        $parts = explode('&', $query_string);
        foreach ($parts as $part) {
            list($varname, $value) = explode('=', $part); // break varname and value on the =-character
            $vars[$varname] = $value; // put it in the associative array
        }
        
        // check required vars
        if ($required_fields) {
            foreach (explode(',', $required_fields) as $field) {
                if (!isset($vars[$field])) {
                    throw new Exception("Required variable not found in query string: $field");
                }
            }
        }
        
        // return associative array
        return $vars;
    }

}

?>