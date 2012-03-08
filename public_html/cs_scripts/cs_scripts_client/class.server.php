<?php

require_once("class.base.php");

class server extends base {

    static $log_file = './server_log.txt';

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

        // use sprintf to replace variables
        $query = sprintf("SELECT * FROM {client_moodles} WHERE is_for_client='%s' AND (status='new' OR status='update')", $for);
        self::log($query);

        // run the query
        $rows = $db->fetch_rows($query); 
        // output all rows as csv
        foreach ($rows as $row) {
            echo "
                {$row['id']};
                {$row['short_code']};
                {$row['domain']};
                {$row['status']};
                {$row['sql_filename']};
                {$row['codebase_filename']};
                {$row['csv_filename']};
                {$row['is_for_client']};
                {$row['exit_code']};
                {$row['timecreated']};
                {$row['timemodified']};
                \n";
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
        $query = sprintf("SELECT * FROM {client_moodles} WHERE 
            id=%d AND is_for_client='%s' AND status='being_processed'",
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
        
        // headers from php.net manual (readfile)
        header('Content-Description: File Transfer');
        header('Content-Type: application/octet-stream'); // or application/x-gzip or application/zip
        header('Content-Disposition: attachment; filename='.basename($row['codebase_filename']));
        header('Content-Transfer-Encoding: binary');
        header('Expires: 0');
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        header('Content-Length: ' . filesize($row['codebase_filename']));
        
        readfile($row['codebase_filename']);
            
        die(); // no further output
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
