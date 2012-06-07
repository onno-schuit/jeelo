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
 * Please note that the memoized results are NOT returned by $client_moodle_id: it
 * is assumed that the class will be used for updating one moodle client at a time only.
 * If you plan to change that behavior, simply store all memoized results with the associated $client_moodle_id
 * (e.g. in an array indexed by $client_moodle_id).
 *
 *
 * TODO: remove {home_folder}/csv and {home_folder}/courses folder after updater has run its course
 */
class client_updater extends client {

    public static $client_moodle = false;
    public static $client_db = false;
    public static $admin_user = false;

    // Objects in following arrays are endowed with additional properties, usually after 'processing' 
    // (performed by client_updater::process_[..]), except in the case of courses
    public static $courses = false; // has $course->groupyear, and $course->current_category_id which contains foreign key pointing to mdl_course_categories.id
    public static $categories = false; // has $category->current_id which contains the actual mdl_course_categories.id
    public static $school_groups = false; // has $school_group->years (array) and $school_group->name
    public static $users = false; // has $user->current_user which contains the corresponding mdl_user object


    public static function get_admin_user() {
        if (static::$admin_user) return $admin_user;

        global $DB;
        static::$admin_user = $DB->get_record('user', array('username' => 'admin'));
    } // function get_admin_user


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
        if (file_exists($target_directory)) return $target_directory;
        $request = array(
            'request' => 'get_csv_zip',
            'id'      => $client_moodle_id
        );
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


    public static function get_and_unzip_courses_from_server($client_moodle_id) {
        self::log("Download zip with courses from server for client_moodle id {$client_moodle_id}");
        $client_moodle = static::get_client_moodle($client_moodle_id);
        $target_directory = static::get_or_create_home_folder($client_moodle->domain) . '/courses';
        if (file_exists($target_directory)) return $target_directory;
        $request = array(
            'request' => 'download_courses',
            'client_moodle_id' => $client_moodle_id
        );               
        shell_exec("mkdir $target_directory");
        shell_exec( $log = sprintf("wget -O {$target_directory}/courses.tgz '%s'", self::get_request_url($request)) );
        shell_exec( "cd $target_directory; tar -xzf courses.tgz");
        self::log($log);
        return $target_directory;
    } // function get_and_unzip_courses_from_server 


    // memoizes results, triggers 'static::process_categories($client_moodle_id)', also downloads actual courses zip from server
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
            $course->current_category_id = static::get_current_category_id($client_moodle_id, $course->parent_category_id);
            $courses[] = $course;
        }
        static::get_and_unzip_courses_from_server($client_moodle_id);
        return static::$courses = $courses;
    } // function get_courses


    public static function process_groups($client_moodle_id) {
        $groups = static::get_groups($client_moodle_id);
        foreach($groups as $school_group) {
            // each school_group gets its own version of all courses belonging to the same 'year' as the school_group
            foreach(static::find_courses_by_year($school_group->years[0], $client_moodle_id) as $course) {
                static::create_course_for_group($course, $school_group, $client_moodle_id); // school_group is used for new course name
            }
        }
    } // function process_groups


    public static function find_courses_by_year($year, $client_moodle_id) {
        if (! static::$courses) static::get_courses($client_moodle_id);
        $found_courses = array();
        foreach(static::$courses as $course) {
            $years = explode('/', $course->groupyear);
            if (in_array($year, $years)) $found_courses[] = $course;
        }
        return $found_courses;
    } // function find_courses_by_year


    public static function create_course_for_group($course, $school_group, $client_moodle_id) {
        // create actual course
        $client_moodle = static::get_client_moodle($client_moodle_id);
        $zip_path = static::get_or_create_home_folder($client_moodle->domain) . "/courses/{$course->backup_name}";
        $new_course = replicator::restore_course(static::$admin_user->id, $zip_path, $course->current_category_id);
        // rename course
        //
        // ... TODO ...
        // enrol all users in the current school_group in this course:
        // static::enrol_users($course, $school_group);
    } // function create_course_for_group


    public static function enrol_users($course, $school_group, $client_moodle_id) {
        foreach(static::find_users_by_group($school_group, $client_moodle_id) as $user) {
            //enroll user in $course...
        }
    } // function enrol_users


    public static function find_users_by_group($school_group, $client_moodle_id) {
        if (! static::$users) static::process_users($client_moodle_id);
    } // function find_users_by_group


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


    // Read csv file for users and create or update users
    public static function process_users($client_moodle_id) {
        global $CFG, $DB;

        $query = "UPDATE {$CFG->prefix}user SET deleted = 1 WHERE username != 'guest' && username != 'admin'";
        $DB->execute($query);

        foreach(static::get_users($client_moodle_id) as $user) {
            static::create_or_update_user($user);
        }        
    } // function process_users


    public static function process_categories($client_moodle_id) {
        global $CFG, $DB;

        $query = "UPDATE {$CFG->prefix}course_categories SET visible = 0 WHERE id != 1";
        $DB->execute($query);
        $categories = static::get_categories($client_moodle_id);        
        foreach($categories as $category) {
            static::create_or_update_category($category);
        }
    } // function process_categories


    // $category->current_id is updated with actual mdl_course_categories.id
    public static function create_or_update_category($category) {
        global $CFG, $DB;
        if (! $existing_category = $DB->get_record('course_categories', array('name' => $category->name)) ) {
            return $category->current_id = $DB->insert_record('course_categories', $category);
        }
        $temp_id = $category->id;
        $category->id = $category->current_id = $existing_category->id;
        $query = "UPDATE {$CFG->prefix}course_categories SET visible = 1 WHERE id = {$category->id}";
        $DB->execute($query);
        $category->id = $temp_id;
        /*
        return $DB->update_record('course_categories', $category);               
        */
    } // function create_or_update_category


    public static function get_current_category_id($client_moodle_id, $parent_category_id) {
        if (! static::$categories) static::process_categories($client_moodle_id);
        foreach(static::$categories as $category) {
            if ($category->id == $parent_category_id) return $category->current_id;
        }
        return false;
    } // function get_current_category_id


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
        $user->current_user = $existing_user;
        $DB->execute("UPDATE {$CFG->prefix}user SET deleted = 0 WHERE id = {$existing_user->id}");
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
        //print  "\n" . $sql . "\n";
        // Throws error for unfathomable reason:
        //$DB->insert_record('user', $new_user);
        static::$db->query($sql);
        $record = $DB->get_record('user', array('username' => $new_user->username, 'mnethostid' => $new_user->mnethostid));
        $user->current_user = $record;
    } // function create_user

} // class client_updater

?>
