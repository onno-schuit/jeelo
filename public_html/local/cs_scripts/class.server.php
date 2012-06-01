<?php

require_once("class.base.php");

class server extends base {

    static $log_file = './server_log.txt';
    static $dirroot = '/home/jeelos/moeder/public_html';
    static $wwwroot = 'http://moeder.srv1a.jeelo.nl';
    static $possible_groups = array(array('1', '2'), array('3', '4'), array('5', '6'), array('7', '8'));

    /**
     * Checks if the request is valid by comparing the hash with our calculated hash; dies with error if 
     * hash is not correct
     * 
     * @param string $query_string
     * @return bool
     */
    public static function check_hash($query_string) {
        
        /// FOR TESTING PURPOSES:
        return true;
        
        
        // extract variables: $hash
        extract(self::_export_query_string($query_string, 'hash')); // puts query string into separate variables
        
        $query_string = preg_replace('/\&hash=[0-9a-z]+/', '', $query_string); // remove &hash=xxxxxxx from query_string
        $calculated_hash = self::create_hash_from_query_string($query_string);
        
        if ($calculated_hash !== $hash) { // $hash has been extracted with extract() function
            die('error: invalid hash'); 
        }
        return true;
    }


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
    }

    
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

        $status_arr = array('prepaired_school', 'prepaired_schoolyear', 'prepaired_upgrade');

        // use sprintf to replace variables
        $query = "SELECT * FROM client_moodles WHERE is_for_client='$for' AND status IN ('" . join($status_arr, "', '") . "')";
        self::log($query);

        // run the query
        $rows = $db->fetch_rows($query);

        foreach ($rows as $row) {
            foreach($row as $key=>$column){
                echo ($key != 'timemodified') ? "$column;" : $column;
            }
            echo "\n";
        }

        // halt
        die();
    }

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
    }

    /**
     * Sends file back if criteria are met; otherwise prints error
     * 
     * @param string $query_string
     * @return void
     */
    public static function handle_request_get_codebase($query_string) {

        // create vars: $request,$for,$hash from query_string
        extract(self::_export_query_string($query_string, 'for,id')); // puts query string into separate variables
        
        $db = self::$db; // makes it easier to use
        $for = str_replace("'", '', $for); // sanitize user input

        // use sprintf to replace variables
        $query = sprintf("SELECT * FROM {client_moodles} WHERE 
            id=%d AND is_for_client='%s' AND status='being_processed'",
            $id, $for);
        // run the query
        $row = $db->fetch_row($query);
        
        if (!$row) {
            die('error: record not found');
        }
        
        if (!file_exists($row['codebase_filename'])) {
            die('error: codebase file not found');
        }
		
		$cmd = "cp " . $row['codebase_filename'] . " " . self::$dirroot . "/site.tgz";
		self::log($cmd);
		shell_exec($cmd);
		
		if (!file_exists(self::$dirroot . "/site.tgz")) {
			self::log("Failed to copy codebase.");
			echo "no_file";
		} else {
			echo self::$wwwroot . "/site.tgz";
		}
		
        die(); // no further output
    }
    
    function handle_request_remove_codebase($query_string) {
		// create vars: $request,$for,$hash from query_string
        extract(self::_export_query_string($query_string, 'for')); // puts query string into separate variables
        
        $db = self::$db; // makes it easier to use
        $for = str_replace("'", '', $for); // sanitize user input

		shell_exec("rm " . self::$dirroot . "/site.tgz");
	}

    function handle_request_get_courses($query_string) {

        extract(self::_export_query_string($query_string, 'for,groupyear,client_moodle_id')); // puts query string into separate variables
        
        $courses_to_call = array();
        $groupyears = explode('/', $groupyear);
        unset($groupyear);
        
        // Get all the groups in an array for a join
        foreach($groupyears as $groupyear) {
            foreach(self::$possible_groups as $key=>$possible_group) {
                if (in_array($groupyear, $possible_group)) $courses_to_call[$key] = join('/', $possible_group);
            }
        }

        $sql_extra = '';
        $count = 0;
        foreach($courses_to_call as $key => $course_to_call) {
            $count ++;
            $sql_extra .= "'$course_to_call'";
            if ($count != count($courses_to_call)) $sql_extra .= ','; // Make sure we wont have a comma at the end
        }
        
        $db = self::$db; // makes it easier to use
        $for = str_replace("'", '', $for); // sanitize user input

        // use sprintf to replace variables
        $query = "SELECT * FROM client_courses
            WHERE groupyear IN ($sql_extra)
            AND client_moodle_id = '$client_moodle_id'
            AND category_id = '$category_id'";
        
        //exit($query);
        self::log($query);
        echo $query;
        
        // run the query
        $rows = $db->fetch_rows($query);
        if (count($rows) == 0) die(); // Die immidietly if no records are found
        
        foreach ($rows as $row) {
            foreach($row as $key=>$column){
                echo ($key != 'parent_category_id') ? "$column;" : $column;
            }
            echo "\n";
        }
        // halt
        die();
    }

    function handle_request_get_categories($query_string) {

        // create vars: $request,$for,$hash from query_string
        //server.php?request=get_available_clients&for=client
        extract(self::_export_query_string($query_string, 'for,client_moodle_id')); // puts query string into separate variables
        
        $db = self::$db; // makes it easier to use
        $for = str_replace("'", '', $for); // sanitize user input

        // use sprintf to replace variables
        $query = sprintf("SELECT * FROM {client_categories} WHERE client_moodle_id = '%s'", $client_moodle_id);
        self::log($query);

        // run the query
        $rows = $db->fetch_rows($query); 

        foreach ($rows as $row) {
            foreach($row as $key=>$column){
                echo ($key != 'client_moodle_id') ? "$column;" : $column;
            }
            echo "\n";
        }

        // halt
        die();
    }


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
    }
    
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
    }
    
}

?>
