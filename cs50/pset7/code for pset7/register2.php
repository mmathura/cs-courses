<?php

    // require common code
    require_once("includes/common.php"); 
 
    // if fields in the form are blank 
    if ($_POST["username"] == "" || $_POST["password"] == "" || $_POST["password2"] == "") {
    	apologize("You must enter a username or password.");
	redirect("register.php");
    }
    else if ($_POST["password"] != $_POST["password2"]) { // if passwords are not the same
    	apologize("Password does not equal re-entered password.");
	redirect("register.php");
    }
    else { // insert into database 
 
    	// escape username and password for safety
    	$username = mysql_real_escape_string($_POST["username"]);
    	$password = mysql_real_escape_string($_POST["password"]); 
        
        $sql = "SELECT * FROM users WHERE username='$username'";
        $result = mysql_query($sql);
        $row_num = mysql_num_rows($result); 
        
        if($row_num) // fail if duplicate entries in table  
            apologize("Username allready exists");
        else {
           // prepare SQL
    	   $sql = "INSERT INTO users (username, password, cash) VALUES('$username', '$password', 1000.00)";

    	   // execute query
    	   $result = mysql_query($sql);

           // check if query was successful
 
           // get uid
           $uid = mysql_insert_id($result);

           // log user into session 
           $_SESSION["uid"] = $uid; 

           // redirect to portfolio 
           redirect("index.php");    
        }
    }

?>
