<ul data-role="listview" data-divider-theme="a" data-filter="true" data-filter-placeholder="Search courses..." data-inset="true">

	<?php 

		$temp = Array();

		foreach($area as $a) {

			$j_requirements = json_decode($a['requirements']);

			if ($j_requirements != null) {

				foreach($j_requirements as $r) {

					if ($r->type === "General Education") {

						$temp[] = $r->name;

					}

				}

			}

		}

		$results = array_unique($temp);

		// var_dump($results); // debug

		foreach ($results as $key => $value) {

			$url = str_replace(' ', '_', $value);

			echo '<li><a href='.'"'.'/Project0/index.php/area/'.$url.'"'.'>'.$value.'</a></li>';

		}

	?>

</ul>
