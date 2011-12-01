<?php
global $CFG;
require_once("{$CFG->libdir}/upgradelib.php");
if(upgrade_noncore(true)) echo 'Upgrade complete';
?>
