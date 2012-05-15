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
    replicator::dump_course($user_id = 2, $course_id = 2, $target = '/home/onno/temp/course.zip');
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


function test_restore_course() {
    global $new_course;
    $new_course = replicator::restore_course($user_id = 2,
                                             $zip = '/home/onno/temp/course.zip',
                                             $category_id = 3);
} // function test_restore_course


function test_delete_course() {
    global $new_course;
    delete_course($new_course);
    fix_course_sortorder(); //update course count in catagories
} // function test_delete_course


function test_delete_category() {
    global $DB;
    $category = $DB->get_record('course_categories', array('id' => 3));
    category_delete_full($category, $showfeedback=false);
} // function test_delete_category


function test_delete_irrelevant_categories() {
    // Create $categories_csv as in client_updater#create_projects: 
    // $categories_csv = new csv();
    replicator::delete_irrelevant_categories($categories_csv);
} // function test_delete_irrelevant_categories

?>
