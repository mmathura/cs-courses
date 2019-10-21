<?php 

	header("Content-type: application/json");

	require_once("dbconnect.php"); 

	// print_r($_GET); // for debugging 


	// open .xml file to query real-time ETA data from BART website

    // $xml = simplexml_load_file("http://www.bart.gov/dev/eta/bart_eta.xml");

    $xml = simplexml_load_file("bart_eta.xml");

    $xml_result1 = $xml->xpath('//station'); // get all stations

    // print_r($xml_result1); // for debugging the xml results 


	$rows = Array(); // represents rows or results from database table 
	  
	// SQL query for train routes 

    $query2 = "SELECT * FROM routes WHERE line="."'"."{$_GET['route_number']}"."'";
    $result2 = mysql_query($query2) or die('SQL query failed: '. mysql_error().'<br>');

	while ($line2 = mysql_fetch_array($result2, MYSQL_ASSOC)) {

	    // SQL query for routes and station names 

	    $query3 = "SELECT * FROM stations WHERE id={$line2['station']}";
	    $result3 = mysql_query($query3) or die('SQL query failed: '. mysql_error().'<br>');

	    while ($line3 = mysql_fetch_array($result3, MYSQL_ASSOC)) {

			$eta_str = null; // clear 

			foreach($xml_result1 as $key => $value) {

			 	if (strtolower($value->abbr) === $line3['abbr']) { // get abbr from database
			        
			    	foreach ($value as $key2 => $value2) {
			        	// echo "{$key2} -> {$value2}<br>"; // for debugging 
			            foreach ($value2 as $key3 => $value3) {
			                // echo "{$key3} -> {$value3}<br>"; // for debugging 
			                $eta_str .= "{$value3}<br>"; // package ETA results to display in info window
			           	}
			        }
			  	}
			}

			$line3['eta'] = $eta_str; // append eta data to row result from DB
			// print_r($line3); // for debugging 

			$rows[] = $line3; // add eta to results 

	    }

	}

	print(json_encode($rows)); // output as a json object 

	// free result set

    // mysql_free_result($result2);

    // mysql_free_result($result3);

?>