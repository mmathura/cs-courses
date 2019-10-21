<!DOCTYPE html>

<?php 

    // connect to database server

    $link = mysql_connect('localhost:3306', 'root', 'password')
        or die('Could not connect to database: '. mysql_error().'<br>');

    // select database 

    mysql_select_db('project3') or die('Could not select database<br>');

    // .. TODO .. get from $_POST the route number to display 

    // print_r($_POST); // for debugging


    // SQL query to populate drop down menu

    $query1 = 'SELECT * FROM trains';
    $result1 = mysql_query($query1) or die('SQL query failed: '. mysql_error().'<br>');

    // SQL query for train routes 

    $query2 = 'SELECT * FROM routes';
    $result2 = mysql_query($query2) or die('SQL query failed: '. mysql_error().'<br>');

    // open .xml file to query real-time ETA data from BART website

    $xml = simplexml_load_file("http://www.bart.gov/dev/eta/bart_eta.xml");

    $xml_result1 = $xml->xpath('//station'); // get all stations

    // print_r($xml_result1); // for debugging 
   
    
    // free result set
    
    // mysql_free_result($result1);
    // mysql_free_result($result2);

    // closing connection

    // mysql_close($link);

?>

<html>

	<head>
    
		<title>BART</title>

			<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />

    		<style type="text/css">
      			html { height: 100% }
      			body { height: 100%; margin: 0; padding: 0 }
      			#map_canvas { height: 100%; margin: 0 auto; }
    		</style>

    		<script type="text/javascript"
      			src="http://maps.googleapis.com/maps/api/js?key=AIzaSyC0dLrfnpU-TQzXKw92koG8FKknu0uGeYU&sensor=false">
    		</script>

    	  <script type="text/javascript">

      			function initialize() {
        			var mapOptions = {
          					center: new google.maps.LatLng(37.7749295, -122.4194155), // San Fransisco, CA, USA
          					zoom: 8,
          					mapTypeId: google.maps.MapTypeId.ROADMAP
        			  };

        			var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);

              var marker = new Array();
              var trainLineCoordinates = new Array();
              var infowindow = new Array();
            
            <?php

              $total = 0; // for number of stations in route 

              // .. TODO .. error: displays n - 1 results 

              while ($line2 = mysql_fetch_array($result2, MYSQL_ASSOC)) {

                  // SQL query for routes and station names 

                  $query3 = "SELECT * FROM stations WHERE id={$line2['station']}";
                  $result3 = mysql_query($query3) or die('SQL query failed: '. mysql_error().'<br>');

                  while ($line3 = mysql_fetch_array($result3, MYSQL_ASSOC)) {
                      
                    // repeat process for all stations on a route

                    echo "marker[{$total}] = new google.maps.Marker({";
                    echo "position: new google.maps.LatLng({$line3['latitude']}, {$line3['longitude']}), ";
                    echo "map: map, ";
                    echo "title: ".'"'."{$line3['name']}".'"';
                    echo "});\n";

                    echo "trainLineCoordinates[{$total}] = new google.maps.LatLng({$line3['latitude']}, {$line3['longitude']});\n";

                    $eta_str = " "; // clear 

                    foreach($xml_result1 as $key => $value) {

                        if (strtolower($value->abbr) === $line3['abbr']) { // get abbr from database
                          
                            foreach ($value as $key2 => $value2) {
                                // echo "{$key2} -> {$value2}<br>"; // for debugging 
                                foreach ($value2 as $key3 => $value3) {
                                     // echo "{$key3} -> {$value3}<br>"; // for debugging 
                                     $eta_str .= "{$value3}<br>"; // package ETA results to display in info window
                                }
                            }
                        }
                    }
                    
                    // add info window for all stations 

                    echo "var contentString ="."'"."<b>{$line3['name']}</b><br>{$eta_str}"."'".";\n";  
                    // display eta information 

                    echo "infowindow[$total] = new google.maps.InfoWindow({
                              content: contentString
                         });\n";

                    echo "google.maps.event.addListener(marker[$total], 'click', function() {
                         infowindow[$total].open(map,marker[{$total}]);
                        });\n";

                  }

                  $total++; // number of stations
              } 

              // draw polylines for train route

              // substitute colour field from trains table 

              $line = mysql_fetch_array($result1, MYSQL_ASSOC);

              echo "var trainLine = new google.maps.Polyline({
                    path: trainLineCoordinates,
                    strokeColor: \"{$line['colour']}\",
                    strokeOpacity: 1.0,
                    strokeWeight: 4
                  });\n

                trainLine.setMap(map);"

            ?>
  
      } // end initialize() function 

      </script>

	</head>

	<body onload="initialize()">

    <center><h4>BART</h4></center>
    <p>
      <center>

        <!-- drop down menu to select the train routes -->
        
        <form method= "post" action = "index.php">
          <select name = "train_route"> 
            <?php 
              // .. TODO .. error: displays n - 1 results
              while ($line = mysql_fetch_array($result1, MYSQL_ASSOC))
                  echo "<option value=".'"'."route{$line['id']}".'"'.">{$line['line']}</option>";
            ?>
          </select>
          <input type = "submit" value = "Go!"></input>
        </form>
      
      </center>
    </p>

    <div id="map_canvas" style="width:50%; height:50%"></div>
    
	</body>

</html>
