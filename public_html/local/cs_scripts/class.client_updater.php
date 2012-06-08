<?php
if (! defined('CLI_SCRIPT') ) define('CLI_SCRIPT', true);

require_once(dirname(__FILE__) . '/../../config.php');
require_once(dirname(__FILE__) . '/../replicator/class.replicator.php');
require_once(dirname(__FILE__) . '/class.client.php');

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
    public static $student_role_id = false;

    // Objects in following arrays are endowed with additional properties, usually after 'processing' 
    // (performed by client_updater::process_[..]), except in the case of courses
    public static $courses = false; // has $course->groupyear, and $course->current_category_id which contains foreign key pointing to mdl_course_categories.id
    public static $categories = false; // has $category->current_id which contains the actual mdl_course_categories.id
    public static $school_groups = false; // has $school_group->years (array) and $school_group->name
    public static $users = false; // has $user->current_user which contains the corresponding mdl_user object
    protected static $_client_id;
    protected static $_admin_email;


    public static function get_admin_user() {
        if (static::$admin_user) return static::$admin_user;

        global $DB;
        return static::$admin_user = $DB->get_record('user', array('username' => 'admin'));
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

        $properties = array('id', 'timecreated', 'domain', 'shortname', 'fullname', 'email', 'sql_filename', 'codebase_filename', 'csv_filename', 'courses_filename', 'is_for_client', 'status', 'exit_code', 'timemodified', 'to_be_upgraded', 'logo', 'customcss');
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
        $users = array();
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

        $properties = array('id', 'fullname', 'shortname', 'groupyear', 'client_moodle_id', 'parent_category_id', 'backup_name');
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
        $groups = static::get_school_groups($client_moodle_id);
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
        $new_course = static::get_or_create_course($course, $school_group, $client_moodle_id);

        // enrol all users in the current school_group in this course:
        static::enrol_users($new_course, $school_group, $client_moodle_id);
    } // function create_course_for_group


    public static function get_or_create_course($course, $school_group, $client_moodle_id) {
        global $DB;

        $course_shortname = "$course->shortname {$school_group->name}";
        if ($existing_course = $DB->get_record('course', array('shortname' => $course_shortname))) return $existing_course;

        // create actual course
        $client_moodle = static::get_client_moodle($client_moodle_id);
        $zip_path = static::get_or_create_home_folder($client_moodle->domain) . "/courses/{$course->backup_name}";
        $admin_user = static::get_admin_user();
        $new_course = replicator::restore_course(static::$admin_user->id, $zip_path, $course->current_category_id);

        // rename course
        $new_course->shortname = "$course->shortname {$school_group->name}";
        $new_course->fullname = "$course->fullname {$school_group->name}";
        $DB->update_record('course', $new_course);               

        return $new_course;
    } // function get_or_create_course


    public static function enrol_users($new_course, $school_group, $client_moodle_id) {
        foreach(static::find_users_by_group($school_group->name, $client_moodle_id) as $user) {
            static::create_course_role_assignment($user, $new_course->id);
        }
    } // function enrol_users



    static public function map_role($user_role) {
         switch($user_role) {
            case 'leerling':
                $role_shortname = 'student';
                break;
            case 'leerkracht':
                $role_shortname = 'teacher';
                break;
            case 'invalkracht':
                $role_shortname = 'substitute';
                break;
            case 'schoolleider':
                $role_shortname = 'schoolleader';
                break;
            default:
                return false; // Return false if role is something else, shouldn't happen though...
                break;
        }               
        return $role_shortname;
    } // function map_role


    public static function create_course_role_assignment($user, $course_id) {
        global $DB, $CFG;
        if (!$role_shortname = static::map_role($user->rol1)) return false;

        $context = $DB->get_record('context', array('contextlevel' => 50, 'instanceid' => $course_id));
        $context_id = $context->id;

        $role = $DB->get_record('role', array('shortname' => $role_shortname));
        $role_id = $role->id;

		// Check if it already exists
        if ($DB->get_record('role_assignments', array('roleid' => $role_id, 'contextid' => $context_id, 'userid' => $user->current_user->id)) ) {
            return true;
        }
        $query = "INSERT INTO {$CFG->prefix}role_assignments (
                    roleid, contextid, userid, timemodified, enrol
                ) VALUES (
                    '$role_id',
                    '$context_id',
                    '{$user->current_user->id}',
                    '".time()."',
                    'manual'
                )";
        //$DB->execute($query);
        $DB->insert_record('role_assignments', array(
                'roleid' => $role_id,
                'contextid' => $context_id,
                'userid' => $user->current_user->id,
                'timemodified' => time(),
                'enrol' => 'manual')
        );
        static::insert_into_user_enrolments_if_not_exists($user->current_user->id, $course_id);
    } // function create_course_role_assignment


    public static function insert_into_user_enrolments_if_not_exists($user_id, $course_id) {
        global $DB;
        if (!$enrol = $DB->get_record('enrol', array('courseid' => $course_id, 'roleid' => static::get_student_role_id() ) ) ) return false;
        $enrol_id = $enrol->id;

        if ( $DB->get_record('user_enrolments', array('userid' => $user_id, 'enrolid' => $enrol_id)) ) return;
        $user_enrolment = new object();
        $user_enrolment->userid = $user_id;
        $user_enrolment->enrolid = $enrol_id;
        $user_enrolment->timestart = time();
        $user_enrolment->timeend = time() + 240 * 4 * 7 * 24 * 60 * 60;
        $user_enrolment->timemodified = time();
        $user_enrolment->timecreated = time();
        $user_enrolment->status = 0; // 0 means active enrolment, 1 means suspended, anything else means inactive

        $DB->insert_record('user_enrolments', $user_enrolment);
    } // function insert_into_user_enrolments_if_not_exists


    static function get_student_role_id() {
        global $DB;
        if (static::$student_role_id) return static::$student_role_id;
        $student_role = $DB->get_record('role', array('shortname' => 'student'));
        return static::$student_role_id = $student_role->id;
    } // function get_student_role_id


    public static function find_users_by_group($school_group_name, $client_moodle_id) {
        if (! static::$users) static::process_users($client_moodle_id);
        $found_users = array();
        foreach(static::$users as $user) {
            if (($user->groep1 == $school_group_name) || ($user->groep2 == $school_group_name) || ($user->groep3 == $school_group_name)) {
                $found_users[] = $user;
            }
        }
        return $found_users;
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


    static public function run() {
        global $CFG;
        
        $shortname = $CFG->dbname;
        
        self::log(sprintf("Checking update status for current installation (%s)", $shortname));
        
        $response = self::get_server_response( $request = array('request' => 'get_status',
            'shortname' => $shortname) );
        if (!$response) die(); // empty response.. weird..
        
        list($client_id, $status, $email) = explode(';', $response);
        self::$_client_id = (int)$client_id;
        self::$_admin_email = $email;
        
        if (!in_array($status, array('first_install', 'needs_update'))) {
            // we could log 'nothing to do', but if cron runs every minute, the log file will be huge..
            die();
        }
        
        self::update_server_status(self::$_client_id, 'being_updated');
        switch($status) {
            case 'first_install':
                self::run_first_install();                
            case 'needs_update':
                self::process_groups(self::$_client_id);
                self::remove_temp_folders(self::$_client_id);
                self::update_moodle_client(self::$_client_id);
        }
        self::update_server_status(self::$_client_id, 'processed');
        
    } // function run


    static public function update_moodle_client($client_moodle_id) {
        global $DB;
        $current_moodle = $DB->get_record( 'course', array('category' => 0, 'format' => 'site') );
        $client_moodle = get_client_moodle($client_moodle_id);

        $to_update = false;
        if (isset($client_moodle->shortname) && (trim($client_moodle->shortname) == '')) {
            $current_moodle->shortname = $client_moodle->shortname;
            $to_update = true;
        }
        if (isset($client_moodle->fullname) && (trim($client_moodle->fullname) == '')) {
            $current_moodle->fullname = $client_moodle->fullname;
            $to_update = true;
        }
        if ($to_update) $DB->update_record('course', $current_moodle);

        if (isset($client_moodle->logo) && (trim($client_moodle->logo) == '')) {
            replicator::configure_theme('logo', $client_moodle->logo);
            replicator::configure_theme('frontpagelogo', $client_moodle->logo);
        }

        if (isset($client_moodle->customcss) && (trim($client_moodle->customcss) == '')) replicator::configure_theme('customcss', $client_moodle->customcss);
    } // function update_moodle_client


    static public function remove_temp_folders($client_moodle_id) {
        $client_moodle = static::get_client_moodle($client_moodle_id);
        $csv_dir = static::get_or_create_home_folder($client_moodle->domain) . '/csv';
        $courses_dir = static::get_or_create_home_folder($client_moodle->domain) . '/courses';
        shell_exec("rm -Rf {$csv_dir}");
        shell_exec("rm -Rf {$courses_dir}");
    } // function remove_temp_folders


    static public function get_password($length=8) {
        $chars = 'bcdfghjklmnprstvwxzaeiou';
        $result = '';
         
        for ($p = 0; $p < $length; $p++) {
            $result .= ($p%2) ? $chars[mt_rand(19, 23)] : $chars[mt_rand(0, 18)];
        }
         
        return $result;
    }

    static protected function _make_admin_password() {
        global $DB, $CFG;
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

        mail(self::$_admin_email, "Nieuw wachtwoord voor Jeelo installatie", $message);
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
