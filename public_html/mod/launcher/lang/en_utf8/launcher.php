<?php
defined('MOODLE_INTERNAL') || die();

// Default module strings
$string['modulename'] = 'launcher';
$string['modulenameplural'] = 'launchers';
$string['launcherfieldset'] = 'Custom example fieldset';
$string['launchername'] = 'launcher name';
$string['launchername_help'] = 'This is the content of the help tooltip associated with the launchername field. Markdown syntax is supported.';
$string['launcher'] = 'launcher';
$string['pluginadministration'] = 'launcher administration';
$string['pluginname'] = 'launcher';

$string['install'] = 'Install';
$string['maxlength'] = 'The (generated) database user name \"$a->msg\" is can maximum be 16 characters.';
$string['unique'] = 'The (generated) database name \"$a->msg\" is already in use. Please chose a different site shortname.';
$string['msg_success'] = 'Worked like a charm!';

$string['launcher_description'] = 'Please enter the information for the new moodle environment.<p>';
$string['categories'] = 'Projects';
$string['moodle_succesfull_set_up'] = 'The moodle environment has been succesfully set up.<br />
                                    All the important information is shown below. It has also been send to the specified email address.<br /><br />
                                    Please do <b>not</b> lose this information.';
$string['groupyear'] = 'Group year';

$string['settings_site'] = 'Site settings';
$string['settings_admin'] = 'Admin settings';
$string['settings_database'] = 'Database settings';

$string['site_shortname'] = 'Shortname *';
$string['site_name'] = 'Name *';
$string['site_description'] = 'Description';
$string['admin_email'] = 'Email address *';
$string['upload_users'] = 'Upload users';
$string['upload_groups'] = 'Upload groups';
$string['settings_content'] = 'Content to be uploaded';
$string['error_users_without_groups'] = 'If you\'re trying to upload users the groups are required.';
$string['error_groups_without_users'] = 'If you\'re trying to upload groups the users are required.';
$string['error_file_extension'] = 'You can only upload csv files.';
$string['error_email'] = 'You have to fill out a correct email address.';


$string['no_feedbackmail_send'] = 'An error occured while trying to send the feedback email messages.
                                  <br />Please copy and paste the feedback manually.';

$string['mail_feedback_subject'] = 'New Moodle environment details';
$string['mail_feedback_body_start'] = 'Hello $a->name,<br /><br />
                                        A new Moodle environment has just been created. Below you can find the details of this environment.<br />
                                        Do <b>not</b> lose this information.<br /><br />';
$string['mail_feedback_body_end'] = 'Sincerely,<br /><br />Solin';

$string['error_key_variables'] = 'Key variables are missing. Please notify the programmers.';
?>
