<?php

defined('MOODLE_INTERNAL') || die();

$module->version   = 2012051601;               // If version == 0 then module will not be installed
//$module->version   = 2010032200;      // The current module version (Date: YYYYMMDDXX)
$module->requires  = 2010031900;      // Requires this Moodle version
$module->cron      = 0;               // Period for cron to check this module (secs)
$module->component = 'mod_launcher'; // To check on upgrade, that module sits in correct place
