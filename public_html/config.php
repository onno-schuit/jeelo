<?php  /// Moodle Configuration File 

unset($CFG);

$CFG = new stdClass();
$CFG->dbtype    = 'mysql';
$CFG->dbhost    = 'localhost';
$CFG->dbname    = 'jeelo19';
$CFG->dbuser    = 'root';
$CFG->dbpass    = '';
$CFG->dbpersist =  false;
$CFG->prefix    = 'mdl_';

$CFG->wwwroot   = 'http://localhost:8080/jeelo/public_html';
$CFG->dirroot   = 'D:\xampp\htdocs\jeelo\public_html';
$CFG->dataroot  = 'D:\xampp\htdocs\jeelo\moodle_data';
$CFG->admin     = 'admin';

$CFG->directorypermissions = 00777;  // try 02777 on a server in Safe Mode

// $CFG->passwordsaltmain = '@~:DPuq`&zi><jF/i5#tCJ]r A* 6';

require_once("$CFG->dirroot/lib/setup.php");
// MAKE SURE WHEN YOU EDIT THIS FILE THAT THERE ARE NO SPACES, BLANK LINES,
// RETURNS, OR ANYTHING ELSE AFTER THE TWO CHARACTERS ON THE NEXT LINE.
?>