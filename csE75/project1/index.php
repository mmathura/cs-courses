<?php

	// start user session

	session_start();

    // open xml file 

	$xml = simplexml_load_file("menu.xml");

	// print_r($xml);  // for debugging

	// perform queries on menu data

	if ($_GET["category"] != 0) {
	
		$xml_result1 = $xml->xpath('//category[@number ='.$_GET["category"].']'); 
		$xml_result2 = $xml->xpath('//category[@number ='.$_GET["category"].']'.'/items/item'); 
		$xml_result3 = $xml->xpath('//category[@number ='.$_GET["category"].']'.'/all_served_with'); 
	}

?>

<!DOCTYPE html>
<head> 
	<meta charset="UTF-8">
	<title>Three Aces - Menu</title>
</head>
<body>
<center>
	<h1>Welcome to Three Aces</h1>
	<p>
	Please choose a category from the menu below:
	</p>
	<p>
	<form method="get" onselect="index.php">
		<select name="category">
			<?php 
				foreach ($xml->categories->category as $category)
	    			echo "<option value={$category["number"]}>".$category["number"]." - ".$category->title."</option>";
	    	?>
		</select>
		<input type="submit" value="Display"></input>
	</form>
</center>
</p>

<p>
<center>
<h2>
	<?php 
		if ($_GET["category"] != 0)
			print($_GET["category"]." - ".$xml_result1[0]->title); 
	?>
</h2>

<?php $_SESSION['category'] = $_GET["category"]; // add the categoy to user session  ?>

<form method="post" action="shopcart.php">

	<?php 
		if ($_GET["category"] != 0)
			print("
				<table border=0>
				<tr>
					<th>No.</th>
					<th>Item(s)</th>
					<th>Served with</th>
					<th>Sm</th>
					<th></th>
					<th>Qty</th>
					<th>Lg</th>
					<th></th>
					<th>Qty</th>
					<th>Reg</th>
					<th></th>
					<th>Qty</th>
				</tr>"
				);
	?>

	<?php

		if (!empty($_GET)) { // Don't display table on startup

			$count = 0;

			foreach ($xml_result2 as $results) {

				print("<tr>");

				// print("<td>".$results["id"]."</td>");

				print("<td>");
				echo $count + 1;
				print("</td>");
				print("<td>".$results->name."</td>");
				print("<td>".$results->served_with."</td>");

				// don't display prices with $0.00 or check boxes

				if ($results->price["small"] == "0.00")
					print("<td>&nbsp</td><td>&nbsp</td><td>&nbsp</td>");
				else {
					print("<td>$".$results->price["small"]);
					print("</td><td><input type=checkbox name=small_price_".$results["id"]." value=".$results->price["small"]."></input></td>");
					print("<td><input type=text name=small_quantity_".$results["id"]." size=2 maxlength=2></input></td>");
				}

				if ($results->price["large"] == "0.00")
					print("<td>&nbsp</td><td>&nbsp</td><td>&nbsp</td>");
				else {
					print("<td>$".$results->price["large"]);
					print("</td><td><input type=checkbox name=large_price_".$results["id"]." value=".$results->price["large"]."></input></td>");
					print("<td><input type=text name=large_quantity_".$results["id"]." size=2 maxlength=2></input></td>");
				}

				if ($results->price["regular"] == "0.00") {
					print("<td>&nbsp</td><td>&nbsp</td><td>&nbsp</td>");
				} else {
					print("<td>$".$results->price["regular"]); 
					print("</td><td><input type=checkbox name=regular_price_".$results["id"]." value=".$results->price["regular"]."></input></td>");
					print("<td><input type=text name=regular_quantity_".$results["id"]." size=2 maxlength=2></input></td>");
				}

				print("</tr>");

				$count++;
			}

			// for all served with table row 

			print("<tr>");
			print("<td></td>");
			print("<td>All served with</td>");
			print("<td>*".$xml_result3[0]->served_with."</td>"); 
			
			if ($xml_result3[0]->price["small"] == "0.00")
				print("<td>&nbsp</td><td>&nbsp</td>");
			else {
				print("<td>$".$xml_result3[0]->price["small"]);
				print("</td><td><input type=checkbox name=served_with_small_price value=".$xml_result3[0]->price["small"]."></input></td>");
				print("<td><input type=text name=served_with_small_quantity size=2 maxlength=2></input></td>");
			}

			if ($xml_result3[0]->price["large"] == "0.00")
				print("<td>&nbsp</td><td>&nbsp</td>");
			else {
				print("<td>$".$xml_result3[0]->price["large"]); 
				print("</td><td><input type=checkbox name=served_with_large_price value=".$xml_result3[0]->price["large"]."></input></td>");
				print("<td><input type=text name=served_with_large_quantity size=2 maxlength=2></input></td>");
			}

			if ($xml_result3[0]->price["regular"] == "0.00")
				print("<td>&nbsp</td><td>&nbsp</td>");
			else {
				print("<td>$".$xml_result3[0]->price["regular"]);
				print("</td><td><input type=checkbox name=served_with_regular_price value=".$xml_result3[0]->price["regular"]."></input></td>");
				print("<td><input type=text name=served_with_regular_quantity size=2 maxlength=2></input></td>"); 
			}

			print("</tr>");
		} 
	?>
	</table>
	<br>
	<?php 
		if ($_GET["category"] != 0)
            echo "<input type='submit' value='Add to Shopping Cart'></imput>"; 
    ?>
</form>
</center>
</p>

</body>
</html>