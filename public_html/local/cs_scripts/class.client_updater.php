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
 */

class client_updater extends client {

    public static $courses = false;
    public static $categories = false;


    public static function test() {
        echo "Okay from client_updater::test\n";        
    } // function test


    public static function get_and_unzip_csv($client_moodle_id, $target_directory) {
        self::log("Getting csv file from server for moodle_client id {$client_moodle_id}");
        $request = array(
            'request' => 'get_csv_zip',
            'id'      => $client_moodle_id
        );
        if (! file_exists($target_directory)) shell_exec("mkdir $target_directory");
        shell_exec( sprintf("wget -O {$target_directory}/csv.tgz '%s'", self::get_request_url($request)) );
        shell_exec( "cd $target_directory; tar -xzf csv.tgz");
    } // function get_and_unzip_csv


    public static function get_school_groups($csv_file) {
        $handler = fopen($csv_file, 'r');
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
        return $school_groups;
    } // function get_school_groups


    public static function get_courses_from_server($client_moodle_id) {
        self::log("Getting courses from server for moodle_client id {$client_moodle_id}");
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
        self::log("Getting categories from server for moodle_client id {$client_moodle_id}");
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


} // class client_updater

?>
