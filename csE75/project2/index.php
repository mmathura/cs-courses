<?php

   // require common code
   require_once("includes/common.php"); 
   
   $session = $_SESSION["uid"];
   
   $result1 = mysql_query("SELECT symbol, shares FROM portfolios WHERE uid=$session"); 
   $result2 = mysql_query("SELECT cash FROM users WHERE uid=$session"); 
   
?>

<!DOCTYPE html>

<html>

  <head>
    <link href="css/styles.css" rel="stylesheet" type="text/css">
    <title>C$50 Finance: Home</title>
  </head>

  <body>

    <div id="top">
      <a href="index.php"><img alt="C$50 Finance" height="110" src="images/logo.gif" width="544"></a>
    </div>

    <div id="middle">
    
      <?php 
        print("<table>");
        print("<th>Stock</th>");
        print("<th>Symbol</th>");
        print("<th>Share(s)</th>");
        print("<th>Price</th>");
        print("<tr></tr>");
                
        while ($row = mysql_fetch_array($result1)) {
           print("<tr>"); 
           $s = lookup($row["symbol"]); 
           print("<td>{$s->name}</td>"); 
           print("<td>{$s->symbol}</td>");
           print("<td>{$row["shares"]}</td>");
           print("<td>\${$s->price}</td>"); 
           print("</tr>");
        }
        
        $row = mysql_fetch_array($result2);
        
        print("<tr>");
        print("<td></td>");
        print("</tr>");
        print("<tr></tr>");
        print("<tr>");
        print("<td>Cash</td>");
        print("<td></td>");
        print("<td></td>");
        print("<td>\${$row["cash"]}</td>"); 
        print("</tr>");
        print("</table>");
      ?>
      
      <!--<img alt="Under Construction" height="299" src="images/construction.gif" width="404">-->
      
    </div>

    <div id="bottom">
      <a href="quote.php">get quote</a><br>
      <a href="sell.php">sell stock(s)</a><br>
      <a href="buy.php">buy stock(s)</a><br>
      <a href="deposit.php">deposit funds</a><br>
      <a href="history.php">transactions history</a><br>
      <a href="logout.php">log out</a>
    </div>

  </body>

</html>
