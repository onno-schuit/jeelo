<?php

include_once('class.replicator.php');

echo replicator::test();

echo replicator::dump_codebase($source = '/home/onno/php/jeelo/public_html', $target = '/home/onno/temp/codebase.tar.gz');

?>
