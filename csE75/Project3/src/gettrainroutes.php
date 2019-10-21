<?php

	header("Content-type: text/html");

	require_once("dbconnect.php"); 

	// SQL query to populate drop down menu

    $query1 = 'SELECT * FROM trains';
    $result1 = mysql_query($query1) or die('SQL query failed: '. mysql_error().'<br>');

    // options for the drop down menu 

 	while ($line = mysql_fetch_array($result1, MYSQL_ASSOC))
 		echo "<option value=".'"'."{$line['id']}".'"'.">{$line['line']}</option>"; 
 		// output form elements as html

 	// free result set
    
    // mysql_free_result($result1);
    
?>