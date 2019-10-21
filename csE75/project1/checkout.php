<?php 

	// start user session

	session_start();

?>

<!DOCTYPE html>
<head> 
	<meta charset="UTF-8">
	<title>Three Aces - Check Out</title>
</head>
<body>
	<center>
		<h1>Checked Out</h1>
		<p>
			Total quantity is <?php echo $_SESSION['quantity']; ?> and total amount is $ <?php printf("%.2f", $_SESSION['total']); ?>.
		</p>

		<?php 

			// unset all session variables 

			session_unset();

			// clean up user session

			session_destroy();

			// print_r($_SESSION); // for debugging 

		?>

		<p>
			Thank you for your order!
		</p>
		<p>
			<form action="index.php"> 
				<input type="submit" value="Back to Menu"></imput>
			</form>
		</p>
	</center>
</body>
</html>