<?php

    header("Content-type: text/plain");

    require_once("dbconnect.php"); 

    // to get colour field from trains table 

    $query1 = "SELECT * FROM trains WHERE id="."'"."{$_GET['route_number']}"."'";  
    $result1 = mysql_query($query1) or die('SQL query failed: '. mysql_error().'<br>');

    $line = mysql_fetch_array($result1, MYSQL_ASSOC);

    // echo $line['colour']; // for debugging 

    // draw polylines for train route

 	echo "var trainLine = new google.maps.Polyline({
	    	path: trainLineCoordinates,
	    	strokeColor: \"{$line['colour']}\",
	    	strokeOpacity: 1.0,
	    	strokeWeight: 4
	  	  });

	  	  trainLine.setMap(map);";

    // free result set

    // mysql_free_result($result1);

?>