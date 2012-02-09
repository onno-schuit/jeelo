<?php
global $CFG;
require_once (dirname(__FILE__) . '/../../config.php');
require_once ($CFG->dirroot . '/backup/backup_scheduled.php');
require_once ($CFG->dirroot . '/backup/lib.php');
require_once ($CFG->dirroot . '/backup/backuplib.php');
require_once ($CFG->libdir . '/blocklib.php');
require_once ($CFG->dirroot . '/lib/xmlize.php');
require_once ($CFG->dirroot . '/course/lib.php');
require_once ($CFG->dirroot . '/backup/restorelib.php');
require_once ($CFG->dirroot . '/backup/bb/restore_bb.php');
require_once ($CFG->libdir . '/wiki_to_markdown.php');
require_once ($CFG->libdir . '/adminlib.php');
require_once ($CFG->libdir . '/dmllib.php');
require_once ($CFG->libdir . '/moodlelib.php');
        

class backup_restore {

    private $backup_folder = 'course_imports';

    function __construct($moodle) {

        $this->moodle = $moodle;

    } // function __construct


    function course_backup($category_id, $group, $course) {
        global $CFG;

        $preferences = schedule_backup_course_configure($course);
        
        
        $preferences->backup_destination = "{$CFG->dataroot}/{$this->backup_folder}";
        // $preferences->backup_destination = "{$this->moodle->cfg->dataroot}/{$this->backup_folder}";


        $preferences->backup_users = 2; // 0=All, 1=Course, 2=None
        $preferences->backup_logs = 0; //0=No, 1=Yes
        $preferences->backup_user_files = 0; // 0=No, 1=Yes

        return (schedule_backup_course_execute($preferences)) ? $preferences->backup_name : false;
        
    } // function backup


    function course_restore($backup_name, $course) {
        global $SESSION, $CFG;

        if (isset ($SESSION->course_header)) {
            unset ($SESSION->course_header);
        }
        if (isset ($SESSION->info)) {
            unset ($SESSION->info);
        }
        if (isset ($SESSION->backupprefs)) {
            unset ($SESSION->backupprefs);
        }
        if (isset ($SESSION->restore)) {
            unset ($SESSION->restore);
        }

        $error_output = '';
        $file = "{$this->backup_folder}/$backup_name";
        define('RESTORE_SILENTLY', true);

        $backup_unique_code = restore_precheck($course->id, $file, $error_output, true);

        // Build up the restore object
        $course_header = $SESSION->course_header;
        $info = $SESSION->info;
        
        $restore = new stdClass();
        $restore->backup_unique_code = $backup_unique_code;

        if ($allmods = get_records("modules")) {
            foreach ($allmods as $mod) {
                $modname = $mod->name;
                $restore->mods[$modname]->restore = 1;
                $restore->mods[$modname]->userinfo = 0;
                
                $instances= get_all_instances_in_course($modname, $course, NULL, true);
//						$instances = !empty ($info->mods[$mod->name]->instances) ? $info->mods[$mod->name]->instances : NULL;		// oude code voor ophalen instances

                if ($instances === NULL) {
                    continue;
                }
                
                foreach ($instances as $instance) {
                        $var = 'restore_' . $modname . '_instance_' . $instance->id;
                    $restore->mods[$modname]->instances[$instance->id]->restore = 1;
                        $var = 'restore_user_info_' . $modname . '_instance_' . $instance->id;
                    $restore->mods[$modname]->instances[$instance->id]->userinfo = 0;
                }
            }
        }

        $restore->file = $CFG->dataroot . '/' . $this->backup_folder . '/' . $file;
        $restore->restoreto = 2;
        $restore->metacourse = 0; //No restore of meta courses
        $restore->users = 2; //restore of users. 1=Course, 2=None
        $restore->logs = 0; //No restore of logs
        $restore->user_files = 0; //No restore of user files
        $restore->site_files = 1; //restore of site related files 0=No, 1=yes
        $restore->messages = 0; //No restore of messages
        $restore->course_files = 1; //Restore course files
        $restore->restore_gradebook_history = 0; //No restore of gradebook history	
        $restore->groups = 0;
        
        $restore->course_startdateoffset = time(); //change to restore
        
        //add new vars to restore object
        $restore->course_shortname = 'testing_this_course';
        $restore->restore_restorecatto = 0;
        $restore->backup_version = $info->backup_moodle_version;        

        //Save the restore session object
        $SESSION->restore =& $restore;
        $SESSION->restore->restore_course_files = $restore->course_files;
        $SESSION->restore->restore_site_files   = $restore->site_files;

        // TEST THIS
        $restore->deleting = false; //There is nothing to delete when we restore to a new course

        return (restore_execute($restore, $info, $course_header, $errorstr));

    } // function restore


    function create_backup_folder() {
        global $CFG;

        return true;
        return (mkdir("{$this->moodle->cfg->dataroot}/{$this->backup_folder}"));
        
    } // function create_backup_folder
}


?>

