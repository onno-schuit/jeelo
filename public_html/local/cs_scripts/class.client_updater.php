<?php
require_once('../../../jeelo_cron/class.client.php');

/**
 * This class runs on local Moodle clients. It should be invoked as a cron job.
 * The class has two functions:
 *
 * - upgrade Moodle code base
 * - 'new schoolyear' / import courses, categories, groups & users scenario
 *
 *
 * If you run client_updater#main, it will check with the 'server' (buffer db wrapper)
 * to see if there are any tasks for this particular Moodle.
 */

require_once("class.base.php");

class client_updater extends base {
    
    static $client_name = 'client'; // for future use when we have more client machines..
    static $_client_id;
    static $log_file = '/var/log/jeelo/client.txt';

    static public function run() {
        global $CFG;
        
        $shortname = $CFG->dbname;
        
        self::log(sprintf("Checking update status for current installation (%s)", $shortname));
        
        $response = self::get_server_response( $request = array('request' => 'get_status',
            'shortname' => $shortname) );
        if (!$response) die(); // empty response.. weird..
        
        list($status, $client_id) = explode(':', $response);
        self::$_client_id = (int)$client_id;
        
        if (!in_array($status, array('first_install', 'needs_update'))) {
            // we could log 'nothing to do', but if cron runs every minute, the log file will be huge..
            die();
        }
        
//        self::update_server_status(self::$_client_id, 'being_updated');
        switch($status) {
            case 'first_install':
                self::run_first_install();                
            case 'needs_update':
        }
        
//        self::update_server_status(self::$_client_id, 'processed');
        
    } // function run

    static public function get_password($length=8) {
        $chars = 'bcdfghjklmnprstvwxzaeiou';
        $result = '';
         
        for ($p = 0; $p < $length; $p++) {
            $result .= ($p%2) ? $chars[mt_rand(19, 23)] : $chars[mt_rand(0, 18)];
        }
         
        return $result;
    }

    static protected function _make_admin_password() {
        global $DB, $CFG, $cs_admin_email;
        require_once($CFG->dirroot . '/user/lib.php');
        $admin_user = $DB->get_record_select('user', 'id=2');
        $password = self::get_password();
        $admin_user->password = $password;
        
        user_update_user($admin_user);
        
        $message =
<<<EOF
Er is een nieuw wachtwoord aangemaakt voor gebruiker 'admin' van een Jeelo installatie:
{$CFG->wwwroot}
Gebruiker: admin
Wachtwoord: $password
--
EOF;

        mail($cs_admin_email, "Nieuw wachtwoord voor Jeelo installatie", $message);
        self::log("Mailed new password for admin to $cs_admin_email");
        
    }
    
    static protected function _remove_all_courses() {
        global $DB, $CFG;
        require_once($CFG->dirroot . '/course/lib.php');
        
        $categories = $DB->get_records_select('course_categories', 1); 
        foreach ($categories as $category) {
            self::log(sprintf("Deleting category %d recursively", $category->id));
            category_delete_full($category);
        }
        
    }

    static public function run_first_install() {
        self::log("Updating installation after first install");
        
        self::_make_admin_password();
        self::_remove_all_courses();
        
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
    } // function update_server_status

    
    public static function get_server_response($request, $debug = false) {
		$request_url = self::get_request_url($request);
        
        //print_object($request_url);
        if ($debug) echo die(var_dump($request_url));
        $response = file_get_contents($request_url);
        
        return $response;
    } // function get_server_response


    public static function get_request_url($request) {
        global $cs_server_url;
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
        
        $request_url = $cs_server_url . '?' . $query_string;
        self::log($request_url);
        
        return $request_url; 
    } // function get_request_url

} // class client_updater

?>