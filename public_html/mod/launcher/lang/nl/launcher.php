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
$string['add_school_header'] = 'U staat op het punt een nieuwe school toe te voegen. Deze actie zal een complete nieuwe moodle omgeving opbouwen.<br />
    Vul alstublieft de juiste gegevens hier onder in. Let op: Dit proces is <b>onomkeerbaar</b>.<p>Alle velden zijn verplicht,
    behalve die onder het kopje Uiterlijk.</p>';
$string['add_schoolyear_header'] = 'Tijd voor het nieuwe schooljaar of gewoon de school bewerken? Vul de gegevens hier onder in.<br />
                                Deze actie zal een nieuw schooljaar aan de school toevoegen.';
$string['add_upgrade_header'] = 'Some header info upgrade...';
$string['upgrade'] = 'Upgrade';

$string['school_prepaired'] = 'De Launcher is gereed met het klaarzetten van de nieuwe school. Heeft u alstublieft even geduld terwijl de Cron het over neemt.<br />
    Het resterende proces kan tot een uur duren. Er wordt een email verstuurd naar {$a->email} zodra het klaar is.';

$string['install'] = 'Installeren';
$string['shortname_format'] = 'De korte naam mag maar 16 karakters hebben en mag alleen letters en nummers bevatten.';
$string['unique'] = 'Deze korte naam wordt al gebruikt. Kiest u alstublieft een andere.';
$string['msg_success'] = 'Het proces is succesvol afgerond. Een moment geduld alstublieft.';
$string['no_categories'] = 'Geen projecten gevonden.';

$string['categories'] = 'Projecten';
$string['prepaired_for_installation'] = 'De gegevens zijn succesvol opgeslagen en staan klaar om te worden verwerkt.<br />
										Binnen 5 minuten zijn de gegevens verwerkt. U ontvangt dan ook een email bericht. Deze pagina kunt u intussen verlaten.';
$string['groupyear'] = 'Leerjaar';
$string['groupyear_help'] = 'De leerjaren die aan deze cursus worden gekoppeld.';

$string['settings_site'] = 'Site configuratie';
$string['settings_admin'] = 'Admin configuratie';
$string['settings_database'] = 'Database configuratie';
$string['settings_server'] = 'Server configuratie';
$string['server_name'] = 'Server';
$string['domain'] = 'Domein';
$string['environment'] = 'Moodle omgeving';
$string['db_username'] = 'Database gebruikersnaam';
$string['db_password'] = 'Database wachtwoord';
// $string['db_password_explentation'] = 'This is the database password you have received in your email when the environment was created.'; // Not in use
$string['unmask'] = 'Tonen';

$string['site_shortname'] = 'Korte naam *';
$string['site_name'] = 'Volledige naam *';
$string['site_description'] = 'Beschrijving';
$string['admin_email'] = 'Email adres *';
$string['upload_users'] = 'Upload gebruikers';
$string['upload_groups'] = 'Upload groepen';
$string['settings_content'] = 'Inhoud van de omgeving';
$string['settings_layout'] = 'Uiterlijk';
$string['navbar'] = 'Navigatiebalk kleur';
$string['logo'] = 'Eigen logo';
$string['customcss'] = 'Eigen CSS';
$string['required_groups'] = 'Wanneer gebruikers geupload worden zijn de groepen verplicht.';
$string['required_users'] = 'Wanneer groepen geupload worden zijn de gebruikers verplicht.';
$string['error_file_extension'] = 'Alleen .csv bestanden kunnen worden geupload.';
$string['error_jpg_extension'] = 'Alleen .jpg bestanden kunnen worden geupload.';
$string['error_email'] = 'Het ingevulde email adres is niet juist.';
$string['error_already_busy'] = 'Deze moodle omgeving staat al klaar voor een update. Binnen enkele minuten zal de update verwerkt zijn.';

$string['no_moodles'] = 'Er zijn nog geen scholen aangemaakt via de Launcher.<br />Om een schooljaar toe te voegen moet u eerst een school aanmaken.';

/*$string['no_feedbackmail_send'] = 'An error occured while trying to send the feedback email messages.
                                  <br />Please copy and paste the feedback manually.';*/ // Not in use

// $string['mail_feedback_subject'] = 'New Moodle environment details';
/* $string['mail_feedback_body_start'] = 'Hello $a->name,<br /><br />
                                        A new Moodle environment has just been created. Below you can find the details of this environment.<br />
                                        Do <b>not</b> lose this information.<br /><br />';*/ // Not in use
// $string['mail_feedback_body_end'] = 'Sincerely,<br /><br />Solin';

$string['error_key_variables'] = 'Belangrijke gegevens ontbreken. Probeer het alstublieft opnieuw over een paar minuten.';
$string['upload_users_error'] = 'Upload a.j.b. een bestand met gebruikers';
$string['upload_groups_error'] = 'Upload a.j.b. een bestand met groepen';
$string['edit_school'] = 'School bewerken';
$string['add_school'] = 'Nieuwe school';
$string['delete'] = 'Scholen verwijderen';
$string['delete_explanation'] = 'Dit proces verwijdert de gekozen scholen permanent. Er zijn nadien geen backups meer beschikbaar.';
$string['index_school_header'] = 'De scholen';
?>
