<?php // $Id: groepsrechten3W.php,v 1.194.2.19 2009/02/04 09:15:06 tjhunt Exp $


//  Lists all the users within a given course

    require_once('../config.php');
    require_once($CFG->libdir.'/tablelib.php');

	
// ============================================================================
//


	/*
	|
	| Wijst global vars toe
	|
	*/
	$upd 				= '0';	
	$ins 				= '0'; 	
	$prefix 			= $_POST['prefix'] ;							// echo $prefix.'<br />';
	$course_id 			= $_POST['course_id'] ; 						// echo $course_id.'<br />';	
	$courseid 			= $_POST['courseid'] ;							// echo $courseid.'<br />';
	$student_id			= $_POST['student_id'] ;						// echo $student_id.'<br />';
	if ( $_POST['visible_id'] == '1' )
	{
		$visible_id = '1'; 
	}
	else
	{
		$visible_id = '0'; 
	}	
																		// echo $visible_id.'<br />';
	//-----/
	
	$rol_id1 			= zoek_student_nl($cursus_id, $prefix) ;   		// 	echo  $rol_id1 ;
	$rol_id2 			= zoek_student_nl_id($rol_id1, $prefix) ;	  	//	echo $rol_id2 ;	

	$vraag_sec = 'select `section`, `sequence`
					from `'.$prefix.'course_sections`
					where `course` = '.$course_id.'
					order by `section` asc ' ;  
						// echo $vraag_sec ;
	$res_sec = get_records_sql($vraag_sec, $limitfrom='', $limitnum='')  ;

	//-----Uitlezen sequences
	foreach ( $res_sec as $sec_sequence ) 
	{
		$items = '' ;
		$items = explode(',', $sec_sequence->sequence );
		
		for ($i = '0'; $i < sizeof($items); $i++) 
		{ 			
				$sequence_id 		= $items[$i] ;
				$tabel_id 			= id_course_module($sequence_id, $prefix) ;
				$module_naam 		= naam_module($tabel_id, $prefix) ;
				$instance_id 		= instance_module($sequence_id, $prefix) ;	
				$checkrg 			= '' ;		
				$checkrg 			= check_role_groepen($student_id, $course_id, $module_naam, $instance_id, $prefix) ;
				$id_role_groep		= id_role_groepen($student_id, $course_id, $module_naam, $instance_id, $prefix) ;
		
				if ( '1' === $checkrg )
				{
					/*
					|
					| afhandelen update
					|
					*/		
						$vraag_upd = "UPDATE `".$prefix."role_groepen` 
										SET `student_id` 	= '".$student_id."',
										`course_id` 		= '".$course_id."',
										`module_naam` 		= '".$module_naam."',
										`instance_id` 		= '".$instance_id."',
										`visible_id`		= '".$visible_id."',
										`datum_in` 			= '1',
										`datum_uit` 		= '1' 
										WHERE `id` 			= '".$id_role_groep."' LIMIT 1 ; " ; 
											// echo $vraag_upd .'<br />' ;
										$upd++ ;	
						$res = get_records_sql($vraag_upd, $limitfrom='', $limitnum='')  ;
					//-----/afhandelen update			
				}
				elseif( '0' === $checkrg  )
				{
					/*
					|
					| afhandelen insert
					|
					*/		
					$vraag_ins = "INSERT INTO `".$prefix."role_groepen`  (
									`id` ,
									`student_id` ,
									`course_id` ,
									`module_naam` ,
									`instance_id` ,
									`visible_id` ,
									`datum_in` ,
									`datum_uit`
									)
									VALUES (
									NULL , 
									'".$student_id."', 
									'".$course_id."', 
									'".$module_naam."', 
									'".$instance_id."',
									'".$visible_id."', 
									'1', 
									'1'
									);" ; 
										 // echo $vraag_ins .'<br />' ;
									$ins++ ;	 
					$res = get_records_sql($vraag_ins, $limitfrom='', $limitnum='')  ;
					//-----/afhandelen insert
				}	
	
		}		
	} 					
	//-----/Uitlezen sequences
	


	
/* ===============================================
|
|	Functies
|
=================================================*/
		
	/*
	|
	| zoek zoek_student_nl
	|
	*/
	function zoek_student_nl($id, $prefix)
	{
		$vraag_1 = "select c.student  
					from ".$prefix."course as c
					where c.id = '".$id."'  " ; 
						// echo $vraag_1 ;
		$res1 = get_records_sql($vraag_1, $limitfrom='', $limitnum='')  ;
		//
		foreach ( $res1 as $item1 ) 
		{
			return $item1->student ;	
		}
	}
	//-----/zoek_student_nl


	/*
	|
	| zoek zoek_student_nl_id
	|
	*/
	function zoek_student_nl_id($id1, $prefix)
	{
		$vraag_2 = "select `id`  
					from `".$prefix."role` 
					where `shortname` = 'student'  " ; 
						// echo $vraag_2 ;
		$res2 = get_records_sql($vraag_2, $limitfrom='', $limitnum='')  ;
		//
		foreach ( $res2 as $item2 ) 
		{
			return $item2->id ;	
		}
	}
	//-----//zoek_student_nl_id
	
	/*
	|
	| zoek visible_id role_groepen
	|
	*/
	function check_role_groepen($student_id, $course_id, $module_naam, $instance_id, $prefix)
	{
		$vraag_3 = "select `visible_id` from `".$prefix."role_groepen`
					where `student_id` 	= '".$student_id."'
					and	`course_id` 	= '".$course_id."'
					and `module_naam`	= '".$module_naam."'
					and `instance_id`	= '".$instance_id."' ; ";
					 // echo $vraag_3.'<br />' ;
		$res3 = get_records_sql($vraag_3, $limitfrom='', $limitnum='')  ;
		//
		if ( $res3 )
		{			
			return '1' ;	
		}		
		else
		{
			return '0' ;			
		}
	}
	//-----//check_role_groepen


	/*
	|
	| zoek id role_groepen
	|
	*/
	function id_role_groepen($student_id, $course_id, $module_naam, $instance_id, $prefix)
	{
		$vraag_4 = "select `id` from `".$prefix."role_groepen`
					where `student_id` 	= '".$student_id."'
					and	`course_id` 	= '".$course_id."'
					and `module_naam`	= '".$module_naam."'
					and `instance_id`	= '".$instance_id."' ; ";
					 // echo $vraag_4.'<br />' ;
		$res4 = get_records_sql($vraag_4, $limitfrom='', $limitnum='')  ;
		//
		if ( $res4 )
		{			
			foreach ( $res4 as $item4 ) 
			{
				return $item4->id ;	
			}	
		}		
		else
		{
			return '0' ;			
		}
	}
	//-----//id_role_groepen
	
	/*
	|
	| function naam_corurse_module => $id  $prefix
	|
	*/	
	//-----
	function id_course_module($id, $prefix) 
	{
			$vraag = 'select module 
						from '.$prefix.'course_modules 
						where id = '.$id.' ' ; 
						// echo $vraag ;	
			$resultaat = get_records_sql($vraag, $limitfrom='', $limitnum='')  ;
			
			foreach ( $resultaat as $item) 
			{
				return $item->module ;				
			}
	}
	//-----/naam_course_module

	
	/*
	|
	| function name_module => $id $id2 $prefix
	|
	*/	
	//-----
	function name_module($id1, $id2, $prefix) 
	{
			$vraag = "select `name` 
						from ".$prefix.$id1." 
						where `id` = '" .$id2."' " ; 
						 // echo $vraag ;	
			$resultaat = get_records_sql($vraag, $limitfrom='', $limitnum='')  ;
			
			foreach ( $resultaat as $item) 
			{
				return $item->name ;				
			}
	}
	//-----/name_module	
	
	/*
	|
	| function instance_module => $id  $prefix
	|
	*/	
	//-----
	function instance_module($id, $prefix) 
	{
			$vraag = 'select instance 
						from '.$prefix.'course_modules 
						where id = '.$id.' ' ; 
						// echo $vraag ;	
			$resultaat = get_records_sql($vraag, $limitfrom='', $limitnum='')  ;
			
			foreach ( $resultaat as $item) 
			{
				return $item->instance ;				
			}
	}
	//-----/instance_module

	/*
	|
	| function name_module => $id $id2 $prefix
	|
	*/	
	//-----
	function name_module2($id1, $id2, $prefix) 
	{
			$vraag = "select `name` 
						from ".$prefix.$id1." 
						where `id` = '" .$id2."' " ; 
						// echo $vraag ;	
			$resultaat = get_records_sql($vraag, $limitfrom='', $limitnum='')  ;
			
			foreach ( $resultaat as $item) 
			{
				return $item->name ;				
			}
	}
	//-----/name_module	

	/*
	|
	| function naam_module => $id  $prefix
	|
	*/	
	//-----
	function naam_module($id, $prefix) 
	{
			$vraag = 'select id, name 
						from '.$prefix.'modules 
						where id = '.$id.' ' ; 

			$resultaat = get_records_sql($vraag, $limitfrom='', $limitnum='')  ;
			
			foreach ( $resultaat as $item) 
			{
				return $item->name ;				
			}
	}
	//-----/naam_module

	/*
	|
	| function naam_module => $id  $prefix
	|
	*/	
	//-----
	function id_module($id, $prefix) 
	{
			$vraag = 'select id, name 
						from '.$prefix.'modules 
						where id = '.$id.' ' ; 

			$resultaat = get_records_sql($vraag, $limitfrom='', $limitnum='')  ;
			
			foreach ( $resultaat as $item) 
			{
				return $item->id ;				
			}
	}
	//-----/naam_module
	
	
/* ===============================================
|
|	afhandelen fouten / header
|
=================================================*/
	//-----
	$check = '0' ; // 0  =>  geen check 	;	1  =>  wel check
	if ( '1' == $check )
	{
		echo '<br />Ok<br />'  ;
		echo 'aantal upd => '.$upd.'<br />'  ;
		echo 'aantal ins&nbsp; => '.$ins.'<br />'  ;	
		echo '<br /><form><input type="button" value="Vorige pagina" onclick="history.back()" /></form>';	
	}
	else
	{
		header('Location: groepsrechten.php?id='.$_POST['course_id']) ;
	}
	//-----/
	
?>