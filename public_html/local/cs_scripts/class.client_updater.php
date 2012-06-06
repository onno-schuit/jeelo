<?php
DEFINE('CLI_SCRIPT', true);
require_once(dirname(__FILE__) . '/../../config.php');
require_once(dirname(__FILE__) . '/../replicator/class.replicator.php');
require_once(dirname(__FILE__) . '/../../../jeelo_cron/class.client.php');

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
 *
 * TODO: remove {home_folder}/csv folder after updater has run its course
 */
class client_updater extends client {

    public static $client_moodle = false;
    public static $courses = false;
    public static $categories = false;
    public static $school_groups = false;
    public static $users = false;
    public static $client_db = false;



    public static function set_client_db() {
        global $CFG;
        if (static::$db) return;
        static::init_db($CFG->dbhost, $CFG->dbuser, $CFG->dbpass, $CFG->dbname);
    } // function set_client_db


    public static function test() {
        echo "Okay from client_updater::test\n";        
    } // function test


    // memoizes results
    public static function get_client_moodle($client_moodle_id) {
        if (static::$client_moodle) return static::$client_moodle;

        $properties = array('id', 'timecreated', 'domain', 'shortname', 'fullname', 'email', 'sql_filename', 'codebase_filename', 'csv_filename', 'courses_filename', 'is_for_client', 'status', 'exit_code', 'timemodified');
        $data = static::get_moodle_client_from_server($client_moodle_id);
        $parsed = str_getcsv($data, ';');
        $client_moodle = new stdClass();
        foreach($properties as $index => $property) {
            $client_moodle->$property = $parsed[$index];
        }
        return static::$client_moodle = $client_moodle;               
    } // function get_client_moodle


    public static function get_moodle_client_from_server($client_moodle_id) {
        self::log("Getting client_moodle from server for client_moodle id {$client_moodle_id}");
        $request = array(
            'request' => 'get_moodle_client_by_id',
            'client_moodle_id'      => $client_moodle_id
        );               
        return self::get_server_response($request);               
    } // function get_moodle_client_from_server


    public static function get_and_unzip_csv($client_moodle_id) {
        self::log("Getting csv file from server for client_moodle id {$client_moodle_id}");
        $client_moodle = static::get_client_moodle($client_moodle_id);
        $target_directory = static::get_or_create_home_folder($client_moodle->domain) . '/csv';
        $request = array(
            'request' => 'get_csv_zip',
            'id'      => $client_moodle_id
        );
        if (file_exists($target_directory)) return $target_directory;
        shell_exec("mkdir $target_directory");
        shell_exec( sprintf("wget -O {$target_directory}/csv.tgz '%s'", self::get_request_url($request)) );
        shell_exec( "cd $target_directory; tar -xzf csv.tgz");
        return $target_directory;
    } // function get_and_unzip_csv


    // memoizes results
    public static function get_school_groups($client_moodle_id) {
        if (static::$school_groups) return static::$school_groups;

        $csv_directory = static::get_and_unzip_csv($client_moodle_id);
        $handler = fopen($csv_directory . '/groups.csv', 'r');
        $line = 0;
        while($data = fgetcsv($handler, 0, ';')) {
            $line ++;
            if ($line == 1) continue;

            // Set variables
            $school_group = new stdClass();
            $school_group->name = $data[0];
            $school_group->years = array_filter(explode('/', $data[1]));
            $school_groups[] = $school_group;
        }
        return static::$school_groups = $school_groups;
    } // function get_school_groups


    // memoizes results
    public static function get_users($client_moodle_id) {
        if (static::$users) return static::$users;

        $csv_directory = static::get_and_unzip_csv($client_moodle_id);
        $handler = fopen($csv_directory . '/users.csv', 'r');
        $line = 0;
        $properties = array("voornaam","achternaam","email","woonplaats","land","rol1","rol2","groep1","groep2","groep3");
        while($data = fgetcsv($handler, 0, ';')) {
            $line ++;
            if ($line == 1) continue;

            // Set variables
            $user = new stdClass();
            foreach($properties as $index => $property_name) {
                $user->$property_name = $data[$index];
            }
            $users[] = $user;
        }
        return static::$users = $users;
    } // function get_users


    public static function get_courses_from_server($client_moodle_id) {
        self::log("Getting courses from server for client_moodle id {$client_moodle_id}");
        $request = array(
            'request' => 'get_courses',
            'client_moodle_id'      => $client_moodle_id
        );               
        return self::get_server_response($request);
    } // function get_courses_from_server 


    // memoizes results
    public static function get_courses($client_moodle_id) {
        if (static::$courses) return static::$courses;

        $properties = array('id', 'fullname', 'shortname', 'groupyear', 'client_moodle_id', 'parent_category_id');
        $data = static::get_courses_from_server($client_moodle_id);
        $lines = array_filter(explode("\n", $data));
        $courses = array();
        foreach($lines as $line) {
            $parsed = str_getcsv($line, ';');
            $course = new stdClass();
            foreach($properties as $index => $property) {
                $course->$property = $parsed[$index];
            }
            $courses[] = $course;
        }
        return static::$courses = $courses;
    } // function get_courses


    public static function get_categories_from_server($client_moodle_id) {
        self::log("Getting categories from server for client_moodle id {$client_moodle_id}");
        $request = array(
            'request' => 'get_categories',
            'client_moodle_id'      => $client_moodle_id
        );               
        return self::get_server_response($request);
    } // function get_categories_from_server 


    // memoizes results
    public static function get_categories($client_moodle_id) {
        if (static::$categories) return static::$categories;

        $properties = array('id', 'name', 'description', 'parent', 'sortorder', 'coursecount', 'visible', 'timemodified', 'depth', 'path', 'theme', 'client_moodle_id', 'original_id');
        $data = static::get_categories_from_server($client_moodle_id);
        $lines = array_filter(explode("\n", $data));
        $categories = array();
        foreach($lines as $line) {
            $parsed = str_getcsv($line, ';');
            $category = new stdClass();
            foreach($properties as $index => $property) {
                $category->$property = $parsed[$index];
            }
            $categories[] = $category;
        }
        return static::$categories = $categories;
    } // function get_categories


    public static function create_courses($groups, $parent_category_id) {
        foreach($groups as $group) {
            foreach($group->years as $group_year) {
                static::find_courses_for($group_year, $parent_category_id);
            }
        }
    } // function create_courses


    public static function process_users($client_moodle_id) {
        global $CFG, $DB;

        $query = "UPDATE {$CFG->prefix}user SET deleted = 1 WHERE username != 'guest' && username != 'admin'";
        $DB->execute($query);

        foreach(static::get_users($client_moodle_id) as $user) {
            static::create_or_update_user($user);
        }        
    } // function process_users


    public static function create_or_update_user($user) {
        global $CFG, $DB;
        if (! $existing_user = $DB->get_record('user', array('username' => $user->email)) ) {
            return static::create_user($user);
        }
        return static::update_user($existing_user, $user);
    } // function create_or_update_user



    public static function update_user($existing_user, $user) {
        global $CFG, $DB;
        self::log("Update existing user {$existing_user->id}");
        //$DB->execute("UPDATE {$CFG->prefix}user SET deleted = 0 WHERE id = {$existing_user->id}");
    } // function update_user


    public static function create_user($user) {
        global $CFG, $DB;
        static::set_client_db();

        $salt = (isset($CFG->passwordsaltmain)) ? $CFG->passwordsaltmain : "";
        $new_user = new stdClass();
        $new_user->username = $user->email;
        $new_user->firstname = $user->voornaam;
        $new_user->password = md5(strtolower($new_user->firstname) . $salt);
        $new_user->email = $user->email;
        $new_user->lastname = $user->achternaam;
        $new_user->city = $user->woonplaats;
        $new_user->country = $user->land;
        $new_user->mnethostid = 1;
        $new_user->confirmed = 1;
        $new_user->deleted = 0;
        $new_user->created = $new_user->timemodified = time();
        self::log("Create new user {$user->email}");
        $values = (array) $new_user;
        $string = join("','", $values);
        $sql = "INSERT INTO {$CFG->prefix}user (username,firstname,password,email,lastname,city,country,mnethostid,confirmed,deleted,timecreated,timemodified) VALUES 
            ('$string')";
        print  "\n" . $sql . "\n";
        //$DB->insert_record('user', $new_user);
        static::$db->query($sql);
    } // function create_user

} // class client_updater

?>
