<?php

class category extends model {

    static $table_name = 'course_categories';

    // Overwrites parent's create function because we also need to create a context record.
    function create() {
        $category_id = parent::create();
        // the unaptly named get_context_instance function will also create a new context record if no existing could be found
        $context = get_context_instance(CONTEXT_COURSECAT, $category_id);
        mark_context_dirty($context->path);
        return $category_id;
    } // function create

} // class category 

?>
