<?php
require_once("../config.php");

global $CFG;

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

//Increase timelimit and memory limit for this script.
@ini_set("max_execution_time", 300); // 5 minutes should be enough
@ini_set("memory_limit","1024M");


class restore_backup {

	private $backup_folder = 'temp/updater/courses';

    function __construct() {

        $this->clean_sessions();
        define('RESTORE_SILENTLY', true);
    }
	
	function course_restore($backup_name, $course, $group_name) {
        global $SESSION, $CFG, $restore;

        ob_start(); // Catch the output, we don't want to see it

        // Error string is being filled if there's an error. Use for debugging if neccesary.
        $errorstr = '';


        // Required session variables
        $info = $SESSION->info;
        $course_header = $SESSION->course_header;

        // We'll build on the restore object now...
        $this->set_restore_variables($info, $errorstr, $backup_name);
        // Now we add the given instances of the models
        $this->get_module_instances($course);

        //Save the restore session object
        $SESSION->restore =& $restore;
        $SESSION->restore->restore_course_files = $restore->course_files;
        $SESSION->restore->restore_site_files   = $restore->site_files;

        // Add our own shortname and fullname to keep the course names unique
        $course_header->course_shortname = "{$course->shortname} - $group_name - ".date('m-Y');
        $course_header->course_fullname = "{$course->fullname} - $group_name - ".date('m-Y');
		exit(print_object($SESSION));

        return (restore_execute($restore, $info, $course_header, $errorstr));

        ob_end_clean(); // Clean any possible errors that might show up
        
        return (isset($restore->course_id) && !empty($restore->course_id)) ? $restore->course_id : false;
    } // function restore

    function get_module_instances($course) {
        global $restore;
        
        $allmods = get_records("modules");
        foreach ($allmods as $mod) {
            $modname = $mod->name;
            
            $instances= get_all_instances_in_course($modname, $course, NULL, true);

            if ($instances === NULL) {
                continue;
            }

            $restore->mods[$modname]->restore = 1;
            $restore->mods[$modname]->userinfo = 0;

            foreach ($instances as $instance) {
                $restore->mods[$modname]->instances[$instance->id]->restore = 1;
                $restore->mods[$modname]->instances[$instance->id]->userinfo = 0;
            }
        }
    }

    function clean_sessions() {
        global $SESSION;
        
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
    }

    function set_restore_variables($info, $errorstr, $backup_name) {
        global $restore;
        
        $restore->file = "{$CFG->dataroot}/{$this->backup_folder}/$backup_name";
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
        $restore->backup_version = $info->backup_moodle_version;
        $restore->deleting = false; //There is nothing to delete when we restore to a new course
        $restore->backup_unique_code = restore_precheck(false, $restore->file, $errorstr, true);
    }

}


$course->fullname = "Test 01";
$course->shortname = "Test01";

$group_name = "Group 1";
$backup_name = "backup-cf6151-20120416-1223.zip";

/*
$file_contents = file_get_contents($argv[1]);
$course = unserialize($file_contents);
$backup_name = $course->backup_name;
$group_name = $course->group_name;
unset($course->backup_name);unset($course->group_name);
*/

$error = false;
// Running script
$restore_backup = new restore_backup();
if (!$course_id = $restore_backup->course_restore($backup_name, $course, $group_name)) $error = true;
echo ($error) ? 'false' : $course_id; // Return course id
unset($restore_backup);

?>
