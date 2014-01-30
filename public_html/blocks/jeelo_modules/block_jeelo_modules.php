<?php
	
include_once($CFG->dirroot . '/course/lib.php');

class block_jeelo_modules extends block_list
{

	
    function init() 
	{
        // $this->title = get_string('pluginname', 'block_jeelo_modules');
		$this->title =  '';        
    }

    public function get_content() 
	{
        global $CFG, $DB, $OUTPUT, $USER, $COURSE, $CONTEXT;
        $adminseesall = true;
		
		//require_login() ;
		
        if($this->content !== NULL) 
		{
            return $this->content;
        }

		//-----
        $this->content 			= new stdClass;
        $this->content->items 	= array();
        $this->content->icons 	= array();
        $this->content->footer 	= '';

		//-----
		
        $course 	= $this->page->course;
        require_once($CFG->dirroot.'/course/lib.php');
        //$context 	= get_context_instance(CONTEXT_COURSE, $course->id);	
        $context 	= context_course::instance($course->id);	
        $system_context 	= context_system::instance();	
		
		//$this->content->items[] = 'Course = '.$course->id;
		//$this->content->items[] = 'Gebruiker = '. $USER->id;	
		//$this->content->items[] = '<br />Is enrolled = '.is_enrolled($context, $USER->id , $withcapability = '', $onlyactive = false) ;
		$kalenderA 				= $DB->get_record('course', array('shortname'	=>	'kalender')) ;
		//$routeteamsA            = $DB->get_record('course', 'shortname LIKE routeteams%') ;
		//$routeteamsA    = $DB->get_record("course", "'shortname' LIKE 'routeteams%'") ;
		$routeteamsA 			= $DB->get_record('course', array('shortname'	=>	'routeteams')) ;
		$course 				= $this->page->course;
        $user = $DB->get_record('user', array('id' => $USER->id));
		$urlJeelo2						= 'http://content.jeelo2.nl/extern/'.md5($user->email).'__'.$user->password.'__'.$course->idnumber ;
		//----- ALGEMEEN
		
			
		if (has_capability('moodle/course:viewhiddencourses',context_course::instance($course->id))) {    // SHOW ALGEMEEN	
			if (empty($CFG->disablemycourses) and isloggedin() and !isguestuser() and !(has_capability('moodle/course:update', $system_context) and $adminseesall)) {
				$this->content->items[] = '<br><span style="font-size: large; color: #BBBBBB;">Algemeen</span>';
				
				if( $course->id > '1' && $course->id !=  $kalenderA->id && $course->format ==  'jeelo')
				{
					$this->content->items[] = '&#9679; '.'<a href="'.$CFG->wwwroot.'/mod/jeelo/?course/'.$COURSE->id.'/">Leerlingenpaneel</a>';
				}
				if( $course->id > '1' && $course->id !=  $kalenderA->id && $course->format ==  'jeelo')
				{
					$this->content->items[] = '&#9679; '.'<a href="'.$CFG->wwwroot.'/group/index.php?id='.$COURSE->id.'/">Groepen voor wiki\'s</a>';
				}
				$this->content->items[] = '&#9679; <a href="'.$CFG->wwwroot.'/report/log/index.php?chooselog=1&showusers=1&showcourses=1&host_course=1%2F'.$COURSE->id.'&id=1&user=&date=&modid=&modaction=&logformat=showashtml">Logs</a>';
				if( $course->id > '1' && $course->id !=  $kalenderA->id && $course->id !=  $routeteamsA->id) 
				{
					$this->content->items[] = '&#9679; <a href="'.$urlJeelo2.'" target="_blank">Handleidingen</a>';
				}
				if( $course->id > '1' && $course->id !=  $kalenderA->id && $course->format ==  'jeelo')
				{
				$modinfo = get_fast_modinfo($course);
				$modfullnames = array();
				$archetypes = array();

				foreach($modinfo->cms as $cm) 
				{
					if( $cm->modname == 'url' && $cm->visible == '0') 
					{				
						$this->content->items[] = '&#9679; <a href="'.$CFG->wwwroot.'/mod/url/view.php?id='.$cm->id.'">'.$cm->name.'</a>' ;				
					}
				}	
				}
				if( $course->id == '1')
				{
					$this->content->items[] = '&#9679; <a href="'.$urlJeelo2.'" target="_blank">Support projecten</a>';
				}				
				//if( $routeteamsA ) 
				//{			
				//	$this->content->items[] = '&#9679; <a href="'.$CFG->wwwroot.'/course/view.php?id='.$routeteamsA->id.'">Support project</a>' ;
				//}	
					$this->content->items[] = '&#9679; <a href="http://vragen.jeelo2.nl" target="_blank">Vragen</a>' ;					
				if (has_capability('moodle/course:viewhiddencourses',context_course::instance($course->id))) 
					{    	
						$this->content->items[] = '&#9679; <a href="'.$CFG->wwwroot.'/course/index.php">Archief</a>';
					}
							
				}
		}
		//-----/ ALGEMEEN
		
		//----- SAMEN LEVEN
		
		$this->content->items[] = '<br><span style="color: #33FF00; font-size: large;">Samen leven</span><br>&#9679; <a href="'.$CFG->wwwroot.'/blog/index.php">Blogs</a>' ;

		if( $kalenderA ) 
		{			
			$this->content->items[] = '&#9679; <a href="'.$CFG->wwwroot.'/course/view.php?id='.$kalenderA->id.'">Kalender</a>' ;
		}
		
		//-----/ SAMEN LEVEN		

		//----- SAMEN WERKEN
		
		$this->content->items[] = '<br><span style="font-size: large; color: #FF6600;">Samen werken</span>';

        $modinfo = get_fast_modinfo($course);
        $modfullnames = array();
		$archetypes = array();

        foreach($modinfo->cms as $cm) 
		{
			if( $cm->modname == 'forum' && $cm->visible == '1') 
			{				
				$this->content->items[] = '&#9679; <a href="'.$CFG->wwwroot.'/mod/forum/view.php?id='.$cm->id.'">'.$cm->name.'</a>' ;				
			}
		}
		//-----/ SAMEN WERKEN

		//----- ZELFSTANDIG LEREN
		
		$this->content->items[] = '<br><span style="font-size: large; color: #00CCFF;">Zelfstandig leren</span>';
		
        collatorlib::asort($modfullnames);

		if( $course->id > '1' && $course->id !=  $kalenderA->id ) 
		{
			$this->content->items[] = '&#9679; <a href="'.$CFG->wwwroot.'/grade/report/user/index.php?id='.$course->id.'">Cijfers</a>' ;
		}
		
		//-----/ ZELFSTANDIG LEREN
		//----- MIJN PROJECTEN
		
        $this->content->items[] = '<br><span style="font-size: large; color: #CC04CC;">Mijn projecten</span>';
		
		if (empty($CFG->disablemycourses) and isloggedin() and !isguestuser() and !(has_capability('moodle/course:update', $system_context) and $adminseesall)) {    // Just print My Courses
			if ($courses = enrol_get_my_courses(NULL, 'visible DESC, fullname ASC')) {
					foreach ($courses as $course) {
						if($course->visible == '1' && $course->id !=  $kalenderA->id) {		
						$this->content->items[]="&#9679; <a $linkcss title=\"" . format_string($course->shortname, true, array('context' => $coursecontext)) . "\" "."href=\"$CFG->wwwroot/course/view.php?id=$course->id\">".$icon.format_string($course->fullname). "</a>";
						}
					}
			}
		}
		
		//-----/ MIJN PROJECTEN	

		//----- BEHEER
		
		if (has_capability('moodle/course:create',context_course::instance($course->id))) {    // Show beheer
			$this->content->items[] = '<br><span style="font-size: large; color: #BBBBBB;">Beheer</span>';
			$this->content->items[] = '&#9679; <a href="'.$CFG->wwwroot.'/admin/user.php">Gebruikers</a>';
			$this->content->items[] = '&#9679; <a href="'.$CFG->wwwroot.'/admin/roles/assign.php?contextid=1">Rollen</a>';
			$this->content->items[] = '&#9679; <a href="'.$CFG->wwwroot.'/course/index.php?categoryedit=on">Projecten</a>' ;
			if( $course->id > '1' && $course->id !=  $kalenderA->id)
				{
					$this->content->items[] = '&#9679; <a href="'.$CFG->wwwroot.'/enrol/users.php?id='.$COURSE->id.'">Aanmelden</a>' ;
				}
		}
		//-----/ BEHEER	
		
		return $this->content;

    }

		  
	//-----/
	
	//-----
    function applicable_formats() 
	{
		//-----
        return array(	'all' 	=> true, 
						'mod' 	=> false, 
						'my' 	=> false, 
						'admin' => false,
						'tag' 	=> false ) ;
		//------/				
    }
	
	//-----/
	
	
}
//-----/20120812 101600 ONEC

?>
