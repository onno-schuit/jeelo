<?php

	/*
		Wijst students toe
	*/
	$students[] = $r_a2_item->ra_userid ;
	//-----	
	echo '<tr>'."\n";
	echo '<td> &nbsp; </td>'."\n";

	$vraag_cm2 = 'select id, module, instance, course 
					from '.$prefix.'course_modules 
					where course = '.$cursus_id.'
					order by `id` asc ' ;   

	$res_cm2 = get_records_sql($vraag_cm2, $limitfrom='', $limitnum='')  ;

	foreach ( $res_cm2 as $cm2_item ) 
	{
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
		echo '<input type="checkbox" name="visible_id"  	value="1">'."\n" ;			
		echo ' &nbsp; <input type="submit" name="wijzig" 	value="allemaal">'."\n";	
		echo '</form>'."\n";
		echo '</td>'."\n";				
	} // aantal modules

?>