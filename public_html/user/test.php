<?php
		
		for ( $teller = '0'; $teller < $cm_i; $teller++ )
		{
			echo '<td>';
			echo $cm[$teller].'&nbsp;'  ;

			echo '</td>'."\n";				
		}







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

		
?>		