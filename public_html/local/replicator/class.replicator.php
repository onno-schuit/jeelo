<?php

class replicator {


    public static function test() {
        return "This is replicator::test()";
    } // function test

    /**
     * Makes a dump of the Moodle codebase (i.e. webroot folder). For security 
     * reasons, we omit the config.php file
     *
     * @param   string  $source     Directory name and path of the codebase
     * @param   string  $target     Filename and path of the resulting zip 
     * @return  void
     */
    public static function dump_codebase($source, $target) {
        return shell_exec("tar -czv --exclude=config.php -f {$target} {$source}");
    } // function dump_codebase 


    /**
     * Makes a dump of a Moodle database 
     *
     * @param   string  $database   Database to be dumped
     * @param   string  $target     Filename and path of the resulting zip
     * @return void
     */
    public static function dump_database($database, $target) {
                
    } // function dump_database


    /**
     * Uses standard Moodle backup function to create a zip of a Moodle course
     *
     * @param   integer     $course_id  Id of the course to be dumped
     * @param   string      $target     Filename and path of the resulting zip
     * @return  boolean                 Returns true if dump succeeded, otherwise false
     */
    public static function dump_course($course_id, $target) {
                
    } // function dump_course


    /**
     * Unzips the $zip in the $target directory
     *
     * @param   string     $zip     Filename and path of the zip containing the codebase
     * @param   string     $target  Target directory and path where codebase is unzipped
     * @return  boolean             Returns true if restore succeeded, otherwise false
     */
    public static function restore_codebase($zip, $target) {
                
    } // function restore_codebase


    /**
     * Creates a new database filled with contents of database dump in $zip.
     *
     * @param   string     $zip  Filename and path of the zip containing the database dump
     * @return  boolean          Returns true if restore succeeded, otherwise false
     */
    public static function restore_database($zip) {
                
    } // function restore_database


    /**
     * Uses standard Moodle restore function to restore a course
     *
     * @param   string     $zip  Filename and path of the zip containing the backup
     * @return  boolean          Returns true if restore succeeded, otherwise false
     */
    public static function restore_course($zip) {
                
    } // function restore_course


} // class replicator 

?>
