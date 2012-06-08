<?php

// Moodle backup scripts
require_once($CFG->dirroot . '/lib/adminlib.php');
require_once($CFG->dirroot . '/backup/util/includes/backup_includes.php');
require_once($CFG->dirroot . '/backup/util/includes/restore_includes.php');
require_once($CFG->dirroot . '/backup/moodle2/backup_plan_builder.class.php');
require_once($CFG->dirroot.'/local/soda/class.user.php');

class school extends user {

    //static $table_name = 'launcher_moodles';
    public $global_root;
    public $dumps_location    = '/etc/moodle_clients';
    public $domain = false;


    function __construct($properties) {
        global $CFG;

        $this->global_root = substr($CFG->dirroot, 0, strrpos($CFG->dirroot, '/'));
        launcher_helper::set_buffer_db();
        $this->include_upload_files();
        $this->datetime_stamp = time();
        if ($this->domain) {
            $this->dumps_location = "/etc/moodle_clients/{$this->domain}";
        }
        if (! file_exists($this->dumps_location . '/csv')) shell_exec("mkdir {$this->dumps_location}/csv");
        if (! file_exists($this->dumps_location . '/courses')) shell_exec("mkdir {$this->dumps_location}/courses");
        if (! file_exists($this->dumps_location . '/code')) shell_exec("mkdir {$this->dumps_location}/code");
        if (! file_exists($this->dumps_location . '/db')) shell_exec("mkdir {$this->dumps_location}/db");
        parent::__construct($properties);
    } // function __construct


    function validate_and_save() {

        if (!$this->validate()) return false;
        $this->prepair_school();

        return true;
    } // function validate_and_save


    function prepair_school() {

        $this->set_dump_locations();
        $this->buffer_id = $this->add_to_buffer();

        $this->dump_codebase();
        $this->dump_database();
        $this->dump_csv_files();
        $this->dump_projects();

        $this->update_buffer_status('prepaired_school');
    } // function prepair_school

    function update_buffer_status($status) {
        global $BUFFER_DB;

        $buffer = new stdClass();
        $buffer->id = $this->buffer_id;
        $buffer->status = $status;

        $BUFFER_DB->update_record('client_moodles', $buffer);
    } // function update_buffer_status


    function define_validation_rules() {

        $this->add_rule('site_name', get_string('required'), function($site_name) { return ( trim($site_name) != '' ); });

        $this->add_rule('site_shortname', get_string('required'), function($site_shortname) { return ( trim($site_shortname) != '' ); });
        $this->add_rule('site_shortname', get_string('unique', 'launcher'), function($site_shortname) {
            global $BUFFER_DB;
            return (!$BUFFER_DB->get_records('client_moodles', array('shortname'=>$site_shortname)));
        });
        $this->add_rule('site_shortname', get_string('shortname_format', 'launcher'), function($site_shortname) {
            return (strlen($site_shortname) <= 16 && !preg_match("/[^a-zA-Z0-9]/s", $site_shortname));
        });

        $this->add_rule('admin_email', get_string('error_email', 'launcher'), function($admin_email) { return (validate_email($admin_email)); });

        $this->add_rule('server_name', get_string('required'), function($server_name) { return ( trim($server_name) != '' ); });

        $this->add_rule('domain', get_string('required'), function($domain) { return ( trim($domain) != '' ); });

        // Check file extensions
        $this->add_rule('upload_users', get_string('error_file_extension', 'launcher'), function($upload_users) {
            return (end(explode(".", $upload_users['name'])) == 'csv');
        });

        $this->add_rule('upload_groups', get_string('error_file_extension', 'launcher'), function($upload_groups) {
            return (end(explode(".", $upload_groups['name'])) == 'csv');
        });

    } // function define_validation_rules


    function validate() {

        $valid = $this->validate_upload_files();
        $valid = $valid && $this->validate_projects();
        $valid = $valid && parent::validate();
                
        return $valid;
    } // function validate


    // TODO
    function validate_projects() {
        return true;
    } // function validate_projects


    function validate_upload_files() {

        if (!$this->has_csv_files_received()) {
            $this->add_error('upload_users', get_string('upload_users_error', 'launcher', $this));
            $this->add_error('upload_groups', get_string('upload_groups_error', 'launcher', $this));
            return false;
        }
        return true;
        
    } // function validate_upload_files

    function set_dump_locations() {
        
        $this->set_dump_file('code');
        $this->set_dump_file('db', '.gz');

        if ($this->has_csv_files_received()) $this->set_dump_file('csv'); // The csv files are optional...
        if ($this->has_categories_selected()) $this->set_dump_file('courses'); // Projects are optional...

    } // function set_dump_locations

    function get_categories_selected() {
        global $DB;

        $query = "SELECT * FROM {course_categories} WHERE id IN (" . join($this->categories, ',') . ")";

        return ($categories = $DB->get_records_sql($query));
    } // function get_categories_selected
    
    function get_courses_selected($category_id) {
        global $DB;

        $query = "SELECT * FROM {course} WHERE id != 1 AND category = $category_id AND (groupyear IS NOT NULL) AND (groupyear != '')";
        
        return ($DB->get_records_sql($query));
    } // function get_courses_selected


    function dump_projects() {
        global $DB;
        
        // The projects are optional

        if (!$this->has_categories_selected()) return true;
        if (!$categories = $this->get_categories_selected()) return false;
        
        shell_exec("cd {$this->dumps_location}/courses ; rm -Rf *");

        // Dump category
        foreach($categories as $category) {

            if (!$category_id = $this->dump_category($category)) print_error("launcher", "Failed to create categories.");
            
            // Dump course
            if (!$courses = $this->get_courses_selected($category->id)) return false;
            foreach($courses as $course) {
                $this->dump_course($course, $category_id);
            }
        }

        $this->compress_courses();
    } // function dump_projects


    function dump_category($category) {
        global $BUFFER_DB;

        $category->client_moodle_id = $this->buffer_id;
        $category->original_id = $category->id;

        return ($BUFFER_DB->insert_record('client_categories', $category));
    } // function dump_category

    /**
     * Uses standard Moodle backup function to create a zip of a Moodle course
     *
     * @param   integer     $user_id    Id of the user performing the backup (required by Moodle)
     * @param   integer     $course_id  Id of the course to be dumped
     * @param   string      $target     Filename and path of the resulting zip
     * @return  boolean                 Returns true if dump succeeded, otherwise false
     */
    function dump_course($course, $category_id) {
        global $USER;

        $backup_name = "course_{$course->id}.zip";
        $target = "{$this->dumps_location}/courses/$backup_name";

        $stored_file = $this->backup_course($USER->id, $course->id);
        $stored_file->copy_content_to($target);

        $this->save_course_in_buffer($course, $category_id, $backup_name);

    } // function dump_course

    function save_course_in_buffer($course, $category_id, $backup_name) {
        global $BUFFER_DB;

        $course->client_moodle_id = $this->buffer_id;
        $course->parent_category_id = $category_id;
        $course->backup_name = $backup_name;

        return ($BUFFER_DB->insert_record('client_courses', $course));
    } // function save_course_in_buffer

    /**
     * Makes a course backup without any users.
     *
     * @param   integer     $course_id  Id of the course to be backed up
     * @param   integer     $user_id    Id of the user performing the backup (required by Moodle)
     * @return  object                  Object of class stored_file, points to the actual backup file
     */
    function backup_course($user_id, $course_id) {
        // MODE_HUB backups by definition never have user info
        $bc = new backup_controller($type = backup::TYPE_1COURSE,
                                    $id = $course_id, 
                                    $format = backup::FORMAT_MOODLE,
                                    $interactive = backup::INTERACTIVE_YES,
                                    $mode = backup::MODE_HUB,
                                    $userid = $user_id);
        $bc->finish_ui();
        $bc->execute_plan();

        // $results_array['backup_destination'] contains a stored_file object.
        // See lib/filestorage/stored_file.php|42 col 1| class stored_file
        $results_array = $bc->get_results();
        $bc->destroy();
        return $results_array['backup_destination'];
    } // function backup_course

    function compress_courses() {

        $target = $this->get_dump_file('courses');
        shell_exec("cd {$this->dumps_location}/courses; tar -cz -f $target *.zip");
        shell_exec("cd {$this->dumps_location}/courses; rm *.zip");
         
    } // function compress_courses

    function add_to_buffer() {
        global $BUFFER_DB;

        $buffer = new stdClass();
        $buffer->domain         = $this->domain;
        $buffer->shortname      = $this->site_shortname;
        $buffer->fullname       = $this->site_name;
        $buffer->email          = $this->admin_email;
        $buffer->sql_filename   = $this->get_dump_file('db');
        $buffer->codebase_filename   = $this->get_dump_file('code');
        $buffer->is_for_client  = 'client';
        $buffer->status         = 'prepairing';
        $buffer->exit_code      = 0;
        $buffer->logo      = $this->logo;
        $buffer->customcss      = $this->customcss;

        if ($this->get_dump_file('csv')) $buffer->csv_filename   = $this->get_dump_file('csv');
        if ($this->get_dump_file('courses')) $buffer->courses_filename   = $this->get_dump_file('courses');

        return ($BUFFER_DB->insert_record("client_moodles", $buffer));
    } // function add_to_buffer


    function dump_csv_files() {

        if (!$this->has_csv_files_received()) return true;

        shell_exec("cd {$this->dumps_location}/csv ; rm -Rf *");

        // Move uploaded csv files to /etc/moodle_clients
        move_uploaded_file($this->upload_users['tmp_name'], "{$this->dumps_location}/csv/users.csv");
        move_uploaded_file($this->upload_groups['tmp_name'], "{$this->dumps_location}/csv/groups.csv");

        // Compress them into 1 file
        $target = $this->get_dump_file('csv');
        shell_exec("cd {$this->dumps_location}/csv ; tar -cz -f {$target} users.csv groups.csv");
        
        // Finally delete the created csv files, we now got them compressed anyway
        unlink("{$this->dumps_location}/csv/users.csv");
        unlink("{$this->dumps_location}/csv/groups.csv");
        
        return true;
    } // function dump_csv_files


    function dump_codebase() {
        $target = $this->get_dump_file('code');
        return shell_exec("cd {$this->global_root} ; tar -czp --exclude='public_html/config.php' -f {$target} public_html/*");
    } // function dump_codebase


    function dump_database() {
        global $CFG;

        $target = $this->get_dump_file('db');

        $cmd = "mysqldump -u{$CFG->dbuser} -p{$CFG->dbpass} {$CFG->dbname} | gzip > {$target}";
        return shell_exec("mysqldump -u{$CFG->dbuser} -p{$CFG->dbpass} {$CFG->dbname} | gzip > {$target}");
    } // function dump_database


    function set_dump_file($type, $ext = '.tgz') {
        //$this->dump->$type = "{$this->dumps_location}/$type/{$this->domain}_{$type}_" . date("Ymd") . "$ext";
        // date makes it impossible to repeatedly test the same dumps...
        $this->dump->$type = "{$this->dumps_location}/$type/{$this->domain}_{$type}_{$this->datetime_stamp}$ext";
    } // function set_dump_file


    function get_dump_file($type) {
        return (isset($this->dump->$type)) ? $this->dump->$type : false;
    } // function get_dump_file
    
    function include_upload_files() {
        if (!isset($_FILES)) return true;
        foreach($_FILES as $key=>$file) {
            $this->$key = $file;
        }
    } // function include_upload_files

    function has_csv_files_received() {
        return (!empty($this->upload_users['tmp_name']) && !empty($this->upload_groups['tmp_name']));
    } // function has_csv_files_received

    function has_categories_selected() {
        return (isset($this->categories) && !empty($this->categories));
    } // function has_categories_selected

}
?>
