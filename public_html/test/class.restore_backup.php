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
        

class restore_backup {

	private $backup_folder = 'temp/updater/courses';
	
	function course_restore($backup_name, $course, $group_name) {
        global $SESSION, $CFG, $restore;

        ob_start();

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
        define('RESTORE_SILENTLY', false);

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

        $restore->file = $CFG->dataroot . '/' . $file;
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
        $restore->backup_version = $info->backup_moodle_version;

        //Save the restore session object
        $SESSION->restore =& $restore;
        $SESSION->restore->restore_course_files = $restore->course_files;
        $SESSION->restore->restore_site_files   = $restore->site_files;

        $restore->deleting = false; //There is nothing to delete when we restore to a new course

        $course_header->course_shortname = "{$course->shortname} - $group_name - ".date('m-Y');
        $course_header->course_fullname = "{$course->fullname} - $group_name - ".date('m-Y');

        if (!@restore_execute($restore, $info, $course_header, $errorstr)) return false;

        ob_end_clean(); // Clean any possible errors that might show up
        
        return (isset($restore->course_id) && !empty($restore->course_id)) ? $restore->course_id : false;
    } // function restore

}

$file_contents = file_get_contents($argv[1]);
$course = unserialize($file_contents);
$backup_name = $course->backup_name;
$group_name = $course->group_name;
unset($course->backup_name);
unset($course->group_name);

$error = false;
// Running script
$restore_backup = new restore_backup();
if (!$course_id = $restore_backup->course_restore($backup_name, $course, $group_name)) $error = true;
echo ($error) ? 'false' : $course_id; // Return course id
unset($restore_backup);

?>
