<?php

/*
*    Written by Tam Denholm
*    No licence, do as you wish with this script.
*
*    This is a script that allows easy addition of apache
*    virtual hosts. Works on a default install from apt
*    on ubuntu.
*
*    To use, download, set the config variables in the
*    __construct method and type the following commands
*    at the prompt depending what you want.
*
*    Create and enable a virtual host for domain.com
*    sudo php site.php create domain.com
*
*    Remove a virtual host for domain.com
*    sudo php site.php remove domain.com
*
*    Enable an already existing virtual host for domain.com
*    sudo php site.php enable domain.com
*
*    Disable an already existing virtual host for domain.com
*    sudo php site.php disable domain.com
*
*/

class site {

    private $domain, $filename, $option, $doc_root, $apache_path, $user;
    
    public function __construct(){
        // checks and variables
        $this->detect_sudo();
        $this->option = $_SERVER['argv'][1];
        $this->domain = $_SERVER['argv'][2];
        $this->user = '<<<REPLACE WITH USERNAME>>>';
        $this->doc_root = '<<<REPLACE WITH WEB DIR>>>';
        $this->apache_path = '/etc/apache2/sites-available/';
        $this->filename = array_shift(explode('.', $this->domain));
        // ok so what option do you want to do?
        $options = array('create', 'enable', 'disable', 'remove');
        if(in_array($this->option, $options)){
            switch($this->option){
                case 'create':
                    $this->require_domain();
                    $this->create_vhost();
                    $this->create_doc_root();
                    $this->enable_vhost();
                    $this->restart_apache();
                    echo "##########################################\n";
                    echo $this->domain." created.\n";
                    break;
                case 'enable':
                    $this->require_domain();
                    $this->enable_vhost();
                    $this->restart_apache();
                    echo "##########################################\n";
                    echo $this->domain." enabled.\n";                
                    break;
                case 'disable':
                    $this->require_domain();
                    $this->disable_vhost();
                    $this->restart_apache();
                    echo "##########################################\n";
                    echo $this->domain." disabled.\n";                
                    break;
                case 'remove':
                    $this->sure();
                    $this->require_domain();
                    $this->disable_vhost();
                    $this->delete_vhost();
                    $this->delete_doc_root();
                    $this->restart_apache();
                    echo "##########################################\n";
                    echo $this->domain." removed.\n";                
                    break;
            }
        }else{
            echo "Invalid option selected, pic from: ".implode(' ', $options)."\n";
            die;
        }
    }
    
    public function detect_sudo(){
/*        $process_info = posix_getpwuid(posix_geteuid());
        if($process_info['name'] != 'root'){
            echo "Sorry, this needs to be run with sudo!\n";
            die;
        }
*/
		return true;
    }
    
    public function require_domain(){
        if(!preg_match('/\w+\.\w+\.?\w*/', $this->domain)){
            echo "Invalid domain name given.\n";
            die;
        }
    }
    
    public function create_vhost(){
        if(file_exists($this->apache_path.$this->filename)){
            echo "The virtualhost file already exists!\n";
            die;
        }
        // should probably move this to read an external file...
        $contents = 'NameVirtualHost *
        <VirtualHost *>
            DocumentRoot '.$this->doc_root.$this->filename.'/htdocs/
            ServerName '.$this->domain.'
            ServerAlias www.'.$this->domain.'
            <Directory '.$this->doc_root.$this->filename.'/htdocs/>
                Options FollowSymLinks MultiViews
                AllowOverride All
            </Directory>
        </VirtualHost>';
        if(file_put_contents($this->apache_path.$this->filename, $contents)){
            echo "Wrote virtual host file: ".$this->apache_path.$this->filename."\n";
        }
    }
    
    public function create_doc_root(){
        mkdir($this->doc_root.$this->filename.'/htdocs', 0777, true);
        chown($this->doc_root.$this->filename, $this->user);
        chown($this->doc_root.$this->filename.'/htdocs', $this->user);
        file_put_contents($this->doc_root.$this->filename.'/htdocs/index.php', 'Welcome to '.$this->domain."\n");
        chown($this->doc_root.$this->filename.'/htdocs/index.php', $this->user);
    }
    
    public function enable_vhost(){
        echo shell_exec('sudo a2ensite '.$this->filename);
    }
    
    public function disable_vhost(){
        echo shell_exec('sudo a2dissite '.$this->filename);
    }
    
    public function restart_apache(){
        echo "Apache Restarting...\n";
        shell_exec('sudo apache2ctl restart');
    }
    
    public function sure(){
                echo "Are you really sure you want to do this? (yes or no)\n";
        $answer = trim(strtolower(fread(STDIN, 80)));
        while($answer != 'yes' || $answer != 'no'){
                if($answer == 'yes'){
                        return true;
                }elseif($answer == 'no'){
                        echo "Script ended.\n";
                        die;
                }else{
                        echo "Please type yes or no.\n";
                        $answer = trim(strtolower(fread(STDIN, 80)));
                }
        }
    }
    
    public function delete_vhost(){
        if(!file_exists($this->apache_path.$this->filename)){
            echo "Can't delete the vhost file, it doesnt exist!\n";
        }else{
            if(unlink($this->apache_path.$this->filename)){
                echo "Virtual host file deleted!\n";
            }else{
                echo "Virtual host file NOT deleted!\n";
            }
        }
    }
    
    public function delete_doc_root(){
        shell_exec('rm -fr '.$this->doc_root.$this->filename);
        echo "Deleted all files within the web root, i hope you meant to do that...\n";
    }
    
}

new site;

?>
