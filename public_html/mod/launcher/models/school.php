<?php

// Moodle backup scriptz
require_once($CFG->dirroot . '/lib/adminlib.php');
require_once($CFG->dirroot . '/backup/util/includes/backup_includes.php');
require_once($CFG->dirroot . '/backup/util/includes/restore_includes.php');
require_once($CFG->dirroot . '/backup/moodle2/backup_plan_builder.class.php');
require_once($CFG->dirroot.'/local/soda/class.user.php');

class school extends user {

    //static $table_name = 'launcher_moodles';
    public $global_root       = '/home/menno/php_projects/jeelo';
    public $dumps_location    = '/etc/moodle_clients';

    function __construct($properties) {

        launcher_helper::set_buffer_db();
        $this->include_upload_files();

        parent::__construct($properties);
    }

    function validate_and_save() {

        if (!$this->validate()) return false;
        $this->prepair_school();

        return true;
    }

    function prepair_school() {

        $this->set_dump_locations();
        $this->buffer_id = $this->add_to_buffer();

        $this->dump_codebase();
        $this->dump_database();
        $this->dump_csv_files();
        $this->dump_projects();

        $this->update_buffer_status('prepaired_school');
    }

    function update_buffer_status($status) {
        global $BUFFER_DB;

        $buffer = new stdClass();
        $buffer->id = $this->buffer_id;
        $buffer->status = $status;

        $BUFFER_DB->update_record('client_moodles', $buffer);
    }

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

        $this->validate_upload_files();

    }

    function validate_upload_files() {

        if (!$this->has_csv_files_received()) return;

        // When groups are being uploaded the users are required
        if (empty($this->upload_users['name'])) {
            $this->add_rule('upload_users', get_string('required_users', 'launcher'), function($upload_users) {
                return (!empty($upload_users['name']));
            });
        }

        // When users are being uploaded the groups are required
        if (empty($this->upload_groups['name'])) {
            $this->add_rule('upload_groups', get_string('required_groups', 'launcher'), function($upload_groups) {
                return (!empty($upload_groups['name']));
            });
        }

        // Check file extensions
        $this->add_rule('upload_users', get_string('error_file_extension', 'launcher'), function($upload_users) {
            return (end(explode(".", $upload_users['name'])) == 'csv');
        });

        $this->add_rule('upload_groups', get_string('error_file_extension', 'launcher'), function($upload_groups) {
            return (end(explode(".", $upload_groups['name'])) == 'csv');
        });
        
    }

    function set_dump_locations() {
        
        $this->set_dump_file('code');
        $this->set_dump_file('db', '.gz');

        if ($this->has_csv_files_received()) $this->set_dump_file('csv'); // The csv files are optional...
        if ($this->has_categories_selected()) $this->set_dump_file('courses'); // Projects are optional...

    }

    function get_categories_selected() {
        global $DB;

        $query = "SELECT * FROM {course_categories} WHERE id IN (" . join($this->categories, ',') . ")";

        return ($categories = $DB->get_records_sql($query));
    }
    
    function get_courses_selected($category_id) {
        global $DB;

        $query = "SELECT * FROM {course} WHERE id != 1 AND category = $category_id";
        
        return ($DB->get_records_sql($query));
    }

    function dump_projects() {
        global $DB;
        
        // The projects are optional
        if (!$this->has_categories_selected()) return true;

        if (!$categories = $this->get_categories_selected()) return false;
        
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
    }

    function dump_category($category) {
        global $BUFFER_DB;

        $category->client_moodle_id = $this->buffer_id;
        $category->original_id = $category->id;

        return ($BUFFER_DB->insert_record('client_categories', $category));
    }

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

        $target = "{$this->dumps_location}/courses/{$course->fullname}.zip";

        $stored_file = $this->backup_course($USER->id, $course->id);
        $stored_file->copy_content_to($target);

        $this->save_course_in_buffer($course, $category_id);

    }

    function save_course_in_buffer($course, $category_id) {
        global $BUFFER_DB;

        $course->client_moodle_id = $this->buffer_id;
        $course->parent_category_id = $category_id;

        return ($BUFFER_DB->insert_record('client_courses', $course));
    }

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
    }

    function compress_courses() {

        $target = $this->get_dump_file('courses');
        shell_exec("cd {$this->dumps_location}/courses; tar -cz -f $target *.zip");
        shell_exec("cd {$this->dumps_location}/courses; rm *.zip");
         
    }

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

        if ($this->get_dump_file('csv')) $buffer->csv_filename   = $this->get_dump_file('csv');
        if ($this->get_dump_file('courses')) $buffer->courses_filename   = $this->get_dump_file('courses');

        return ($BUFFER_DB->insert_record("client_moodles", $buffer));
    }

    function dump_csv_files() {

        if (!$this->has_csv_files_received()) return true;

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
    }

    function dump_codebase() {

        $homedir = $this->global_root;
        $target = $this->get_dump_file('code');

        return shell_exec("cd {$homedir} ; tar -czp --exclude='public_html/config.php' -f {$target} public_html/*");
    }

    function dump_database() {
        global $CFG;

        $target = $this->get_dump_file('db');

        $cmd = "mysqldump -u{$CFG->dbuser} -p{$CFG->dbpass} {$CFG->dbname} | gzip > {$target}";
        return shell_exec("mysqldump -u{$CFG->dbuser} -p{$CFG->dbpass} {$CFG->dbname} | gzip > {$target}");
    }

    function set_dump_file($type, $ext = '.tgz') {
        $this->dump->$type = "{$this->dumps_location}/$type/{$this->domain}_{$type}_" . date("Ymd") . "$ext";
    }

    function get_dump_file($type) {
        return (isset($this->dump->$type)) ? $this->dump->$type : false;
    }
    
    function include_upload_files() {
        if (!isset($_FILES)) return true;
        foreach($_FILES as $key=>$file) {
            $this->$key = $file;
        }
    }

    function has_csv_files_received() {
        return (!empty($this->upload_users['tmp_name']) && !empty($this->upload_groups['tmp_name']));
    }

    function has_categories_selected() {
        return (isset($this->categories) && !empty($this->categories));
    }

}
?>
