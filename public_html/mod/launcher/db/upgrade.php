<?php


defined('MOODLE_INTERNAL') || die();
function xmldb_launcher_upgrade($oldversion) {

    global $DB;

    $dbman = $DB->get_manager(); // loads ddl manager and xmldb classes


/// if ($oldversion < YYYYMMDD00) { //New version in version.php
///
/// }

/// Final return of upgrade result (true, all went good) to Moodle.
    return true;
}
