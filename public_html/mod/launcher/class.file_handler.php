<?php
class file_handler {


    function next($moodle) {
        
        $handler = fopen($moodle->upload_groups['tmp_name'], 'r');

        while($data = fgetcsv($handler, 0, ';')) {

        }


    } // function next


    function validate_columns($columns) {

        $error_col = array();
        foreach($columns as $key => $column) {
            if (empty($column)) continue;
            if ($this->fields_groups[$key] != $column) $error_col[] = $column;
        }
        if (count($error_col) > 0) launcher_helper::error('The following columns in the csv file are not correct: <br />', $error_col);

        return true;
    } // function validate_columns
}
