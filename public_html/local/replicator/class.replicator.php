<?php

class replicator {

    /**
     * Makes a dump of the current Moodle codebase
     *
     * @param   string  $target     Filename of the resulting zip
     * @return  void
     */
    public static function dump_codebase($target) {

    } // function dump_codebase 


    /**
     * Makes a dump of the database of the current Moodle
     *
     * @param   string  $target     Filename of the resulting zip
     * @return void
     */
    public static function dump_database($target) {
                
    } // function dump_database


    /**
     * Uses standard Moodle backup function to create a zip of a Moodle course
     *
     * @param   integer     $course_id  Id of the course to be dumped
     * @param   string      $target     Filename of the resulting zip
     * @return  boolean                 Returns true if dump succeeded, otherwise false
     */
    public static function dump_course($course_id, $target) {
                
    } // function dump_course


    /**
     * Unzips the $source in the $target directory
     *
     * @param   string     $source  Filename of the zip containing the codebase
     * @param   string     $target  Target directory where codebase is unzipped
     * @return  boolean             Returns true if restore succeeded, otherwise false
     */
    public static function restore_codebase($source, $target) {
                
    } // function restore_codebase


    /**
     * Creates a new database filled with contents of database dump in $source.
     *
     * @param   string     $source  Filename of the zip containing the database dump
     * @return  boolean             Returns true if restore succeeded, otherwise false
     */
    public static function restore_database($source) {
                
    } // function restore_database


    /**
     * Uses standard Moodle restore function to restore a course
     *
     * @param   string     $source  Filename of the zip containing the backup
     * @return  boolean             Returns true if restore succeeded, otherwise false
     */
    public static function restore_course($source) {
                
    } // function restore_course


} // class replicator 

?>
