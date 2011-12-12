<?php


defined('MOODLE_INTERNAL') || die();
function xmldb_launcher_upgrade($oldversion) {

    global $DB, $CFG;

	$result = true;
    $dbman = $DB->get_manager(); // loads ddl manager and xmldb classes
    
    /*
    if ($result && $oldversion < 2011111704) {

        $query = "ALTER TABLE {$CFG->prefix}launcher CHANGE average_loadtime average_loadtime FLOAT( 20 ) UNSIGNED NULL DEFAULT NULL";

        $result = $result && $DB->execute($query);
    }
    */

/// Final return of upgrade result (true, all went good) to Moodle.
    return $result;
}
