// Prerequisite: The moodle files are in /moodle_name/public_html/

Put soda on invisible in the moodle environment!

Uitzondering maken voor new moodle als er nog geen variabelen zijn...


The following file should be added:
/lang/en_utf8/help/groupyear.html


Formulier:
	Name = naam van de school
Wachtwoord aanpassen
Wachtwoord = voornaam achternaam aan elkaar zonder spaties

Cursus naam = Projectnaam - Cursus titel <-- kan ingesteld worden!!
Cursus shortname = shortname + jaartal

Nederlandse taalstrings toevoegen.

Rol toevoegen voor medewerker die alleen de launcher uitvoert.

Gebruikersnaam: voornaam, achternaam, aan elkaar, zonder spatie enzo.
Wachtwoord hetzelfde.

Email adres aanmaken wanneer die leeg is.

Database wordt meegekopieerd.




CHANGE: /home/menno/Desktop/menno/php_projects/jeelo19/public_html/lang/en_utf8/help/groupyear.html




Have to add a column to mdl_course in order to judge which groupyear the course is for.

Hack in /course/edit_form.php
line 102, after the lines:
            $mform->setConstant('shortname', $course->shortname);
        }
 
/* Hack by Menno de Ridder, Solin, 2012-01-03
 * This hack is added to link the course with the groups. */
$mform->addElement('text','groupyear', get_string('groupyear', 'launcher'),'maxlength="100" size="20"');
$mform->setHelpButton('groupyear', array('groupyear', get_string('groupyear', 'launcher')), true);


QUICK & DIRTY HACK:

IN:
/backup/restorelib.php
$CFG->dataroot = $hacked_dataroot;
OOK IN:
7948
7959
7995
8011
8051
8135
8146
8150
8262 <-- SAME!

