const mapStyle = [{
  'featureType': 'administrative',
  'elementType': 'all',
  'stylers': [{
    'visibility': 'on',
  },
  {
    'lightness': 33,
  },
  ],
},
{
  'featureType': 'landscape',
  'elementType': 'all',
  'stylers': [{
    'color': '#f2e5d4',
  }],
},
{
  'featureType': 'poi.park',
  'elementType': 'geometry',
  'stylers': [{
    'color': '#c5dac6',
  }],
},
{
  'featureType': 'poi.park',
  'elementType': 'labels',
  'stylers': [{
    'visibility': 'on',
  },
  {
    'lightness': 20,
  },
  ],
},
{
  'featureType': 'road',
  'elementType': 'all',
  'stylers': [{
    'lightness': 20,
  }],
},
{
  'featureType': 'road.highway',
  'elementType': 'geometry',
  'stylers': [{
    'color': '#c5c6c6',
  }],
},
{
  'featureType': 'road.arterial',
  'elementType': 'geometry',
  'stylers': [{
    'color': '#e4d7c6',
  }],
},
{
  'featureType': 'road.local',
  'elementType': 'geometry',
  'stylers': [{
    'color': '#fbfaf7',
  }],
},
{
  'featureType': 'water',
  'elementType': 'all',
  'stylers': [{
    'visibility': 'on',
  },
  {
    'color': '#acbcc9',
  },
  ],
},
];

var geocoder = null;

function initMap() {
  // Create the map.
var markers = [];

  geocoder = new google.maps.Geocoder();
  const map = new google.maps.Map(document.getElementById('map'), {
    zoom: 4,
    center: {lat: 40.25145, lng: -95.89508},
	navigationControl: true,
	mapTypeControl: true
  });

  // Load the stores GeoJSON onto the map.
  map.data.loadGeoJson('locations_.cfc?method=myLocationData', {idPropertyName: 'storeid'});

  // Define the custom marker icons, using the store's "category".
  map.data.setStyle((feature) => {
    return {
      icon: {
        url: `img/icon_${feature.getProperty('category')}.png`,
        scaledSize: new google.maps.Size(64, 64),
      },
    };
  });


  const apiKey = 'AIzaSyDuSjJxKDbqvgHdNUrmWICe2LnH8LxWng0';
  const infoWindow = new google.maps.InfoWindow();

  // Show the information for a store when its marker is clicked.
  map.data.addListener('click', (event) => {
    const category = event.feature.getProperty('category');
    const name = event.feature.getProperty('name');
    const description = event.feature.getProperty('description');
    const hours = event.feature.getProperty('hours');
    const phone = event.feature.getProperty('phone');
    const position = event.feature.getGeometry().get();
    const content = `
<img style="float:left; width:200px; margin-top:30px" src="img/logo_${category}.png">
      <div style="margin-left:220px; margin-bottom:20px;">
        <h2>${name}</h2><p>${description} - ${position.lat()} - ${position.lng()}</p>
        <p><b>Open:</b> ${hours}<br/><b>Phone:</b> ${phone}</p>
        <p><img src="https://maps.googleapis.com/maps/api/streetview?size=350x120&location=${position.lat()},${position.lng()}&key=${apiKey}"></p>
      </div>    `;

    infoWindow.setContent(content);
    infoWindow.setPosition(position);
    infoWindow.setOptions({pixelOffset: new google.maps.Size(0, -30)});
    infoWindow.open(map);
  });


/*  function addMarker(feature) {
    var marker = new google.maps.Marker({
      position: feature.position,
      icon: icons[feature.type].icon,
      map: map
    });
  }
*/
 /* function addOption(feature, i) {
    var name = 'marker ' + i;  // you should have the name of the location in the data
    
	var option = '<option value="'+ i +'">' + name + '</option>';
    document.getElementById('dropdown').innerHTML += option;
  }*/
  


function selectOpion(selectElm,choice) {
    var p = selectElm.value;
	var bounds = new google.maps.LatLngBounds();

	//alert(choice);
    //clearMarkers();
	//map.setCenter(myfeatures[i].position); ?state='+p

	
     map.data.loadGeoJson('locations_.cfc?method=myLocationData&'+choice+'='+p, {idPropertyName: 'storeid'});

	 $.getJSON( {
		url  : 'locations_.cfc?method=myLocationData&'+choice+'='+p,
		data : {
			sensor  : false
		},
		success : function( data, textStatus ) {
			//console.log( textStatus, data );
			//var results = JSON.parse(data);
			
			if (data.features.length > 0){
				for (var i = 0; i < data.features.length; i++) {
		
					var coords = data.features[i].geometry.coordinates;
					var myLatLng = new google.maps.LatLng(coords[1],coords[0]);
					bounds.extend(myLatLng); // Iceland
					console.log( coords);
				}
				map.fitBounds(bounds);
			} // end if
		}
	} );
	
	
	}; // end of getJson

 
 


// we can use complate address here to go to exact location
//console.log(this);
  if(choice == 'state') // filter by state
	  if(p == 'All'){
		  var zoom = 3;
		  p = 'United States';
	  }
	  else if(p == 'Ontario'){
		  p = 'Toronto,Ontario';
		  var zoom = 6;
	  }
	  else
		  var zoom = 6;
  else if (choice == 'country'){ // filter by country
	   if(p == 'All'){
	   	var zoom = 4;
	   	p = 'United States';
	   }
	   else{
	  	var zoom = 4;
	   }
  }
  else if (choice == 'strname'){ // filter by name
	  var zoom = 4;
	  map.setZoom(zoom);
  }

if (choice != 'strname')
	findAddressState(p,zoom);
//map.setZoom(6);  // with many markers per country you could zoom/pan with the boundaries ... 



if (choice == 'strname'){
var bounds = new google.maps.LatLngBounds();

//bounds.extend(new google.maps.LatLng('43.67842', '-79.34441')); // Iceland
//bounds.extend(new google.maps.LatLng('43.84414', '-79.25432')); // Turkey
//bounds.extend(new google.maps.LatLng('43.82117', '-79.45601')); // Iceland
//bounds.extend(new google.maps.LatLng('35.87226', '-78.62179')); // Turkey



	 $.getJSON( {
		url  : 'locations_.cfc?method=myLocationData&'+choice+'='+p,
		data : {
			sensor  : false
		},
		success : function( data, textStatus ) {
			//console.log( textStatus, data );
			//var results = JSON.parse(data);
			
			for (var i = 0; i < data.features.length; i++) {
	
				var coords = data.features[i].geometry.coordinates;
				var myLatLng = new google.maps.LatLng(coords[1],coords[0]);
				bounds.extend(myLatLng); // Iceland
				console.log( coords);
			}
			map.fitBounds(bounds);
		}
	} );
	
	
	}; // end of getJson


}; // end of main



function findAddressState(address,intZoom) {
  var addressStr = address;
    geocoder.geocode({
      'address': address
    }, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        if (status != google.maps.GeocoderStatus.ZERO_RESULTS) {
          if (results && results[0] &&
            results[0].geometry && results[0].geometry.viewport)
            map.fitBounds(results[0].geometry.viewport);
			map.setZoom(intZoom);
			//console.log(results);
        } else {
          alert("No results found");
        }
      } else {
        alert("Geocode was not successful for the following reason: " + status);
      }
    });
  
}




function clearMarkers() {
  infoWindow.close();
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(null);
  }
  markers.length = 0;
}


function clearLocations() {
	  map.data.forEach(function(feature) {
    // If you want, check here for some constraints.
    map.data.remove(feature);
	
});
}

function addLocations() {
	  map.data.forEach(function(feature) {
    // If you want, check here for some constraints.
	map.data.add(feature);
});
}

  // onChange of the select element
  google.maps.event.addDomListener(document.getElementById('dropdown'), 'change', function(e) {
    clearLocations();
	selectOpion(this,'state');
	//addLocations();
  	
  	//console.log(this);
  });
  

  // onChange of the select element
  google.maps.event.addDomListener(document.getElementById('dropdowncountry'), 'change', function(e) {
    clearLocations();
	selectOpion(this,'country');
	//map.setZoom(2);
	//addLocations();
  	
  	//console.log(this);
  });

/*google.maps.event.addListener(map, 'bounds_changed', function() {
    var zoom = map.getBounds();
    //console.log(zoom);
});
*/

  $("#others").click(function() {
	  //map.addLayer(others)
	  //map.removeLayer(cafes)
  });
  $("#cafes").click(function() {
	  alert();
	  //map.addLayer(cafes)
	  //map.removeLayer(others)
  });
  $("#centers").click(function() {
	  var center = document.getElementById('strcenters');
	  if (center.value.length > 3){
		      clearLocations();
			  selectOpion(center,'strname');

	  }
	  else{
	  }
	  //alert(center);
	  //map.addLayer(cafes)
	  //map.removeLayer(others)
  });

  $("#allbus").click(function() {
	  //map.addLayer(cafes)
	  //map.addLayer(others)
  });
  
  
/*  var myfeatures = [{
    position: new google.maps.LatLng(40.25145, -95.89508),
    type: 'office'
  }, {
    position: new google.maps.LatLng(51.2368042, 4.4566387),
    type: 'office'
  }, {
    position: new google.maps.LatLng(50.1152834, 8.5038213),
    type: 'office'
  }, {
    position: new google.maps.LatLng(53.6245002, -1.7210977),
    type: 'office'
  }];

  for (var i = 0, feature; feature = myfeatures[i]; i++) {
    //addMarker(feature);
   
	addOption(feature, i);
	

  }
*/

/*

 // Build and add the search bar
  const card = document.createElement('div');
  const titleBar = document.createElement('div');
  const title = document.createElement('div');
  const container = document.createElement('div');
  const input = document.createElement('input');
  const options = {
    types: ['address'],
    componentRestrictions: {country: 'us'},
  };

  card.setAttribute('id', 'pac-card');
  title.setAttribute('id', 'title');
  title.textContent = 'Find the nearest store';
  titleBar.appendChild(title);
  container.setAttribute('id', 'pac-container');
  input.setAttribute('id', 'pac-input');
  input.setAttribute('type', 'text');
  input.setAttribute('placeholder', 'Enter an address');
  container.appendChild(input);
  card.appendChild(titleBar);
  card.appendChild(container);
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(card);

  // Make the search bar into a Places Autocomplete search bar and select
  // which detail fields should be returned about the place that
  // the user selects from the suggestions.
  const autocomplete = new google.maps.places.Autocomplete(input, options);

  autocomplete.setFields(
      ['address_components', 'geometry', 'name']);


// Set the origin point when the user selects an address
  const originMarker = new google.maps.Marker({map: map});
  originMarker.setVisible(false);
  let originLocation = map.getCenter();

  autocomplete.addListener('place_changed', async () => {
    originMarker.setVisible(false);
    originLocation = map.getCenter();
    const place = autocomplete.getPlace();

    if (!place.geometry) {
      // User entered the name of a Place that was not suggested and
      // pressed the Enter key, or the Place Details request failed.
      window.alert('No address available for input: \'' + place.name + '\'');
      return;
    }

    // Recenter the map to the selected address
    originLocation = place.geometry.location;
    map.setCenter(originLocation);
    map.setZoom(9);
    console.log(place);

    originMarker.setPosition(originLocation);
    originMarker.setVisible(true);

    // Use the selected address as the origin to calculate distances
    // to each of the store locations
    const rankedStores = await calculateDistances(map.data, originLocation);
    showStoresList(map.data, rankedStores);

    return;
  });







async function calculateDistances(data, origin) {
  const stores = [];
  const destinations = [];

  // Build parallel arrays for the store IDs and destinations
  data.forEach((store) => {
    const storeNum = store.getProperty('storeid');
    const storeLoc = store.getGeometry().get();

    stores.push(storeNum);
    destinations.push(storeLoc);
  });

  // Retrieve the distances of each store from the origin
  // The returned list will be in the same order as the destinations list
  const service = new google.maps.DistanceMatrixService();
  const getDistanceMatrix =
    (service, parameters) => new Promise((resolve, reject) => {
      service.getDistanceMatrix(parameters, (response, status) => {
        if (status != google.maps.DistanceMatrixStatus.OK) {
          reject(response);
        } else {
          const distances = [];
          const results = response.rows[0].elements;
          for (let j = 0; j < results.length; j++) {
            const element = results[j];
            const distanceText = element.distance.text;
            const distanceVal = element.distance.value;
            const distanceObject = {
              storeid: stores[j],
              distanceText: distanceText,
              distanceVal: distanceVal,
            };
            distances.push(distanceObject);
          }

          resolve(distances);
        }
      });
    });

  const distancesList = await getDistanceMatrix(service, {
    origins: [origin],
    destinations: destinations,
    travelMode: 'DRIVING',
    unitSystem: google.maps.UnitSystem.METRIC,
  });

  distancesList.sort((first, second) => {
    return first.distanceVal - second.distanceVal;
  });

  return distancesList;
}










function showStoresList(data, stores) {
  if (stores.length == 0) {
    console.log('empty stores');
    return;
  }

  let panel = document.createElement('div');
  // If the panel already exists, use it. Else, create it and add to the page.
  if (document.getElementById('panel')) {
    panel = document.getElementById('panel');
    // If panel is already open, close it
    if (panel.classList.contains('open')) {
      panel.classList.remove('open');
    }
  } else {
    panel.setAttribute('id', 'panel');
    const body = document.body;
    body.insertBefore(panel, body.childNodes[0]);
  }


  // Clear the previous details
  while (panel.lastChild) {
    panel.removeChild(panel.lastChild);
  }

  stores.forEach((store) => {
    // Add store details with text formatting
    const name = document.createElement('p');
    name.classList.add('place');
    const currentStore = data.getFeatureById(store.storeid);
    name.textContent = currentStore.getProperty('name');
    panel.appendChild(name);
    const distanceText = document.createElement('p');
    distanceText.classList.add('distanceText');
    distanceText.textContent = store.distanceText;
    panel.appendChild(distanceText);
  });

  // Open the panel
  panel.classList.add('open');

  return;
}

*/





}