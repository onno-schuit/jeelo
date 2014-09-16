<?php

define("CLI_SCRIPT", true);

require_once("config.php");
require_once("class.client.php");

client::init_db($cs_dbhost, $cs_dbuser, $cs_dbpass, $cs_dbname); // from config.php

// The script client_updater.php is called inside each installed Moodle
client::update_all_clients();

?>
