<?php 

	session_start();

	// reset totals

	$_SESSION['quantity'] = 0; // for total quantity 
	$_SESSION['total'] = 0.0; // for total price 

	// for debugging 

	// echo "<pre>";
	// print_r($_SESSION);
	// echo "</pre>";

?>

<!DOCTYPE html>
<head> 
	<meta charset="UTF-8">
	<title>Three Aces - Shopping Cart</title>
</head>
<body>
	<center>
		<h1>Shopping Cart</h1>
		<p>
			<pre><?php // print_r($_POST); // for debugging ?></pre>

			<form method="get" action="update.php">

				<table border="0">
					<tr>
						<th>No.</th>
						<th>Item</th>
						<th>Qty</th>
						<th>Price</th>
						<th>Remove</th>
					</tr>

					<?php

						if (sizeof($_SESSION['order']) != 0) {

							$number = 0; // for enumeration of items 

							// display items in shopping cart 

							foreach($_SESSION['order'] as $key => $value) {

								echo "<tr>";
								echo "<td>";
								echo $number + 1;
								echo "</td>";
								echo "<td><center>{$value['name']}</center></td>";
								echo "<td><center>
										<input type=text name={$key} size=2 maxlength=2 value={$value['quantity']}></input>
									  </center></td>";
								echo "<td><center>{$value['price']}</center></td>";
								echo "<td><center><input type=checkbox name=remove_".$key." value=".$key."></input></center></td>";
							    echo "</tr>";

							    // re-calculate totals 

							    // for debugging

							    // echo "The key is {$key} => Quantity is {$value['quantity']} <br>";
							    // echo "The key is {$key} => Price is {$value['price']} <br>";

							    $_SESSION['quantity'] += $value['quantity'];
	    						$_SESSION['total'] += ($value['price'] * $value['quantity']);

	    						$number++;
							}
						}
				
					?>
				</table>
				<p>
					<input type="submit" value="Remove Items"></input>
				</p>
				<p>
					<input type="submit" value="Update"></input>
				</p>
			</form>
		</p>
		<p>
			<pre><?php // print_r($_SESSION); // for debugging session variable ?></pre>
		</p>
		<p> 
			Do you want to continue with your order or check out? 
		</p>
		<p>
			<form action="index.php">
				<input type="submit" value="Back to Menu"></imput>
			</form>	
		</p> 
		<p>		
			<form action="checkout.php">
				<input type="submit" value="Check Out"></imput>
			</form>
		</p>
	</center>
</body>
</html>