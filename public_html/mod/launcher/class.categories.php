<?php
class categories extends content_uploader {

    function create_new_category($category_id) {
        global $CFG;

        $category = get_record('course_categories', 'id', $category_id);
        unset($category->id);
        $category->timemodified = time();
        $category->coursecount = $course_count;

        $query = $this->insert_query_join_properties('course_categories', $category);

        return launcher_helper::remote_execute($moodle, $query, true);

    } // function create_new_categories
}
?>
