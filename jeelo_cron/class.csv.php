<?php

class csv {

    // The elements of this array are made available as keys in a 'csv' array
    private $client_moodles_fields = array(
        'id',
        'timecreated',
        'domain',
        'shortcode',
        'fullname',
        'email',
        'sql_filename',
        'codebase_filename',
        'csv_filename',
        'courses_filename',
        /*
        'logo_filename',
        'navbar_color',
         */
        'is_for_client',
        'status',
        'exit_code',
        'timemodified'
    );

    private $client_categories_fields = array(
        'id',
        'name',
        'description',
        'parent',
        'sortorder',
        'coursecount',
        'visible',
        'timemodified',
        'depth',
        'path',
        'theme',
        'client_moodle_id',
        'original_id'
    );

    private $client_courses_fields = array(
        'id',
        'backup_name',
        'course_fullname',
        'course_shortname',
        'groupyear',
        'client_moodle_id',
        'parent_category_id'
    );

    private $lines = array();
    private $csv = array();
    private $curr_line = 0;


    /* build_csv_object
     *
     * This function will create a new csv object
     * with the data from the server and the keys
     * from $this->csv_fields
     */
    function build_csv_object($data, $table_name) {
        $this->lines = explode("\n", trim($data));
        $columns = $this->{$table_name.'_fields'};

        foreach($this->lines as $line_num=>$line) {
            if (empty($line)) continue; // Skip lines with no data

            $properties = explode(';', $line);
            
            // Connect properties to object
            foreach($properties as $key_property=>$property) {
                $column = $columns[$key_property];
                $this->csv[$line_num]->$column = trim($property);
            }
        }
        return $this->csv;
    }

    function nextline() {
        $csv = (isset($this->csv[$this->curr_line])) ? $this->csv[$this->curr_line] : false;
        $this->curr_line ++;
        return $csv;
    }
}

?>

