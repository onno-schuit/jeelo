<?php

function xmldb_launcher_upgrade($oldversion=0) {

    global $CFG, $THEME, $db;

    $result = true;

    if ($result && $oldversion < 2012010304) {

    /// Define field picture to be added to signup_user_data
        $table = new XMLDBTable('course');
        $field = new XMLDBField('groupyear');
        $field->setAttributes(XMLDB_TYPE_CHAR, '30', null, XMLDB_NOTNULL, null, null, null, null, 'theme');

    /// Launch add field picture
        $result = $result && add_field($table, $field);
    }

    return $result;
}

?>
