// Prerequisite: The moodle files are in /moodle_name/public_html/

Put soda on invisible in the moodle environment!

Uitzondering maken voor new moodle als er nog geen variabelen zijn...


The following file should be added:
/lang/en_utf8/help/groupyear.html





CHANGE: /home/menno/Desktop/menno/php_projects/jeelo19/public_html/lang/en_utf8/help/groupyear.html


Ignore below


Have to add a column to mdl_course in order to judge which groupyear the course is for.

Hack in /course/edit_form.php
line 102, after the lines:
            $mform->setConstant('shortname', $course->shortname);
        }
 
/* Hack by Menno de Ridder, Solin, 2012-01-03
 * This hack is added to link the course with the groups. */
$mform->addElement('text','groupyear', get_string('groupyear', 'launcher'),'maxlength="100" size="20"');
$mform->setHelpButton('groupyear', array('groupyear', get_string('groupyear', 'launcher')), true);

