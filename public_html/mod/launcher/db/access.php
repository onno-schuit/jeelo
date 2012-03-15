<?php

$mod_launcher_capabilities = array(

	'mod/launcher:access' => array(
		'captype' => 'write',
		'contextlevel' => CONTEXT_SYSTEM,
		'legacy' => array(
			'admin' => CAP_ALLOW
		)
	)
);

?>
