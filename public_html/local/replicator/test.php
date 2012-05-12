<?php

include_once('class.replicator.php');


function test_dump_codebase() {
    echo replicator::dump_codebase($source = '/home/onno/php/jeelo/public_html', $target = '/home/onno/temp/codebase.tar.gz');
} // function test_dump_codebase


function test_dump_database() {
    replicator::dump_database($database = 'jeelo',
                              $username = 'root',
                              $password = 'paarse',
                              $target = '/home/onno/temp/databasedump.mysql.gzip'); 
} // function test_dump_database


test_dump_database();

?>
