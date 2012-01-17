<?php
class launcher_helper extends helper {


    /* Executes query against the remote database */
    static function remote_execute($moodle, $query, $return_id = false) {

        if (!$con = mysql_connect($moodle->db->host, $moodle->db->name, key($moodle->db->password))) return false;
        if (!mysql_select_db($moodle->db->name)) return false;

        if (!$result = mysql_query($query)) return false; // Execute the actual query
        
        if ($return_id) $id = mysql_insert_id();
        mysql_close($con);

        return ($return_id) ? $id : $result;
    } // function 


    function print_input_field($field, $moodle) {

        $preset_value = (isset($moodle->$field)) ? $moodle->$field : '';
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
