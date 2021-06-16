/*
 * Copyright 2017 Google Inc. All rights reserved.
 *
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
 * file except in compliance with the License. You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under
 * the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
 * ANY KIND, either express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

// Style credit: https://snazzymaps.com/style/1/pale-dawn
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
var markerCluster ;
var markers = [];
var markerAll;
var markerAllNew;
var closest = [];
var global_data ;
var globalmy_data;
/*var markerSearch;
*/var infoWindow;

function initMap() {
  // Create the map.


  geocoder = new google.maps.Geocoder();
  const map = new google.maps.Map(document.getElementById('map'), {
    zoom: 4,
    center: {lat: 40.25145, lng: -95.89508},
	navigationControl: true,
	mapTypeControl: true
  });

  mapbk = new google.maps.Map(document.getElementById('mapbk'), {
    zoom: 0,
    center: {lat: 0, lng: 0},
	navigationControl: false,
	mapTypeControl: false
  });

  // Load the stores GeoJSON onto the map.
  map.data.loadGeoJson('cfc/locations_.cfc?method=myLocationData', {idPropertyName: 'storeid'});
  //mapbk =  map.data ; 
  //console.log(mapbk);
  mapbk.data.loadGeoJson('cfc/locations_.cfc?method=myLocationData', {idPropertyName: 'storeid'});
  // Define the custom marker icons, using the store's "category".
  map.data.setStyle((feature) => {
    return {
      icon: {
        url: `img/icon_${feature.getProperty('category')}.png`,
        scaledSize: new google.maps.Size(60, 60),
      },
    };
  });

  
  var strhostname = window.location.hostname;
  var strprod = 'cfdeploy.sowk.umaryland.edu';
  
  //console.log(strhostname.indexOf(strprod));
  
  if (strhostname.indexOf(strprod) !== -1){
  	var apiKey = 'AIzaSyA8uvY8BKz--0VBPd3QiiRqliijjwmsExY';
  }
  else{
	var apiKey = 'AIzaSyDuSjJxKDbqvgHdNUrmWICe2LnH8LxWng0';  	
  }
  infoWindow = new google.maps.InfoWindow(/*{ maxWidth:500}*/);

/*  const locationButton = document.createElement("button");
  locationButton.textContent = "Pan to Current Location";
  locationButton.classList.add("custom-map-control-button");
  map.controls[google.maps.ControlPosition.TOP_CENTER].push(
	locationButton
  );
*/  
  // Show the information for a store when its marker is clicked.
  map.data.addListener('click', (event) => {
    const category = event.feature.getProperty('category');
    const name = event.feature.getProperty('name');
    const address = event.feature.getProperty('address');
    const hours = event.feature.getProperty('hours');
    const phone = event.feature.getProperty('phone');
	const storeid = event.feature.getProperty('storeid');
    const position = event.feature.getGeometry().get();
    const content = `
<img style="float:left; width:100px; margin-top:30px" src="img/logo_${category}.png">
      <div style="margin-left:220px; margin-bottom:20px;">
        <h2>${name}</h2><p>${address} - ${position.lat()} - ${position.lng()}</p>
        <p><b>Open:</b> ${hours}<br/><b>Phone:</b> ${phone}</p>
		<p><b>Details:</b> <a href="map_details.cfm?id=${storeid}">Location Details</a></p>
        <p><img src="https://maps.googleapis.com/maps/api/streetview?size=350x120&location=${position.lat()},${position.lng()}&key=${apiKey}"></p>
      </div>    `;

    infoWindow.setContent(content);
    infoWindow.setPosition(position);
    infoWindow.setOptions({pixelOffset: new google.maps.Size(0, -30)});
    infoWindow.open(map);
	
  });


/*	 $.getJSON( {
		url  : 'cfc/locations_.cfc?method=myLocationData',
		data : {
			sensor  : false
		},
		success : function( data, textStatus ) {
			//console.log( textStatus, data );			
			if (data.features.length > 0){
			var global_data = data ;
			} // end if
		} // end success 
	}); // end getJson
*/

  // This is to make global JSON array to be used afterwards instead of calling
  // cfc again n again . within callbackFuncWithData setting up global score variable
  // to save json data . 
  $.getJSON("cfc/locations_.cfc?method=myLocationData", callbackFuncWithData);



  // Build and add the search bar
  const card = document.createElement('div');
  const titleBar = document.createElement('div');
  const title = document.createElement('div');
  const container = document.createElement('div');
  const input = document.createElement('input');
  const options = {
    types: ['address'],
    componentRestrictions: {country: ['us','ca']},
  };

  card.setAttribute('id', 'pac-card');
  title.setAttribute('id', 'title');
  title.textContent = 'Find the nearest location';
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
  var m_lat;
  var m_lng;
  
  const autocomplete = new google.maps.places.Autocomplete(input, options);

  autocomplete.setFields(
      ['address_components', 'geometry', 'name']);

  // Set the origin point when the user selects an address
  const originMarker = new google.maps.Marker({map: map});
  originMarker.setVisible(false);
  let originLocation = map.getCenter();

  autocomplete.addListener('place_changed', async () => {
    //clearLocations();
	//map.data.loadGeoJson('cfc/locations_.cfc?method=myLocationData', {idPropertyName: 'storeid'});
	originMarker.setVisible(false);
    originLocation = map.getCenter();
    const place = autocomplete.getPlace();
	

    if (!place.geometry) {
      // User entered the name of a Place that was not suggested and
      // pressed the Enter key, or the Place Details request failed.
      window.alert('No address available for input: \'' + place.name + '\'');
      return;
    }
	else{
	var m_lat = autocomplete.getPlace().geometry.location.lat();
	var m_lng = autocomplete.getPlace().geometry.location.lng();
	
	}

    // Recenter the map to the selected address
    originLocation = place.geometry.location;
    map.setCenter(originLocation);
    map.setZoom(9);
    //console.log('place',place.geometry.location);

    originMarker.setPosition(originLocation);
    originMarker.setVisible(true);

    // Use the selected address as the origin to calculate distances
    // to each of the store locations

	// if there is issue with myCalc , then we can disable this function
	// and enable rankedStores and update mao below , which work fine except 
	// for hawaii locations . 
	const myCalc = getGlobal(originLocation,5);

	
	//const rankedStores = await calculateDistances(mapbk.data,originLocation );
	
	//console.log(rankedStores);
    //var myData = getAllData();//SetMarkers();
	//getAllData( function ( value ) { console.log(value); } );
	//updateMap(rankedStores,m_lat,m_lng);
	
	

    return;
  }); // end auto Complete Function 

function createString(arr, key) {
  return arr.map(function (obj) {
    return obj[key];
  }).join(', ');
}
  
function updateMap(calDistance,m_lat,m_lng) {
    //var p = selectElm.value;
	var bounds = new google.maps.LatLngBounds();
	var p = createString(calDistance, 'storeid');
	var p =p.split(",",5);
	//var remainder = p.substring(p.indexOf(",")+1, p.len());
	
	var choice = 'storeids';
	var limitData = 5 ;
	clearLocations();
	//console.log(p);


	 $.getJSON( {
		url  : 'cfc/locations_.cfc?method=myLocationData&'+choice+'='+p+'&strLimit='+limitData,
		data : {
			sensor  : false
		},
		success : function( data, textStatus ) {
			//console.log( textStatus, data );			
			if (data.features.length > 0){
				for (var i = 0; i < data.features.length; i++) {
		
					var coords = data.features[i].geometry.coordinates;
					var myLatLng = new google.maps.LatLng(coords[1],coords[0]);
					bounds.extend(myLatLng); // Iceland
					//console.log( coords);
				}
				var myLatLng = new google.maps.LatLng(m_lat,m_lng);
				bounds.extend(myLatLng);
				map.data.addGeoJson(data, {idPropertyName: 'storeid'});
				map.fitBounds(bounds);
				//console.log( data);
			} // end if
		} // end success 
	}); // end getJson
}; // end of function


function selectOpion(selectElm,choice) {
    var p = selectElm.value;
	var bounds = new google.maps.LatLngBounds();
	originMarker.setVisible(false);
	clearLocations();
	try{
	clearMarkers();
	
	}catch(e){
		console.log('Ignoring this to move on with the code execution ');
	}

//console.log( global_data);
			if (global_data.features.length > 0){
				for (var i = 0; i < global_data.features.length; i++) {
					console.log( global_data.features[i].properties.stateabv)
					if (global_data.features[i].properties.stateabv == p){
						var coords = global_data.features[i].geometry.coordinates;
						var myLatLng = new google.maps.LatLng(coords[1],coords[0]);

					var centerName = global_data.features[i].properties.name;
					var centerCategory = global_data.features[i].properties.category;
					var centerAddress = global_data.features[i].properties.address;
					var centerPhone = global_data.features[i].properties.phone;
					var centerStoreid = global_data.features[i].properties.storeid;
					var centerHours = global_data.features[i].properties.hours;

					  markerAllNew = new google.maps.Marker({
										position: {
											lat: parseFloat(coords[1]),
											lng: parseFloat(coords[0])
										},
										icon: 'img/icon_'+centerCategory+'.png',
										map: map
									});
					//map.data.addGeoJson(data, {idPropertyName: 'storeid'});
					//tt.push(marker);
					bounds.extend(myLatLng); // Iceland
					var content = `
							<img style="float:left; width:100px; margin-top:30px" src="img/logo_${centerCategory}.png">
								  <div style="margin-left:220px; margin-bottom:20px;">
									<h2>${centerName}</h2><p>${centerAddress}</p>
									<p><b>Open:</b> ${centerHours}<br/><b>Phone:</b> ${centerPhone}</p>
									<p><b>Details:</b> <a href="map_details.cfm?id=${centerStoreid}">Location Details</a></p>
									<p><img src="https://maps.googleapis.com/maps/api/streetview?size=350x120&location=${coords[1]},${coords[0]}&key=${apiKey}"></p>
								  </div>    `;
	  
					var infowindowc = new google.maps.InfoWindow();
								
					google.maps.event.addListener(markerAllNew,'click', (function(markerAllNew,content,infowindowc){ 
						return function() {
							infowindowc.setContent(content);
							infowindowc.open(map,markerAllNew);
						};
					})(markerAllNew,content,infowindowc));  




					}//console.log( coords);
				}
					//map.data.setMap(null);
					map.fitBounds(bounds);

				
			}
}; // end of function

        

function resetMap() {
	originMarker.setVisible(false);
	clearLocations();
	try{
	clearMarkers();
	
	}catch(e){
		console.log('Ignoring this to move on with the code execution ');
	}
	markerCluster = 999;
	
	var bounds = new google.maps.LatLngBounds();


	 $.getJSON( {
		url  : 'cfc/locations_.cfc?method=myLocationData',
		data : {
			sensor  : false
		},
		success : function( data, textStatus ) {
			//console.log( textStatus, data );			
			if (data.features.length > 0){
				for (var i = 0; i < data.features.length; i++) {
		
					var coords = data.features[i].geometry.coordinates;
					var myLatLng = new google.maps.LatLng(coords[1],coords[0]);
					bounds.extend(myLatLng); // Iceland
					
					//console.log(data.features[i].properties.storeid);
					//console.log( coords);
				
				}
				map.data.addGeoJson(data, {idPropertyName: 'storeid'});
				
				map.fitBounds(bounds);
			} // end if
		} // end success 
	}); // end getJson
}; // end of function

	  
function clearLocations() {
	  map.data.forEach(function(feature) {
      // If you want, check here for some constraints.
      map.data.remove(feature);
	 // map.data.setMap(null);
	
});
};

		

  // onChange of the select element
  google.maps.event.addDomListener(document.getElementById('dropdown'), 'change', function(e) {
    clearLocations();
	selectOpion(this,'state');
  	//console.log(this);
  });
  

  // onChange of the select element
  google.maps.event.addDomListener(document.getElementById('dropdowncountry'), 'change', function(e) {
    clearLocations();
	selectOpion(this,'country');
  });


$("#centers").click(function() {
	var center = document.getElementById('strcenters');
	if (center.value.length > 3){
			clearLocations();
			selectOpion(center,'strname');

	}
	else{
	}
});

$("#allbus").click(function() {
    clearLocations();
	resetMap();
});

$("#others").click(function() {
	originMarker.setVisible(false);
	//map.addLayer(others)
	//map.removeLayer(cafes)
});
  
$("#cafes").click(function() {
  var bounds = new google.maps.LatLngBounds();

if (navigator.geolocation) {
  navigator.geolocation.getCurrentPosition(
	(position) => {
	  const pos = {
		lat: position.coords.latitude,
		lng: position.coords.longitude,
	  };
	  var test = position.coords.latitude + ',' + position.coords.longitude;
	  var newOrigin = new google.maps.LatLng(test);
	  //map.setCenter(newOrigin);
	  //map.setZoom(9);

	  //const rankedStores = calculateDistances(map.data, newOrigin);
	  //findAddressState(test,6);
	  //console.log( newOrigin );
	  //console.log( map.data );
	  //console.log(rankedStores);
	  //infoWindow.setPosition(pos);
	  //infoWindow.setContent("Location found.");
	  //infoWindow.open(map);
	  map.setCenter(pos);
	},
	() => {
	  handleLocationError(true, infoWindow, map.getCenter());
	}
  );
} else {
  // Browser doesn't support Geolocation
  handleLocationError(false, infoWindow, map.getCenter());
}

	
});

  
$("#clusters").click(function() {
	//originMarker.setVisible(false);
	//map.addLayer(others)
	//map.removeLayer(cafes)
	 clearLocations();
    // var tt = [];
	//alert(cstr); 
	if(! markerCluster || markerCluster == 999) {
	markerCluster = new MarkerClusterer(map, [], {
	imagePath:
  "https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m",
  });
	  
 								
	 
	 $.getJSON( {
		url  : 'cfc/locations_.cfc?method=myLocationData',
		data : {
			sensor  : false
		},
		success : function( data, textStatus ) {
			//console.log( data );			
			if (data.features.length > 0){
				for (var i = 0; i < data.features.length; i++) {
		
					var coords = data.features[i].geometry.coordinates;
					var centerName = data.features[i].properties.name;
					var centerCategory = data.features[i].properties.category;
					var centerAddress = data.features[i].properties.address;
					var centerPhone = data.features[i].properties.phone;
					var centerStoreid = data.features[i].properties.storeid;
					var centerHours = data.features[i].properties.hours;
					
					
					var myLatLng = new google.maps.LatLng(coords[1],coords[0]);
					
					//bounds.extend(myLatLng); // Iceland

					
					  markerAll = new google.maps.Marker({
										position: {
											lat: parseFloat(coords[1]),
											lng: parseFloat(coords[0])
										},
										icon: 'img/icon_'+centerCategory+'.png',
										map: map
									});
					//map.data.addGeoJson(data, {idPropertyName: 'storeid'});
					//tt.push(marker);
					var content = `
							<img style="float:left; width:100px; margin-top:30px" src="img/logo_${centerCategory}.png">
								  <div style="margin-left:220px; margin-bottom:20px;">
									<h2>${centerName}</h2><p>${centerAddress}</p>
									<p><b>Open:</b> ${centerHours}<br/><b>Phone:</b> ${centerPhone}</p>
									<p><b>Details:</b> <a href="map_details.cfm?id=${centerStoreid}">Location Details</a></p>
									<p><img src="https://maps.googleapis.com/maps/api/streetview?size=350x120&location=${coords[1]},${coords[0]}&key=${apiKey}"></p>
								  </div>    `;
	  
					var infowindowc = new google.maps.InfoWindow();
								
					google.maps.event.addListener(markerAll,'click', (function(markerAll,content,infowindowc){ 
						return function() {
							infowindowc.setContent(content);
							infowindowc.open(map,markerAll);
						};
					})(markerAll,content,infowindowc));  


					markerCluster.addMarker(markerAll);
        			markers.push(markerAll);

				

					//console.log( coords);
				}
			} // end if

//		infoWindow = new google.maps.InfoWindow();
		
		 //markerCluster = new MarkerClusterer(map, tt,{imagePath: `img/m`});
		//markerCluster.clearMarkers();
		
		
		//console.log( tt );
		//preventDefault();
        //stopPropagation();
       	// markerClusterer.clearMarkers();
		//$("#clusters").prop("disabled",true);			
			

		} // end success 
	}); // end getJson
	 }

  // Add some markers to the map.
  // Note: The code uses the JavaScript Array.prototype.map() method to
  // create an array of markers based on a given "locations" array.
  // The map() method here has nothing to do with the Google Maps API.
/*  const markers = locations.map((location, i) => {
    return new google.maps.Marker({
      position: location,
      label: labels[i % labels.length],
    });
  });*/
  // Add a marker clusterer to manage the markers.
/*var markerCluster = new MarkerClusterer(map, markers,
            {imagePath: `img/m`});
*/
});

//google.maps.event.addDomListener(document.getElementById('refresh'),'click', clearMarkers);

function setMapOnAll(map) {
    for (let i = 0; i < markers.length; i++) {
      markers[i].setMap(map);
    }
  }
  // Removes the markers from the map, but keeps them in the array.
function clearMarkers() {
    setMapOnAll(null);
    markerCluster.clearMarkers(markerAll);
}
  
  // Shows any markers currently in the array.
  function showMarkers() {
    setMapOnAll(map);
  }




/**
 * Use Distance Matrix API to calculate distance from origin to each store.
 * @param {google.maps.Data} data The geospatial data object layer for the map
 * @param {google.maps.LatLng} origin Geographical coordinates in latitude
 * and longitude
 * @return {Promise<object[]>} n Promise fulfilled by an array of objects with
 * a distanceText, distanceVal, and storeid property, sorted ascending
 * by distanceVal.
 */
async function calculateDistances(data, origin) {
  
  
   const destinations = [];
   const stores = [];
   const destinations_p = [];
 
  // Build parallel arrays for the store IDs and destinations
  data.forEach((store) => {

	const storeNum = store.getProperty('storeid');
    const storeLoc = store.getGeometry().get();
	
    destinations_p.push(storeLoc);
	stores.push(storeNum); 
    
	
  });
  
  destinations.push(destinations_p,stores);
  //console.log(destinations);
 /******************************************************************************************
 	I thought this step above would be helpful to make 2 dimentional array and send it to 
 	distance metrix service and get storeid sorted in that function but distance matrix only 
  	allow a set of inputs to be taken in consideration , we cannot set additional custom identtifier
 	
	
	NOTE: IS SOMEHOW THIS FUNCTION DOES NOT WORK PROPERLY USE SUBSTITUTE FUNCTION I HAD IN TEST
	PHASE UNDER /DATA/TEST.CFM - ITS LOCAL CFM FUNCTION WHICH CALCULATES DISTANCE BETWEEEN 2 
	GIVEN LAT LNG , NEEDS TWEAKING TO BE USED HERE . 
********************************************************************************************/



  // Retrieve the distances of each store from the origin
  // The returned list will be in the same order as the destinations list
  const service = new google.maps.DistanceMatrixService();
 // console.log(service);
  const getDistanceMatrix =
    (service, parameters) => new Promise((resolve, reject) => {
      service.getDistanceMatrix(parameters, (response, status) => {
        if (status != google.maps.DistanceMatrixStatus.OK) {
          reject(response);
        } else {
          const distances = [];
          const results = response.rows[0].elements;
          //console.log(response);
		  for (let j = 0; j < results.length; j++) {
            const element = results[j];
			//console.log(element);
            const distanceText = (element.status != 'ZERO_RESULTS') ? element.distance.text : '9999999999 km';
            const distanceVal = (element.status != 'ZERO_RESULTS') ? element.distance.value : '9999999999 km'; 
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
	
	  
  /***********************************************************************************
  This method was build to pass only 25 destinations in array to distance matrix 
  service , please that's the max it was take at a time , if there is change to this 
  settings in google then only chnage max_records value below and it should work
  ************************************************************************************/
  let p_results = [];
  let p_process = [];
  let nextSet = [] ;
  var lastIndex = 0
  var max_records = 25 ;
  var p_stores = [] ;
  var flatArray = [];
  var total_records = Math.ceil(destinations[0].length/max_records);


// later i figured out that foreach does not work with async function however for loop works

/*  data.forEach((store) => {
  let p_val = store.getGeometry().get().lat()+","+store.getGeometry().get().lng();
  p_results.push("["+p_val+"]");
    });
*/  

 
 for(var g=1 ; g<=total_records ; g++){
 
 	 let nextSet = [] ;
	 
	 /*************************************************************
	 These debugging could be use to match what we are sending 
	 matching with destination and storeid'd in parallel array
	 console.log(destinations[0].slice(lastIndex, max_records));
	 console.log(destinations[1].slice(lastIndex, max_records));
	 *************************************************************/
	 nextSet.push(destinations[0].slice(lastIndex, max_records));
 	 
  	lastIndex = max_records ;
	max_records = lastIndex + 25;
	
	/*********************************************************************************************
	There is some issue going on with hawaii lats and lng - This is Test for that these are hawaii
	lat,lng from excel
	
	   https://developers.google.com/maps/documentation/places/web-service/place-id#find-id
	   {tried place id's also : }
	   https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=715%20S%20King%20St,%20Honolulu,%20HI%2096813,%20USA&destinations=place_id:ChIJMQhmN-dtAHwR5Ce1PZClZcU|place_id:ChIJKzzKfvwOVHkRB9nZfZ35Ghg&key=
	   
	   p_process.push(await getDistanceMatrix(service, {
		  origins: ['21.304247103770592,-157.8504303328067'],
		  destinations: ['19.638878300603324,-155.9901696156307','19.666046167473695,-155.99401485525755','19.517828633585925,-155.92144357145344','19.927879613527526,-155.78726601617393','21.304247103770592,-157.8504303328067'],
		  travelMode: 'DRIVING',
		  unitSystem: google.maps.UnitSystem.METRIC,
		}));
	
	*********************************************************************************************/
 
   p_process.push(await getDistanceMatrix(service, {
	  origins: [origin],
	  destinations: nextSet[0],
      travelMode: google.maps.TravelMode.DRIVING,
      unitSystem: google.maps.UnitSystem.METRIC,
      avoidHighways: false,
      avoidTolls: false
	}));
  
	
 }; // end for loop


	/**********************************************************
	So i get back array results from getDistance matrix and now
	they are nice stacked in 3,4,5 etc # of array depends on how
	many set of 25's where passed , now to process further more
	we need to merge all these array togather and stamp back 
	storeID - if you get 'undefined' error that means somehow 
	there is mismatch between array and loop count .
	**********************************************************/
	
	

	flatArray = Array.prototype.concat(...p_process);
	//console.log(flatArray);
	for (var h = 0; h < flatArray.length; h++) {
		 
		  flatArray[h].storeid = h ; // reassigning storeid
			 
	};
	
  
    // finally sorting array's
	flatArray.sort((first, second) => {
		return first.distanceVal - second.distanceVal;
	});
  
  
  //console.log(flatArray);
  return  flatArray;

}; // end function
        

  

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
  
};


  
function handleLocationError(browserHasGeolocation, infoWindow, pos) {
	  infoWindow.setPosition(pos);
	  infoWindow.setContent(
		browserHasGeolocation
		  ? "Error: The Geolocation service failed."
		  : "Error: Your browser doesn't support geolocation."
	  );
	  infoWindow.open(map);
};



// These 3 function are for USE MY LOCATION CODE . 

async function showLocation(position) {
  var latitude = position.coords.latitude;
  var longitude = position.coords.longitude;
  var latlongvalue = position.coords.latitude+ ","+ position.coords.longitude;
  let rankedStores =  await calculateDistances(mapbk.data,latlongvalue );
  updateMap(rankedStores,latitude,longitude);
  //console.log(rankedStores);
  
  //var img_url = "https://maps.googleapis.com/maps/api/staticmap?center="+latlongvalue+"&amp;zoom=14&amp;size=400x300&amp;key="+apiKey;
  //document.getElementById("mapholder").innerHTML = "<img src='"+img_url+"'>";
};
function errorHandler(err) {
  if(err.code == 1) {
	 alert("Error: Access is denied!");
  } else if( err.code == 2) {
	 alert("Error: Position is unavailable!");
  }
};

$("#mylocation").click(function() {
	  if(navigator.geolocation){
	 // timeout at 60000 milliseconds (60 seconds)
	 var options = {timeout:60000};
	 navigator.geolocation.getCurrentPosition
	 (showLocation, errorHandler, options);
  } else{
	 alert("Sorry, browser does not support geolocation!");
  }
});


// this function to make global marker array .. 

function getGlobal(pt,numberOfResults){
	   var closest = [];
	   var gmarkers = [];
	   //document.getElementById('info').innerHTML += "processing "+gmarkers.length+"<br>";
		//console.log(pt);

	 $.getJSON( {
		url  : 'cfc/locations_.cfc?method=myLocationData',
		data : {
			sensor  : false
		},
		success : function( data, textStatus ) {
			//console.log( data );			
			if (data.features.length > 0){
				for (var i = 0; i < data.features.length; i++) {
		
					var coords = data.features[i].geometry.coordinates;
					var myLatLng = new google.maps.LatLng(coords[1],coords[0]);
					var centerName = data.features[i].properties.name;
					var centerCategory = data.features[i].properties.category;
					var centerAddress = data.features[i].properties.address;
					var centerPhone = data.features[i].properties.phone;
					var centerStoreid = data.features[i].properties.storeid;
					
					//bounds.extend(myLatLng); // Iceland

					
					  var markerSearch = new google.maps.Marker({
										position: {
											lat: parseFloat(coords[1]),
											lng: parseFloat(coords[0])
										},
										storeid: centerStoreid,
										title: centerName,
										address: centerAddress,
										map: map
									});
					
					 gmarkers.push(markerSearch);				
					//map.data.addGeoJson(data, {idPropertyName: 'storeid'});
					//tt.push(marker);

				

					//console.log( coords);
				} // end for 
				
				
				 console.log(gmarkers);
				 //closest = [];
				 for (var i=0; i<gmarkers.length;i++) {
				   gmarkers[i].distance = google.maps.geometry.spherical.computeDistanceBetween(pt,gmarkers[i].getPosition());
				   //document.getElementById('info').innerHTML += "process "+i+":"+gmarkers[i].getPosition().toUrlValue(6)+":"+gmarkers[i].distance.toFixed(2)+"<br>";
				   gmarkers[i].setMap(null);
				   closest.push(gmarkers[i]);
				 }
				
				   closest.sort(sortByDist);
				   //console.log(closest);
				   closest = closest.splice(0,numberOfResults);
				  // console.log(closest);
				   MYcalculateDistances(pt, closest,numberOfResults);
				   
				
			} // end if			

		} // end success 
	}); // end getJson

	
	
};



function sortByDist(a,b) {
   return (a.distance- b.distance)
}




function MYcalculateDistances(pt,closest,numberOfResults) {
  var service = new google.maps.DistanceMatrixService();
  var request =    {
      origins: [pt],
      destinations: [],
      travelMode: google.maps.TravelMode.DRIVING,
      unitSystem: google.maps.UnitSystem.METRIC,
      avoidHighways: false,
      avoidTolls: false
    };
  for (var i=0; i<closest.length; i++) {
    request.destinations.push(closest[i].getPosition());
  }
  service.getDistanceMatrix(request, function (response, status) {
    
	if (status != google.maps.DistanceMatrixStatus.OK) {
      alert('Error was: ' + status);
    } else {
      var origins = response.originAddresses;
      var destinations = response.destinationAddresses;
      var outputDiv = document.getElementById('info');
      outputDiv.innerHTML = '';

      var results = response.rows[0].elements;
      //console.log(results);// save title and address in record for sorting
      for (var i=0; i<closest.length;i++) {
         
		 	if(results[i].status == 'ZERO_RESULTS')
			{
			//console.log(results[i]);
			results[i].distance = "{text:0,value:0}";
			results[i].duration = "{text:0,value:0}";
			}
			results[i].title = closest[i].title;
         	results[i].address = closest[i].address;
		 	results[i].storeid = closest[i].storeid;
	 		results[i].idx_closestMark = i;
		 
	  }
      
	 // console.log(results);
	  results.sort(sortByDistDM);
	  //console.log(kk);
	  
	  //var myarr = createString(results, 'storeid');
	  
      for (var i = 0; ((i < numberOfResults) && (i < closest.length)); i++) {
        //closest[i].setMap(map);
       /* console.log(i);
		if(results[i].status != 'ZERO_RESULTS')
		outputDiv.innerHTML += "<a href='javascript:google.maps.event.trigger(closest["+results[i].idx_closestMark+"],\"click\");'>"+results[i].title + '</a><br>' + results[i].address+"<br>"
            + results[i].distance.text + ' appoximately '
            + results[i].duration.text + '<br><hr>';*/
     } 
    }
  
	var m_lat = pt.lat();
	var m_lng = pt.lng();
	  
   MYmap(results,m_lat,m_lng);
  
  
  });

}
function sortByDistDM(a,b) {
   return (a.distance.value- b.distance.value)
}



function MYmap(calDistance,m_lat,m_lng){

	var bounds = new google.maps.LatLngBounds();
	var p = createString(calDistance, 'storeid');
	//var p =p.split(",",5);
	//var remainder = p.substring(p.indexOf(",")+1, p.len());
	
	var choice = 'storeids';
	var limitData = 5 ;
	clearLocations();
	//console.log(p);


	 $.getJSON( {
		url  : 'cfc/locations_.cfc?method=myLocationData&'+choice+'='+p+'&strLimit='+limitData,
		data : {
			sensor  : false
		},
		success : function( data, textStatus ) {
			//console.log( textStatus, data );			
			if (data.features.length > 0){
				for (var i = 0; i < data.features.length; i++) {
		
					var coords = data.features[i].geometry.coordinates;
					var myLatLng = new google.maps.LatLng(coords[1],coords[0]);
					bounds.extend(myLatLng); // Iceland
					//console.log( coords);
				}
				var myLatLng = new google.maps.LatLng(m_lat,m_lng);
				bounds.extend(myLatLng);
				map.data.addGeoJson(data, {idPropertyName: 'storeid'});
				map.fitBounds(bounds);
				//console.log( data);
			} // end if
		} // end success 
	}); // end getJson
}; // end of function












































} ;// end initMap()

function callbackFuncWithData(data){

     global_data = data;
	console.log(global_data);
	
};


function initMapDetail() {

    
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);
	const sid = urlParams.get('id')
	var bounds = new google.maps.LatLngBounds();

    const cmap = new google.maps.Map(document.getElementById('mapdetails'), {
    zoom: 15,
	mapTypeId: "roadmap",
    center: {lat: 0, lng: 0},
	navigationControl: true,
	mapTypeControl: true
  });
	
	  cmap.data.setStyle((feature) => {
		return {
		  icon: {
			url: `img/icon_${feature.getProperty('category')}.png`,
			scaledSize: new google.maps.Size(64, 64),
		  },
		};
	  });

	//clearLocations();
	
	$.getJSON( {
		url  : 'cfc/locations_.cfc?method=myLocationData&storeids='+sid,
		data : {
			sensor  : false
		},
		success : function( data, textStatus ) {
			//console.log( textStatus, data );			
			if (data.features.length > 0){
				for (var i = 0; i < data.features.length; i++) {
		
					var coords = data.features[i].geometry.coordinates;
					var myLatLng = new google.maps.LatLng(coords[1],coords[0]);
					bounds.extend(myLatLng);
					//console.log( coords);
				}
				cmap.data.addGeoJson(data, {idPropertyName: 'storeid'});
				
				cmap.fitBounds(bounds);
				cmap.setZoom(15);
			} // end if
		} // end success 
	}); // end getJson
	

function clearLocations() {
	  cmap.data.forEach(function(feature) {
      // If you want, check here for some constraints.
      cmap.data.remove(feature);
	
});
};
	
	
	
	//console.log(id);
	
};