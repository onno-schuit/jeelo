<?php
require_once("class.base.php");
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
    static $client_url = '';
 
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
    }
 
    public static function create_database($csv_line) {
        $sql = "CREATE DATABASE `{$csv_line->short_code}`";
        self::log($sql);
        self::$db->query($sql);
    }
    
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
    }
    
    public static function create_codebase($csv_line) {

		$tmpfile = self::$target_folder . $csv_line->domain . '/site.tgz';
		
		self::create_codebase_folder($csv_line);

		$codebase = self::get_codebase_from_server($csv_line, $tmpfile);
		
		self::copy_codebase_to_client($csv_line, $codebase);
		
        self::remove_codebase_from_server($tmpfile);
        
        self::extract_codebase_contents($tmpfile);
    }
    
    public static function copy_codebase_to_client($csv_line, $codebase) {
		
		$cmd = "wget --quiet --directory-prefix=" . self::$target_folder . "/" . $csv_line->domain . " $codebase";
		self::log($cmd);
		shell_exec($cmd);
		
	}
    
    public static function create_codebase_folder($csv_line) {
		
        $target = self::$target_folder . $csv_line->domain;
        self::log("Creating folder: $target");
        mkdir($target, 0755); // without the public_html folder
        
	}
	
	public static function extract_codebase_contents($tmpfile) {
		
        // extract contents
        $cmd = sprintf("tar -xz -C %s -f %s", dirname($tmpfile), $tmpfile);
        self::log($cmd);
        shell_exec($cmd);
        
        // When done unlink the file
        unlink($tmpfile);
	}

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
	}
	
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

	}
    
    public static function get_db_from_server($csv_line) {
		self::log("Getting db from server");
        $request = array(
            'request' => 'get_database',
            'id' => $csv_line->id
        );
        
        $response = self::get_server_response($request);
        // check if we have file contents or maybe an error
        if (strlen($response) < 100 && strstr($response, 'error')) {
            self::log($response);
            die();
        }
        
        // write contents to temp file
        $tmpfile = tempnam('/tmp', 'jmdl'); // prefix jmdl (jeelo moodle)
        self::log("Creating file " . $tmpfile . '.gz');
        file_put_contents($tmpfile . '.gz', $response);
        
        unset($response); // clear memory ?

        $cmd = sprintf("gunzip -c %s > %s", $tmpfile . '.gz' , $tmpfile);
        self::log($cmd);
        $output = shell_exec($cmd);

        // import into mysql
        $dbname = '' . $csv_line->short_code; // no prefix
        $add_password_switch = !empty(self::$db->pass) ? ("-p" . self::$db->pass) : ''; 
        $cmd = sprintf("mysql -u %s %s %s < %s", self::$db->user, $add_password_switch, $dbname, $tmpfile);
        self::log($cmd); 
        
        $output = shell_exec($cmd); // command line execute
        self::log("Mysql ouput: [$output]"); // put mysql output into log file
        
    }
 
    public static function get_server_response($request) {
		
		$request_url = self::get_request_url($request);
        $response = file_get_contents($request_url);
        
        return $response;
    }
    
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
	}

    public static function process_client_from_csv($csv_line) {
        self::log("Processing id {$csv_line->id}, status {$csv_line->status}");
        
        // Update status FIRST
        self::update_server_status($csv_line->id, 'being_processed');

        switch($csv_line->status) {
            case 'new':
                self::process_new_client($csv_line);
                break;
            case 'update':
                self::process_update_client($csv_line);
                break;
        }

        self::update_server_status($csv_line->id, 'processed', 0); // everything ok! 
    }


    /* Executes query against the remote database */
    public static function remote_execute($csv_line, $query, $return_id = false) {
        $clean_cfg = self::get_clean_config($csv_line);

        if (!$con = mysql_connect($clean_cfg->dbhost, $clean_cfg->dbuser, $clean_cfg->dbpass)) {
			self::log("Couldn't asteblish remote db connection when trying to execute query: $query");
			die("No remote db connection");
		}
        if (!mysql_select_db($clean_cfg->dbname, $con)) die("Failed to select db for remote execute");

        if (!$result = mysql_query($query)) die(mysql_error());
        
        if ($return_id) $id = mysql_insert_id();
        mysql_close($con);


        return ($return_id) ? $id : $result;
    }


    public static function process_update_client($csv_line) {
		include("class.client_updater.php");
		
        $client_updater = new client_updater($csv_line);
        $client_updater->start_updater();
    }


    public static function process_new_client($csv_line) {
	self::log("Starting the creation of a new moodle school.");
        
        self::create_database($csv_line);
        $user_and_pass = self::create_database_user($csv_line->short_code);
        self::get_db_from_server($csv_line);
        
        self::create_codebase($csv_line);

        self::update_moodle_config($csv_line, $user_and_pass);
        
        self::change_site_template($csv_line);
        
        self::add_to_apache($csv_line);

        self::email_school_created($csv_line, $user_and_pass);
        
    }
    
    
    public static function change_site_template($csv_line) {
		$query = "UPDATE " . self::$prefix . "config SET value = 'children-education' WHERE name = 'theme'";
		return (self::remote_execute($csv_line, $query));
	}


    public static function get_clean_config($csv_line) {
        $target = self::$target_folder . $csv_line->domain;
        require("$target/public_html/config_clean.php");
        return $CFG;
    }


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
                    <td>Wachtwoord</td>
                    <td>test</td>
                </tr>
                
                <tr><td colspan='2'><hr /></td></tr>
            </table>
            <br /><br />
            Met vriendelijke groet,<br /><br />
            Jeelo Launcher 1.9";

        return (self::mail_with_headers($user->email, $body, $subject));
    }


    static public function mail_with_headers($email_to, $body, $subject) {
        
        // To send HTML mail, the Content-type header must be set
        $headers  = 'MIME-Version: 1.0' . "\r\n";
        $headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
        $headers .= 'From: Jeelo Launcher 1.9 <noreply@jeelo.nl>' . "\r\n";

        // Mail it
        mail($email_to, $subject, $body, $headers);
    }


    static public function run() {
        require_once("class.csv.php");
        
        self::log("Checking for available clients.");
        
        $request = array(
            'request' => 'get_available_clients'
        );
        $response = self::get_server_response($request);
        
        if (!$response) {
           die(); // no clients available for processing.. do nothing
        }
        
        $csv = new csv();
        $moodle_clients = $csv->build_csv_object($response, 'client_moodles');


        while($moodle_clients_line = $csv->nextline()) {
			// Usefull variable
			self::$client_url = $moodle_clients_line->domain;
			
            self::process_client_from_csv($moodle_clients_line);
        }
    }
    
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
    
    static public function update_server_status($record_id, $status, $exit_code=0) {
        $request = array(
            'request' => 'set_status',
            'id' => $record_id,
            'status' => $status,
            'exit_code' => $exit_code,
        );
        $response = self::get_server_response($request);
        self::log("Updated status for record $record_id to $status: $response");
    }
    
}

