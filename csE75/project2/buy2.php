<?php

   // require common code
   require_once("includes/common.php");
   
   // escape text input
   $symbol = mysql_real_escape_string($_POST["symbol"]);
   $shares = mysql_real_escape_string($_POST["shares"]);
   
   // number of shares can't be zero
   if ($symbol == "" || $shares == "") {
      apologize("You must enter a stock symbol or the number of shares.");
   }
   else {
      // saves current user
      $uid = $_SESSION["uid"];
      
      // get chash from user table 
      $sql = "SELECT cash FROM users WHERE uid='$uid'";
      $result = mysql_query($sql);
      $row = mysql_fetch_array($result);
      $cash = $row["cash"];
            
      // get price of stock 
      $symbol = strtoupper($symbol); // uppercase
      $s = lookup($symbol);
      $price = $s->price;
            
      if (($total = $price * $shares) <= $cash) {  // buy stock
      
         // if stock exists update number of shares 
         
         // get stock symbol
         $sql2 = "SELECT * FROM portfolios WHERE uid='$uid'";
         $result2 = mysql_query($sql2);

         while ($row2 = mysql_fetch_array($result2)) {
            $found = 0;  // clear 
            $stock_symbol = $row2["symbol"];
            if (strcmp($stock_symbol,$symbol) == 0) // match
               break;
            else
               $found++; // no match
          }
          
          // if match
          if ($found == 0) {
      
              $stock_shares = $row2["shares"];
              $stock_shares += $shares; 
              // update shares with new value
              $sql3 = "UPDATE users SET cash=cash-$total WHERE uid='$uid'";
              $sql4 = "UPDATE portfolios SET shares=$stock_shares WHERE uid='$uid' AND symbol='$symbol'";
              mysql_query($sql3);
              mysql_query($sql4);
          }
          else if ($found > 0) { // no match
          
            // if stock doesn't exist add to portfolio 
            // subtract from total cash 

            $sql5 = "INSERT INTO portfolios (uid, symbol, shares) VALUES('$uid','$symbol', '$shares')";
            $sql6 = "UPDATE users SET cash=cash-$total WHERE uid='$uid'";
            mysql_query($sql5);
            mysql_query($sql6);             
          }
      }
      else 
         apologize("Not enough funds.");
      
      // update history 
      // log entry into history table 
      $sql7 = "INSERT INTO history (uid, symbol, shares, status, price) VALUES('$uid', '$symbol', '$shares', 'BOUGHT', '$price')";
      mysql_query($sql7);
      
      redirect("index.php");
    }

?>

