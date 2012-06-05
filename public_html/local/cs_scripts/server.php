<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);

//require_once("../../config.php");
require_once("class.server.php");

server::init_db(server::$host, server::$user, server::$pass, server::$db); // from config.php

$query_string = $_SERVER['QUERY_STRING'];

server::log($_SERVER['REMOTE_ADDR'] . ': ' . $query_string);
//server::check_hash($query_string);

switch($_REQUEST['request']) {
    case 'get_available_clients':
        server::handle_request_get_available_clients($query_string);
        break;
    case 'set_status':
        server::handle_request_set_status($query_string);
        break;
    case 'get_database':
        server::handle_request_get_database($query_string);
        break;
    case 'get_codebase':
        //server::test();
        server::handle_request_get_codebase($query_string);
        break;
    case 'remove_codebase':
        server::handle_request_remove_codebase($query_string);
        break;
    case 'get_csv_file':
        server::handle_request_get_csv_file($query_string);
        break;
    case 'get_categories':
        server::handle_request_get_categories($query_string);
        break;
    case 'get_courses':
        server::handle_request_get_courses($query_string);
        break;
    case 'clean_buffer_db':
        server::handle_request_clean_buffer_db($query_string);
        break;
    default:
        $method_name = 'handle_request_' . $_REQUEST['request'];
        server::$method_name($query_string);
        /********
        $method_call = 'handle_request_' . $_REQUEST['request'] . '($query_string);';
        eval($str);
         */
}



?>
