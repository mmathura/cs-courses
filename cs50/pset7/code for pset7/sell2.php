<?php

   // require common code
   require_once("includes/common.php");
   
   // escape text input
   $symbol = mysql_real_escape_string($_POST["symbol"]);
   $shares = mysql_real_escape_string($_POST["shares"]);
   
   // error - number of shares can't be zero

   if ($symbol == "" || $shares == "") {

      apologize("You must enter a stock symbol or the number of shares.");

   }
   else {

      $uid = $_SESSION["uid"]; // saves current user 

      // get chash from user table 
      $sql = "SELECT cash FROM users WHERE uid='$uid'"; // query string 
      $result = mysql_query($sql); // execute query
      $row = mysql_fetch_array($result); // get row from table 
      $cash = $row["cash"];
      
      // get stock symbol
      $symbol = strtoupper($symbol);
      $sql2 = "SELECT * FROM portfolios WHERE uid='$uid'"; // query string
      $result2 = mysql_query($sql2); // execute query

      while ($row2 = mysql_fetch_array($result2)) { // get row(s) from table 
        $flag = 0;  // clear 
        $stock_symbol = $row2["symbol"];
        if (strcmp($stock_symbol,$symbol) == 0) // match
           break;
        else
          $flag++; // no match
      }
    
      if ($flag > 0) { // no match
         apologize("$symbol not found.");
         redirect("sell.php");
      }
      
      // if match, delete from table
      
      $s = lookup($symbol);
      $price = $s->price;
      $stock_shares = $row2["shares"];
      
      if (($stock_shares - $shares) >= 1) {       // update the user's cash and shares
         // update
         $sql3 = "UPDATE users SET cash=cash+($price*$shares) WHERE uid='$uid'";
         $sql4 = "UPDATE portfolios SET shares=shares-$shares WHERE uid='$uid' AND symbol='$symbol'";
         mysql_query($sql3);
         mysql_query($sql4);

      }
      else if (($stock_shares - $shares) == 0) { // remove from table - update users cash
         // delete 
         $sql5 = "DELETE FROM portfolios WHERE uid='$uid' AND symbol='$symbol'";
         $sql6 = "UPDATE users SET cash=cash+($price*$shares) WHERE uid='$uid'";
         mysql_query($sql5);
         mysql_query($sql6);
      }
      else
         apologize("Can't have negative shares.");
      
      // log entry into history table 
      
      $sql7 = "INSERT INTO history (uid, symbol, shares, status, price) VALUES('$uid', '$symbol', '$shares', 'SOLD', '$price')";
      mysql_query($sql7);
      
      redirect("index.php");
    }

?>

