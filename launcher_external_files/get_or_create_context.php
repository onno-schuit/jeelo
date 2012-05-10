<?php
require_once(dirname($_SERVER['PHP_SELF']) . "/config.php");

$file_contents = file_get_contents($argv[1]);
$context_settings = unserialize($file_contents);
$context_level = $context_settings->context_level;
$instance_id = $context_settings->instance_id;
unset($context_settings);

$context = get_context_instance($context_level, $instance_id);
echo ($context) ? $context->id: "false";
?>
