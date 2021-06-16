	$.getJSON( 'myLocation.cfm?state='+p, function(data) {    
	
		$.each( data, function(i, value) {
	
		  var myLatlng = new google.maps.LatLng(value.lat, value.lng);
		    //alert(myLatlng);
			console.log(value);

		  var marker = new google.maps.Marker({position: myLatlng, map: map, title: "text " + value.lng, icon: "img/logo_resturant.png"});
	
		  var infowindow = new google.maps.InfoWindow ({
			content: "<b>Name:</b> " + value.name + "<br>" +
				 "<b>Open:</b> " + value.hours + "<br>" 
/*				 "<b>Date:</b> " + value.day + "-" + value.month + "-" + value.year + "<br>" +
				 "<b>Killed:</b> " + value.killed + "<br>" +
				 "<b>Wounded:</b> " + value.wounded + "<br>" +
				 "<b>Attack Type:</b> " + value.attack_type + "<br>" +
				 "<b>Organization:</b> " + value.guilty + "<br>" 
*/	
		  }); // end of infowindows
	
		  marker.addListener('click', function() {
			  infowindow.open(map, marker);
			  //infoWindow.open(map);
		  }); // end of marker listner
	
		}); // End of for each
	
	  }); //end of getHSON

// geojson Example 1 using buttons
http://bl.ocks.org/zross/47760925fcb1643b4225

using radion button
http://www.gistechsolutions.com/leaflet/DEMO/filter/filter.html




// get data from database

var geojsondata = JSON.parse('data from mysql database already in the client side');
map.data.addGeoJson(geojsondata); 

//google map movment addlistner  - this is what i modified for dropdown
https://jsfiddle.net/kpoynp8w/9/

// how to add custom listner
https://stackoverflow.com/questions/35366806/how-can-i-access-dataobjects-in-geojson-data-placed-on-google-maps

//on button event
https://stackoverflow.com/questions/35204167/get-json-data-and-filter-markers-on-google-maps-with-button

//some filter examples
https://codepen.io/sevleonard/pen/NRWNkV

//mechdonalds json file
https://github.com/gavinr/usa-mcdonalds-locations/blob/master/mcdonalds.geojson
https://raw.githubusercontent.com/gavinr/usa-mcdonalds-locations/master/mcdonalds.geojson




http://127.0.0.1/mygooglemap/locations_.cfc?method=myLocationData&strname=hopk
http://127.0.0.1/mygooglemap/locations_.cfc?method=myLocationData&sensor=false&choice=hopk


//another way of doing distance matrix

/*function calculateDistances(origins,destinations) {
   origins = [];
   destinations = [];

            var service = new google.maps.DistanceMatrixService();
            var d = $.Deferred();
            service.getDistanceMatrix(
                {
                    origins: origins,
                    destinations: destinations,
                    travelMode: google.maps.TravelMode.DRIVING,
                    unitSystem: google.maps.UnitSystem.METRIC,
                    avoidHighways: false,
                    avoidTolls: false
                }, 
                function(response, status){
                  if (status != google.maps.DistanceMatrixStatus.OK) {
                     d.reject(status);
                  } else {
                     d.resolve(response);
                  }
                });
            return d.promise();
};
*/


