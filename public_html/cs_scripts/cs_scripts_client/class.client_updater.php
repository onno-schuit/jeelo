<?php
include("../config.php");
error_reporting(E_ALL);
ini_set('display_errors','On');

class client_updater extends client {

    function start_updater($csv_line) {
        
        /* include config.php
         * update course 1
         * update all course categories, set them invisible
         * extract csv tar                                      ***DONE***
         * insert / update / delete users
         * insert new courses / groups / enrollments
         */

        // Update course 1
        // self::update_sitewide_course($csv_line);

        // Update all course categories
        // $this->set_existing_categories_invisible(); DONE
        // Extract csv files
        // $this->extract_csv_files($csv_line); DONE
        // Update users
        $this->update_all_users($csv_line);
    }

    function extract_csv_files($csv_line) {
        global $CFG;

        if (is_dir("{$CFG->dataroot}/temp/updater")) shell_exec("rm -R {$CFG->dataroot}/temp/updater");
        mkdir("{$CFG->dataroot}/temp/updater");
        $cmd = sprintf("tar -xz -C %s -f %s", "{$CFG->dataroot}/temp/updater", $csv_line->csv_filename);
        self::log($cmd);
        shell_exec($cmd);

        return true;
    }


    function set_existing_categories_invisible() {
        global $CFG;

        $error = false;

        $query = "UPDATE {$CFG->prefix}course_categories SET visible='0'";
        self::log($query);
        if (!execute_sql($query, false)) $error = true;

        $query = "UPDATE {$CFG->prefix}course SET visible='0' WHERE category != '0'";
        self::log($query);
        if (!execute_sql($query, false)) $error = true;

        if ($error) {
            self::log("Failed to set the categories and courses invisible on client.");
            die();
        }
        return;
    }

    function update_all_users($csv_line) {
        global $CFG;

        $handler = fopen("{$CFG->dataroot}/temp/updater/users.csv", 'r');
        while($data = fgetcsv($handler)) {
            exit(print_object($data));
        }
    }


    function create_new_content() {
        
    }

    function get_categories_from_server() {
        
    }


    function update_sitewide_course($csv_line) {

        $site_wide = get_record('course', 'category', 0);
        $site_wide->name = $csv_line->name;
        $site_wide->description = $csv_line->description;
        self::log("Update side-wide course.");
        return (update_record('course', $site_wide));
    } // function FunctionName

}

?>

