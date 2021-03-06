<?php
if (! defined('CLI_SCRIPT') ) define('CLI_SCRIPT', true);

require_once(dirname(__FILE__) . '/../../config.php');
require_once(dirname(__FILE__) . '/../replicator/class.replicator.php');
require_once(dirname(__FILE__) . '/class.client.php');

/**
 * This class runs on local Moodle clients. It should be invoked as a cron job.
 * The class has the following function:
 *
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
    public static $parent_archive_name = 'Archief'; // All 'old' categories are archived to this category
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

        $properties = array('id', 'timecreated', 'domain', 'shortname', 'fullname', 'email', 'sql_filename', 'codebase_filename', 'csv_filename', 'courses_filename', 'is_for_client', 'status', 'exit_code', 'timemodified', 'to_be_upgraded', 'logo', 'customcss', 'archive');
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
        return static::$school_groups = array_reverse($school_groups);
    } // function get_school_groups


    // memoizes results
    public static function get_users($client_moodle_id) {
        if (static::$users) return static::$users;

        $csv_directory = static::get_and_unzip_csv($client_moodle_id);
        $handler = fopen($csv_directory . '/users.csv', 'r');
        $line = 0;
        $properties = array("voornaam","achternaam","email","gebruikersnaam","wachtwoord","woonplaats","land","schoolrol","groepsrol","groep1","groep2","groep3","groep4","groep5");
        $users = array();

        // Encoding fix
        setlocale(LC_ALL, 'nl_NL');

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
        if (!$new_course = static::get_or_create_course($course, $school_group, $client_moodle_id)) return false;

        // enrol all users in the current school_group in this course:
        return static::enrol_users($new_course, $school_group, $client_moodle_id);
    } // function create_course_for_group


    public static function get_or_create_course($course, $school_group, $client_moodle_id) {
        global $DB;

        $course_shortname = "$course->shortname {$school_group->name}";
        if ($existing_course = $DB->get_record('course', array('shortname' => $course_shortname))) {
            // $existing_course->visible = 1;
            //$DB->update_record('course', $existing_course);               
            return $existing_course;
        }
        // create actual course
        $client_moodle = static::get_client_moodle($client_moodle_id);
        $zip_path = static::get_or_create_home_folder($client_moodle->domain) . "/courses/{$course->backup_name}";
        if (!file_exists($zip_path)) {
            self::log("Could not find file {$zip_path} in function get_or_create_course. Course $course_shortname not created.");
            return false;
        }

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
        return true;
    } // function enrol_users



    static public function map_role($user_role) {
        $user_role = trim($user_role);
        switch($user_role) {
            case 'leerling':
                $role_shortname = 'student';
                break;
            case 'leerkracht':
                $role_shortname = 'editingteacher';
                break;
            case 'invalkracht':
            case 'leerkracht zonder bewerken':
                $role_shortname = 'teacher';
                break;
            case 'schoolleider':
            case 'beheerder':
                $role_shortname = 'manager';
                break;
            default:
                $role_shortname = 'student';
                break;
        }               
        return $role_shortname;
    } // function map_role


    public static function create_course_role_assignment($user, $course_id) {
        if (!$role_shortname = static::map_role($user->groepsrol)) return false;
        if (! static::assign_role($user, $role_shortname, $context_level = 50, $instance_id = $course_id) ) return false;
        static::insert_into_user_enrolments_if_not_exists($user->current_user->id, $course_id);
    } // function create_course_role_assignment


    public static function assign_role($user, $role_shortname, $context_level, $instance_id) {
        global $DB, $CFG;

        if (! property_exists($user, "current_user") ) {
            echo "\nCould not find Moodle record for {$user->voornaam} {$user->achternaam} (assign_role)\n";
            return false;
        }
        $context = $DB->get_record('context', array('contextlevel' => $context_level, 'instanceid' => $instance_id));
        $context_id = $context->id;

        if (! $role = $DB->get_record('role', array('shortname' => $role_shortname))) return false;
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
        if (! $DB->insert_record('role_assignments', array(
            'roleid' => $role_id,
            'contextid' => $context_id,
            'userid' => $user->current_user->id,
            'timemodified' => time(),
            'enrol' => 'manual'))
        ) return false;
        return true;
    } // function assign_role


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
            if (static::user_in_group($user, $school_group_name)) $found_users[] = $user;
        }
        return $found_users;
    } // function find_users_by_group


    public static function user_in_group($user, $school_group_name) {
        for($i = 1; $i <= 5; $i++) {
            $property = "groep$i";
            if ($user->$property == $school_group_name) return true;
        }
        return false;
    } // function user_in_group


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
            static::create_site_wide_role($user);
        }        
    } // function process_users


    public static function create_site_wide_role($user) {
        global $DB, $CFG;
        if ( (! $user->schoolrol) || trim($user->schoolrol) == '') return;
        if (!$role_shortname = static::map_role($user->schoolrol)) return false;
        static::assign_role($user, $role_shortname, $context_level = 10, $instance_id = 0);
    } // function create_site_wide_role


    public static function process_categories($client_moodle_id) {
        global $CFG, $DB;

        //$query = "UPDATE {$CFG->prefix}course_categories SET visible = 0 WHERE id != 1";
        //$DB->execute($query);
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
        // $query = "UPDATE {$CFG->prefix}course_categories SET visible = 1 WHERE id = {$category->id}";
        //$DB->execute($query);
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

        // Encoding fix
        setlocale(LC_ALL, 'nl_NL');

        // utf8_encode is necessary because DB contains utf8, but $user contains data derived from latin1 csv
        if (! $existing_user = $DB->get_record('user', array('username' => utf8_encode(static::create_username($user)))) ) {
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


    // Side effect: adds property current_user to $user object
    public static function create_user($user) {
        global $CFG, $DB;
        static::set_client_db();

        // Encoding fix
        setlocale(LC_ALL, 'nl_NL');

        $new_user = new stdClass();
        $new_user->username = static::create_username($user);
        $new_user->firstname = $user->voornaam;
        $new_user->password = static::create_password($user);
        $new_user->email = $user->email;
        $new_user->lastname = $user->achternaam;
        $new_user->city = $user->woonplaats;
        $new_user->country = static::map_country($user->land);
        $new_user->lang = 'nl';
        $new_user->mnethostid = 1;
        $new_user->confirmed = 1;
        $new_user->deleted = 0;
        $new_user->created = $new_user->timemodified = time();
        self::log("Create new user {$user->email}");
        $values = (array) $new_user;
        $string = join("','", $values);
        $sql = "INSERT INTO {$CFG->prefix}user (username,firstname,password,email,lastname,city,country,lang,mnethostid,confirmed,deleted,timecreated,timemodified) VALUES ('$string')";
        // Throws error for unfathomable reason:
        //$DB->insert_record('user', $new_user);
        static::$db->query($sql);
        // utf8_encode is necessary because DB contains utf8, but $user contains data derived from latin1 csv
        if (! $record = $DB->get_record('user', array('username' => utf8_encode($new_user->username), 'mnethostid' => $new_user->mnethostid)) ) {
            exit("Could not find record for {$new_user->username} in create_user");
        }
        $user->current_user = $record;
    } // function create_user


    public static function create_username($user) {
        // Encoding fix
        setlocale(LC_ALL, 'nl_NL');
        if (($user->gebruikersnaam) && (trim($user->gebruikersnaam) != '')) return $user->gebruikersnaam;
        return $user->email;
    } // function create_username


    public static function create_password($user) {
        global $CFG;
        $salt = (isset($CFG->passwordsaltmain)) ? $CFG->passwordsaltmain : "";
        if (($user->wachtwoord) && (trim($user->wachtwoord) != '')) return md5(trim($user->wachtwoord) . $salt);
        return md5(trim($user->voornaam) . $salt);
    } // function create_password


    public static function map_country($input) {
        switch (trim($input)) {
            case 'Belgie':
            case 'belgie':
            case 'België':
            case 'belgië':
                return 'BE';
                break;
            default:
                return 'NL';
                break;
        }
    } // function map_country


    static public function run() {
        global $CFG;
        
        $shortname = $CFG->dbname;
        
        self::log(sprintf("Checking update status for current installation (%s)", $shortname));
        
        $response = self::get_server_response( $request = array('request' => 'get_status', 'shortname' => $shortname) );
        if (!$response) die(); // empty response.. weird..
        
        list($client_id, $status, $email, $archive) = explode(';', $response);
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
                self::run_update($archive);
                break;
            case 'needs_update':
                self::run_update($archive);
                break;
        }
        self::update_server_status(self::$_client_id, 'processed', $end_of_process = 1);
    } // function run


    static function run_update($archive) {
        //self::hide_courses(); // client doesn't want this anymore, 'old' courses are now archived only on demand
        self::archive_courses(self::$_client_id, $archive);
        self::process_groups(self::$_client_id);
        self::remove_temp_folders(self::$_client_id);
        self::update_moodle_client(self::$_client_id);
        self::update_coursecount_in_categories();
        replicator::remove_module('launcher');
        self::clear_server_for(self::$_client_id);               
    } // function run_update


    static public function hide_courses() {
        global $DB, $CFG;
        $sql = "UPDATE {$CFG->prefix}course SET visible = 0";
        $DB->execute($sql);
    } // function hide_courses


    static public function archive_courses($client_moodle_id, $archive_name = '') {
        global $DB, $CFG;
        if (!$archive_name || trim($archive_name) == '') return;
        static::reset_archive_on_server($client_moodle_id);

        $parent_category = static::get_or_create_category(static::$parent_archive_name);
        $category = static::get_or_create_category($archive_name, $parent_category->id);
        if (! $unarchived_categories = static::get_unarchived_categories($parent_category->id)) return;
        static::archive_categories_to($unarchived_categories, $category->id, $archive_name);
        static::postfix_courses_in($unarchived_categories, $archive_name);
    } // function archive_courses


    static public function archive_categories_to($unarchived_categories, $archive_id, $postfix) {
        global $DB, $CFG;
        $spaced_postfix = ' ' . trim($postfix);
        foreach($unarchived_categories as $category) {
            $sql = "UPDATE {$CFG->prefix}course_categories
                    SET parent = $archive_id, name = CONCAT(name, '$spaced_postfix')
                    WHERE id = {$category->id}";
            $DB->execute($sql);
        }               
        fix_course_sortorder();
    } // function archive_categories_to


    static public function get_unarchived_categories($parent_archive_id) {
        global $DB;
        return $DB->get_records_select('course_categories', "path NOT LIKE '%/{$parent_archive_id}/%' AND id <> {$parent_archive_id}");
    } // function get_unarchived_categories


    // Adds postfix (e.g. ' schoolyear 2011/12' to course name. Also sets course to invisible.
    static public function postfix_courses_in($categories, $postfix) {
        global $DB, $CFG;
        $spaced_postfix = ' ' . trim($postfix);
        foreach($categories as $category) {
            $sql = "UPDATE {$CFG->prefix}course
                    SET fullname = CONCAT(fullname, '$spaced_postfix'),
                        shortname = CONCAT(shortname, '$spaced_postfix'),
                        visible = 0
                    WHERE category = {$category->id}";
            $DB->execute($sql);
        }
    } // function postfix_courses_in


    static public function reset_archive_on_server($client_moodle_id) {
        $request = array(
            'request' => 'reset_archive',
            'client_moodle_id' => $client_moodle_id
        );
        $response = self::get_server_response($request);
    } // function reset_archive_on_server 


    static public function get_or_create_category($category_name, $parent_id = false) {
        global $DB;
        if ($category = $DB->get_record('course_categories', array('name' => $category_name)) ) return $category;
        return static::create_category($category_name, $parent_id);
                
    } // function get_or_create_category


    // Does not work with nested categories!
    static public function update_coursecount_in_categories() {
        global $DB;
        $categories = $DB->get_records('course_categories');
        foreach($categories as $category) {
            $category->coursecount = $DB->count_records('course', array('category' => $category->id));
            $DB->update_record('course_categories', $category);
        }
        fix_course_sortorder();
    } // function update_coursecount_in_categories


    static public function update_moodle_client($client_moodle_id) {
        global $DB;
        $current_moodle = $DB->get_record( 'course', array('category' => 0, 'format' => 'site') );
        $client_moodle = self::get_client_moodle($client_moodle_id);

        $to_update = false;
        if (isset($client_moodle->shortname) && (trim($client_moodle->shortname) != '')) {
            $current_moodle->shortname = $client_moodle->shortname;
            $to_update = true;
        }
        if (isset($client_moodle->fullname) && (trim($client_moodle->fullname) != '')) {
            $current_moodle->fullname = $client_moodle->fullname;
            $to_update = true;
        }
        if (isset($client_moodle->email) && (trim($client_moodle->email) != '')) {
            $current_moodle->email = $client_moodle->email;
            $to_update = true;
        }
        if ($to_update) $DB->update_record('course', $current_moodle);

        if (isset($client_moodle->logo) && (trim($client_moodle->logo) != '')) {
            replicator::configure_theme('logo', $client_moodle->logo);
            replicator::configure_theme('frontpagelogo', $client_moodle->logo);
        }

        static::update_customcss($client_moodle_id);
    } // function update_moodle_client


    static public function update_customcss($client_moodle_id) {
        self::log("Getting customcss from server for client_moodle id {$client_moodle_id}");
        $request = array(
            'request' => 'get_customcss',
            'client_moodle_id'      => $client_moodle_id
        );               
        if ($customcss = self::get_server_response($request)) {
            replicator::configure_theme('customcss', $customcss);
        }
    } // function update_customcss


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
        
        $courses = $DB->get_records_select('course', 1);
        foreach ($courses as $course) {
            if ($course->id == 1) continue;
            self::log(sprintf("Deleting course %d", $course->id));
            delete_course($course->id, false);
        }
    }


    static public function run_first_install() {
        self::log("Updating installation after first install");
        
        self::_make_admin_password();
        self::_remove_all_courses();
        
    }


    static public function update_server_status($record_id, $status, $end_of_process = 0) {
        $request = array(
            'request' => 'set_status',
            'id' => $record_id,
            'status' => $status,
            'end_of_process' => $end_of_process,
        );
        $response = self::get_server_response($request);
        self::log("Updated status for record $record_id to $status: $response");
    } // function update_server_status


    static public function clear_server_for($client_moodle_id) {
        $request = array(
            'request' => 'clean_buffer_db',
            'client_moodle_id' => $client_moodle_id
        );
        $response = self::get_server_response($request);
    } // function clear_server_for

    
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
    

    static public function create_category($name, $parent_id = false) {
        global $DB;
        $newcategory = new stdClass();
        $newcategory->name = $name;
        if ($parent_id) $newcategory->parent = $parent_id;
        $category_id = $DB->insert_record('course_categories', $newcategory);
        // the unaptly named get_context_instance function will also create a new context record if no existing could be found
        $context = get_context_instance(CONTEXT_COURSECAT, $category_id);
        mark_context_dirty($context->path);
        fix_course_sortorder();
        return $DB->get_record('course_categories', array('id' => $category_id));
    } // function create_category

} // class client_updater

?>
