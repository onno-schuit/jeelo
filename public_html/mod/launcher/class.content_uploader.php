<?php
require_once('class.categories.php');
require_once('class.file_handler.php');


class content_uploader extends model {

    function __construct() {

        // Set variables
        $this->moodle = parent::get_moodle_vars();
        $this->fields_users = array('voornaam', 'achternaam', 'etc...');
        $this->fields_groups = array('naam', 'jaar');
        exit(print_object($this->moodle));

        // Check files received, if not break it off immidietly
        $this->has_files_received(array($moodle->upload_users, $moodle->upload_groups));

    } // function __construct

    function upload() {
        
        if (!$this->create_categories($moodle)) print_error('launcher', 'Failed to create courses and categories.');

        //$groups = $this->upload_groups($moodle->upload_groups);
        //$users = $this->upload_users($moodle->upload_users, $groups);
    } // function upload_start


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

    function create_categories($moodle) {

        $child_categories = new categories();
        $uploader = new uploader();
        foreach($moodle->categories as $parent_category) {

            $category_courses = get_records('course', 'category', $category_id);
            if (!$child_categories = $child_categories->create_new_category($parent_category)) error('Failed to create categories.');

            $uploader->begin();
            while($uploader_data = $uploader->next()) {

                $uploader->line ++;

                if ($uploader->line == 1) $uploader->validate_columns($data);

                // Continue with next
            }
        }
        exit();
        
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


    function create_category($moodle, $category_id, $course_count) {
        global $CFG;
        $category = get_record('course_categories', 'id', $category_id);
        unset($category->id);
        $category->timemodified = 0;
        $category->coursecount = $course_count;
        $query = $this->insert_query_join_properties('course_categories', $category);

        return launcher_helper::remote_execute($moodle, $query, true);

    } // function create_category


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


    function has_files_received($files) {

        foreach($files as $file) {
            if ($file['name'] == '') error('One of the uploaded files could not be found.');
        }

        return true;
    } // function has_files_received


    function validate_columns($columns) {

        $error_col = array();
        foreach($columns as $key => $column) {
            if (empty($column)) continue;
            if ($this->fields_groups[$key] != $column) $error_col[] = $column;
        }
        if (count($error_col) > 0) launcher_helper::error('The following columns in the csv file are not correct: <br />', $error_col);

        return true;
    } // function validate_columns
}
?>
