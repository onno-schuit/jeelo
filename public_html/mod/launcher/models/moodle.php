<?php
class moodle extends model {

    static $table_name = 'launcher_moodle';

    function define_validation_rules() {
        // $this->add_rule('username', get_string('error_username', 'signup'), function($username) { return ( trim($username) != '' ); });
        
    }


    function print_input_field($field) {
        
        echo "
        <tr>
            <td>$field</td>
            <td><input type='text' name='$field' value=''></td>
        </tr>";

    }
}
?>
