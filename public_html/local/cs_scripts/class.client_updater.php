<?php
require_once('../../../jeelo_cron/class.client.php');

/**
 * This class runs on local Moodle clients. It should be invoked as a cron job.
 * The class has two functions:
 *
 * - upgrade Moodle code base
 * - 'new schoolyear' / import courses, categories, groups & users scenario
 *
 *
 * If you run client_updater#main, it will check with the 'server' (buffer db wrapper)
 * to see if there are any tasks for this particular Moodle.
 */

class client_updater extends client {

    public static function test() {
        echo "Okay from client_updater::test\n";        
        static::parent_test();
    } // function test


    public static function get_csv_zip_from_server($client_moodle_id, $target) {
        self::log("Getting csv file from server for moodle_client id {$client_moodle_id}");
        $request = array(
            'request' => 'get_csv_zip',
            'id'      => $client_moodle_id
        );
        shell_exec( sprintf("wget -O $target '%s'", self::get_request_url($request)) );
    } // function get_csv_zip_from_server


    public static function get_school_groups($moodle_client_id) {
                
    } // function get_school_groups


} // class client_updater

?>
