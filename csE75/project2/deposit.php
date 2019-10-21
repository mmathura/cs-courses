<?php

    // require common code
    // require_once("includes/common.php");

?>

<!DOCTYPE html>

<html>

  <head>
    <link href="css/styles.css" rel="stylesheet" type="text/css">
    <title>C$50 Finance: Deposit</title>
  </head>

  <body OnLoad="document.deposit.cash.focus();">

    <div id="top">
      <a href="index.php"><img alt="C$50 Finance" src="images/logo.gif"></a>
    </div>

    <div id="middle">
      <form action="deposit2.php" method="post" name="deposit">
        <table>
          <tr>
            <td>Cash: $</td>
            <td><input name="cash" type="text"></td>
          </tr>
          <tr>
            <td colspan="2"><input type="submit" value="Deposit Additional Funds"></td>
          </tr>
        </table>
      </form>
    </div>

    <div id="bottom">
      go to <a href="index.php">index</a> page
    </div>

  </body>

</html>
