


Apply hack to:
course/edit_form.php

on line:
104

after code:
    $mform->setConstants('idnumber', $course->idnumber);
}


HACK
$mform->addElement('text','groupyear', get_string('groupyear', 'launcher'),'maxlength="100"  size="10"');
$mform->addHelpButton('groupyear', 'groupyear', 'launcher');
$mform->setType('groupyear', PARAM_RAW);
HACK
$mform->addElement('text','groupyear', get_string('groupyear', 'launcher'),'maxlength="100"  size="10"');
$mform->addHelpButton('groupyear', 'groupyear', 'launcher');
$mform->setType('groupyear', PARAM_RAW);
HACK
$mform->addElement('text','groupyear', get_string('groupyear', 'launcher'),'maxlength="100"  size="10"');
$mform->addHelpButton('groupyear', 'groupyear', 'launcher');
$mform->setType('groupyear', PARAM_RAW);

ALTER TABLE `mdl_course` ADD `groupyear` VARCHAR( 255 )


Specify group year for each course, in this format: 7/8 (use "course settings" to get there)


----

Create "buffer" database. 

ALTER TABLE `jeelo_buffer`.`client_moodles` ADD `to_be_upgraded` INT( 1 ) NOT NULL ,
        ADD INDEX ( `to_be_upgraded` );
ALTER TABLE `jeelo_buffer`.`client_courses` ADD `backup_name` VARCHAR( 255 ) NOT NULL ;


Specify connection details in config.php:

$CFG->buffer_dbhost    = 'localhost';
$CFG->buffer_dbname    = 'jeelo_buffer';
$CFG->buffer_dbuser    = 'root';
$CFG->buffer_dbpass    = 'menno';


----

Dirs:

/etc/apache2/conf/jeelos

/etc/moodle_clients/csv
/etc/moodle_clients/courses
/etc/moodle_clients/db
/etc/moodle_clients/code
/home/jeelos

/var/log/jeelo

----

Logs:


/var/log/jeelo/client.txt
public_html/local/cs_scripts/server_log.txt

----

Adapt jeelo_cron/config.php
mkdir /etc/apache2/conf/jeelos (for testing purposes)
mkdir /home/jeelos (is referenced in jeelo_cron/config.php as $cs_jeelos_target_folder)

In /etc/apache2/httpd.conf
include /etc/apache2/conf/jeelos (for testing purposes)

Adapt jeelo_cron/apache_vhost_file.txt


Adapt:

public_html/local/cs_scripts/class.server.php

    static $log_file = './server_log.txt';
    static $dirroot = '/home/jeelos/moeder/public_html';
    static $wwwroot = 'http://moeder.srv1a.jeelo.nl';

    * With regard to $dirroot and $wwwroot
      the assumption is that the code base first gets copied to /etc/moodle_clients, then to a publicly accessible place
      ('moeder' moodle)


----

Assumptions: home directory name for client moodles is same as domain name

----

RUN

1. Use Launcher to specify school, course, users and groups
2. Call jeelo_cron/client.php to actually create new Moodle or upgrade or New schoolyear
    - client.php outputs messages in a browser-specific format
