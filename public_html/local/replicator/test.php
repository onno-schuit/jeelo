<?php

// TEST script only!

include_once('class.replicator.php');


function test_dump_codebase() {
    echo replicator::dump_codebase($homedir = '/home/onno/php/jeelo', $target = '/home/onno/temp/codebase.tar.gz');
} // function test_dump_codebase


function test_dump_moodledata() {
    echo replicator::dump_moodledata($homedir = '/home/onno/php/jeelo', $target = '/home/onno/temp/moodledata.tar.gz');
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
    include_once('class.csv.php');

    // Create $categories_csv as in client_updater#create_projects 

    // WARNING: this object should specify the categories selected by user,
    // NOT the categories to be deleted, but the inverse...
    $categories_csv = new csv();
    $category_data = "139;P02 Omgaan met elkaar;;0;999;3;1;0;1;/3;;170;1";
    $categories_csv->build_csv_object($category_data, 'client_categories');

    replicator::delete_irrelevant_categories($categories_csv);
} // function test_delete_irrelevant_categories

function test_backup_client_moodle() {
    replicator::backup_client_moodle($homedir = '/home/onno/php/jeelo',
                                     $database = 'jeelo22',
                                     $username = 'root',
                                     $password = 'paarse'); 
} // function test_dump_database
?>
