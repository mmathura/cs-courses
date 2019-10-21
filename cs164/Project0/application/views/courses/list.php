<ul data-role="listview" data-filter="true" data-filter-placeholder="Search courses..." data-inset="false">

	<?php 

		foreach($courses as $c) {

			echo '<li>';
			// echo $c['id'].'<br>';
			echo 'Catalog No. '. $c['cat_num'].'<br>';
			echo 'Offered: '.$c['offered'].'<br>';
			echo 'Department of '.$c['dept_short_name'].'<br>';
			echo '<b>'.$c['title'].'</b><br>';
			
			if ($c['description'] != "null")
				echo $c['description'].'<br>';

			$fl = json_decode($c['faculty_list']);

			if (!empty($fl)) {

				echo '<b>Instructor(s)</b><br>';
				
				foreach ($fl as $f)
					echo strval($f).'<br>';
			}

			$s = json_decode($c['schedule']);

			if (!empty($s)) {

				echo '<b>Schedule</b><br>';

				foreach ($s as $sc)
					echo 'Day: '.$sc->day.' Time: '.$sc->begin_time.' to '.$sc->end_time.'<br>';
			}

			$ml = json_decode($c['meeting_locations']);

			if (!empty($ml)) {

				echo '<b>Location(s)</b><br>';
				
				foreach ($ml as $m)
					echo $m->building.'; Room: '.$m->room.'<br>';
			}

			$r = json_decode($c['requirements']);

			if (!empty($r)) {

				echo '<b>Requirement(s)</b><br>';
				
				foreach ($r as $rs)
					echo $rs->type.': '.$rs->name.'<br>';
			}

			// add course 

			if (!$flag) {
		
				echo '<div data-role="controlgroup" data-type="horizontal" class="ui-mini">';
				echo '<a href="/Project0/index.php/add_courses_shopping_for/'.$c['id'].'" class="ui-btn ui-btn-icon-right ui-icon-shop">Shop course</a>';
				echo '<a href="/Project0/index.php/add_courses_taking/'.$c['id'].'" class="ui-btn ui-btn-icon-right ui-icon-plus">Add course</a></div>';
			}

			echo '</li>';
		} 

	?>

</ul>

