<ul data-role="listview" data-divider-theme="a" data-filter="true" data-filter-placeholder="Search courses..." data-inset="true">

	<?php 

		foreach($departments as $d) {

			$url = str_replace(', ', '-', $d['dept_short_name']);
			$url = str_replace(' ', '_', $url);

			// echo $url; // debug

			echo '<li><a href='.'"'.'/Project0/index.php/department/'.$url.'"'.'>'.$d['dept_short_name'].'</a></li>';
		}

	?>

</ul>
