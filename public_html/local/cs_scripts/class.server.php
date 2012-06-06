<?php

require_once("class.base.php");

class server extends base {

    static $log_file = './server_log.txt';
    /*
    static $dirroot = '/home/www/jeelo/public_html';
    static $wwwroot = 'http://jeelo.debian.lcal';
     */
    static $possible_groups = array(array('1', '2'), array('3', '4'), array('5', '6'), array('7', '8'));
    static $prepaired_status_array = array('prepaired_school', 'prepaired_schoolyear', 'prepaired_upgrade');
    // status can also be: being_processed
    //

    /**
     * Checks if the request is valid by comparing the hash with our calculated hash; dies with error if 
     * hash is not correct
     * 
     * @param string $query_string
     * @return bool
     */
    public static function check_hash($query_string) {
        
        /// FOR TESTING PURPOSES: TODO: remove return!
        return true;
        
        // extract variables: $hash
        extract(self::_export_query_string($query_string, 'hash')); // puts query string into separate variables
        
        $query_string = preg_replace('/\&hash=[0-9a-z]+/', '', $query_string); // remove &hash=xxxxxxx from query_string
        $calculated_hash = self::create_hash_from_query_string($query_string);
        
        if ($calculated_hash !== $hash) { // $hash has been extracted with extract() function
            die('error: invalid hash'); 
        }
        return true;
    } // function check_hash


    /* Deletes courses and categories from database
     * To be called after an update has been succesfull */
    public static function handle_request_clean_buffer_db($query_string) {

        extract(self::_export_query_string($query_string, 'for')); // puts query string into separate variables
        
        $db = self::$db; // makes it easier to use
        $for = str_replace("'", '', $for); // sanitize user input

        $query = "DELETE FROM jeelo_buffer.client_courses WHERE client_moodle_id = '$id'";
        $db->query($query);
        $query = "DELETE FROM jeelo_buffer.client_categories WHERE client_moodle_id = '$id'";
        $db->query($query);

        return true;
    } // function handle_request_clean_buffer_db

    
    /**
     * Echos csv of all available records
     * 
     * @param string $query_string
     * @return void
     */
    public static function handle_request_get_available_clients($query_string) {
        // create vars: $request,$for,$hash from query_string
        //server.php?request=get_available_clients&for=client
        extract(self::_export_query_string($query_string, 'for')); // puts query string into separate variables

        $db = self::$db; // makes it easier to use
        $for = str_replace("'", '', $for); // sanitize user input

        $query = "SELECT * FROM client_moodles WHERE is_for_client='$for' AND status IN ('" . join(static::$prepaired_status_array, "', '") . "')";
        self::log($query);

        $rows = $db->fetch_rows($query);

        foreach ($rows as $row) {
            foreach($row as $key=>$column){
                echo ($key != 'timemodified') ? "$column;" : $column;
            }
            echo "\n";
        }

        die();
    } // function handle_request_get_available_clients

    /**
     * Sends file back if criteria are met; otherwise prints error
     * 
     * @param string $query_string
     * @return void
     */
    public static function handle_request_get_database($query_string) {
        // create vars: $request,$for,$hash from query_string
        extract(self::_export_query_string($query_string, 'for,id')); // puts query string into separate variables
        
        $db = self::$db; // makes it easier to use
        $for = str_replace("'", '', $for); // sanitize user input

        // use sprintf to replace variables
        $query = sprintf("SELECT * FROM jeelo_buffer.client_moodles WHERE 
            id=%d AND is_for_client='%s'",
            $id, $for);
        // run the query
        $row = $db->fetch_row($query);
        
        if (!$row) {
            die('error: record not found');
        }
        
        if (!file_exists($row['sql_filename'])) {
            die('error: sql file not found');
        }
        
        // headers from php.net manual (readfile)
        header('Content-Description: File Transfer');
        header('Content-Type: application/octet-stream'); // or application/x-gzip or application/zip
        header('Content-Disposition: attachment; filename='.basename($row['sql_filename']));
        header('Content-Transfer-Encoding: binary');
        header('Expires: 0');
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        header('Content-Length: ' . filesize($row['sql_filename']));
        
        readfile($row['sql_filename']);
            
        die(); // no further output
    } // function handle_request_get_database


    public static function test() {
        $file = '/etc/moodle_clients/code/solin7.srv1a.jeelo.nl_code_1338648388.tgz';
        header('Content-Description: File Transfer');
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename='.basename($file));
        header('Content-Transfer-Encoding: binary');
        header('Expires: 0');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
        header('Pragma: public');
        header('Content-Length: ' . filesize($file));
        ob_clean();
        flush();
        readfile($file);
        exit;               
    } // function test


    public static function get_moodle_client_by_id($id) {
        $query = sprintf("SELECT * FROM {client_moodles} WHERE id=%d", $id);
        if (! $row = static::$db->fetch_row($query) ) {
            die('error: record not found');
        }               
        return $row;
    } // function get_moodle_client_by_id


    /**
     * Sends file back if criteria are met; otherwise prints error
     * 
     * @param string $query_string
     * @return void
     */
    public static function handle_request_get_codebase($query_string) {
        error_reporting(0); // notices and warnings interfere with zip download...
        // create vars: $request,$for,$hash from query_string
        extract(self::_export_query_string($query_string, 'id')); // puts query string into separate variables

        $moodle_client = static::get_moodle_client_by_id($id);
        static::send_file_to_client($moodle_client['codebase_filename']);
    } // function handle_request_get_codebase


    public static function send_file_to_client($file) {
        if (!file_exists($file)) {
			self::log("Failed to find codebase. File does not exist: $file");
			echo "no_file";
        }
        header('Content-Description: File Transfer');
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename='.basename($file));
        header('Content-Transfer-Encoding: binary');
        header('Expires: 0');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
        header('Pragma: public');
        header('Content-Length: ' . filesize($file));
        ob_clean();
        flush();
        readfile($file);
        exit;               
    } // function send_file_to_client


    public static function handle_request_get_csv_zip($query_string) {
        error_reporting(0); // notices and warnings interfere with zip download...
        extract(self::_export_query_string($query_string, 'id')); // puts query string into separate variables

        $moodle_client = static::get_moodle_client_by_id($id);
        static::send_file_to_client($moodle_client['csv_filename']);
    } // function handle_request_get_csv_zip

    
    function handle_request_remove_codebase($query_string) {
        /// for testing purposes
        return;
		// create vars: $request,$for,$hash from query_string
        extract(self::_export_query_string($query_string, 'id')); // puts query string into separate variables
        $moodle_client = static::get_moodle_client_by_id($id);
		shell_exec("rm " . $moodle_client['codebase_filename']);
	} // function handle_request_remove_codebase


    function handle_request_get_courses($query_string) {
        extract(self::_export_query_string($query_string, 'client_moodle_id')); // puts query string into separate variables
        
        $db = self::$db; // makes it easier to use

        // use sprintf to replace variables
        $query = "SELECT * FROM client_courses WHERE client_moodle_id = '$client_moodle_id';";
        
        self::log($query);
        
        // run the query
        $rows = $db->fetch_rows($query);
        if (count($rows) == 0) die(); // Die immediately if no records are found
        
        foreach ($rows as $row) {
            echo join(';', $row);
            echo "\n";
        }
        // halt
        die();
    } // function handle_request_get_courses


    function handle_request_get_categories($query_string) {

        extract(self::_export_query_string($query_string, 'client_moodle_id')); // puts query string into separate variables
        
        $db = self::$db; // makes it easier to use

        // use sprintf to replace variables
        $query = sprintf("SELECT * FROM {client_categories} WHERE client_moodle_id = '%s'", $client_moodle_id);
        self::log($query);

        // run the query
        $rows = $db->fetch_rows($query); 

        foreach ($rows as $row) {
            echo join($row,';');
            echo "\n";
        }

        // halt
        die();
    } // function handle_request_get_categories


    /**
     * Updates status and exit code of a record if criteria are met; otherwise prints error
     * 
     * @param string $query_string
     * @return void
     */
    public static function handle_request_set_status($query_string) {
        // create vars: $request,$for,$hash from query_string
        extract(self::_export_query_string($query_string, 'for,id,status')); // puts query string into separate variables
        
        $db = self::$db; // makes it easier to use
        $for = str_replace("'", '', $for); // sanitize user input
        if (!in_array($status, array('new','being_processed', 'processed'))) {
            die('invalid status');
        }
        $exit_code = isset($exit_code) ? $exit_code : 0;

        // use sprintf to replace variables
        $query = sprintf("UPDATE {client_moodles} 
            SET status='%s', exit_code=%d
            WHERE id=%d AND is_for_client='%s'", 
            $status, $exit_code, $id, $for);
            
        // run the query
        $db->query($query);
        die('ok');
    } // function handle_request_set_status
    
    /**
     * Converts query_string to indexed array 
     * 
     * @param string $query_string
     * @param string $required fields (comma separated)
     * @return array
     */
    protected static function _export_query_string($query_string, $required_fields='') {
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
    } // function _export_query_string


    public static function handle_request_get_moodle_client_by_id($query_string) {
        extract(self::_export_query_string($query_string, 'client_moodle_id')); // puts query string into separate variables
        
        $db = self::$db; // makes it easier to use

        // use sprintf to replace variables
        $query = "SELECT * FROM client_moodles WHERE id = '$client_moodle_id';";
        
        self::log($query);
        
        // run the query
        $rows = $db->fetch_rows($query);
        if (count($rows) == 0) die(); // Die immediately if no records are found
        
        foreach ($rows as $row) {
            echo join(';', $row);
            echo "\n";
        }
        // halt
        die();               
    } // function handle_request_get_moodle_client_by_id
    
} // class server 


?>
