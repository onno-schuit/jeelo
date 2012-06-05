<?php

/**
 * This class runs on local Moodle clients. It should be invoked as a cron job.
 * The class has two functions:
 *
 * - upgrade Moodle code base
 * - 'new schoolyear' / import courses, categories, groups & users scenario
 *
 *
 * If you run client_updater#main, it will check with the 'server' (buffer db wrapper)
 * to see if there are any tasks for this particular Moodle.
 */

class client_updater {

} // class client_updater

?>
