<?php

//Increase timelimit and memory limit for this script.
set_time_limit(0);
raise_memory_limit('512M');

class content_uploader extends moodle {

    function __construct(&$moodle) {

        $this->moodle = $moodle;
        
        // Check files received, if not break it off immidietly
        if (!$this->has_files_received()) launcher_helper::print_error('3000');

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

    } // function __construct


    function upload() {
        global $CFG;
        
        if (!$this->create_users()) launcher_helper::print_error('3002');
        if (!$this->create_child_content()) launcher_helper::print_error('3003');
        if (!$this->destroy_used_files()) launcher_helper::print_error('3004');

        return true;
    } // function upload


    // Creates users from the csv file
    function create_users() {
        
        $line = 0;
        $handler = fopen($this->moodle->upload_users['tmp_name'], 'r');
        while($data = fgetcsv($handler, 0, ';')) {

            $line ++;
            // Check column names
            if ($line == 1) {
				continue;
                // if ($this->validate_columns($data, $this->fields_users)) continue;
            }

            // Continue with the users
            $child_user = new stdClass();
            $child_user = $this->assign_column_names($data, $child_user, 'fields_users');

            if (!$this->create_user($child_user)) return false;
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
    } // function assign_column_names

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
    } // function create_admin_enrollment


    function create_user($child_user) {

        $child_user->username = strtolower($child_user->email);
        $child_user->password = hash_internal_user_password(strtolower($child_user->firstname)); // Should be changed, unsafe
        $child_user->mnethostid = 1;
        $child_user->confirmed = 1;
        $child_user->timemodified = time();
        $query = $this->insert_query_join_properties('user', $child_user);

        if (!$new_child_user_id = launcher_helper::remote_execute($this->moodle, $query, true)) error('Couldn\'t create user');

		return $new_child_user_id;
    } // function create_user


    function read_csv_and_execute_code($type, $code) {

        $line = 0;
        $handler = fopen($_FILES["upload_$type"]["tmp_name"], 'r');
        while($data = fgetcsv($handler, 0, ';')) {
            $line ++;
            if ($line == 1) {
                $fields_type = ($type == 'users') ? 'fields_users' : 'fields_groups';
                if ($this->validate_columns($data, $this->$fields_type)) continue;
            } // Check column names

            $child = new stdClass();
            $child = $this->assign_column_names($data, $child, 'fields_'.$type);

            $code($child);

            unset($child);
        }

    } // function read_csv_and_execute_code


    function create_child_content() {

        foreach($this->moodle->categories as $parent_category_id) {

            $parent_courses = get_records('course', 'category', $parent_category_id);
            if (!$child_category_id = $this->create_category($parent_category_id, count($parent_courses))) error('Failed to create categories.');
            // $child_category_id = 2;

 //           $this->read_csv_and_execute_code('users', function($child_group) {
            $line = 0;
            $handler = fopen($_FILES["upload_groups"]["tmp_name"], 'r');
            while($data = fgetcsv($handler, 0, ';')) {
                $line ++;
                if ($line == 1) {
                    if ($this->validate_columns($data, $this->fields_groups)) continue;
                } // Check column names

                $child_group = new stdClass();
                $child_group = $this->assign_column_names($data, $child_group, 'fields_groups');


                // Continue with the groups
                $child_group->groupyears = $this->groupyears_to_array($child_group->year);

                foreach($parent_courses as $parent_course) {
                    // If no groupyear exists for the course we can't do anything with it.
                    if (empty($parent_course->groupyear)) continue;
                    // If its not an array yet convert it
                    if (!is_array($parent_course->groupyear)) $parent_course->groupyear = $this->groupyears_to_array($parent_course->groupyear);

                    foreach($this->possible_groups as $possible_group) {

                        foreach($child_group->groupyears as $child_group_year) {
                            if (!in_array($child_group_year, $possible_group)) continue;
                            if (!in_array($child_group_year, $parent_course->groupyear)) continue;

                            // Create course
                            if (!$child_course_id = $this->create_course($this->moodle, $child_category_id, $child_group, $parent_course)) error("Couldn't create course");
                            // Create group
                            if (!$child_group_id = $this->create_group($this->moodle, $child_course_id, $child_group)) error("Couldn't create group.");
                            // Add users to groups
                            if (!$this->add_group_members($this->moodle, $child_course_id, $child_group_id)) error("Couldn't add group members.");
 
                            // Everything went well, break to avoid copying the course another time
                            break;
                        }
                    }
                }
                unset($child_group);
//            });
            }
        }
        return true;
    } // function create_child_content


    function add_group_members($moodle, $course_id, $group_id) {
        global $CFG;

        $line = 0;
        $handler = fopen($this->moodle->upload_users['tmp_name'], 'r');
        while($data = fgetcsv($handler, 0, ';')) {

            $line ++;
            // Check column names
            if ($line == 1) {
                if ($this->validate_columns($data, $this->fields_users)) continue;
            }

            // Continue with the groups
            $child_user = new stdClass();
            $child_user = $this->assign_column_names($data, $child_user, 'fields_users');

            if (!empty($child_user->group1)) $child_user->groups[] = $child_user->group1;
            if (!empty($child_user->group2)) $child_user->groups[] = $child_user->group2;
            if (!empty($child_user->group3)) $child_user->groups[] = $child_user->group3;

            foreach($child_user->groups as $user_group) {
                $query = "SELECT * FROM {$CFG->prefix}groups WHERE name = '$user_group' AND courseid = '$course_id'";
                $group = launcher_helper::remote_execute($moodle, $query);
                 
                if (mysql_num_rows($group) == 0) continue; // No group selected; continue

                $group_id = mysql_result($group, 0, 0);
                $query = "SELECT * FROM {$CFG->prefix}user WHERE username = '{$child_user->email}'";
                $user = launcher_helper::remote_execute($moodle, $query);
                $user_id = mysql_result($user, 0, 0);

                if (!$this->add_group_member($user_id, $group_id)) error('Couldn\'t create group member.');
                if (!$this->create_enrollment($user_id, $course_id, $child_user->rol1, $child_user->rol2)) error('Error creating enrollment.');
            }
            unset($child_user);
        }
        return true;
    } // function create_enrollments

/*
    function destroy_used_files() {
        
        if (!unlink("{$this->moodle->cfg->dirroot}/class.restore_backup.php")) error('Didn\'t unlink');
        if (!unlink("{$this->moodle->cfg->dirroot}/get_or_create_context.php")) error('Didn\'t unlink');

        return true;
    } // function destroy_used_files
*/

    function create_enrollment($user_id, $course_id, $rol1, $rol2) {
        global $CFG;

        $error = false;
        $roles = array($rol1, $rol2);
        foreach($roles as $role) {

            // Only add student and teacher for now
            switch($role) {
                case 'leerling':
                    $role_query = "SELECT * FROM mdl_role WHERE shortname = 'student'";
                    break;
                case 'leerkracht':
                    $role_query = "SELECT * FROM mdl_role WHERE shortname = 'teacher'";
                    break;
                default:
                    $role_query = false;
                    break;
            }
            if (!$role_query) continue;

            $role_result = launcher_helper::remote_execute($this->moodle, $role_query);
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
    } // function create_enrollment


    function add_group_member($user_id, $group_id) {
        $group_member->userid = $user_id;
        $group_member->groupid = $group_id;
        $group_member->timeadded = time();
        $query = $this->insert_query_join_properties('groups_members', $group_member);

        return launcher_helper::remote_execute($this->moodle, $query);
    } // function add_group_member


    function create_category($category_id, $course_count) {
        global $CFG;

        $category = get_record('course_categories', 'id', $category_id);
        unset($category->id);
        $category->timemodified = time();
        $category->coursecount = $course_count;
        $query = $this->insert_query_join_properties('course_categories', $category);

        if (!$new_category_id = launcher_helper::remote_execute($this->moodle, $query, true)) error('Couldn\'t create category');
        if (!$this->get_or_create_context(CONTEXT_COURSECAT, $new_category_id)) error("Couldn't create context for category");

        return $new_category_id;
    } // function create_categories


    function create_course($moodle, $category_id, $group, $course) {

        if (!$backup_name = $this->create_backup($moodle, $category_id, $group, $course)) error("Failed to create backup for parent course {$course->id}");
        $data_string = $this->assemble_data_string_for_restore($course, $group, $backup_name);
        if (!$new_course_id = trim($this->execute_course_restore($moodle, $data_string))) error("Failed to execute course restore for parent course {$course->id}");

        return $new_course_id; // Will return newly created course id
    } // function create_course


    function execute_course_restore($moodle, $data_string) {
        
        $curl = curl_init($moodle->cfg->wwwroot.'/class.restore_backup.php');

        curl_setopt($curl,CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data_string);
        $result = curl_exec($curl);
        curl_close ($curl);

        return ($result == 'false') ? false : $result;
    } // function execute_course_restore


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

        return ($backup_name = $backup_restore->course_backup($category_id, $group, $course)) ? $backup_name : false;

    } // function create_backup


    function create_block_instance($parent_block, $parent_block_instance, $child_course_id) {
        global $CFG;

        $query = "SELECT * FROM {$CFG->prefix}block WHERE name = '{$parent_block->name}'";
        $child_block_result = launcher_helper::remote_execute($this->moodle, $query);
        $child_block_id = mysql_result($child_block_result, 0, 0);

        $query = "SELECT * FROM {$CFG->prefix}block_instance WHERE blockid = '$child_block_id' AND pageid = '$child_course_id'";
        if (mysql_num_rows(launcher_helper::remote_execute($this->moodle, $query)) > 0) return true; // The instance exists already

        $child_block_instance = clone($parent_block_instance);
        $child_block_instance->pageid = $child_course_id;
        $child_block_instance->blockid = $child_block_id;
        $query = $this->insert_query_join_properties('block_instance', $child_block_instance);

        return (launcher_helper::remote_execute($this->moodle, $query));

    } // function create_block_instance


    function create_group($moodle, $course_id, $group) {
        $new_group = clone($group);
        $new_group->courseid = $course_id;

        $query = $this->insert_query_join_properties('groups', $new_group);

        return (launcher_helper::remote_execute($moodle, $query, true));
    } // function create_group


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
    } // function join_properties_and_values


    function filter_wrong_columns($table, $object) {
        global $CFG;
        $query = "SHOW COLUMNS FROM {$CFG->prefix}$table";
        $columns = get_records_sql($query, false);
        foreach($object as $key=>$obj_column) {
            if (!isset($columns[$key])) unset($object->$key);
        }
        return $object;
    } // function filter_wrong_columns


    function groupyears_to_array($groupyears) {
        return array_filter(explode('/', $groupyears));
    } // function groupyear_to_array


    function has_files_received() {

        $error = false;
        $files = array($this->moodle->upload_users, $this->moodle->upload_groups);
        foreach($files as $file) {
            if ($file['name'] == '') $error = true;
        }

        return (!$error);
    } // function has_files_received


    function validate_columns($columns_to_validate, $correct_column_names) {

        $error_col = array();
        foreach($columns_to_validate as $key => $column_to_validate) {
            if (empty($column_to_validate)) continue;

            if (!in_array($column_to_validate, $correct_column_names)) $error_col[] = $column_to_validate;
        }
        if (count($error_col) > 0) launcher_helper::error('The following columns in the csv file are not correct: <br />', $error_col);

        return true;
    } // function validate_columns


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
    } // function get_or_create_context
}
?>
