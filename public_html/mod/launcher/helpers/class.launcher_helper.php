<?php
class launcher_helper extends helper {


    function print_input_field($field, $preset) {
        global $CFG;

        $preset_value = (isset($preset->$field)) ? $preset->$field : '';
        echo "
        <tr>
            <td>{$this->get_string($field)} *</td>
            <td><input type='text' name='{$this->model_name}[$field]' value='$preset_value'></td>
            <td class='error'>".soda_error::get_first_error($preset, $field)."</td>
        </tr>";
    } // function print_input_field


    function print_textarea_field($field, $preset) {
        global $CFG;

        $preset_value = (isset($preset->$field)) ? $preset->$field : '';
        echo "
        <tr>
            <td>{$this->get_string($field)}</td>
            <td><textarea name='{$this->model_name}[$field]'>$preset_value</textarea></td>
        </tr>";
    } // function print_textarea_box

    
}
?>
