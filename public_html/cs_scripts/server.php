<?php

require_once("class.server.php");

server::init_db('localhost', 'root', '', 'jeelo_test');

$query_string = $_SERVER['QUERY_STRING'];

switch($_REQUEST['request']) {
    case 'get_available_clients':
        server::handle_request_get_available_clients($query_string);
        break;
    case 'set_status':
        // todo
        break;
    case 'get_database':
        // todo
        break;
    case 'get_codebase':
        // todo
        break;
}



?>