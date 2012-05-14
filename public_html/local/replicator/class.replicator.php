<?php

define('CLI_SCRIPT', true);
require_once(dirname(__FILE__) . '/../../config.php');
require_once($CFG->dirroot . '/backup/util/includes/backup_includes.php');
require_once($CFG->dirroot . '/backup/util/includes/restore_includes.php');
require_once($CFG->dirroot . '/backup/moodle2/backup_plan_builder.class.php');


/**
 * Class Replicator contains a number of state independent static functions 
 * for replicating a Moodle codebase, course or database.
 *
 * WARNING: most functions do not work if executed through Apache!
 */
class replicator {


    public static function test() {
        return "This is replicator::test()";
    } // function test


    /**
     * Makes a dump of the Moodle codebase (i.e. webroot folder). For security 
     * reasons, we omit the config.php file.
     *
     * @param   string  $source     Directory name and path of the codebase
     * @param   string  $target     Filename and path of the resulting zip 
     * @return  string              Returns the output of the tar command
     */
    public static function dump_codebase($source, $target) {
        return shell_exec("cd {$source} ; cd .. ; tar -czp --exclude='tags' --exclude='public_html/config.php' --exclude='moodledata' -f {$target} *");
    } // function dump_codebase 


    /**
     * Makes a dump of a Moodle database 
     *
     * @param   string  $database   Database to be dumped
     * @param   string  $username   Mysql username
     * @param   string  $password   Mysql password
     * @param   string  $target     Filename and path of the resulting zip
     * @return  string              Returns the output of the mysqldump command
     */
    public static function dump_database($database, $username, $password, $target) {
        return shell_exec("mysqldump -u{$username} -p{$password} {$database} | gzip > {$target}");
    } // function dump_database


    /**
     * Uses standard Moodle backup function to create a zip of a Moodle course
     *
     * @param   integer     $user_id    Id of the user performing the backup (required by Moodle)
     * @param   integer     $course_id  Id of the course to be dumped
     * @param   string      $target     Filename and path of the resulting zip
     * @return  boolean                 Returns true if dump succeeded, otherwise false
     */
    public static function dump_course($user_id, $course_id, $target) {
        $stored_file = static::backup_course($user_id, $course_id);
        return $stored_file->copy_content_to($target);
    } // function dump_course


    /**
     * Unzips the $zip in the $target directory
     *
     * @param   string     $zip     Filename and path of the zip containing the codebase
     * @param   string     $target  Target directory and path where codebase is unzipped
     * @return  string              Returns output of the shell command tar
     */
    public static function restore_codebase($zip, $target) {
        return shell_exec("cd $target; tar -zpxf {$zip}");
    } // function restore_codebase


    /**
     * Creates a new database filled with contents of database dump in $zip.
     *
     * @param   string     $database   Database to create
     * @param   string     $username   Mysql username
     * @param   string     $password   Mysql password
     * @param   string     $zip        Filename and path of the zip containing the database dump
     * @return  boolean                Returns true if restore succeeded, otherwise false
     */
    public static function restore_database($database, $username, $password, $zip) {
        shell_exec("mysql -u{$username} -p{$password} -e 'CREATE DATABASE {$database} CHARACTER SET utf8 COLLATE utf8_general_ci;'");
        shell_exec("gunzip -c {$zip} | mysql -u{$username} -p{$password} {$database}");
    } // function restore_database


    /**
     * Uses standard Moodle restore function to restore a course
     *
     * @param   integer    $DB   Moodle database object
     * @param   string     $zip  Filename and path of the zip containing the backup
     * @return  boolean          Returns true if restore succeeded, otherwise false
     */
    public static function restore_course($DB, $zip) {
                
    } // function restore_course


    /**
     * Makes a course backup without any users.
     *
     * @param   integer     $course_id  Id of the course to be backed up
     * @param   integer     $user_id    Id of the user performing the backup (required by Moodle)
     * @return  object                  Object of class stored_file, points to the actual backup file
     */
    private static function backup_course($course_id, $user_id) {
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


} // class replicator 

?>
