<?php

   // require common code
   require_once("includes/common.php");
   
   if ($_POST["cash"] == "")
      apologize("Must enter additional funds to deposit.");
      
   // update cash in user table 
   
   $cash = $_POST["cash"];
   $uid = $_SESSION["uid"];
   
   $sql =  "UPDATE users SET cash=cash+$cash WHERE uid='$uid'";
   mysql_query($sql);
   
   // refresh - go to index page and show new total
   
   redirect("index.php");

?>