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
        
//Increase timelimit and memory limit for this script.
@ini_set('max_execution_time', 300); // 5 minutes should be enough
@ini_set("memory_limit","1024M");

class backup_course {

    private $backup_folder = 'temp/updater/courses';

    function __construct($dataroot, $course_imports = false) {

        $this->child_dataroot = $dataroot;
        if ($course_imports) $this->backup_folder = $course_imports;

    }


    function course_backup($category_id, $course) {
        global $CFG;

        ob_start();

        $preferences = @schedule_backup_course_configure($course);
        
        $preferences->backup_destination = $this->child_dataroot.'/'.$this->backup_folder;
        $preferences->backup_users = 2; // 0=All, 1=Course, 2=None
        $preferences->backup_logs = 0; //0=No, 1=Yes
        $preferences->backup_user_files = 0; // 0=No, 1=Yes

        if (!schedule_backup_course_execute($preferences)) return false;

        ob_end_clean(); // Clean any possible errors that might show up
        
        return $preferences->backup_name;
    }


    function create_backup_folder() {
        $target = $this->child_dataroot.'/'.$this->backup_folder;
        return (!is_dir($target)) ? mkdir($target) : true;
    }
}


?>

