<?php

define("CLI_SCRIPT", true);

require_once("config.php");
require_once("class.client_updater.php");
require_once("../../config.php"); // moodle config

client_updater::run();

