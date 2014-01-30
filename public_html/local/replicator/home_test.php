<?php

// TEST script only!

include_once('class.replicator.php');

replicator::dump_course($user_id = 2, $course_id = 1, $target = '/home/onno/temp/jeelo/course1.zip');
?>
