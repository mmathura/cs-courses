<?php 

	session_start();

	// print_r($_SESSION); // for debugging

	// open menu file 

	$xml = simplexml_load_file("menu.xml");

	// validate POST variable 

	$nerror = 0; // error count 

	foreach($_POST as $key => $value) {

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
		header('Location: index.php'); 	// redirect 
		exit();
	} 

	// initialize totals 

	if (!isset($_SESSION['quantity']))
		$_SESSION['quantity'] = 0; // for total quantity 
	
	if (!isset($_SESSION['total'])) 
		$_SESSION['total'] = 0.0; // for total price 

	// save order into user's session

	foreach($_POST as $key => $value) {

		// calculate number of items in the shopping cart

		$count = sizeof($_SESSION['order']);

		// gets the item number for lookup in menu.xml 

		$item_number = explode('_', $key);

		// Don't add to shopping cart if no items selected

		if (is_numeric($item_number[2]) && !empty($value)) 
		{

		   	$xml_result1 = $xml->xpath('//items/item[@id ='.$item_number[2].']'); 					   	
		   		
		    // small 

		   	if ($key === "small_price_$item_number[2]") {
		   		$_SESSION['order'][$count]['name'] = $xml_result1[0]->name."";
		   		$_SESSION['order'][$count]['price'] = $value;
		   	}

		   	if ($key === "small_quantity_$item_number[2]")
		   		$_SESSION['order'][$count - 1]['quantity'] = $value;

		   	// large 

		   	if ($key === "large_price_$item_number[2]") {
		   		$_SESSION['order'][$count]['name'] = $xml_result1[0]->name."";
		   		$_SESSION['order'][$count]['price'] = $value;
		   	}

		   	if ($key === "large_quantity_$item_number[2]")
		   		$_SESSION['order'][$count - 1]['quantity'] = $value;

		   	// regular 

		   	if ($key === "regular_price_$item_number[2]") {
		   		$_SESSION['order'][$count]['name'] = $xml_result1[0]->name."";
		   		$_SESSION['order'][$count]['price'] = $value;
		   	}

		   	if ($key === "regular_quantity_$item_number[2]")
		   		$_SESSION['order'][$count - 1]['quantity'] = $value;
		}
		else if (is_string($item_number[2]) && !empty($value)) 
		{

			$category_number = $_SESSION['category'];

			$xml_result2 = $xml->xpath('//category[@number ='.$category_number.']'.'/all_served_with');					   	

			// served with - small 

		   	if ($key === "served_with_small_price") {
		   		$_SESSION['order'][$count]['name'] = $xml_result2[0]->served_with."";
		   		$_SESSION['order'][$count]['price'] = $value;
		   	}

		   	if ($key === "served_with_small_quantity")
		   		$_SESSION['order'][$count - 1]['quantity'] = $value;

		   	// served with - large 

		   	if ($key === "served_with_large_price") {
		   		$_SESSION['order'][$count]['name'] = $xml_result2[0]->served_with."";
		   		$_SESSION['order'][$count]['price'] = $value;
		   	}

		   	if ($key === "served_with_large_quantity")
		   		$_SESSION['order'][$count - 1]['quantity'] = $value;

		   	// served with - regular 

		   	if ($key === "served_with_regular_price") {
		   		$_SESSION['order'][$count]['name'] = $xml_result2[0]->served_with."";
		   		$_SESSION['order'][$count]['price'] = $value;
		   	}

		   	if ($key === "served_with_regular_quantity")
		   		$_SESSION['order'][$count - 1]['quantity'] = $value;
		}
	} 

	// print("<br>"); // for debugging 

	// update totals 

	// for debugging

	// echo "<pre>";  
	// print_r($_SESSION);
	// echo "</pre>";

	// error on browser refresh or back button 

	header('Location: shopcart2.php'); 	// redirect 

	exit();

?>