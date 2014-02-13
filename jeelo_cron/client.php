<?php
// TODO: turn into real cli script
require_once("config.php");
require_once("class.client.php");

client::init_db($cs_dbhost, $cs_dbuser, $cs_dbpass, $cs_dbname); // from config.php

// also from config.php: -- O.S., 20140210: No, not found there... (nor on live server's jeelo_cron/config.php)
//client::$server_url = $cs_server_url;
//client::$target_folder = $cs_jeelos_target_folder;
//client::$log_file = $cs_client_log_file;

// run the client script
client::run();
?>
