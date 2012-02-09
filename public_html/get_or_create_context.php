<?php
require_once("config.php");

$context = get_context_instance($_POST["context_level"],$_POST["instance_id"]);
echo ($context) ? $context->id: "false";

?>
