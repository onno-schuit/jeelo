<?php

//Increase timelimit and memory limit for this script.
set_time_limit(0);
raise_memory_limit('512M');

class content_uploader extends moodle {


    function __construct(&$moodle) {

        // Set variables
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
        $this->possible_groups = array(array('1', '2'), array('3', '4'), array('5', '6'), array('7', '8'));

        $this->moodle = $moodle;
        
        // Check files received, if not break it off immidietly
        if (!$this->has_files_received()) launcher_helper::print_error('3000');

    }


    function upload() {
        global $CFG;
        
        if (!$this->create_users()) launcher_helper::print_error('3002');
        if (!$this->create_child_content()) launcher_helper::print_error('3003');
        if (!$this->create_nonstandard_enrollments()) launcher_helper::print_error('3005');
        if (!$this->destroy_used_files()) launcher_helper::print_error('3004');

        return true;
    }


    // Creates users from the csv file
    function create_users() {
        global $CFG;
        
        $line = 0;
        $handler = fopen($this->moodle->upload_users['tmp_name'], 'r');
        while($data = fgetcsv($handler, 0, ';')) {

            $line ++;
            // Check column names
            if ($line == 1) {
				// continue;
                if ($this->validate_columns($data, $this->fields_users)) continue;
            }

            // Continue with the users
            $child_user = new stdClass();
            $child_user = $this->assign_column_names($data, $child_user, 'fields_users');

            if (!$child_user_id = $this->create_user($child_user)) return false;
            unset($child_user);
        }
        return true;
    }


    function assign_column_names($data, $obj, $fields_type) {

        $count = 0;
        foreach($this->$fields_type as $key => $column) { // Assign column names to $group
            $obj->$key = $data[$count];
            $count ++;
        }

        return $obj;
    }

    function create_admin_enrollment($user_id) {
        global $CFG;

        $query = "SELECT id FROM {$CFG->prefix}role WHERE shortname = 'admin'";
        if (!$role_result = launcher_helper::remote_execute($this->moodle, $query)) error('Couldn\'t select role.');

        $role_assignment = new stdClass();
        $role_assignment->roleid = mysql_result($role_result,0,0);
        $role_assignment->contextid = 1;
        $role_assignment->userid = $user_id;
        $role_assignment->timestart = time();
        $role_assignment->timemodified = time();
        $role_assignment->enrol = 'manual';
        $query = $this->insert_query_join_properties('role_assignments', $role_assignment);

        if (!$child_role_assignment_id = launcher_helper::remote_execute($this->moodle, $query, true)) error('Couldn\'t create role.');
    }


    function create_user($child_user) {
        global $CFG;

        $query = "SELECT * FROM {$CFG->prefix}user WHERE username = '".strtolower($child_user->email)."'";
        if (mysql_num_rows(launcher_helper::remote_execute($this->moodle, $query)) != 0) return true;

        $child_user->username = strtolower($child_user->email);
        $child_user->password = hash_internal_user_password(strtolower($child_user->firstname)); // Should be changed, unsafe
        $child_user->mnethostid = 1;
        $child_user->confirmed = 1;
        $child_user->timemodified = time();
        $query = $this->insert_query_join_properties('user', $child_user);

        return ($new_child_user_id = launcher_helper::remote_execute($this->moodle, $query, true)) ? $new_child_user_id : false;
    }


    function create_child_content() {
        global $CFG;

        foreach($this->moodle->categories as $parent_category_id) {

            if (!$child_category_id = $this->create_category($parent_category_id, count($parent_courses))) error('Failed to create categories.');
            //$child_category_id = 2;

            $moodle = $this->moodle;

            $line = 0;
            $handler = fopen($_FILES["upload_groups"]["tmp_name"], 'r');
            while($data = fgetcsv($handler, 0, ';')) {
                $line ++;
                if ($line == 1) {
                    if ($this->validate_columns($data, $this->fields_groups)) continue;
                } // Check column names

                // Set variables
                $child_group = new stdClass();
                $child_group = $this->assign_column_names($data, $child_group, 'fields_groups');
                $child_group->year = $this->groupyears_to_array($child_group->year);

                // Get courses with the same groupyear
                $parent_courses = $this->get_courses_by_groupyear($parent_category_id, $child_group->year);

                // Loop over courses
                foreach($parent_courses as $parent_course) {

                    // If not set yet: create array from parent groupyears
                    // $parent_course->groupyear = $this->groupyears_to_array($parent_course->groupyear);

                    // Possibly there are more years assigned to 1 group
                    // foreach($child_group->year as $child_group_year) {

                    // Create course
                    if (!$child_course_id = $this->create_course($moodle, $child_category_id, $child_group, $parent_course)) error("Couldn't create course");
                    // $child_course_id = 5;
                    // Create group
                    if (!$child_group_id = $this->create_group($moodle, $child_course_id, $child_group)) error("Couldn't create group.");
                    // $child_group_id = 1;
                    // Add users to groups
                    if (!$this->add_group_members($moodle, $child_course_id, $child_group, $child_group_id)) error("Couldn't add group members.");

                        // Everything went well, break to avoid copying the course another time
                     //   break;
                    // }
                }



                /* Loop over courses
                foreach($parent_courses as $parent_course) {

                    // If not set yet: create array from parent groupyears
                    if (!is_array($parent_course->groupyear)) $parent_course->groupyear = $this->groupyears_to_array($parent_course->groupyear);

                    exit(print_object($parent_course));
                    // Possible groups: 1/2, 3/4, 5/6, 7/8
                    foreach($this->possible_groups as $possible_group) {

                        // Possibly there are more years assigned to 1 group
                        foreach($child_group->year as $child_group_year) {
                            if (!in_array($child_group_year, $possible_group)) continue;
                            if (!in_array($child_group_year, $parent_course->groupyear)) continue;

                            // Create course
                            if (!$child_course_id = $this->create_course($moodle, $child_category_id, $child_group, $parent_course)) error("Couldn't create course");
                            // Create group
                            if (!$child_group_id = $this->create_group($moodle, $child_course_id, $child_group)) error("Couldn't create group.");
                            // Add users to groups
                            if (!$this->add_group_members($moodle, $child_course_id, $child_group_id)) error("Couldn't add group members.");
 
                            // Everything went well, break to avoid copying the course another time
                            break;
                        }
                    }
                }*/
            }
//            }
        }
        return true;
    }


    /* get courses by groupyear
     *
     * This function will build a query according to what groupyears
     * are given. It will execute the query and return only the courses
     * that are actually important, rather than checking later if we have
     * to skip certain courses... */
    function get_courses_by_groupyear($category_id, $groupyears) {
        global $CFG;
        
        $courses_to_call = array();
        // Get all the groups in an array for a join
        foreach($groupyears as $groupyear) {
            foreach($this->possible_groups as $key=>$possible_group) {
                if (in_array($groupyear, $possible_group)) $courses_to_call[$key] = join('/', $possible_group); // $courses_to_call[$key] = $possible_group;
            }
        }

        $sql_extra = '';
        $count = 0;
        foreach($courses_to_call as $key => $course_to_call) {
            $count ++;
            $sql_extra .= "'$course_to_call'";
            if ($count != count($courses_to_call)) $sql_extra .= ','; // Make sure we wont have a comma at the end
        }

        $query = "
            SELECT * FROM {$CFG->prefix}course
            WHERE category = '$category_id'
            AND groupyear IN ($sql_extra)";

        return (get_records_sql($query));
    }


    function add_group_members($moodle, $course_id, $group, $group_id) {
        global $CFG;

        $line = 0;
        $handler = fopen($moodle->upload_users['tmp_name'], 'r');
        while($data = fgetcsv($handler, 0, ';')) {

            $line ++;
            // Check column names
            if ($line == 1) {
                if ($this->validate_columns($data, $this->fields_users)) continue;
            }

            // Assign variables
            $csv_user = new stdClass();
            $csv_user = $this->assign_column_names($data, $csv_user, 'fields_users');
            $csv_user->groups = array($csv_user->group1, $csv_user->group2, $csv_user->group3);

            // Skip users with different groups
            if (!in_array($group->name, $csv_user->groups)) continue;


            $query = "SELECT * FROM {$CFG->prefix}user WHERE username = '{$csv_user->email}'";
            $child_db_user = launcher_helper::remote_execute($moodle, $query);
            $child_db_user_id = mysql_result($child_db_user, 0, 0);

            // Enroll user
            if (!$this->create_enrollment($child_db_user_id, $course_id, array($csv_user->rol1, $csv_user->rol2))) error('Error creating enrollment.');

            if ($csv_user->rol1 == 'beheerder' || $csv_user->rol2 == 'beheerder') continue; // Admins don't need groups, skip the creation

            if (isset($csv_user->groups) && count($csv_user->groups) > 0) {
                if (!$this->add_group_member($moodle, $csv_user, $child_db_user_id, $course_id, $group_id)) return false;
            }

            unset($csv_user);
        }
        return true;
    }


    function add_group_member($moodle, $csv_user, $child_db_user_id, $course_id, $group_id) {
        global $CFG;

        $group_member = new stdClass();
        $group_member->userid = $child_db_user_id;
        $group_member->groupid = $group_id;
        $group_member->timeadded = time();
        $query = $this->insert_query_join_properties('groups_members', $group_member);

        return (launcher_helper::remote_execute($this->moodle, $query));
    }


    function destroy_used_files() {
        
        if (file_exists("{$this->moodle->cfg->dirroot}/class.restore_backup.php")) unlink("{$this->moodle->cfg->dirroot}/class.restore_backup.php");

        return true;
    }


    function create_enrollment($user_id, $course_id, $roles, $multiple_courses = false) {
        global $CFG;

        $error = false;
        foreach($roles as $role) {
            if (empty($role)) continue;

            $break = false;
            // Only add student and teacher for now, the other roles need access to more courses
            switch(true) {
                case ($role == 'leerling' && !$multiple_courses):
                    $role_query = "SELECT * FROM {$CFG->prefix}role WHERE shortname = 'student'";
                    break;
                case ($role == 'leerkracht' && !$multiple_courses):
                    $role_query = "SELECT * FROM {$CFG->prefix}role WHERE shortname = 'teacher'";
                    break;

                case ($role == 'invalkracht' && $multiple_courses):
                    $role_query = "SELECT * FROM {$CFG->prefix}role WHERE shortname = 'substitute'";
                    break;
                case ($role == 'schoolleider' && $multiple_courses):
                    $role_query = "SELECT * FROM {$CFG->prefix}role WHERE shortname = 'schoolleader'";
                    break;
                case ($role == 'beheerder' && $multiple_courses):
                    $role_query = "SELECT * FROM {$CFG->prefix}role WHERE shortname = 'admin'";
                    break;

                default:
                    $break = true; // If a different role type is assigned skip it
                    break;
            }
            if ($break) continue;

            if (!$role_result = launcher_helper::remote_execute($this->moodle, $role_query)) continue;

            $role_id = mysql_result($role_result,0,0);
            $context_id = trim($this->get_or_create_context(CONTEXT_COURSE, $course_id));

            $role_assignment->roleid = $role_id;
            $role_assignment->contextid = $context_id;
            $role_assignment->userid = $user_id;
            $role_assignment->timemodified = time();
            $role_assignment->enrol = 'manual';

            $query = $this->insert_query_join_properties('role_assignments', $role_assignment);

            if (!launcher_helper::remote_execute($this->moodle, $query)) continue;
            // error("Couldn't create role assignment for role:<br />Role id:$role_id<br />Context id: $context_id<br />User id: $user_id<br /><br />$query<br />".mysql_error());
        }

        return (!$error);
    }


    function create_nonstandard_enrollments() {
        global $CFG;
        
        $line = 0;
        $handler = fopen($this->moodle->upload_users['tmp_name'], 'r');
        while($data = fgetcsv($handler, 0, ';')) {

            $line ++;
            // Check column names
            if ($line == 1) {
                if ($this->validate_columns($data, $this->fields_users)) continue;
            }
            // Continue with the users
            $csv_user = new stdClass();
            $csv_user = $this->assign_column_names($data, $csv_user, 'fields_users');

            $user_query = "SELECT * FROM {$CFG->prefix}user WHERE username='{$csv_user->email}' AND deleted = 0";
            $user_result = launcher_helper::remote_execute($this->moodle, $user_query);
            $user_id = mysql_result($user_result, 0, 0);

            // If rol == beheerder skip looping through the courses. We want a side-wide rol assignment instead.
            if ($csv_user->rol1 == 'beheerder' || $csv_user->rol2 == 'beheerder') {
                $this->create_enrollment($user_id, 1, array($csv_user->rol1, $csv_user->rol2), true);
                return true;
            }

            // Any other rol we'll loop through the courses first
            $query = "SELECT * FROM {$CFG->prefix}course WHERE category > 0 AND visible = 1";
            $courses = launcher_helper::remote_execute($this->moodle, $query);
            while($course = mysql_fetch_array($courses)) {
                // Assign roles now
                $this->create_enrollment($user_id, $course['id'], array($csv_user->rol1, $csv_user->rol2), true);
            }
        }
        return true;
    }


    function create_category($category_id, $course_count) {

        $category = get_record('course_categories', 'id', $category_id);
        unset($category->id);
        $category->timemodified = time();
        $category->coursecount = $course_count;
        $query = $this->insert_query_join_properties('course_categories', $category);

        if (!$new_category_id = launcher_helper::remote_execute($this->moodle, $query, true)) error('Couldn\'t create category');
        if (!$this->get_or_create_context(CONTEXT_COURSECAT, $new_category_id)) error("Couldn't create context for category");

        return $new_category_id;
    }


    function create_course($moodle, $category_id, $group, $course) {
        global $CFG;

        if (!$backup_name = $this->create_backup($moodle, $category_id, $group, $course)) error("Failed to create backup for parent course {$course->id}");
        $data_string = $this->assemble_data_string_for_restore($course, $group, $backup_name);
        if (!$new_course_id = trim($this->execute_course_restore($moodle, $data_string))) error("Failed to execute course restore for parent course {$course->id}");

        return $new_course_id; // Will return newly created course id
    }


    function execute_course_restore($moodle, $data_string) {
        
        $curl = curl_init($moodle->cfg->wwwroot.'/class.restore_backup.php');

        curl_setopt($curl,CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data_string);
        $result = curl_exec($curl);
        curl_close ($curl);

        return ($result == 'false') ? false : $result;
    }


    function assemble_data_string_for_restore($course, $group, $backup_name) {

        $course_new = clone($course);
        unset($course_new->groupyear);

        $data_string = "backup_name=$backup_name&group_name={$group->name}&";
        foreach($course_new as $key=>$value) {
            $data_string .= "course[$key]=$value&";
        }
        rtrim($data_string,'&');
        unset($course_new);

        return $data_string;
    } // assemble_data_string_for_restore


    function create_backup($moodle, $category_id, $group, $course) {
        require_once('class.backup_course.php');

        $backup_restore = new backup_course($moodle->cfg->dataroot);
        if (!$backup_restore->create_backup_folder()) return false;

        return ($backup_restore->course_backup($category_id, $course));
    }


    function create_group($moodle, $course_id, $group) {
        $new_group = clone($group);
        $new_group->courseid = $course_id;

        $query = $this->insert_query_join_properties('groups', $new_group);

        return (launcher_helper::remote_execute($moodle, $query, true));
    }


    function insert_query_join_properties($table, $object) {
        global $CFG;

        $object = $this->filter_wrong_columns($table, $object);

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
    }


    function filter_wrong_columns($table, $object) {
        global $CFG;

        $query = "SHOW COLUMNS FROM {$CFG->prefix}$table";
        $columns = get_records_sql($query, false);
        foreach($object as $key=>$obj_column) {
            if (!isset($columns[$key])) unset($object->$key);
        }

        return $object;
    }


    function groupyears_to_array($groupyear) {
        return array_filter(explode('/', $groupyear));
    }


    function has_files_received() {

        $error = false;
        $files = array($this->moodle->upload_users, $this->moodle->upload_groups);
        foreach($files as $file) {
            if ($file['name'] == '') $error = true;
        }

        return (!$error);
    }


    function validate_columns($columns_to_validate, $correct_column_names) {

        $error_col = array();
        foreach($columns_to_validate as $key => $column_to_validate) {
            if (empty($column_to_validate)) continue;

            if (!in_array($column_to_validate, $correct_column_names)) $error_col[] = $column_to_validate;
        }
        if (count($error_col) > 0) launcher_helper::error('The following columns in the csv file are not correct: <br />', $error_col);

        return true;
    }


    function get_or_create_context($context_level, $instance_id) {

        $data = array('context_level'=>$context_level, 'instance_id'=>$instance_id);
        $curl = curl_init($this->moodle->cfg->wwwroot.'/get_or_create_context.php');

        curl_setopt($curl,CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        $context_id = curl_exec($curl);
        curl_close ($curl);
        if ($context_id == 'false') error('Failed to create context for context level ' . $context_level . ' and instance id ' . $instance_id);

        return trim($context_id);
    }
}
?>
