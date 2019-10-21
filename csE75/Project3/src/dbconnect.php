<?php

	// connect to database server

    $link = mysql_connect('localhost:3306', 'root', 'password')
        or die('Could not connect to database: '. mysql_error().'<br>');

    // select database 

    mysql_select_db('project3') or die('Could not select database<br>');


    // closing connection

    // mysql_close($link);

?>