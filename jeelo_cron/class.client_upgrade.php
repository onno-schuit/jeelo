<?php

class client_upgrade {
    
    static $info; // csv info from server
    
    function run($info) {
        self::$info = $info;
        self::backup_database();
        self::backup_codebase();
        self::backup_config();
        self::extract_codebase();
        self::restore_config();
        self::fire_moodle_cli_upgrade();
    }
    
    
    static function abort_upgrade() {
        client::update_server_status(self::$info->id, 'upgraded', $end_of_process = 1);
        client::log("Upgrade aborted");
        die("Upgrade aborted");
    }

    static protected function _get_backup_dir() {
        global $cs_jeelos_target_folder;
        
        $dbname = self::$info->shortcode;
        $backup_folder = $cs_jeelos_target_folder . '/_backups/' . $dbname;
        if (!file_exists($backup_folder)) {
            mkdir($backup_folder, 0755, true);
        }
        
        return $backup_folder;
    }
    
    static public function backup_codebase() {
        global $cs_jeelos_target_folder;
        
        $backup_folder = self::_get_backup_dir();

        $dbname = self::$info->shortcode;
        $target = $backup_folder . '/codebase.tgz';
        $domain = self::$info->domain;
        $sourcedir = $cs_jeelos_target_folder . '/' . $domain;

        // remember current dir and change to installation dir for backup of the public_html folder
        $cur_dir = getcwd();
        chdir($sourcedir); 

        // do the backup    
        // -c = create, -z = gzip, -v = verbose, -f = filename %s    
        $cmd = sprintf("tar -czvf %s %s ", $target, 'public_html'); // we already are in the correct dir via chdir
        client::log($cmd);
        shell_exec($cmd);

        // change back to original dir        
        chdir($cur_dir); 
        
    }
    
    static public function backup_config() {
        global $cs_jeelos_target_folder;
        
        $backup_folder = self::_get_backup_dir();
        
        $source = $cs_jeelos_target_folder . '/' . self::$info->domain . '/public_html/config.php';
        $target = $backup_folder . '/config.php';
        
        client::log("cp $source $target");
        copy($source, $target);
        
    }

    static public function backup_database() {
        global $mysql_dump_bin, $cs_dbuser, $cs_dbpass;
        
        $backup_folder = self::_get_backup_dir();

        $dbname = self::$info->shortcode;
        $target = $backup_folder . '/' . $dbname . '.sql';
        
        // dump the database; -Q = backticks around table names, -u = user, -p = password
        $cmd = sprintf($mysql_dump_bin . " -Qu %s %s --add-drop-table %s > %s",
            $cs_dbuser, $cs_dbpass ? '-p' . $cs_dbpass : '', $dbname, $target);
        client::log($cmd);
        shell_exec($cmd);
        
        // gzip the database
        $cmd = sprintf("gzip -f %s", $target);
        client::log($cmd);
        shell_exec($cmd);
        
    }
    
    static public function extract_codebase() {
        global $cs_jeelos_target_folder;
        
        $backup_folder = self::_get_backup_dir();
        $install_dir = $cs_jeelos_target_folder . '/' . self::$info->domain;
        
        // first remove the current installation
        $cmd = sprintf("rm -r %s/public_html", $install_dir); // -r = recursive
        if (strlen($cmd) < 10) {
            client::log("Folder name too short; probably wrong configuration ($cmd)");
            self::abort_upgrade();
        }
        if (!file_exists($install_dir . '/public_html')) {
            client::log("Folder not found: $install_dir/public_html");
            self::abort_upgrade();
        }
        client::log($cmd);
        shell_exec($cmd);
        
        // move new codebase to install_dir
        $src = self::$info->codebase_upgrade;
        $target = $install_dir . '/' . basename($src);
        client::log("rename($src, $target)");
        rename($src, $target);
        
        // extract tgz
        $cur_dir = getcwd(); // remember where we are
        chdir($install_dir); // change to install dir
        client::log("chdir($install_dir)");

        $cmd = sprintf("tar -xzvf %s", $target); // create tar command; x = extract, z = gzip, v = verbose, f = filename %s
        client::log($cmd);
        shell_exec($cmd); // execute tar command
        chdir($cur_dir); // change back to prev dir
        
        // remove tgz
        client::log("unlink($src)");
        unlink($target);
        
    }
    
    static public function restore_config() {
        global $cs_jeelos_target_folder;
        
        $backup_folder = self::_get_backup_dir();
        
        $source = $backup_folder . '/config.php';
        $target = $cs_jeelos_target_folder . '/' . self::$info->domain . '/public_html/config.php';
        
        client::log("cp $source $target");
        copy($source, $target);
        
    }
    
    static public function fire_moodle_cli_upgrade() {
        
        global $cs_jeelos_target_folder, $cs_apache_user;
        
        $install_dir = $cs_jeelos_target_folder . '/' . self::$info->domain . '/public_html';
        
        client::log("chdir($install_dir)");
        chdir($install_dir);
        
        $cmd = "sudo -u $cs_apache_user php admin/cli/upgrade.php --non-interactive";
        client::log($cmd);
        shell_exec($cmd);   
    }
    
}
