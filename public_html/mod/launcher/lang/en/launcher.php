<?php

defined('MOODLE_INTERNAL') || die();

$string['modulename'] = 'Launcher';
$string['modulenameplural'] = 'Launchers';
$string['modulename_help'] = 'Use the launcher module for... | The launcher module allows...';
$string['launcherfieldset'] = 'Custom example fieldset';
$string['launchername'] = 'Launcher name';
$string['launchername_help'] = 'This is the content of the help tooltip associated with the launchername field. Markdown syntax is supported.';
$string['launcher'] = 'launcher';
$string['pluginadministration'] = 'Launcher administration';
$string['pluginname'] = 'Launcher';


$string['launcher_header'] = 'Welcome to the launcher.';
$string['add_school_header'] = 'You are about to add a new school. This action will create an entirely new moodle environment.<br />
                                Please enter the information below. Note: This process is <b>irreversible</b>.';
$string['add_schoolyear_header'] = 'Time to start the new school year? Fill out the information below.<br />
                                Submitting this form will create a new school year for the moodle environment.';
$string['add_upgrade_header'] = 'Some header info upgrade...';
$string['upgrade'] = 'Upgrade';

$string['school_prepaired'] = 'The Launcher has finished prepairing the new school. Please be patient while the cron job takes over.<br />
                                The remaining process can take up to an hour to finish. An email will be send to {$a->email} once it\'s finished.';

$string['install'] = 'Install';
$string['shortname_format'] = 'The shortname can be of maximum 16 characters and can only contain letters and numbers.';
$string['unique'] = 'This shortname is already in use. Please chose a different one.';
$string['msg_success'] = 'Worked like a charm!';
$string['no_categories'] = 'No projects found.';

$string['categories'] = 'Projects';
$string['prepaired_for_installation'] = 'Prepaired for installation';
$string['groupyear'] = 'Group year';
$string['groupyear_help'] = 'The group years which will be assigned to this course.';

$string['settings_site'] = 'Site settings';
$string['settings_admin'] = 'Admin settings';
$string['settings_database'] = 'Database settings';
$string['settings_server'] = 'Server settings';
$string['server_name'] = 'Server';
$string['domain'] = 'Domain';
$string['environment'] = 'Moodle environment';
$string['db_username'] = 'Database username';
$string['db_password'] = 'Database password';
$string['db_password_explentation'] = 'This is the database password you have received in your email when the environment was created.';
$string['unmask'] = 'Unmask';

$string['site_shortname'] = 'Shortname *';
$string['site_name'] = 'Name *';
$string['site_description'] = 'Description';
$string['admin_email'] = 'Email address *';
$string['upload_users'] = 'Upload users';
$string['upload_groups'] = 'Upload groups';
$string['settings_content'] = 'Content to be uploaded';
$string['settings_layout'] = 'Layout settings';
$string['navbar'] = 'Navigation bar color';
$string['logo'] = 'Logo';
$string['required_groups'] = 'If you want to upload users the groups are required.';
$string['required_users'] = 'If you want to upload groups the users are required.';
$string['error_file_extension'] = 'You can only upload csv files.';
$string['error_jpg_extension'] = 'You can only upload jpg files.';
$string['error_email'] = 'You have to fill out a correct email address.';
$string['error_already_busy'] = 'This environment is already set for an update. Please wait until it has finished.';

$string['no_moodles'] = 'There are no registered moodle environments yet.<br />Please create a school before you add a school year.';

$string['no_feedbackmail_send'] = 'An error occured while trying to send the feedback email messages.
                                  <br />Please copy and paste the feedback manually.';

$string['mail_feedback_subject'] = 'New Moodle environment details';
$string['mail_feedback_body_start'] = 'Hello $a->name,<br /><br />
                                        A new Moodle environment has just been created. Below you can find the details of this environment.<br />
                                        Do <b>not</b> lose this information.<br /><br />';
$string['mail_feedback_body_end'] = 'Sincerely,<br /><br />Solin';

$string['error_key_variables'] = 'Key variables are missing. Please notify the programmers.';
