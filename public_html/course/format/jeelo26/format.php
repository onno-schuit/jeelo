<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * Topics course format.  Display the whole course as "topics" made of modules.
 *
 * @package format_jeelo26
 * @copyright 2006 The Open University
 * @author N.D.Freear@open.ac.uk, and others.
 * @license http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

defined('MOODLE_INTERNAL') || die();

require_once($CFG->libdir.'/filelib.php');
require_once($CFG->libdir.'/completionlib.php');

// Horrible backwards compatible parameter aliasing..
if ($topic = optional_param('topic', 0, PARAM_INT)) {
    $url = $PAGE->url;
    $url->param('section', $topic);
    debugging('Outdated topic param passed to course/view.php', DEBUG_DEVELOPER);
    redirect($url);
}
// End backwards-compatible aliasing..



/**** JEELO custom code **/
// 20140130: ATTENTION: $mods are actually available in this context. 
// BUT we are having trouble setting the visibility...
// $mod->set_user_visible(true); // is not working

# Get course default access config
/*
$access = false;
$expanded = array();

$course_access = $DB->get_records('jeelo', array('course'=>$course->id));
if (count($course_access) > 0) {
  foreach($course_access as $ca) {
    $access = (bool)$ca->access;
    $expanded = explode(',', $ca->expanded);
  }
}
 */

# Check if mod access is enabled
$_new_mods = array();
$student = False;

$controlled_sections = array();

foreach (get_user_roles($context, $USER->id) as $_role) {
   if ($_role->shortname == 'student') {
     $student = True;
   }
}
if ($student) {
  foreach ($mods as $modid=>$mod) {
    $data = $DB->get_records('jeelo_access', array('type'=>$mod->section,
						   'userid'=>$USER->id,
						   'activity'=>$mod->id));
    if (!array_key_exists($mod->section, $controlled_sections)) {
        $controlled_sections[$mod->section] = false;
    }

    if (count($data) > 0) {
      foreach($data as $config) {
        $mod->set_user_visible(($config->level == 1), false);
      }
    } else {
        // Default to false
        $mod->set_user_visible(false, false);
    }
    
    if ($mod->visible) {
      // if at least one mod in section is visible - set section as visible
      $controlled_sections[$mod->section] = True;
      $_new_mods[$modid] = $mod;
    }
  }
  
  $mods = $_new_mods;
}

# End of jeelo access checks


$context = context_course::instance($course->id);

if (($marker >=0) && has_capability('moodle/course:setcurrentsection', $context) && confirm_sesskey()) {
    $course->marker = $marker;
    course_set_marker($course->id, $marker);
}

// make sure all sections are created
$course = course_get_format($course)->get_course();
course_create_sections_if_missing($course, range(0, $course->numsections));

$renderer = $PAGE->get_renderer('format_jeelo26');

if (!empty($displaysection)) {
    $renderer->print_single_section_page($course, null, null, null, null, $displaysection);
} else {
    $renderer->print_multiple_section_page($course, null, null, null, null, $controlled_sections);
}

// Include course format js module
$PAGE->requires->js('/course/format/jeelo26/format.js');
