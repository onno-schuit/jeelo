<?php

function xmldb_newmodule_upgrade($oldversion=0) {

    global $CFG, $THEME, $db;

    $result = true;

    if ($result && $oldversion < 2011120802) {

    /// Define field picture to be added to signup_user_data
        $table = new XMLDBTable('signup_user_data');
        $field = new XMLDBField('picture');
        $field->setAttributes(XMLDB_TYPE_INTEGER, '1', XMLDB_UNSIGNED, XMLDB_NOTNULL, null, null, null, '0', 'yahoo');

    /// Launch add field picture
        $result = $result && add_field($table, $field);
    }

    return $result;
}

?>
