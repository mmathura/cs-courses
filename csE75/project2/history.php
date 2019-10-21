<?php

   // require common code 
   require_once("includes/common.php"); 
   
   $uid = $_SESSION["uid"];
   
   $history = "SELECT * FROM history WHERE uid='$uid'";
   $result = mysql_query($history);

?>

<!DOCTYPE html>

<html>
  <head>
    <link href="css/styles.css" rel="stylesheet" type="text/css">
    <title>C$50 Finance: History</title>
  </head>

  <body>
     <div id="top">
         <a href="index.php"><img alt="C$50 Finance" height="110" src="images/logo.gif" width="544"></a>
     </div>

     <div id="middle">
        <div style="text-align: center">
        <table>
          <th>Date/Time</th>
          <th></th>
          <th>Symbol</th>
          <th>Share(s)</th>
          <th>Status</th>
          <th>Price</th>
          <tr></tr>
        
          <?php      
              while ($row = mysql_fetch_array($result)) {
                 print("<tr>");
                 print ("<td>{$row["timestamp"]}</td>");
                 print("<td></td>");
                 print ("<td>{$row["symbol"]}</td>");
                 print ("<td>{$row["shares"]}</td>");
                 print ("<td>{$row["status"]}</td>");
                 print ("<td>{$row["price"]}</td>");
                 print("</tr>");
              }
          ?>
        </table>
        </div>
     </div>
    
     <div id="bottom">
       go to <a href="index.php">index</a> page
     </div>
   </body>
</html>

