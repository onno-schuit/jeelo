<?php

require_once("class.server.php");

server::init_db('localhost', 'root', '', 'jeelo_test');

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
}



?>