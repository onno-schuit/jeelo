
TODO: 
- Client Moodle in maintenance mode during update
- Send mail after update and upgrade
- Show more feedback after submitting forms
- Finetune "school" and "schoolyear" validation
- Document statuses
- Make empty before update ("new schoolyear" action): client_categories & client_courses in buffer db
- Remove mod launcher from client moodle after install
- Take site out of edit mode before doing actual database copy
- Fix customcss transfer (also: allow customcss to be set to empty string) -- make explicit get_customcss request for class.server.php
- Log rotation for all log files
- Make backup of moodledata upon upgrade
- Get new moodledata/lang dir from server upon upgrade


------------------------------------------------------------------------------------
INSTALL & CONFIG

* DB Action: add master DB user to buffer DB (all privileges except grant and 'lock tables and references')


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


ALTER TABLE `jeelo_buffer`.`client_moodles` ADD `to_be_upgraded` INT( 1 ) NOT NULL DEFAULT 0 ,
    ADD INDEX ( `to_be_upgraded` );
ALTER TABLE `jeelo_buffer`.`client_courses` ADD `backup_name` VARCHAR( 255 ) NOT NULL ;
ALTER TABLE `client_moodles` ADD `logo` VARCHAR( 255 ) NULL ,
ADD `customcss` TEXT NULL ;
ALTER TABLE `jeelo_buffer`.`client_moodles` ADD `proc_starttime` INT( 10 ) NOT NULL DEFAULT 0 ;
ALTER TABLE `jeelo_buffer`.`client_moodles` ADD `proc_endtime` INT( 10 ) NOT NULL DEFAULT 0 ;
ALTER TABLE `jeelo_buffer`.`client_moodles` ADD `archive` VARCHAR( 255 ) NOT NULL AFTER `customcss` ;

Specify connection details in config.php:

$CFG->buffer_dbhost    = 'localhost';
$CFG->buffer_dbname    = 'jeelo_buffer';
$CFG->buffer_dbuser    = 'root';
$CFG->buffer_dbpass    = 'menno';

// temporary domain of new client Moodle
$CFG->temporary_client_domain = 'srv1a.jeelo.nl';

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


----

Assumptions: home directory name for client moodles is same as domain name

----

RUN

1. Use Launcher to specify school, course, users and groups
2. Call jeelo_cron/client.php to actually create new Moodle or upgrade or New schoolyear
    - client.php outputs messages in a browser-specific format
3. Call newclient/public_html/local/cs_scripts/client_updater.php


DELETE FOR TESTING PURPOSES

Remove newclient database and database user newclient
Remove /etc/moodle_clients/newclient.domainname
Remove /home/jeelos/newclient.domainname



