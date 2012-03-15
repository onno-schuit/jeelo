<?php
include("../config.php");
error_reporting(E_ALL);
ini_set('display_errors','On');

class client_updater extends client {

    function __construct() {
        global $CFG;
        $this->tmp_csv_folder = "{$CFG->dataroot}/temp/updater/csv";
        $this->tmp_courses_folder = "{$CFG->dataroot}/temp/updater/courses";
        
        // Set variables for csv files
        $this->fields_users = array(
                'firstname'=>'voornaam',
                'lastname'=>'achternaam',
                'email'=>'email',
                'city'=>'woonplaats',
                'country'=>'land',
                'rol1'=>'rol1',
                'rol2'=>'rol2',
                'group1'=>'groep1',
                'group2'=>'groep2',
                'group3'=>'groep3'
            );
        $this->fields_groups = array('name'=>'naam', 'year'=>'jaar');
        // Possible group combinations
        $this->possible_groups = array(array('1', '2'), array('3', '4'), array('5', '6'), array('7', '8'));
    }

    function start_updater($csv_line) {
        
        /* include config.php
         * update course 1                                      ***DONE***
         * update all course categories, set them invisible     ***DONE***
         * extract csv tar                                      ***DONE***
         * insert / update / delete users                       ***DONE***
         * insert categories                                    ***DONE***
         * insert new courses & groups
         * Create enrollments
         */

        // Update course 1
        // self::update_sitewide_course($csv_line);

        // Update all course categories
        // $this->set_existing_categories_invisible();
        // Extract csv files
        // $this->extract_csv_files($csv_line);
        // Update users
        // $this->update_all_users($csv_line);
        $this->create_categories($csv_line);
        // Finally, add the side-wide enrollments (for admin users)
        if (!$this->add_sidewide_enrollment()) error("Failed to create side-wide roles");
    }


    function create_categories($csv_line) {
        global $CFG;
        
        /* Extract courses              ***DONE***
         * Create categories            ***DONE***
         * Create courses               ***DONE***
         * Create groups                ***DONE***
         * Create course enrollments    ***DONE***
         * Create side-wide enrollments
         */

        $this->extract_course_files($csv_line); // Before we go through any loop we'll want to extract backup files
        $parent_courses = $this->get_parent_courses($csv_line);

        $request = array(
            'request' => 'get_categories',
            'client_moodle_id' => $csv_line->id
        );
        $response = self::get_server_response($request);

        $csv = new csv();
        $categories = $csv->build_csv_object($response, 'client_categories');

        while($category = $csv->nextline()) { // Loop through categories

            $category_id = $this->create_category($category);
            //$category_id = 4; // For test purposes
            $this->create_courses_and_groups($csv_line, $parent_courses, $category_id);

            break; // For testing, don't wanne wait all the time
        }

        return true;
    }


    function get_parent_courses($csv_line) {

        $request = array(
            'request' => 'get_courses',
            'client_moodle_id' => $csv_line->id
        );
        $response = self::get_server_response($request);

        $csv = new csv();
        $csv_courses = $csv->build_csv_object($response, 'client_courses');
        $parent_courses = array();

        while($csv_course = $csv->nextline()) {
            $parent_courses[] = $csv_course;
        }

        return $parent_courses;
    }

    
    /* We probably wont need this script anymore
    function get_dir_contents($folder) {
        $files = array();
        $folder_handler = opendir($folder);

        while($file = readdir($folder_handler)) {
            $files[] = $file;
        }

        return $files;
    }
     */


    function create_category($category) {
        $category->name = $category->name.' - '.date("m/Y"); // Add month and year to keep names unique

        self::log("Creating course category and context");
        $category_id = insert_record('course_categories', $category);
        echo "<br />Inserted category id $category_id<br />";
        get_context_instance(CONTEXT_COURSECAT, $category_id); // Creates the context

        return $category_id;
    }


    function create_courses_and_groups($csv_line, $parent_courses, $category_id) {

        $handler = fopen("{$this->tmp_csv_folder}/groups.csv", 'r');
        $line = 0;
        while($data = fgetcsv($handler, 0, ';')) {
            $line ++;
            if ($line == 1) continue;

            $child_group = new stdClass();
            // Create object with the right data and column names
            $child_group = $this->assign_column_names($data, 'fields_groups');

            // Create an array from the groupyears
            $child_group->year = $this->groupyears_to_array($child_group->year);

            // Loop over courses
            foreach($parent_courses as $parent_course) {

                // If not set yet: create array from parent groupyears
                if (!is_array($parent_course->groupyear)) $parent_course->groupyear = $this->groupyears_to_array($parent_course->groupyear);

                // Possible groups: 1/2, 3/4, 5/6, 7/8
                foreach($this->possible_groups as $possible_group) {

                    // Possibly there are more years assigned to 1 group
                    foreach($child_group->year as $child_group_year) {
                        if (!in_array($child_group_year, $possible_group)) continue;
                        if (!in_array($child_group_year, $parent_course->groupyear)) continue;

                        // Restore earlier backuped course
                        if (!$child_course_id = $this->restore_course($category_id, $child_group, $parent_course)) error("Couldn't create course");
                        echo "<br />Restored course id $child_course_id<br />";
                        // $child_course_id = 12;
                        // Create group
                        if (!$child_group_id = $this->create_group($child_course_id, $child_group)) error("Couldn't create group.");
                        echo "<br />Created group id $child_group_id<br />";
                        // $child_group_id = 9;
                        // Add users to groups
                        if (!$this->add_group_members($child_course_id, $child_group_id, $child_group->name)) error("Couldn't add group members.");

                        // Everything went well, break to avoid copying the course another time
                        break;
                    }
                }
            }
        }
        return true;
    }


    function add_group_members($course_id, $group_id, $group_name) {
        
        $handler = fopen("{$this->tmp_csv_folder}/users.csv", 'r');
        $line = 0;
        while($data = fgetcsv($handler, 0, ';')) {
            $line ++;
            if ($line == 1) continue;

            // Continue with the groups
            $csv_user = new stdClass();
            $csv_user = $this->assign_column_names($data, 'fields_users');

            // Assign userid to csv user record
            $csv_user->userid = get_record('user', 'username', $csv_user->email)->id;
            $csv_user->groups = array($csv_user->group1, $csv_user->group2, $csv_user->group3);
            
            // If user is not in the same group AND doesn't need to be
            // assigned to all courses we've got nothing to do
            if (!in_array($group_name, $csv_user->groups) && (!$this->needs_all_course_enrollments($csv_user->rol1))) continue;

            if (!$this->add_group_member($csv_user, $group_id)) return false;
            if (!$this->create_course_role_assignment($csv_user, $course_id)) return false;
        }
        return true;
    }


    function needs_all_course_enrollments($rol) {
        $global_roles = array('invalkracht', 'schoolleider');
        return (in_array($rol, $global_roles));
    }


    function add_sidewide_enrollment() {
        
        $handler = fopen("{$this->tmp_csv_folder}/users.csv", 'r');
        $line = 0;
        while($data = fgetcsv($handler, 0, ';')) {
            $line ++;
            if ($line == 1) continue;

            // Continue with the groups
            $csv_user = new stdClass();
            $csv_user = $this->assign_column_names($data, 'fields_users');
            
            if ($csv_user->rol1 != 'beheerder') continue; // If not admin, continue

            $role_assignment = new stdClass();
            $role_assignment->userid = get_record('user', 'username', $csv_user->email)->id;
            $role_assignment->roleid = get_record('role', 'shortname', 'admin')->id;
            $role_assignment->contextid = get_context_instance(CONTEXT_SYSTEM, 1)->id; // Get course context id
            $role_assignment->timemodified = time();
            $role_assignment->courseid = 1;

            if (!insert_record('role_assignments', $role_assignment)) return false;
        }
        return true;
    }


    function create_course_role_assignment($user, $course_id) {

        switch($user->rol1) {
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
                return true; // Return if role is something else, shouldn't happen though...
                break;
        }
        $role_assignment = new stdClass();
        $role_assignment->roleid = get_record('role', 'shortname', $role_shortname)->id;
        $role_assignment->contextid = get_context_instance(CONTEXT_COURSE, $course_id)->id; // Get course context id
        $role_assignment->userid = $user->userid;
        $role_assignment->timemodified = time();
        echo "<br />Created role assignment user {$user->userid} {$course_id}<br />";

        return (insert_record('role_assignments', $role_assignment));
    }


    function add_group_member($user, $group_id) {
        $group_member = new stdClass();
        $group_member->groupid = $group_id;
        $group_member->timeadded = time();
        $group_member->userid = $user->userid;

        $error = false;
        if (!insert_record('groups_members', $group_member)) $error = true;
        echo "<br />Added group member user {$group_member->userid} to group {$group_member->groupid}<br />";
        return (!$error);
    }

    function create_group($course_id, $group) {
        $group->courseid = $course_id;
        return (@insert_record('groups', $group));
    }


    function restore_course($category_id, $child_group, $parent_course) {
        global $CFG;
        require_once("{$CFG->dirroot}/class.restore_course.php");

        $restore_course = new restore_backup();
        echo "<br />Course for group: {$child_group->name}<br />";
        if (!$course_id = $restore_course->course_restore($parent_course, $child_group->name, $category_id)) return false;
        unset($restore_course);

        return $course_id;
    }


    function extract_course_files($csv_line) {
        global $CFG;

        if (is_dir($this->tmp_courses_folder)) shell_exec("rm -R {$this->tmp_courses_folder}");
        mkdir($this->tmp_courses_folder);
        $cmd = sprintf("tar -xz -C %s -f %s", $this->tmp_courses_folder, $csv_line->courses_filename);
        self::log($cmd);
        shell_exec($cmd);

        return true;
    }

    function extract_csv_files($csv_line) {
        global $CFG;

        if (is_dir($this->tmp_csv_folder)) shell_exec("rm -R {$this->tmp_csv_folder}");
        mkdir($this->tmp_csv_folder);
        $cmd = sprintf("tar -xz -C %s -f %s", $this->tmp_csv_folder, $csv_line->csv_filename);
        self::log($cmd);
        shell_exec($cmd);

        return true;
    }


    function groupyears_to_array($groupyear) {
        return array_filter(explode('/', $groupyear));
    } // function groupyear_to_array


    function set_existing_categories_invisible() {
        global $CFG;

        $error = false;

        $query = "UPDATE {$CFG->prefix}course_categories SET visible='0'";
        self::log($query);
        if (!execute_sql($query, false)) $error = true;

        $query = "UPDATE {$CFG->prefix}course SET visible='0' WHERE category != '0'";
        self::log($query);
        if (!execute_sql($query, false)) $error = true;

        if ($error) {
            self::log("Failed to set the categories and courses invisible on client.");
            die();
        }
        return;
    }


    function assign_column_names($data, $fields_type) {
        $count = 0;

        $obj = new stdClass();
        foreach($this->$fields_type as $key => $column) { // Assign column names to $group
            $obj->$key = $data[$count];
            $count ++;
        }

        return $obj;
    }


    function update_all_users($csv_line) {
        global $CFG;

        $query = "UPDATE {$CFG->prefix}user SET deleted = 1 WHERE username != 'guest' && username != 'admin'";
        self::log($query);
        execute_sql($query, false); // Set all users deleted, we'll update them again later

        $handler = fopen("{$this->tmp_csv_folder}/users.csv", 'r');
        $line = 0;
        while($data = fgetcsv($handler, 0, ';')) {
            $line ++;
            if ($line == 1) continue;

            $child_user = new stdClass();
            $this->assign_column_names($data, $child_user, 'fields_users');

            if (!$this->create_or_update_user($child_user)) die('Failed to edit users');
            unset($child_user);
        }
    }


    function create_or_update_user($user) {
        global $CFG;

        $query = "SELECT * FROM {$CFG->prefix}user WHERE username = '{$user->email}'";
        $existing_user = get_record_sql($query);

        // Update user
        if ($existing_user) {
            $user->deleted = 0;
            $user->id = $existing_user->id;
            self::log("Update user {$user->id}");
            return (update_record('user', $user));
        }

        // Create user
        $user->username = $user->email;
        $user->password = hash_internal_user_password(strtolower($user->firstname)); // Should be changed, unsafe
        $user->mnethostid = 1;
        $user->confirmed = 1;
        $user->timemodified = time();
        self::log("Create user {$user->email}");
        return (insert_record('user', $user));
    }


    function update_sitewide_course($csv_line) {

        $site_wide = get_record('course', 'category', 0);
        $site_wide->name = $csv_line->name;
        $site_wide->description = $csv_line->description;
        self::log("Update side-wide course.");
        return (update_record('course', $site_wide));
    } // function FunctionName

}

?>

