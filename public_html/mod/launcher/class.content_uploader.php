<?php
require_once('class.categories.php');

class content_uploader extends moodle {

    function __construct(&$moodle) {

        $this->moodle = $moodle;
        // Set variables
        $this->fields_users = array('firstname', 'lastname', 'email', 'city', 'country', 'rol1', 'rol2', 'group1', 'group2', 'group3');
        $this->fields_groups = array('name', 'year');

        // Check files received, if not break it off immidietly
        $this->has_files_received();

    } // function __construct


    function upload() {
        
        if (!$this->create_users()) error('Failed to create users.');
        if (!$this->create_categories()) error('Failed to create courses and categories.');

        //$groups = $this->upload_groups($moodle->upload_groups);
        //$users = $this->upload_users($moodle->upload_users, $groups);
    } // function upload_start


    // Creates users from the csv file
    function create_users() {
        
        $line = 0;
        $handler = fopen($this->moodle->upload_users['tmp_name'], 'r');
        while($data = fgetcsv($handler, 0, ';')) {

            $line ++;
            // Check column names
            if ($line == 1) {
                if ($this->validate_columns($data, $this->fields_users)) continue;
            }

            // Continue with the users
            $child_user = new stdClass();
            foreach($this->fields_users as $key => $column) { // Assign column names to $group
                $child_user->$column = $data[$key];
            }

            //$child_user_id = $this->create_user($child_user);
            $child_user_id = 3;
            if ($child_user->rol1 == 'beheerder' || $child_user->rol2 == 'beheerder') $this->create_enrollment($child_user_id, 'admin');
        }
    }


    function create_enrollment($user_id, $role_name) {
        global $CFG;

        switch($role_name) {
            case 'beheerder':
                $role_name = 'admin';
                break;
            case 'icter':
                $role_name = 'whatever';
                break;
        }
        $query = "SELECT id FROM {$CFG->prefix}role WHERE shortname = '$role_name'";
        if (!$role_result = launcher_helper::remote_execute($this->moodle, $query)) error('Couldn\'t select role.');

        $role_assignment = new stdClass();
        $role_assignment->roleid = mysql_result($role_result,0,0);
        $role_assignment->contextid = ($role_name == 'admin') ? 1 : 2
        $role_assignment->userid = $user_id;
        $role_assignment->timemodified = time();
        $role_assignment->enrol = 'manual';
        //$role_assignment = ;
    } // function create_enrollment

    function create_user($child_user) {
        
        unset($child_user->rol1);
        unset($child_user->rol2);
        unset($child_user->group1);
        unset($child_user->group2);
        unset($child_user->group3);
        $child_user->username = strtolower($child_user->firstname);
        $child_user->password = hash_internal_user_password(strtolower($child_user->firstname)); // Should be changed, unsave
        $child_user->mnethostid = 1;
        $child_user->confirmed = 1;
        $child_user->timemodified = time();
        $query = $this->insert_query_join_properties('user', $child_user);

        if (!$new_child_user_id = launcher_helper::remote_execute($this->moodle, $query, true)) error('Couldn\'t create user');

    } // function create_user

/*    function upload_groups($groups) {
        
        // groups
        $handler = fopen($groups['tmp_name'], 'r');
        $line_num = 0;
        while($data = fgetcsv($handler, 0, ';')) {

            $line_num ++;
            if ($line_num == 1) { // Check column names
                if ($this->validate_columns($data)) continue;
            }
            
            $groups = new stdClass();
            foreach($this->fields_groups as $key => $column) {
                $group->$column = $data[$key];
            }

            exit(print_object('Processing ...'));
        }
    } // function upload_groups
 */

    function create_categories() {

        foreach($this->moodle->categories as $parent_category_id) {

            $parent_courses = get_records('course', 'category', $parent_category_id);
            // if (!$child_category_id = $this->create_category($parent_category_id, count($parent_courses))) error('Failed to create categories.');
            $child_category_id = 2;

            $line = 0;
            $handler = fopen($this->moodle->upload_groups['tmp_name'], 'r');
            while($data = fgetcsv($handler, 0, ';')) {

                $line ++;
                if ($line == 1) {
                    if ($this->validate_columns($data, $this->fields_groups)) continue;
                } // Check column names

                // Continue with the groups
                $child_group = new stdClass();
                foreach($this->fields_groups as $key => $column) { // Assign column names to $group
                    $child_group->$column = $data[$key];
                }
                $child_group->groupyear = $this->groupyears_to_array($child_group->year);

                foreach($parent_courses as $parent_course) {
                    if (empty($parent_course->groupyear)) continue; // If no groupyear exists for the course we can't do anything with it.
                    $parent_course->groupyear = $this->groupyears_to_array($parent_course->groupyear);

                    if (!in_array($parent_course->groupyear, $child_group->groupyears)) continue; // This shouldn't happen
                    // Create course
                    if (!$child_course_id = $this->create_course($this->moodle, $child_category_id, $child_group, $parent_course)) error('Couldn\'t create course');
                    // Create group
                    $this->create_group($this->moodle, $child_course_id, $child_group);
                    // Create enrollment
                    

                }
            }
            exit(print_object('First category loop succesfull...'));

        }
        exit(print_object('Force quit...'));
        
        foreach($moodle->categories as $category_id) {

            $courses = get_records('course', 'category', $category_id);
            $remote_category_id = $this->create_category($moodle, $category_id, count($courses));
            
            $handler = fopen($moodle->upload_groups['tmp_name'], 'r');
            $line_num = 0;
            while($data = fgetcsv($handler, 0, ';')) {

                $line_num ++;
                if ($line_num == 1) { // Check column names
                    if ($this->validate_columns($data)) continue;
                }
                
                $group = new stdClass();
                foreach($this->fields_groups as $key => $column) { // Assign column names to $group
                    $group->$column = $data[$key];
                }

                $group_groupyears = $this->groupyears_to_array($group->year);

                foreach($courses as $course) {
                    if (empty($course->groupyear)) continue;
                    $course_groupyears = $this->groupyears_to_array($course->groupyear);

                    foreach($course_groupyears as $course_groupyear) {
                        if (in_array($course_groupyear, $group_groupyears)) {
                            // Create course
                            if (!$new_course_id = $this->create_course($moodle, $remote_category_id, $group, $course)) error('Could not create course');

                            // Create group
                            $this->create_group($moodle, $new_course_id, $group);
                            break;
                        }
                    }
                }
            }
        }
    } // function create_courses_and_categories()


    function create_category($category_id, $course_count) {
        global $CFG;

        $category = get_record('course_categories', 'id', $category_id);
        unset($category->id);
        $category->timemodified = time();
        $category->coursecount = $course_count;
        $query = $this->insert_query_join_properties('course_categories', $category);

        return ($new_category_id = launcher_helper::remote_execute($this->moodle, $query, true)) ? $new_category_id : false;
    } // function create_categories


    function create_course($moodle, $category_id, $group, $course) {
        global $CFG;

        // Courses
        $new_course = $course;
        $new_course->category = $category_id;
        $new_course->fullname .= " - {$group->name}";
        $new_course->shortname .= "_{$group->name}";
        unset($new_course->groupyear); // Dont need this any more...

        $query = $this->insert_query_join_properties('course', $new_course);
        $new_course_id = launcher_helper::remote_execute($moodle, $query, true);

        $course_tables = array('course_allowed_modules', 'course_modules', 'course_sections');
        foreach($course_tables as $course_table) {
            $this->insert_into_course_tables($moodle, $course, $course_table, $new_course_id);
        }

        $modules = get_records_sql("SELECT * FROM {$CFG->prefix}modules WHERE name != 'launcher'");
        foreach($modules as $module) {
            //exit(print_object($module));
            if (!$activities = get_records($module->name, 'course', $course->id)) continue;
            foreach($activities as $activity) {
                unset($activity->id);
                $activity->course = $new_course_id;
                $query = $this->insert_query_join_properties($module->name, $activity);
                if (!launcher_helper::remote_execute($moodle, $query)) exit('Foutmelding');
            }
        }

        return $new_course_id;
    } // function create_course


    function insert_into_course_tables($moodle, $course, $course_table, $new_course_id) {
        
        // Sections
        if (!$course_table_objects = get_records($course_table, 'course', $course->id)) return false;

        foreach($course_table_objects as $object) {
            unset($object->id);
            $object->course = $new_course_id;
            $query = $this->insert_query_join_properties($course_table, $object);
            if (!launcher_helper::remote_execute($moodle, $query)) exit(print_object('Doe iets...'));
        }

        return true;
    } // function 


    function create_group($moodle, $course_id, $group) {
        $group->courseid = $course_id;
        unset($group->year); // Don't need this anymore.

        $query = $this->insert_query_join_properties('groups', $group);

        launcher_helper::remote_execute($moodle, $query, true);
    } // function create_group


    function insert_query_join_properties($table, $object) {
        global $CFG;
        
        $query = "INSERT INTO {$CFG->prefix}$table (";
        $values = $fields = array();
        foreach($object as $field => $property) {
            if ($field == 'id') continue; // Ignore primary ids
            $fields[] = $field;
            $values[] = $property;
        }
        $query .= join(',', $fields) . ") VALUES (";
        $count = 0;
        foreach($values as $value) {
            $count ++;
            $query .= "'".mysql_escape_string($value)."'";
            if (count($values) != $count) $query .= ",";
        }
        return ($query .= ")");
    } // function join_properties_and_values


    function groupyears_to_array($groupyears) {
        return array_filter(explode('/', $groupyears));
    } // function groupyear_to_array


    function has_files_received() {

        $files = array($this->moodle->upload_users, $this->moodle->upload_groups);
        foreach($files as $file) {
            if ($file['name'] == '') error('One of the uploaded files could not be found.');
        }

        return true;
    } // function has_files_received


    function validate_columns($columns, $file) {

        $error_col = array();
        foreach($columns as $key => $column) {
            if (empty($column)) continue;
            if ($file[$key] != $column) $error_col[] = $column;
        }
        if (count($error_col) > 0) launcher_helper::error('The following columns in the csv file are not correct: <br />', $error_col);

        return true;
    } // function validate_columns
}
?>
