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
        

class backup_course {

    private $backup_folder = 'course_imports';

    function __construct($dataroot) {

        $this->child_dataroot = $dataroot;

    } // function __construct


    function course_backup($category_id, $group, $course) {
        global $CFG;

        $preferences = schedule_backup_course_configure($course);
        
        $preferences->backup_destination = "{$this->child_dataroot}/{$this->backup_folder}";
        // $preferences->backup_destination = "{$this->moodle->cfg->dataroot}/{$this->backup_folder}";

        $preferences->backup_users = 2; // 0=All, 1=Course, 2=None
        $preferences->backup_logs = 0; //0=No, 1=Yes
        $preferences->backup_user_files = 0; // 0=No, 1=Yes

        return (@schedule_backup_course_execute($preferences)) ? $preferences->backup_name : false;
        
    } // function backup


    function create_backup_folder() {
        global $CFG;

        // return true;
        if (is_dir("{$this->child_dataroot}/{$this->backup_folder}")) return true;
        return (mkdir("{$this->child_dataroot}/{$this->backup_folder}"));
        
    } // function create_backup_folder
}


?>

