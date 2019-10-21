<?php

	// connect to database

	$link = mysql_connect('localhost', 'root', 'bitnami')
    	or die('Could not connect: ' . mysql_error() . '<br>');

	echo 'Connected successfully<br>';

	mysql_select_db('project0') or die('Could not select database<br>');

	// load courses xml file 

	$xml = simplexml_load_file('courses.xml');

	// print_r($xml);  // for debugging 

	$result = $xml->xpath('//course');

	// print_r($result); // for debugging 

	$total = 0; // init

	// if xml file is modified update database

	// if table exists update table

	// $sql2 ="TRUNCATE fas_courses";
	
	// $result3 = mysql_query($sql2);
	// if (!$result3) die('Invalid query: <br>' . mysql_error() . '<br>' . $sql2); // for debugging 

	foreach($result as $c) { 

		// echo $total + 1.'<br>'; // count 

		// echo 	$c['cat_num'].'<br>'.
		// 			$c['offered'].'<br>'.
		// 			$c->department->dept_short_name.'<br>'.
		// 			$c->title.'<br>'.
		// 			$c->description.'<br>'; // debug

		// $s_faculty_list = " ";	// init

		unset($s_faculty_array); // init

		foreach($c->faculty_list->faculty as $f) {

			// $s_faculty_list .= 	$f->name->prefix.' '.
			// 						$f->name->first.' '.
			// 						$f->name->middle.' '.
			// 						$f->name->last.' '.
			// 						$f->name->suffix.'<br>';

			$s_faculty_array[] = 		$f->name->prefix.' '.
										$f->name->first.' '.
										$f->name->middle.' '.
										$f->name->last.' '.
										$f->name->suffix;
		}

		// echo json_encode($s_faculty_array); // debug
		// echo '<br><br>';

		// echo $s_faculty_list; // debug

		$j_faculty = json_encode($s_faculty_array);

		// $s_schedule = " "; // init

		unset($s_meeting_array);

		foreach($c->schedule->meeting as $s) {

			// $s_schedule .= 	$s['day'].' '.
			// 					$s['begin_time'].' '.
			// 					$s['end_time'].'<br>';

			$s_meeting_array[] = array(	'day' => "{$s['day']}", 
							   			'begin_time' => "{$s['begin_time']}", 
							 			'end_time' => "{$s['end_time']}" );
		}

		// echo $s_schedule; 	// debug
		// print_r($s_array);	// debug
		
		// echo json_encode($s_meeting_array); // debug
		// echo '<br><br>';

		$j_meeting = json_encode($s_meeting_array);

		// $s_meeting_locations = " "; // init

		unset($s_location_array);

		foreach($c->meeting_locations->location as $l) {

      		// $s_meeting_locations .= 	$l['building'].' '.
      		//  						$l['room'].'<br>';

      		$s_location_array[] = array( 'building' => "{$l['building']}",
			 							 'room' => "{$l['room']}" );
      	}

      	// print_r($s_location_array);	// debug
      	// echo $s_meeting_locations; 	// debug
		
		// echo json_encode($s_location_array); //debug
		// echo '<br><br>';
  	
  		$j_location = json_encode($s_location_array);

  		// $s_requirements = " "; // init

  		unset($s_requirement_array);

  		foreach($c->requirements->requirement as $r) {

      		// $s_requirements .= 	$r['type'].' '.  		// general education 	
      		//  					$r['name'].'<br>';      // area of study 

      		$s_requirement_array[] = array( 'type' => "{$r['type']}", 		 // general education 	
      		  								'name' => "{$r['name']}");       // area of study 
      	}
      	
      	// echo $s_requirements.'<br>'; 	// debug
      	// print_r($s_requirement_array);	// debug
		
		// echo json_encode($s_requirement_array); // debug
		// echo '<br><br>';

		$j_requirement = json_encode($s_requirement_array);

      	$title = mysql_real_escape_string($c->title);
      	$description = mysql_real_escape_string($c->description);
      	// $faculty_list = mysql_real_escape_string($s_faculty_list);
      	$faculty_list = mysql_real_escape_string($j_faculty);

		// insert course info into data table 

		if (empty($description)) $description = "null";

		$sql = "INSERT INTO 
				fas_courses(cat_num, offered, dept_short_name, title, description, 
				faculty_list, schedule, meeting_locations, requirements) 
				VALUES ('{$c['cat_num']}', '{$c['offered']}', '{$c->department->dept_short_name}',
				'{$title}',
				'{$description}',
				'{$faculty_list}',
				'{$j_meeting}',
				'{$j_location}',
				'{$j_requirement}' )";

		// $sql = "INSERT INTO 
		// 		fas_courses(cat_num, offered, dept_short_name, title, description, 
		// 		faculty_list, schedule, meeting_locations, requirements) 
		// 		VALUES ('{$c['cat_num']}', '{$c['offered']}', '{$c->department->dept_short_name}',
		// 		'{$title}',
		// 		'{$description}',
		// 		'{$faculty_list}',
		// 		'{$s_schedule}',
		// 		'{$s_meeting_locations}',
		// 		'{$s_requirements}'
		// 	)";

		// echo $sql.'<br><br>'; // for debugging query

		// $result2 = mysql_query($sql);
		// if (!$result2) die('Invalid query: <br>' . mysql_error() . '<br>' . $sql); // for debugging 
	
		$total++;
	} 
	
	echo 'TOTAL RECORDS ADDED = '.$total.'<br>';

	// close db connection
	
	mysql_close($link);

?>