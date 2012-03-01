<?php

require_once("class.client.php");

client::init_db('localhost', 'root', '', 'jeelo_test');

client::run();
