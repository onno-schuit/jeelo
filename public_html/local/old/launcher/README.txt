// Prerequisite: The moodle files are in /moodle_name/public_html/

Important issues
- Put soda on invisible in the moodle environment!
- If users are not in the csv files they'll be put on deleted
- The following file should be added: /lang/en_utf8/help/groupyear.html
- Have to add a column to mdl_course in order to judge which groupyear the course is for.
- Add the edit_form hack
- Enable in Site Administration / Courses / Backups:
	- Include modules
	- Include module user data
	- Course files
	- Site files
- Add non-standard roles in the to-be-copied database!!

- Courses without groupyear will be ignored!
- Redirect to change password when http://[domain].jeelo.nl/user/* is reached 
	HAS to be turned off in /etc/httpd/conf/extra/httpd-alias.conf:
	# Alias /user /var/www/html/redirect2.php
- Add the individuele rechten module (check email 17-04-2012)



==========================================================================================================

Hack in /course/edit_form.php
line 102, after the lines:
            $mform->setConstant('shortname', $course->shortname);
        }
 
/* Hack by Menno de Ridder, Solin, 2012-01-03
 * This hack is added to link the course with the groups. */
$mform->addElement('text','groupyear', get_string('groupyear', 'launcher'),'maxlength="100" size="20"');
$mform->setHelpButton('groupyear', array('groupyear', get_string('groupyear', 'launcher')), true);
