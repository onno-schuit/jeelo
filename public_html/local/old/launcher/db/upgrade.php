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

    if ($result && $oldversion < 2012022903) {

    /// Define field id to be added to launcher_moodles
        $table = new XMLDBTable('launcher_moodles');
        $field = new XMLDBField('admin_email');
        $field->setAttributes(XMLDB_TYPE_CHAR, '100', null, XMLDB_NOTNULL, null, null, null, null, 'description');
        $result = $result && add_field($table, $field);

		// Launch add field id
		// $result = $result && add_field($table, $field);
    }

    if ($result && $oldversion < 2012030201) {

        $table = new XMLDBTable('launcher_moodles');

		$field = new XMLDBField('domain');
        $field->setAttributes(XMLDB_TYPE_CHAR, '100', null, XMLDB_NOTNULL, null, null, null, null, 'admin_email');
        $result = $result && add_field($table, $field);

		$field = new XMLDBField('server_name');
        $field->setAttributes(XMLDB_TYPE_CHAR, '100', null, XMLDB_NOTNULL, null, null, null, null, 'domain');
        $result = $result && add_field($table, $field);
        
	}



    return $result;
}

?>
