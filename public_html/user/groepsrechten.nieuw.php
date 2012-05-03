<?PHP // $Id: groepsrechten.php,v 1.194.2.19 2009/02/04 09:15:06 tjhunt Exp $

//  Lists all the users within a given course

    require_once('../config.php');
    require_once($CFG->libdir.'/tablelib.php');

    define('USER_SMALL_CLASS', 20);   // Below this is considered small
    define('USER_LARGE_CLASS', 200);  // Above this is considered large
    define('DEFAULT_PAGE_SIZE', 20);
    define('SHOW_ALL_PAGE_SIZE', 5000);

    $page         = optional_param('page', 0, PARAM_INT);                     // which page to show
    $perpage      = optional_param('perpage', DEFAULT_PAGE_SIZE, PARAM_INT);  // how many per page
    $mode         = optional_param('mode', NULL);                             // '0' for less details, '1' for more
    $accesssince  = optional_param('accesssince',0,PARAM_INT);                // filter by last access. -1 = never
    $search       = optional_param('search','',PARAM_CLEAN);
    $roleid       = optional_param('roleid', 0, PARAM_INT);                   // optional roleid, -1 means all site users on frontpage

    $contextid    = optional_param('contextid', 0, PARAM_INT);                // one of this or
    $courseid     = optional_param('id', 0, PARAM_INT);                       // this are required

	$gemelden 	  = array();
	$i 			  = '0' ;
		
    if ($contextid) 
	{
        if (! $context = get_context_instance_by_id($contextid)) {
            error("Context ID is incorrect");
        }
        if (! $course = get_record('course', 'id', $context->instanceid)) {
            error("Course ID is incorrect");
        }
    } 
	else 
	{
        if (! $course = get_record('course', 'id', $courseid)) 
		{
            error("Course ID is incorrect");
        }
        if (! $context = get_context_instance(CONTEXT_COURSE, $course->id)) 
		{
            error("Context ID is incorrect");
        }
		/*
		else
		{
			echo '<pre>';
			print_r( $context ) ;
			echo '</pre>';			
		}
		*/
    }
    // not needed anymore
	
	unset($contextid);
    unset($courseid);
	
    require_login($course);

    $sitecontext 	= get_context_instance(CONTEXT_SYSTEM);
    $frontpagectx 	= get_context_instance(CONTEXT_COURSE, SITEID);

    if ($context->id != $frontpagectx->id) 
	{
        require_capability('moodle/course:viewparticipants', $context);
    } 
	else 
	{
        require_capability('moodle/site:viewparticipants', $sitecontext);
        // override the default on frontpage
        $roleid = optional_param('roleid', -1, PARAM_INT);
    }

	// echo $context->id ;
	
    /// front page course is different
    $rolenames = array();
    $avoidroles = array();

    if ($roles = get_roles_used_in_context($context, true)) 
	{
        // We should ONLY allow roles with moodle/course:view because otherwise we get little niggly issues
        // like MDL-8093
        // We should further exclude "admin" users (those with "doanything" at site level) because
        // Otherwise they appear in every participant list

        $canviewroles    = get_roles_with_capability('moodle/course:view', CAP_ALLOW, $context);
        $doanythingroles = get_roles_with_capability('moodle/site:doanything', CAP_ALLOW, $sitecontext);

        if ($context->id == $frontpagectx->id) {
            //we want admins listed on frontpage too
            foreach ($doanythingroles as $dar) {
                $canviewroles[$dar->id] = $dar;
            }
            $doanythingroles = array();
        }

        foreach ($roles as $role) {
            if (!isset($canviewroles[$role->id])) {   // Avoid this role (eg course creator)
                $avoidroles[] = $role->id;
                unset($roles[$role->id]);
                continue;
            }
            if (isset($doanythingroles[$role->id])) {   // Avoid this role (ie admin)
                $avoidroles[] = $role->id;
                unset($roles[$role->id]);
                continue;
            }
            $rolenames[$role->id] = strip_tags(role_get_name($role, $context));   // Used in menus etc later on
        }
    }

    if ($context->id == $frontpagectx->id and $CFG->defaultfrontpageroleid) {
        // default frontpage role is assigned to all site users
        unset($rolenames[$CFG->defaultfrontpageroleid]);
    }

    // no roles to display yet?
    // frontpage course is an exception, on the front page course we should display all users
    if (empty($rolenames) && $context->id != $frontpagectx->id) {
        if (has_capability('moodle/role:assign', $context)) {
            redirect($CFG->wwwroot.'/'.$CFG->admin.'/roles/assign.php?contextid='.$context->id);
        } else {
            error ('No participants found for this course');
        }
    }

    add_to_log($course->id, 'user', 'view all', 'index.php?id='.$course->id, '');

    $bulkoperations = has_capability('moodle/course:bulkmessaging', $context);

    $countries = get_list_of_countries();

    $strnever = get_string('never');

    $datestring->year  = get_string('year');
    $datestring->years = get_string('years');
    $datestring->day   = get_string('day');
    $datestring->days  = get_string('days');
    $datestring->hour  = get_string('hour');
    $datestring->hours = get_string('hours');
    $datestring->min   = get_string('min');
    $datestring->mins  = get_string('mins');
    $datestring->sec   = get_string('sec');
    $datestring->secs  = get_string('secs');

    if ($mode !== NULL) 
	{
        $SESSION->userindexmode = $fullmode = ($mode == 1);
    } 
	else if (isset($SESSION->userindexmode)) 
	{
        $fullmode = $SESSION->userindexmode;
    } 
	else 
	{
        $fullmode = false;
    }

/// Check to see if groups are being used in this course
/// and if so, set $currentgroup to reflect the current group

    $groupmode    = groups_get_course_groupmode($course);   // Groups are being used
    $currentgroup = groups_get_course_group($course, true);

    if (!$currentgroup) 
	{      // To make some other functions work better later
        $currentgroup  = NULL;
    }

    $isseparategroups = ($course->groupmode == SEPARATEGROUPS and $course->groupmodeforce and !has_capability('moodle/site:accessallgroups', $context));

    if ($isseparategroups and (!$currentgroup) ) 
	{
        $navlinks = array();
        $navlinks[] = array('name' => get_string('participants'), 'link' => null, 'type' => 'misc');
        $navigation = build_navigation($navlinks);

        print_header("$course->shortname: ".get_string('participants'), $course->fullname, $navigation, "", "", true, "&nbsp;", navmenu($course));
        print_heading(get_string("notingroup"));
        print_footer($course);
        exit;
    }

    // Should use this variable so that we don't break stuff every time a variable is added or changed.
   $baseurl = $CFG->wwwroot.'/user/index.php?contextid='.$context->id.'&amp;roleid='.$roleid.'&amp;id='.$course->id.'&amp;perpage='.$perpage.'&amp;accesssince='.$accesssince.'&amp;search='.s($search);

/// Print headers

    $navlinks = array();
    $navlinks[] = array('name' => get_string('participants'), 'link' => null, 'type' => 'misc');
    $navigation = build_navigation($navlinks);

    print_header("$course->shortname: ".get_string('participants'), $course->fullname, $navigation, "", "", true, "&nbsp;", navmenu($course));
	
/// setting up tags
    if ($course->id == SITEID) 
	{
        $filtertype = 'site';
    } 
	else if ($course->id && !$currentgroup) 
	{
        $filtertype = 'course';
        $filterselect = $course->id;
    } 
	else 
	{
        $filtertype = 'group';
        $filterselect = $currentgroup;
    }

    // we are looking for all users with this role assigned in this context or higher
    if ($usercontexts = get_parent_contexts($context)) 
	{
        $listofcontexts = '('.implode(',', $usercontexts).')';
    } 
	else 
	{
        $listofcontexts = '('.$sitecontext->id.')'; // must be site
    }
	
    if ($roleid > 0 ) 
	{
        $selectrole = " AND r.roleid = ".$roleid ;
    } 
	else 
	{
        $selectrole = " ";
    }

	
    // $currenttab = 'participants';
	$currenttab = 'groepsrechten';   
	
	$user = $USER;

        $select = "SELECT DISTINCT u.id, u.username, u.firstname, u.lastname,                       
					ctx.id AS ctxid, ctx.path AS ctxpath,
					ctx.depth AS ctxdepth, ctx.contextlevel AS ctxlevel" ;

		$from   = "FROM ".$CFG->prefix."user u
					LEFT OUTER JOIN ".$CFG->prefix."context ctx
					ON (u.id=ctx.instanceid AND ctx.contextlevel = ".CONTEXT_USER.")
					JOIN ".$CFG->prefix."role_assignments r
					ON u.id=r.userid
					LEFT OUTER JOIN ".$CFG->prefix."user_lastaccess ul
					ON (r.userid=ul.userid and ul.courseid = ".$course->id.") ";

        $where  = "WHERE (r.contextid = ".$context->id." OR r.contextid in ".$listofcontexts.")
					AND u.deleted = 0 ".$selectrole."
					AND (ul.courseid = ".$course->id." OR ul.courseid IS NULL)
					AND u.username != 'guest' 
					AND r.roleid NOT IN (1)
					AND r.roleid = '5'  ";

		$sort 	= ' ORDER BY ctx.id ASC';


					
	$vraag_basis = $select.' '.$from.' '.$where.' '.$sort ;
	
	$check_vwc = '0' ; //	0 	=>	niet zichtbaar  ;	1	=>	wel zichtbaar
	if ( '1' == $check_vwc )
	{
		echo '<br />';
		echo $select."<br />\n";	
		echo $from."<br />\n";
		echo $where."<br />\n";	
		echo $sort."<br />\n";	
	}
 
	require_once($CFG->dirroot .'/user/tabs.php');

	
// ============================================================================
//

	/*
	|
	| Wijst global vars toe
	|
	*/
	$prefix 		= $CFG->prefix ;
	$cursus_id 		= $filterselect ;
	//-----		

	echo '<br />';

	echo '<table border="1" cellspacing="5" cellpadding="5" summary="">'."\n" ;
	echo '<tr>'."\n";
	echo '<td class="tdvwc"> Naam </td>'."\n";
	echo '<td> &nbsp; </td>'."\n";	
	
	/*
	|
	| zoekt leerlingen bij cursus
	| table => user
	| table => role_assignments
	|
	*/	
	//-----		
	$resultaat1 = get_records_sql($vraag_basis, $limitfrom='', $limitnum='')  ;
	
	foreach ( $resultaat1 as $r_a_item ) 
	{				
		echo '<td class="tdvwc">';
		echo $r_a_item->firstname .'<br />'. $r_a_item->lastname ;
		/*
			Wijst $gemelden[$i]  toe
		*/
		$gemelden[$i] 		= $r_a_item->id ;	
		$i++ ;	
		
		echo '<br />';
		echo '<form action="groepsrechten3W.php" method="post">'."\n" ;
		echo '<input type="hidden" name="student_id" 	value="'.$r_a_item->id.'">'."\n" ; 				  // echo $r_a_item->id ;				
		echo '<input type="hidden" name="course_id" 	value="'.$cursus_id.'">'."\n" ;  				  // echo $cursus_id ;
		echo '<input type="hidden" name="module_naam" 	value="'.$naam_module.'">'."\n" ;  				  // echo $naam_module ;	
		echo '<input type="hidden" name="instance_id" 	value="'.$cm_item->instance.'">'."\n" ; 		  // echo $cm_item->instance ;
		echo '<input type="hidden" name="prefix" 		value="'.$prefix.'">'."\n" ; 					  // echo $prefix ;
		echo '<input type="checkbox" name="visible_id"  value="1" class="itvwc">'."\n" ;
		echo '<input type="hidden" name="id" value="'.$value_i.'">'."\n" ; 	 // echo $value_i ;	
		echo ' &nbsp; <input type="submit" name="wijzig" value="Ok" class="itvwc">'."\n";	
		echo '</form>'."\n";			
		echo '</td>'."\n";
	}	
	
	echo '</tr>'."\n";
		
	$vraag_cmn = 'select cm.id, cm.module, cm.instance, m.name as mod_naam
					from '.$prefix.'course_modules as cm
					left join '.$prefix.'modules as m
					on cm.module = m.id
					where cm.course = '.$cursus_id.'
					order by `id` asc ' ; 

	$res_cmn = get_records_sql($vraag_cmn, $limitfrom='', $limitnum='')  ;

	foreach ( $res_cmn as $cmn_item ) 
	{
		echo '<tr>'."\n";	
		echo '<td class="tdvwc">'."\n" ;
		echo naam_mod($cmn_item->mod_naam, $cmn_item->instance, $prefix) ;
		echo '</td>'."\n";	

		/*
			Wijst students toe
		*/		
		$naam_module 	= naam_module($cm2_item->module, $prefix) ;	
		$value 			= vrg($naam_module, $student_id, $cursus_id, $cm2_item->instance, $prefix) ;
		$value_i 		= irg($naam_module, $student_id, $cursus_id, $cm2_item->instance, $prefix) ;
		
		echo '<td>'."\n" ;
		echo '<form action="groepsrechten2W.php?id='.$cursus_id.'"  method="post">'."\n" ;
		echo '<input type="hidden" name="courseid" 			value="'.$cursus_id.'">'."\n" ;  				// echo $cursus_id ;
		echo '<input type="hidden" name="course_id" 		value="'.$cursus_id.'">'."\n" ;  				// echo $cursus_id ;
		echo '<input type="hidden" name="module_naam" 		value="'.$naam_module.'">'."\n" ;  				// echo naam_module($cm2_item->module, $prefix) ;	
		echo '<input type="hidden" name="instance_id" 		value="'.$cm2_item->instance.'">'."\n" ; 		// echo $cm2_item->instance ;
		echo '<input type="hidden" name="prefix" 			value="'.$prefix.'">'."\n" ; 					// echo $prefix ;
		for ($x=0; $x<sizeof($gemelden); $x++) 
		{
			echo '<input type="hidden" name="gemelden[]" 	value="'.$gemelden[$x].'">'."\n" ; 				// print_r($gemelden) ;	
		}		
		echo '<input type="checkbox" name="visible_id"  	value="1" class="itvwc">'."\n" ;			
		echo ' &nbsp; <input type="submit" name="wijzig" 	value="A" class="itvwc">'."\n";	
		echo '</form>'."\n";
		echo '</td>'."\n";
		//-----
		
		$vraag_cm = 'select id, module, instance, course 
						from '.$prefix.'course_modules 
						where course = '.$cursus_id.'
						and module = '. $cmn_item->module.'
						and instance = '. $cmn_item->instance.'
						order by `id` asc ' ;   

		$res_cm = get_records_sql($vraag_cm, $limitfrom='', $limitnum='')  ;
	
		foreach ( $res_cm as $cm_item ) 
		{
			$naam_module 	= naam_module($cm_item->module, $prefix) ;	
			$value 			= vrg($naam_module, $r_a_item->id, $cursus_id, $cm_item->instance, $prefix) ;
			$value_i 		= irg($naam_module, $r_a_item->id, $cursus_id, $cm_item->instance, $prefix) ;
			
			echo '<td>'."\n" ;
			echo '<form action="groepsrechtenW.php" method="post">'."\n" ;
			echo '<input type="hidden" name="student_id" 	value="'.$r_a_item->id.'">'."\n" ; 				 // echo $r_a_item->id ;				
			echo '<input type="hidden" name="course_id" 	value="'.$cursus_id.'">'."\n" ;  				 // echo $cursus_id ;
			echo '<input type="hidden" name="module_naam" 	value="'.$naam_module.'">'."\n" ;  				 // echo $naam_module ;	
			echo '<input type="hidden" name="instance_id" 	value="'.$cm_item->instance.'">'."\n" ; 		 // echo $cm_item->instance ;
			echo '<input type="hidden" name="prefix" 		value="'.$prefix.'">'."\n" ; 					 // echo $prefix ;
			//		
			echo '<input type="checkbox" name="visible_id" ';
			if ( '1' == $value )
			{
				echo 'checked  ';
			}
			echo 'value="1" class="itvwc">'."\n" ;
			echo '<input type="hidden" name="id" value="'.$value_i.'">'."\n" ; 	 // echo $value_i ;	
			if ( '1' == $value )
			{
				echo ' &nbsp; <input type="submit" name="wijzig" value="1" class="itvwc">'."\n";	
			}
			else
			{
				echo ' &nbsp; <input type="submit" name="wijzig" value="0" class="itvwc">'."\n";				
			}
			echo '</form>'."\n";
			echo '</td>'."\n";				
		} // aantal modules	
		
		
		echo '</tr>'."\n";	
	} // naam modules		
	
	echo '</table>'."\n" ;	
	//-----

	
/* ========================================================================
|
| functies 
|
 ======================================================================== */		

	/*
	|
	| function rechten_groep => $student_id $course_id $module_id $prefix) 
	|
	*/	
	// rechten_groep($u_id, $cursus_id, $cm[$teller], $prefix)
	//-----
	function rechten_groep($student_id, $course_id, $module_id, $prefix) 
	{
			$vraag = 'select id, visible, datum_in, datum_uit 
						from '.$prefix.'role_groepen 
						where student_id = '.$student_id.'
						and course_id = '.$course_id.' 
						and module_id = '.$module_id.' ' ; 

			$resultaat = get_records_sql($vraag, $limitfrom='', $limitnum='')  ;
			
			if ( $resultaat )
			{
				foreach ( $resultaat as $item) 
				{
					return $item->visible ;				
				}
			}
			else
			{
				return '0' ;
			}
	}
	//-----/rechten_groep 

	
	/*
	|
	| function naam_gebruiker => $id  $prefix
	|
	*/	
	// echo naam_gebruiker($r_a_item->ra_userid, $CFG->prefix) ;		
	//-----
	function naam_gebruiker($id, $prefix) 
	{
			$vraag = 'select id, username from '.$prefix.'user where id = '.$id.' ' ; 

			$resultaat = get_records_sql($vraag, $limitfrom='', $limitnum='')  ;
			
			foreach ( $resultaat as $item) 
			{
				return $item->username ;				
			}
	}
	//-----/naam_gebruiker


	/*
	|
	| function naam_module => $id  $prefix
	|
	*/	
	//-----
	function naam_module($id, $prefix) 
	{
			$vraag = 'select id, name from '.$prefix.'modules where id = '.$id.' ' ; 

			$resultaat = get_records_sql($vraag, $limitfrom='', $limitnum='')  ;
			
			foreach ( $resultaat as $item) 
			{
				return $item->name ;				
			}
	}
	//-----/naam_module

	/*
	|
	|	ncm => $id  $prefix
	| 	naam course module 
	|
	*/	
	//-----
	function ncm($id, $prefix) 
	{
			$vraag = "select distinct module from ".$prefix."course_modules where course = '".$id."' ;" ; 
			// echo $vraag ;
			$resultaat = get_records_sql($vraag, $limitfrom='', $limitnum='')  ;
			
			$ncm = '' ;
			
			if ( $resultaat )
			{
				foreach ( $resultaat as $item ) 
				{
					$ncm[] =  $item->name ;				
				}
			}
			else
			{
				$ncm = '' ;
			}
			
		return $ncm	;
	}
	//-----/ncm



	/*
	|
	|	acm => 	$id $id2 $prefix
	| 	zoek aantal cursus modules	
	|
	*/
	//-----	
	function acm($id, $id2, $prefix) 
	{	
		$vraag = "select count(`id`) as aantal 
						from ".$prefix."course_modules 
						where `course` = '".$id."' 
						and `module` = '".$id2."' " ; 
					// echo '<br />'.$vraag.'<br />' ;
		$res = get_records_sql($vraag, $limitfrom='', $limitnum='')  ;			
		if ( $res )
		 {
			foreach ( $res as $item) 
			{
				return $item->aantal ;		
			}
		}
		else
		{
			return '0';
		}
	}
	//-----/acm
	
	/*
	|
	| function vrg	=>	$id $id2 $id3 $id4 $prefix 
	| visible_id role groepen	
	|
	*/	
	//-----
	function      vrg($id,            $id2,               $id3,           $id4,                    $prefix) 
	{
		$vraag_vrg = "select visible_id from ".$prefix."role_groepen 
						where student_id = '".$id2."'
						and course_id = '".$id3."'
						and module_naam = '".$id."'
						and instance_id = '".$id4."' ; " ; 
			    //echo $vraag_vrg.'<br />' ; ;
		$resultaat_vrg = get_records_sql($vraag_vrg, $limitfrom='', $limitnum='')  ;
		
		
		if ( $resultaat_vrg )
		{
			foreach ( $resultaat_vrg as $item_vrg) 
			{
				return $item_vrg->visible_id ;				
			}
		}
		else
		{
			return '0' ;
		}
	}
	//-----/vrg

	
	/*
	|
	| function vrg	=>	$id $id2 $id3 $id4 $prefix 
	| visible_id role groepen	
	|
	*/	
	//-----
	function      irg($id,            $id2,               $id3,           $id4,                    $prefix) 
	{
		$vraag_irg = "select id from ".$prefix."role_groepen 
						where student_id = '".$id2."'
						and course_id = '".$id3."'
						and module_naam = '".$id."'
						and instance_id = '".$id4."' ; " ; 
			   // echo $vraag_irg ;
		$resultaat_irg = get_records_sql($vraag_irg, $limitfrom='', $limitnum='')  ;		
		
		if ( $resultaat_irg )
		{
			foreach ( $resultaat_irg as $item_irg) 
			{
				return $item_irg->id ;				
			}
		}
		else
		{
			return '0' ;
		}
	}
	//-----/irg

	
	/*
	|
	|	naam_mod => 	$id $id2 $prefix
	| 	naam cursus modules	
	|
	*/
	//-----	
	// select name from ".$prefix.$cmn_item->mod_naam." where  id = '".$cmn_item->instance."' ;" ;	
	function naam_mod($id, $id2, $prefix) 
	{	
		$vraag_mod = "select name 
						from ".$prefix.$id." 
						where `id` = '".$id2."' ; " ; 
					// echo '<br />'.$vraag.'<br />' ;
		$res_mod = get_records_sql($vraag_mod, $limitfrom='', $limitnum='')  ;			
		foreach ( $res_mod as $item_mod) 
		{
			return $item_mod->name ;		
		}
	}
	//-----/naam_mod

	
//-----//location /user/groepsrechten.php	
?>