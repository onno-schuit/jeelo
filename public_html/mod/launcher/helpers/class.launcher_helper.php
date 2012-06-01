<?php
class launcher_helper extends helper {

 	function has_access_rights()
	{
		global $context;
		require_login();
        
        return (require_capability('mod/launcher:access', $context));
	} // function has_assess_rights()

    public static function set_buffer_db() {
        global $BUFFER_DB, $DB, $CFG;
        $db_class = get_class($DB);
        $BUFFER_DB = new $db_class();
        $BUFFER_DB->connect($CFG->buffer_dbhost, $CFG->buffer_dbuser, $CFG->buffer_dbpass, $CFG->buffer_dbname, false);
    } // function set_source_db
	
    function print_menu() {
        global $id;
        echo "<a href='index.php?id=$id&controller=school'>Create a new school</a><br />";
        echo "<a href='index.php?id=$id&controller=schoolyear'>Add a new school year</a><br />";
        echo "<a href='index.php?id=$id&controller=upgrade'>Upgrade</a>";
    }

    function print_input_field($field, $moodle, $input_extra = '') {

        // Set the preset value if one is already set
        // Set default of the field 'server' to 'localhost'
        $preset_value = (isset($moodle->$field)) ? $moodle->$field : (($field == 'server_name') ? 'localhost' : '');
        echo "
        <tr>
            <td>".	get_string($field, 'launcher') . 
					$this->print_help_button() . "</td>
            <td><input type='text' id='$field' name='{$this->model_name}[$field]' value='$preset_value' $input_extra></td>";
        if ($moodle) {
            echo "
            <td class='error'>".soda_error::get_first_error($moodle, $field)."</td>";
        }
        echo "</tr>";
    }
    
    function print_help_button() {
		// We'll figure this out later
		// It used to be like this:
		// helpbutton($field, get_string($field, 'launcher'), 'launcher', true, false, '', true)
		return;
	}
    
    function print_special_input_field($field, $moodle) {
		$js = 'onkeyup = \'if (this.value != "") document.getElementById("domain").value=this.value + ".srv1a.jeelo.nl" \'';
		$this->print_input_field($field, $moodle, $js);
	}
	
    function print_upload_field($field, $moodle) {

        echo "
        <tr>
            <td>" . get_string($field, 'launcher')
				  . $this->print_help_button() . "</td>
            <td><input type='file' name='$field' /></td>";
        if ($moodle) {
            echo "
            <td class='error'>".soda_error::get_first_error($moodle, $field)."</td>";
        }
        echo "</tr>";
        
    }
    
	function print_categories_checkboxes($categories_preset = null)
	{
		global $CFG, $DB;
		
		// "SELECT * FROM {$CFG->prefix}course_categories WHERE visible = 1 AND sortorder != 0
        if (!$categories = $DB->get_records_sql('SELECT * FROM {course_categories} WHERE id != 1 AND visible = 1')) {
            echo get_string('no_categories', 'launcher'); // AND category != 0
            return;
        }

		echo "<table>";
		foreach($categories as $key=>$category)
		{
			$this->print_categories_checkbox($category, $categories_preset);
		}
		echo "</table>";
	}

	function print_categories_checkbox($category, $categories_preset)
    {
        if (isset($categories_preset) && $categories_preset) {
            $categories_preset = (is_array(array_keys($categories_preset))) ? array_keys($categories_preset) : $categories_preset;
            $checked = ($categories_preset != NULL && in_array($category->id, $categories_preset)) ? 'checked="checked"' : '';
        } else {
            $checked = '';
        }
		
        echo '<tr>';
		echo "<td><input type='checkbox' name='{$this->model_name}[categories][{$category->id}]' value='{$category->id}' id='{$this->model_name}_categories' $checked>{$category->name}</td>";
        echo '</tr>';
	}

	/*
    function get_moodle_environments() {
        global $CFG, $DB;
        
        $query = "SELECT * FROM jeelo_buffer.client_moodles WHERE status = 'processed'";
        if (!$moodle_environments = get_records_sql($query)) error(get_string('no_moodles', 'launcher'));
        return $moodle_environments;
    }
    */

}
?>
