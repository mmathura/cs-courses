<?php

    // require common code
    require_once("includes/common.php"); 
 
    // if fields in form are blank 
    if ($_POST["symbol"] == "") {
    	apologize("Must enter a stock symbol.");
    }
    else { // display stock quote
    
       $s = lookup($_POST["symbol"]);
       if ($s == "") {
          apologize("Must enter a valid stock quote.");
       }
       
    }

?>

<!DOCTYPE html>

<html>
  <head>
    <link href="css/styles.css" rel="stylesheet" type="text/css">
    <title>C$50 Finance: Quote</title>
  </head>

  <body>
     <div id="top">
         <a href="index.php"><img alt="C$50 Finance" height="110" src="images/logo.gif" width="544"></a>
     </div>

     <div id="middle">
        <div style="text-align: center">
           A share of <?php print($s->name);?> currently costs $<?php print($s->price);?>.
        </div>
     </div>
    
     <div id="bottom">
       go to <a href="quote.php">quote</a> page<br>
       go to <a href="index.php">index</a> page
     </div>
   </body>
</html>
