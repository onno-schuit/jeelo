<?php // $Id: groepsrechtenW.php,v 1.194.2.19 2009/02/04 09:15:06 tjhunt Exp $

require_once('../config.php');
require_once($CFG->libdir.'/tablelib.php');

	/*
	|
	| afhandelen visible_id
	|
	*/
	if ( $_POST['visible_id'] == '1' )
	{
		$visible_id = '1'; 
	}
	else
	{
		$visible_id = '0'; 
	}
	//-----/visible_id

	
	/*
	|
	| afhandelen update
	|
	*/
	if ( $_POST['id'] > '0' )
	{	
		$vraag_upd = "UPDATE `".$_POST['prefix']."role_groepen` 
						SET `student_id` 	= '".$_POST['student_id']."',
						`course_id` 		= '".$_POST['course_id']."',
						`module_naam` 		= '".$_POST['module_naam']."',
						`instance_id` 		= '".$_POST['instance_id']."',
						`visible_id`		= '".$visible_id."',
						`datum_in` 			= '1',
						`datum_uit` 		= '1' 
						WHERE `".$_POST['prefix']."role_groepen`.`id` = '".$_POST['id']."' LIMIT 1 ; " ; 

		$res = get_records_sql($vraag_upd, $limitfrom='', $limitnum='')  ;	
	}
	else
	/*
	|
	| afhandelen insert
	|
	*/	
	{
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
						'".$_POST['student_id']."', 
						'".$_POST['course_id']."', 
						'".$_POST['module_naam']."', 
						'".$_POST['instance_id']."',
						'".$visible_id."', 
						'1', 
						'1'
						);" ; 

		$res = get_records_sql($vraag_ins, $limitfrom='', $limitnum='')  ;		
	}
	//-----/	
	

/* ===============================================
|
|	afhandelen fouten / header
|
=================================================*/
	//-----
	$check = '0' ; // 0  =>  geen check 	;	1  =>  wel check
	if ( '1' == $check )
	{
		if ( $_POST['id'] > '0' )
		{
			echo $vraag_upd .'<br />'.$res ;
		}
		else
		{		
			echo $vraag_ins .'<br />'.$res ;
		}	
		echo '<br /><form><input type="button" value="Vorige pagina" onclick="history.back()" /></form>';		
	}
	else
	{
		header('Location: groepsrechten.php?id='.$_POST['course_id']) ;
	}
	//-----/
?>