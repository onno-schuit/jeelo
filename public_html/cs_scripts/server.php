<?php

require_once("config.php");
require_once("class.server.php");

server::init_db($cs_dbhost, $cs_dbuser, $cs_dbpass, $cs_dbname); // from config.php

$query_string = $_SERVER['QUERY_STRING'];

server::log($_SERVER['REMOTE_ADDR'] . ': ' . $query_string);

server::check_hash($query_string);

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
        server::handle_request_get_codebase($query_string);
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
}



?>
