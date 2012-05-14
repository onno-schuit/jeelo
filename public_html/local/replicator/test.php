<?php

// TEST script only!

include_once('class.replicator.php');


function test_dump_codebase() {
    echo replicator::dump_codebase($source = '/home/onno/php/jeelo/public_html', $target = '/home/onno/temp/codebase.tar.gz');
} // function test_dump_codebase


function test_dump_database() {
    replicator::dump_database($database = 'jeelo22',
                              $username = 'root',
                              $password = 'paarse',
                              $target = '/home/onno/temp/databasedump.sql.gz'); 
} // function test_dump_database


//test_dump_database();

function test_dump_course() {
    replicator::dump_course($user = 2, $course_id = 2, $target = '/home/onno/temp/course.zip');
}


function test_restore_codebase() {
    replicator::restore_codebase($zip = '/home/onno/temp/codebase.tar.gz',
                                 $target = '/home/onno/temp/restore');
} // function test_restore_codebase


function test_restore_database() {
    replicator::restore_database($database = 'dump_test',
        $username = 'root',
        $password = 'paarse',
        $zip = '/home/onno/temp/databasedump.sql.gz');
} // function test_restore_database

?>
