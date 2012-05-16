<?php


defined('MOODLE_INTERNAL') || die();

$capabilities = array(

    'mod/launcher:access' => array(
        'captype' => 'read',
        'contextlevel' => CONTEXT_MODULE,
        'legacy' => array(
            'manager' => CAP_ALLOW
        )
    ),

/***************************** remove these comment marks and modify the code as needed
    'mod/launcher:submit' => array(
        'riskbitmask' => RISK_SPAM,
        'captype' => 'write',
        'contextlevel' => CONTEXT_MODULE,
        'legacy' => array(
            'student' => CAP_ALLOW
        )
    ),
******************************/
);

