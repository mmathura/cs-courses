<?php

	session_start();

	// remove items from order and handle update of form 

	// error check to GET variable 
	
	$nerror = 0; // error count 

	foreach($_GET as $key => $value) {

		if (!empty($value)) { // handle zero entries 
			if ($value < 0 || is_numeric($value) == false) {
				// echo "Error: (".$value.")<br>"; // for debugging
				$nerror++;
			}
		}
	}

	// redirect

	if ($nerror > 0) { 
		// echo "Error count = ".$nerror."<br>"; // for debugging 
		header('Location: update.php'); 	// redirect 
		exit();
	}

	// remove or update item in session  

	if (sizeof($_GET) != 0) {
		
		foreach($_GET as $key => $value) {

			$item_number = explode("_", $key);

			if (is_numeric($item_number[1])) {
				// print("The item number is {$item_number[1]}<br>"); // for debugging 
				$_SESSION['total'] -= ($_SESSION['order'][$item_number[1]]['price'] * $_SESSION['order'][$item_number[1]]['quantity']);
				$_SESSION['quantity'] -= $_SESSION['order'][$item_number[1]]['quantity'];
				unset($_SESSION['order'][$item_number[1]]); // remove item from session 
			}
			else { // update new quantity in session 
				// print("The key is {$key} value is {$value}.<br>"); // for debugging 
				$_SESSION['order'][$key]['quantity'] = $value;
				$_SESSION['quantity'] += $_SESSION['order'][$key]['quantity'];
				$_SESSION['total'] += ($value['price'] * $_SESSION['order'][$key]['quantity']);
			}
		}
	}

	// for debugging

	// echo "<pre>";  
	// print_r($_SESSION);
	// echo "</pre>";

	header('Location: shopcart2.php');  // redirect 
	
	exit();

?>