<?php

require_once("class.client.php");

client::init_db('localhost', 'root', 'menno', 'jeelo_buffer');

client::run();
