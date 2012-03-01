<?php
class launcher_helper extends helper {


    /* Executes query against the remote database */
    static function remote_execute($moodle, $query, $return_id = false) {

        if (!$con = mysql_connect($moodle->db->host, $moodle->db->name, $moodle->get_password($moodle->db->password))) return false;
        if (!mysql_select_db($moodle->db->name)) return false;

        if (!$result = mysql_query($query)) return false; // Execute the actual query
        
        if ($return_id) $id = mysql_insert_id();
        mysql_close($con);

        return ($return_id) ? $id : $result;
    } // function 


    /* Menno de Ridder, 06-02-2012
     *
     * This function prints errors based on an error code.
     * The error codes are listed in the readme, together
     * with at which page the error is called from and a
     * possible reason for the failure.
     *
     * Codes
     * 1000 - 1999  /controllers/moodle.php
     * 2000 - 2999  /models/moodle.php
     * 3000 - 3999  /class.content_uploader.php
     *
     * @param string $code The code of the error. */
    static function print_error($code) {
        $errors = array(
            '1000'=>'A required parameter was missing.',

            '2000'=>'Failed to create child moodle codebase.',
            '2001'=>'Failed to set up child moodle database.',
            '2002'=>'Failed to insert content in the child moodle.',
            '2003'=>'Failed to set up the child URL.',
            '2004'=>'Failed to save the child in the mother database.',
            '2005'=>'Failed to create child database.',
            '2006'=>'Failed to save the child in the mother database.',
            '2007'=>'Failed to save the child in the mother database.',
            '2008'=>'Failed to save the child in the mother database.',
            '2009'=>'Failed to create zip file from codebase and database.',

            '3000'=>'Failed to identify the csv files.',
            '3001'=>'Failed to create context files.',
            '3002'=>'Failed to create users.',
            '3003'=>'Failed to create categories',
            '3004'=>'Failed to delete context files.'
        );

        if (!isset($errors[$code])) return "Error code '$code' could not be found.";
        
        error("Error $code: {$errors[$code]}");
    } // function print_error


    function print_menu() {
        global $id;
        echo "<a href='index.php?id=$id&controller=moodle&action=add_school'>Create a new school</a><br />";
        echo "<a href='index.php?id=$id&controller=moodle&action=add_schoolyear'>Add a new school year</a>";
    } // function print_menu


    function print_moodles_dropdown($schoolyear) {
        $moodle_environments = $this->get_moodle_environments();

        echo "<select name='{$this->model_name}[environment_id]' onChange='this.form.submit();'>";
        echo "<option value='select'>".get_string('select')."</option>"; 
        foreach($moodle_environments as $environment) {

            $selected = (isset($schoolyear->environment->id) && ($schoolyear->environment->id == $environment->id)) ? 'selected' : '';
            echo "<option value='{$environment->id}' $selected>{$environment->name}</option>";

        }
        echo "</select>";
    } // function print_moodles_dropdown


    function get_moodle_environments() {
        global $CFG;
        if (!$moodle_environments = get_records('launcher_moodles')) error(get_string('no_moodles', 'launcher'));
        return $moodle_environments;
    } // function get_moodle_environments


    function print_input_field($field, $moodle) {

        // Set the preset value if one is already set
        // Set default of the field 'server' to 'localhost'
        $preset_value = (isset($moodle->$field)) ? $moodle->$field : ($field == 'server_name') ? 'localhost' : '';
        echo "
        <tr>
            <td>".get_string($field, 'launcher')."</td>
            <td><input type='text' name='{$this->model_name}[$field]' value='$preset_value'></td>";
        if ($moodle) {
            echo "
            <td class='error'>".soda_error::get_first_error($moodle, $field)."</td>";
        }
        echo "</tr>";
    } // function print_input_field


    function print_textarea_field($field, $moodle) {

        $preset_value = (isset($moodle->$field)) ? $moodle->$field : '';
        echo "
        <tr>
            <td>".get_string($field, 'launcher')."</td>
            <td><textarea name='{$this->model_name}[$field]'>$preset_value</textarea></td>
        </tr>";
    } // function print_textarea_box


    function print_upload_field($field, $moodle) {

        echo "
        <tr>
            <td>".get_string($field, 'launcher')."</td>
            <td><input type='file' name='$field' /></td>";
        if ($moodle) {
            echo "
            <td class='error'>".soda_error::get_first_error($moodle, $field)."</td>";
        }
        echo "</tr>";
        
    } // function print_upload_field


    function get_average_loadtime() {
        global $CFG, $launcher;

        $sql = "
            SELECT (
                average_loadtime / installed
            ) as loadtime
            FROM {$CFG->prefix}launcher
            WHERE id = {$launcher->id}";
        $average_load_time = get_record_sql($sql);

        return round($average_load_time->loadtime);
    } // function get_average_loadtime


    function store_load_time($start_time) {
        global $launcher;
        $oldtime = get_record('launcher', 'id', $launcher->id);
        $end_time = $this->get_page_time();
        $obj->id = $launcher->id;
        $obj->average_loadtime = $oldtime->average_loadtime + ($end_time - $start_time);
        $obj->installed = $oldtime->installed + 1;

        return (update_record('launcher', $obj));
    } // function store_load_time


    static function error($msg, $arr_columns = false) {
        $str = '';
        if (!$arr_columns) error($msg);
        foreach($arr_columns as $arr_column) {
            $str .= "$arr_column<br />";
        }
        error($msg.$str);
    } // function error


	function print_categories_checkboxes($categories_preset = null)
	{
		global $CFG;
		$categories = get_recordset_sql("SELECT * FROM {$CFG->prefix}course_categories WHERE visible = 1 AND sortorder != 0"); // AND category != 0

		echo "<table>";
		foreach($categories as $key=>$category)
		{
			$this->print_categories_checkbox($category, $categories_preset);
		}
		echo "</table>";
	} // function print_courses_checkboxes


	function print_categories_checkbox($category, $categories_preset)
    {
        if (isset($categories_preset) && $categories_preset) {
            $categories_preset = (is_array(array_keys($categories_preset))) ? array_keys($categories_preset) : $categories_preset;
            $checked = ($categories_preset != NULL && in_array($category['id'], $categories_preset)) ? 'checked="checked"' : '';
        } else {
            $checked = '';
        }
		
        echo '<tr>';
		echo "<td><input type='checkbox' name='{$this->model_name}[categories][{$category['id']}]' value='{$category['id']}' id='{$this->model_name}_categories' $checked>{$category['name']}</td>";
        echo '</tr>';
	} // function print_course_checkbox

    
}
?>
