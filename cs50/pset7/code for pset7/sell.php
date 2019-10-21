<?php

    // require common code
    // require_once("includes/common.php");

?>

<!DOCTYPE html>

<html>

  <head>
    <link href="css/styles.css" rel="stylesheet" type="text/css">
    <title>C$50 Finance: Sell</title>
  </head>

  <body>

    <div id="top">
      <a href="index.php"><img alt="C$50 Finance" src="images/logo.gif"></a>
    </div>

    <div id="middle">
      <form action="sell2.php" method="post">
        <table>
          <tr>
            <td>Stock Symbol:</td>
            <td><input name="symbol" type="text"></td>
          </tr>
          <tr>
            <td>Number of Shares:</td>
            <td><input name="shares" type="text"></td>
          </tr>
          <tr>
            <td colspan="2"><input type="submit" value="Sell Stock(s)"></td>
          </tr>
        </table>
      </form>
    </div>

    <div id="bottom">
      go to <a href="index.php">index</a> page
    </div>

  </body>

</html>
