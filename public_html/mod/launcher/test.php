<?php
require_once($CFG->libdir.'/adminlib.php');
require_once($CFG->libdir.'/csvlib.class.php');
require_once($CFG->dirroot.'/user/profile/lib.php');
require_once($CFG->dirroot.'/group/lib.php');
require_once($CFG->dirroot.'/admin/uploaduserlib.php');
require_once($CFG->dirroot.'/admin/uploaduser_form.php');

// array of all valid fields for validation
$STD_FIELDS = array('id', 'firstname', 'lastname', 'username', 'email',
        'city', 'country', 'lang', 'timezone', 'mailformat',
        'maildisplay', 'maildigest', 'htmleditor', 'ajax', 'autosubscribe',
        'institution', 'department', 'idnumber', 'skype',
        'msn', 'aim', 'yahoo', 'icq', 'phone1', 'phone2', 'address',
        'url', 'description', 'descriptionformat', 'password',
        'auth',        // watch out when changing auth type or using external auth plugins!
        'oldusername', // use when renaming users - this is the original username
        'deleted',     // 1 means delete user
    );

$PRF_FIELDS = array();
if ($prof_fields = $DB->get_records('user_info_field')) {
    foreach ($prof_fields as $prof_field) {
        $PRF_FIELDS[] = 'profile_field_'.$prof_field->shortname;
    }
}
unset($prof_fields);


$formdata->uutype = 0;
$formdata->uupasswordnew = 1;
$formdata->auth = 'manual';
$formdata->maildisplay = 2;
$formdata->mailformat = 1;
$formdata->maildigest = 0;
$formdata->autosubscribe = 1;
$formdata->htmleditor = 1;
$formdata->ajax = 1;
$formdata->timezone = 99;
$formdata->lang = 'en';
$formdata->description = '';
$formdata->address = '';
$formdata->iid = csv_import_reader::get_new_iid('uploaduser');
$formdata->descriptionformat = 1;
$formdata->encoding = 'UTF-8';
$formdata->delimiter_name = 'semicolon';


$cir = new csv_import_reader($formdata->iid, 'uploaduser');
$content = file_get_contents($_FILES['uploaduser']['tmp_name']);
$readcount = $cir->load_csv_content($content, $formdata->encoding, $formdata->delimiter_name);
unset($content);

$returnurl = new moodle_url(''); // Kinda forced into this...
$filecolumns = uu_validate_user_upload_columns($cir, $STD_FIELDS, $PRF_FIELDS, $returnurl);

$createpasswords   = (!empty($formdata->uupasswordnew));
$resetpasswords    = isset($formdata->uuforcepasswordchange) ? $formdata->uuforcepasswordchange : UU_PWRESET_NONE;

$supportedauths = uu_supported_auths(); // officially supported plugins that are enabled

// we use only manual enrol plugin here, if it is disabled no enrol is done
if (enrol_is_enabled('manual')) {
    $manual = enrol_get_plugin('manual');
} else {
    $manual = NULL;
}

// init csv import helper
$cir->init();
$linenum = 1; //column header is first line

$error = false;
while ($line = $cir->next()) {
    $linenum++;

    $user = new stdClass();

    // add fields to user object
    foreach ($line as $keynum => $value) {

        $key = $filecolumns[$keynum];
        if (strpos($key, 'profile_field_') === 0) {
            //NOTE: bloody mega hack alert!!
            if (isset($USER->$key) and is_array($USER->$key)) {
                // this must be some hacky field that is abusing arrays to store content and format
                $user->$key = array();
                $user->$key['text']   = $value;
                $user->$key['format'] = FORMAT_MOODLE;
            } else {
                $user->$key = $value;
            }
        } else {
            $user->$key = $value;
        }
    }

    if ((!isset($user->firstname) || $user->firstname === '') ||
        (!isset($user->lastname) || $user->lastname == '') ||
        (!isset($user->username) || $user->username == '')
    ) {
        $error = true;
        continue;
    }
        
    // normalize username
    $originalusername = $user->username;
    $user->username = clean_param($user->username, PARAM_USERNAME);

    if ($existinguser = $DB->get_record('user', array('username'=>$user->username, 'mnethostid'=>$CFG->mnet_localhost_id))) {
        $error = true;
        continue;
    }

    // add default values for remaining fields
    $formdefaults = array();
    foreach ($STD_FIELDS as $field) {
        if (isset($user->$field)) {
            continue;
        }
        // all validation moved to form2
        if (isset($formdata->$field)) {
            // process templates
            $user->$field = uu_process_template($formdata->$field, $user);
            $formdefaults[$field] = true;
        }
    }
    foreach ($PRF_FIELDS as $field) {
        if (isset($user->$field)) {
            continue;
        }
        if (isset($formdata->$field)) {
            // process templates
            $user->$field = uu_process_template($formdata->$field, $user);
            $formdefaults[$field] = true;
        }
    }

    // save the new user to the database
    $user->confirmed    = 1;
    $user->timemodified = time();
    $user->timecreated  = time();
    $user->mnethostid   = $CFG->mnet_localhost_id; // we support ONLY local accounts here, sorry

    if (empty($user->auth)) {
        $user->auth = 'manual';
    }

    // do not insert record if new auth plugin does not exist!
    try {
        $auth = get_auth_plugin($user->auth);
    } catch (Exception $e) {
        $error = true;
        continue;
    }
    if (!isset($supportedauths[$user->auth])) {
        $error = true;
    }

    $isinternalauth = $auth->is_internal();

    if (empty($user->email)) {
        $error = true;
        continue;

    } else if ($DB->record_exists('user', array('email'=>$user->email))) {
        $error = true;
        continue;
    }
    if (!validate_email($user->email)) {
        $error = true;
        continue;
    }

    $forcechangepassword = true; // Change monday

    if ($isinternalauth) {
        if (empty($user->password)) {
            if ($createpasswords) {
                $user->password = 'to be generated';
            } else {
                $error = true;
                continue;
            }
        } else {
            if ($resetpasswords == UU_PWRESET_ALL or ($resetpasswords == UU_PWRESET_WEAK and $weak)) {
                $forcechangepassword = true;
            }
            $user->password = hash_internal_user_password($user->password);
        }
    }

    // create user - insert_record ignores any extra properties
    $user->id = $DB->insert_record('user', $user);

    // save custom profile fields data
    profile_save_data($user);

    if ($forcechangepassword) {
        set_user_preference('auth_forcepasswordchange', 1, $user);
    }
    if ($user->password === 'to be generated') {
        set_user_preference('create_password', 1, $user);
    }

}
$cir->close();
$cir->cleanup(true);

?>
