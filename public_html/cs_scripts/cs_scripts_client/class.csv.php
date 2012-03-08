<?php

class csv {

    private $csv_fields = array(
        'id',
        'timecreated',
        'domain',
        'short_code',
        'name',
        'description',
        'categories',
        'sql_filename',
        'codebase_filename',
        'csv_filename',
        'is_for_client',
        'status',
        'exit_code',
        'timemodified'
    );
    private $lines = array();
    private $csv = array();
    private $curr_line = 0;



    function __construct($data) {

        $this->build_csv_object($data);

    }


    /* build_csv_object
     *
     * This function will create a new csv object
     * with the data from the server and the keys
     * from $this->csv_fields
     */
    function build_csv_object($data) {
        $this->lines = explode("\n", trim($data));

        foreach($this->lines as $line_num=>$line) {
            if (empty($line)) continue; // Skip lines with no data

            $properties = explode(';', $line);
            foreach($properties as $key_property=>$property) {

                $column = $this->csv_fields[$key_property];

                if ($column == 'categories') {
                    $this->csv[$line_num]->$column = ($property != '') ? explode('~', $property) : array();
                } else {
                    $this->csv[$line_num]->$column = $property;
                }
            }
        }
    }

    function nextline() {

        $csv = (isset($this->csv[$this->curr_line])) ? $this->csv[$this->curr_line] : false;

        $this->curr_line ++;

        return $csv;
    }
}

?>

