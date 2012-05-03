<?php // $Id: groepsrechtenW.php,v 1.194.2.19 2009/02/04 09:15:06 tjhunt Exp $


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
	$prefix 			= $_POST['prefix'] ;
	$cursus_id 			= $_GET['id'] ;	
	$courseid 			= $_POST['courseid'] ;
	$course_id 			= $_POST['course_id'] ; 
	$module_naam 		= $_POST['module_naam'] ;	// echo $module_naam ;
	$instance_id  		= $_POST['instance_id'] ;
	$gemelden 			= $_POST['gemelden'] ;
	
	// echo $_POST['visible_id'] ;
	if ( $_POST['visible_id'] == '1' )
	{
		$visible_id = '1'; 
	}
	else
	{
		$visible_id = '0'; 
	}	
	//-----/
	
	$rol_id1 			= zoek_student_nl($cursus_id, $prefix) ;   		// 	echo  $rol_id1 ;
	$rol_id2 			= zoek_student_nl_id($rol_id1, $prefix) ;	  	//	echo $rol_id2 ;	
	$context 			= get_context_instance(CONTEXT_COURSE, $cursus_id) ;

	/*
	|
	| zoekt leerlingen bij cursus
	| table => user
	| table => role_assignments
	|
	*/
	//-----	
	for ($x=0; $x<sizeof($gemelden); $x++) 
	{
		// $gemelden[$x]	
		$student_id 		=  $gemelden[$x] ;
		$checkrg 			= '' ;		
		$checkrg 			= check_role_groepen($student_id, $course_id, $module_naam, $instance_id, $prefix) ;
		$id_role_groep		= id_role_groepen($student_id, $course_id, $module_naam, $instance_id, $prefix) ;		
		 // echo $id_role_groep .' '; ;
		
		if ( '1' === $checkrg )
		{
		/*
		|
		| afhandelen update
		|
		*/		
			$vraag_upd = "UPDATE `".$_POST['prefix']."role_groepen` 
							SET `student_id` 	= '".$student_id."',
							`course_id` 		= '".$course_id."',
							`module_naam` 		= '".$module_naam."',
							`instance_id` 		= '".$instance_id."',
							`visible_id`		= '".$visible_id."',
							`datum_in` 			= '1',
							`datum_uit` 		= '1' 
							WHERE `id` 			= '".$id_role_groep."' LIMIT 1 ; " ; 
								// echo $vraag_upd .'<br />' ;
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
		$vraag_ins = "INSERT INTO `".$_POST['prefix']."role_groepen`  (
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
		$res = get_records_sql($vraag_ins, $limitfrom='', $limitnum='')  ;
		//-----/afhandelen insert
		}			
	} 
	//-----/zoekt leerlingen bij cursus

	
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
	}
	else
	{
		header('Location: groepsrechten.php?id='.$_POST['course_id']) ;
	}
	//-----/
	
?>