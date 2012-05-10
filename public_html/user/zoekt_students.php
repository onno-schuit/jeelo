<?php

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
		echo '<tr>'."\n";
		echo '<td>';
		echo $r_a_item->firstname .'<br />'. $r_a_item->lastname ;
		/*
			Wijst $gemelden[$i]  toe
		*/
		$gemelden[$i] 		= $r_a_item->id ;	
		$i++ ;	
		
		//-----
		//echo '  '.$r_a_item->id ;
		echo '</td>'."\n";

		$vraag_cm = 'select id, module, instance, course 
						from '.$prefix.'course_modules 
						where course = '.$cursus_id.'
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
			echo 'value="1">'."\n" ;
			echo '<input type="hidden" name="id" value="'.$value_i.'">'."\n" ; 	 // echo $value_i ;						
			echo ' &nbsp; <input type="submit" name="wijzig" value="wijzig">'."\n";	
			echo '</form>'."\n";
			echo '</td>'."\n";				
		} // aantal modules
		
		echo '</tr>'."\n";		
	} // user

?>