<?php
require_once("../public_html/local/cs_scripts/class.base.php");
require_once("../public_html/local/replicator/class.replicator.php");
// For debugging:
error_reporting(E_ALL);
ini_set('display_errors','On');
set_time_limit(0);

class client extends base {
    
    static $client_name = 'client';
    static $prefix = 'mdl_';
    static $server_url = '';
    static $target_folder = '';
    static $log_file = './client_log.txt';
    static $log_echo = true;
    // static $client_url = ''; // NOT USED?
    //static $tmp_dir = '/home/menno/php_projects/jeelo_databases';
 
 
    static public function run() {
        require_once("class.csv.php");
        
        self::log("Checking for available clients.");
        
        $request = array('request' => 'get_available_clients');
        $response = self::get_server_response($request);
        
        if (!$response) die(); // no clients available for processing.. do nothing
        exit(print_object($response));
        
        $csv = new csv();
        $moodle_clients = $csv->build_csv_object($response, 'client_moodles');

        while($moodle_clients_line = $csv->nextline()) {
			// Useful variable
			//self::$client_url = $moodle_clients_line->domain;
            self::process_client_from_csv($moodle_clients_line);
        }
    } // function run


    public static function process_client_from_csv($csv_line) {
        self::log("Processing id {$csv_line->id}, status {$csv_line->status}");
        
        // Update status FIRST
        //self::update_server_status($csv_line->id, 'being_processed');

        switch($csv_line->status) {
            case 'prepaired_school':
                self::process_new_client($csv_line);
                break;
            /*
            case 'schoolyear_prepaired':
                self::process_new_client($csv_line);
                break;
            case 'upgrade_prepaired':
                self::process_update_client($csv_line);
                break;
            */
        }

        //self::update_server_status($csv_line->id, 'processed', 0); // everything ok! 
    } // function process_client_from_csv


    public static function process_new_client($csv_line) {
        exit(print_r($csv_line));
		self::log("Starting the creation of a new moodle school.");
        
        $user_and_pass = self::restore_database($csv_line);
        //exit(var_dump($user_and_pass));
        $user_and_pass = array('username'=>'', 'password'=>'');
        
        self::create_codebase($csv_line);
        self::create_moodle_config($csv_line, $user_and_pass); // Doesn't actually do anything...
        self::add_to_apache($csv_line);
        
        // Now the site is build and has a solid database. From this point we shall rebuild the courses, users and other content
        self::process_update_client($csv_line);
        self::email_school_created($csv_line, $user_and_pass);
        
    } // function process_new_client

    
    public static function restore_database($csv_line) {
        //self::create_database($csv_line);
        
        self::import_database($csv_line);
        /*
        $user_and_pass = self::create_database_user($csv_line);

        var_dump($user_and_pass);
        exit();

        /*
        var_dump($db_zip);

        //shell_exec("mysql -u{$cs_dbuser} -p{$cs_dbpass} -e 'CREATE DATABASE {$csv_line->shortcode} CHARACTER SET utf8 COLLATE utf8_general_ci;'");
        exit();

        $user_and_pass = self::create_database_user($csv_line->shortcode);

        //self::create_database($csv_line);
        //self::import_database($csv_line);
		
        return $user_and_pass;
         */
    } // function restore_database 


    function import_database($csv_line) {
        include("config.php");
        
        $db_filename = self::get_db_from_server($csv_line);
        
        $cmd = "gunzip -c {$db_filename} | mysql -u{$cs_dbuser} -p{$cs_dbpass} {$csv_line->shortcode}";
        var_dump(shell_exec($cmd));

        /*
        var_dump($cmd);echo "<br />";
        $test = shell_exec($cmd);echo "<br />";
        var_dump($test);
        */
        exit(var_dump("Test"));
    } // function import_database
    /*

    public static function import_database() {
        $db_file = self::get_db_from_server($csv_line);
    }
     */

    /**
     * Reads variable apache conf file, replaces vars and writes to /apache/conf/domain.conf
     * /apache/conf path is set in config.php in $cs_apache_config_dir
     * 
     * @param mixed $csv_line
     * @return void
     */
    public static function add_to_apache($csv_line) {
        global $cs_apache_conf_dir;
        $filename = preg_replace('/[^A-Za-z0-9_\.+]/', '', $csv_line->domain);
        $filename = str_replace('.', '_', $filename);
        $destination = $cs_apache_conf_dir . '/' . $filename;
        self::log("Creating file $destination");

        $contents = file_get_contents(dirname(__FILE__) . '/apache_vhost_file.txt');
        $contents = str_replace('{domain}', $csv_line->domain, $contents);
        $contents = str_replace('{short_code}', $csv_line->short_code, $contents);

        global $cs_apache_conf_dir;

        file_put_contents($destination, $contents);  
        self::log("File $destination created");
        
        self::log("Restarting apache");
        shell_exec('apachectl graceful');
        self::log("Apache restarted");
    } // function add_to_apache
 

    public static function create_database($csv_line) {
        $sql = "CREATE DATABASE `{$csv_line->shortcode}`";
        self::log($sql);
        self::$db->query($sql);
    } // function create_database
    

    public static function create_database_user($short_code) {
        $dbname = '' . $short_code; // no prefix
        $username = $short_code;
        $password = md5("SomeSalt" . $username); // Unsafe...
        
		self::$db->query("CREATE USER '$username'@'localhost' IDENTIFIED BY '$password'");
		self::$db->query("GRANT USAGE ON $dbname . * TO '$username'@'localhost' IDENTIFIED BY '$password'");
		self::$db->query("GRANT ALL PRIVILEGES ON $dbname . * TO '$username'@'localhost';");
        self::log("Created database user for client database.");
		
        return array(
            'username' => $username,
            'password' => $password
        );
    } // function create_database_user
    

    public static function create_codebase($csv_line) {
		$tmpfile = self::$target_folder . $csv_line->domain . '/site.tgz';
		self::create_codebase_folder($csv_line);
		$codebase = self::get_codebase_from_server($csv_line, $tmpfile);
		self::copy_codebase_to_client($csv_line, $codebase);
        self::remove_codebase_from_server($tmpfile);
        self::extract_codebase_contents($tmpfile);
    } // function create_codebase

    
    public static function copy_codebase_to_client($csv_line, $codebase) {
		$cmd = "wget --quiet --directory-prefix=" . self::$target_folder . "/" . $csv_line->domain . " $codebase";
		self::log($cmd);
		shell_exec($cmd);
	} // function copy_codebase_to_client

    
    public static function create_codebase_folder($csv_line) {
        $target = self::$target_folder . $csv_line->domain;
        self::log("Creating folder: $target");
        mkdir($target, 0755); // without the public_html folder
	} // function create_codebase_folder

	
	public static function extract_codebase_contents($tmpfile) {
        // extract contents
        $cmd = sprintf("tar -xz -C %s -f %s", dirname($tmpfile), $tmpfile);
        self::log($cmd);
        shell_exec($cmd);
        
        // When done unlink the file
        unlink($tmpfile);
	} // function extract_codebase_contents


	public static function get_codebase_from_server($csv_line, $tmpfile) {
		$request = array(
            'request'	=> 'get_codebase',
            'for'		=> 'client',
            'id'		=> $csv_line->id
        );
        
		// Response = directory / filename of the codebase
		$response = self::get_server_response($request);
		if ($response == 'nofile') {
			self::log("Failed to retreive codebase from server.");
			exit();
		}
		
		return $response;
	} // function get_codebase_from_server

	
	public static function remove_codebase_from_server($tmpfile) {
		$request = array(
            'request'	=> 'remove_codebase',
            'for'		=> 'client'
        );
        
		// Response = directory / filename of the codebase
		$response = self::get_server_response($request);
		if ($response == 'faal') {
			self::log("Failed to retreive codebase from server.");
			exit();
		}

	} // function remove_codebase_from_server
    

    public static function get_db_from_server($csv_line) {
        self::log("Getting db from server");
        $request = array(
            'request' => 'get_database',
            'id' => $csv_line->id
        );

        if (!is_dir(self::$tmp_dir)) mkdir(self::$tmp_dir);
        
        $response = self::get_server_response($request);
        // check if we have file contents or maybe an error
        if (strlen($response) < 100 && strstr($response, 'error')) {
            self::log($response);
            die();
        }

       
        // TODO: fixme! -- variables do not exist
        if (!ftp_chdir($fpc_ftp_conn, $fpc_ftp_path)) {
            echo "Error go to the directory $fpc_ftp_path.<br />"; 
        }
        
        //$tmpfile = 'test';
        //file_put_contents($tmpfile . '.gz', $response);

        
        // write contents to temp file
        $tmpfile = tempnam(self::$tmp_dir, 'jmdl'); // prefix jmdl (jeelo moodle)
        
        self::log("Creating file " . $tmpfile . '.gz');
        
        unset($response); // clear memory ?
		
        return ($tmpfile);
        /*
		$dir = getcwd();
		chdir("/tmp");
		
        $cmd = sprintf("tar xvf %s", $tmpfile . '.gz');
        self::log($cmd);
        $output = shell_exec($cmd);
        
        chdir($dir);

        // import into mysql
        $dbname = '' . $csv_line->shortcode; // no prefix
        $add_password_switch = !empty(self::$db->pass) ? ("-p" . self::$db->pass) : '';
        $cmd = sprintf("mysql -u %s %s %s < %s", self::$db->user, $add_password_switch, $dbname, $tmpfile);
        self::log($cmd);
        
        $output = shell_exec($cmd); // command line execute
        self::log("Mysql ouput: [$output]"); // put mysql output into log file
         */
    } // function get_db_from_server

    
    public static function create_moodle_config($csv_line, $user_and_pass) {
        global $CFG;

		$target = "/home/jeelos/{$csv_line->domain}";
    } // function create_moodle_config


    static public function email_school_created($csv_line, $user_and_pass) {
        $query = "SELECT * FROM ".self::$prefix."user WHERE username = 'admin'";
        $result = self::remote_execute($csv_line, $query);
        $user = mysql_fetch_object($result);

        $subject = "Jeelo School aangemaakt";
        $body = "
            Hallo,<br /><br />
            Een nieuwe school is zojuist succesvol aangemaakt. De gegevens van de school staan hier onder.<br /><br />
            <table border-collapse='collapse'>

                <tr><td colspan='2'><hr /></td></tr>
                <tr><td colspan='2'><b>Website</b></td></tr>

                <tr>
                    <td>Naam</td>
                    <td>{$csv_line->name}</td>
                </tr>
                <tr>
                    <td>Link</td>
                    <td>http://{$csv_line->domain}</td>
                </tr>

                <tr><td colspan='2'><hr /></td></tr>
                <tr><td colspan='2'><b>Moodle Admin</b></td></tr>

                <tr>
                    <td>Gebruikersnaam</td>
                    <td>{$user->username}</td>
                </tr>
                <tr>
                </tr>
                
                <tr><td colspan='2'><hr /></td></tr>
            </table>
            <br /><br />
            Met vriendelijke groet,<br /><br />
            Jeelo Launcher 1.9";

        return (self::mail_with_headers($user->email, $body, $subject));
    } // function email_school_created


    static public function mail_with_headers($email_to, $body, $subject) {
        // To send HTML mail, the Content-type header must be set
        $headers  = 'MIME-Version: 1.0' . "\r\n";
        $headers .= '' . "\r\n";
        $headers .= 'From: Jeelo Launcher 1.9 <noreply@jeelo.nl>' . "\r\n";

        // Mail it
        mail($email_to, $subject, $body, $headers);
    } // function mail_with_headers


	/*
	static public function update_moodle_config($csv_line, $user_and_pass) {
        $folder = self::$target_folder . $csv_line->domain;

        $config_contents = file_get_contents($folder . '/public_html/config.php');
        $fields_to_change = array(
            '$CFG->dirroot'=>self::$target_folder.$csv_line->domain.'/public_html',
            '$CFG->wwwroot'=>'http://'.$csv_line->domain,
            '$CFG->dataroot'=>self::$target_folder.$csv_line->domain.'/moodle_data'
        );
        foreach($fields_to_change as $field=>$value) {
            $config_contents = self::set_config_contents($config_contents, $field, $value);
        }
        file_put_contents($folder .'/public_html/config.php', $config_contents);
        //shell_exec("chmod 777 $folder/public_html/config.php");

        // Handle config clean contents now
        $config_clean_contents = file_get_contents($folder . '/public_html/config_clean.php');
        $config_clean_contents = self::set_config_contents($config_clean_contents, '$CFG->dbpass', $user_and_pass['password']);
        file_put_contents($folder .'/public_html/config_clean.php', $config_clean_contents);
    }


    function set_config_contents($config_contents, $field, $value) {

        $offset = strpos($config_contents, $field); // find the line with CFG->dbpass

        $start = strpos($config_contents, '"', $offset); // find first double quote from there
        $end = strpos($config_contents, '"', $start+1); // find next double quote

        $config_contents = substr($config_contents, 0, $start+1) . $value . substr($config_contents, $end);
        
        return $config_contents;
    }
    */
    
    static public function update_server_status($record_id, $status, $exit_code=0) {
        $request = array(
            'request' => 'set_status',
            'id' => $record_id,
            'status' => $status,
            'exit_code' => $exit_code,
        );
        $response = self::get_server_response($request);
        self::log("Updated status for record $record_id to $status: $response");
    } // function update_server_status

    
    public static function get_server_response($request, $debug = false) {
		$request_url = self::get_request_url($request);
        if ($debug) echo die(var_dump($request_url));
        $response = file_get_contents($request_url);
        
        return $response;
    } // function get_server_response


    public static function get_request_url($request) {
        if (!is_array($request)) {
            throw new Exception("Parameter should be an associative array");
        }
        $request['for'] = self::$client_name;
 
        $pairs = array();
        foreach ($request as $varname=>$value) {
            $pairs[] = "$varname=$value";
        }
        $query_string = join('&', $pairs);
 
        // add hash to the $query_string
        $hash = self::create_hash_from_query_string($query_string);
        $query_string .= "&hash=$hash";
        
        $request_url = self::$server_url . '?' . $query_string;
        self::log($request_url);
        
        return $request_url; 
    } // function get_request_url


} // class client 

