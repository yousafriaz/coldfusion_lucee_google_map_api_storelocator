<cfsetting showdebugoutput="no">
<cfset objMyQuery = createobject("component","cfc/locations_")>
<cfset myQuery = objMyQuery.getLocation()>
<cfquery name="States" dbtype="query">
select DISTINCT state , country from myQuery order by state 
</cfquery>
<cfquery name="country" dbtype="query">
select DISTINCT country from myQuery order by country 
</cfquery>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">

    <title>Goole Map Project</title>

   <!-- <link rel="canonical" href="https://getbootstrap.com/docs/4.1/examples/jumbotron/">
-->
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://d19vzq90twjlae.cloudfront.net/leaflet-0.7/leaflet.css" />
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Leaflet.awesome-markers/2.0.2/leaflet.awesome-markers.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<!-- Custom styles for this template -->
    <link href="css/jumbotron.css" rel="stylesheet">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://d19vzq90twjlae.cloudfront.net/leaflet-0.7.3/leaflet.js"></script>
    <script src='https://api.tiles.mapbox.com/mapbox.js/v1.6.4/mapbox.js'></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Leaflet.awesome-markers/2.0.2/leaflet.awesome-markers.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <!-- These Two are for Clustring-->
	<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<!---    <script src="https://unpkg.com/@google/markerclustererplus@4.0.1/dist/markerclustererplus.min.js"></script>
--->    <script src="https://unpkg.com/@googlemaps/markerclustererplus/dist/index.min.js"></script>


  <style>
    /*#map {
      height: 100%;
    }*/
    
    html,
    body {
      height: 100%;
      margin: 0;
      padding: 0;
    }

    /* Styling for autocomplete search bar */
    #pac-card {
      background-color: #fff;
      border-radius: 2px 0 0 2px;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
      box-sizing: border-box;
      font-family: Roboto;
      margin: 10px 10px 0 0;
      -moz-box-sizing: border-box;
      outline: none;
    }
    
    #pac-container {
      padding-top: 12px;
      padding-bottom: 12px;
      margin-right: 12px;
    }
    
    #pac-input {
      background-color: #fff;
      font-family: Roboto;
      font-size: 15px;
      font-weight: 300;
      margin-left: 12px;
      padding: 0 11px 0 13px;
      text-overflow: ellipsis;
      width: 400px;
    }
    
    #pac-input:focus {
      border-color: #4d90fe;
    }
    
    #title {
      color: #fff;
      background-color: #acbcc9;
      font-size: 18px;
      font-weight: 400;
      padding: 6px 12px;
    }
    
    .hidden {
      display: none;
    }

    /* Styling for an info pane that slides out from the left. 
     * Hidden by default. */
    #panel {
      height: 100%;
      width: null;
      background-color: white;
      position: fixed;
      z-index: 1;
      overflow-x: hidden;
      transition: all .2s ease-out;
    }
    
    .open {
      width: 250px;
    }
    
    .place {
      font-family: 'open sans', arial, sans-serif;
      font-size: 1.2em;
      font-weight: 500;
      margin-block-end: 0px;
      padding-left: 18px;
      padding-right: 18px;
    }
    
    .distanceText {
      color: silver;
      font-family: 'open sans', arial, sans-serif;
      font-size: 1em;
      font-weight: 400;
      margin-block-start: 0.25em;
      padding-left: 18px;
      padding-right: 18px;
    }
	
	 .pac-container, .pac-item{
    z-index: 2147483647 !important;
 }
  h1, h2, h3, h4, h5, h6 {
    font-family: "merriweather","serif";
    font-weight: 400;
    font-style: normal;
    color: #444770;
    text-rendering: optimizeLegibility;
    margin-top: 0;
    margin-bottom: .5rem;
    line-height: 1.2;
}
  </style>

  </head>

  <body>

    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
      <a class="navbar-brand" href="#">Navbar</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="map.cfm">Home <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Link</a>
          </li>
          <li class="nav-item">
            <a class="nav-link disabled" href="#">Disabled</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="http://example.com" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</a>
            <div class="dropdown-menu" aria-labelledby="dropdown01">
              <a class="dropdown-item" href="#">Action</a>
              <a class="dropdown-item" href="#">Another action</a>
              <a class="dropdown-item" href="#">Something else here</a>
            </div>
          </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
          <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
      </div>
    </nav>

    <main role="main">

      <!-- Main jumbotron for a primary marketing message or call to action -->
      <div class="jumbotron" style="height:250px">
        <div class="container">
          <h1 class="display-3">Center Mapping Application</h1>
          
        
          <p>This is a template for a simple marketing or informational website. It includes a large callout called a jumbotron and three supporting pieces of content. Use it as a starting point to create something more unique.</p>
          <!---<p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more &raquo;</a></p>--->
        </div>
      </div>

      <div class="container">
        <!-- Example row of columns -->
        <div class="row">
          <div class="col-md-4">
            <h2>Center's Directory</h2>
            
            
    <!-- This is new -->
    
    <div class="btn-group">
        <button type="button" id="allbus" class="btn btn-success">Reset Map</button>
        <button type="button" id="others" class="btn btn-primary"> Clear Pin</button>
        <button type="button" id="clusters" class="btn btn-danger">Cluster Display</button>
        
    </div>
    <br><br>

<h4>Find 5 Nearest Locations</h4>
<!-- Default unchecked -->
<div class="form-check">
  <label class="form-check-label">
    <input type="radio" class="form-check-input" name="optradio" id="mylocation">USE MY LOCATION
  </label>
</div>
<!---     	<br><br>
        <input id="refresh" type="button" value="Refresh Map" class="item" />
      	<a href="#" id="clear">Clear</a>
--->
    <br><br>
        
        <h4>Filter by State/Province</h4>
        <select id="dropdown" class="form-control">
        	<option value="All">Reset Province or State</option>
			<cfoutput query="states">
            	<cfif trim(state) neq ''>
            	<option value="#state#">#state#</option>
                </cfif>
            </cfoutput>
        </select>

		<br><br>
        <h4>Filter by Country</h4>
        <select id="dropdowncountry" class="form-control">
        	<option value="All">Reset Country</option>
			<cfoutput query="country">
            	<option value="#country#">#country#</option>
            </cfoutput>
        </select>
            
        <br><br>
        <h4>Filter Center by Name</h4>
         <form class="form-inline my-2 my-lg-0">
          <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search" name="strcenters" id="strcenters">
          <button type="button" id="centers" class="btn btn-danger">Search</button>
        </form>
    <div class="col-md" id="info" >
    </div>
            
            
<!---            <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
           <p><a class="btn btn-secondary" href="#" role="button">View details &raquo;</a></p>---> 
          </div>
          <div class="col-md-8" id="map" >
            <h2></h2>
            <p></p>
            <p><a class="btn btn-secondary" href="#" role="button">View details &raquo;</a></p>
          </div>
<!--          <div class="col-md-4">
            <h2>Heading</h2>
            <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
            <p><a class="btn btn-secondary" href="#" role="button">View details &raquo;</a></p>
          </div>
-->        </div>
			<div id="mapbk" style="height:0px; width:0px"></div>
                <!-- this is for alternative app where less calls to json are made -->
				<script src="app.js"></script>
				<!---<script src="app.js"></script>--->
    			<script async defer src="https://maps.googleapis.com/maps/api/js?key=<cfoutput>#request.googlemapkey#</cfoutput>&libraries=places,geometry&callback=initMap">
    			</script>

        <hr>

      </div> <!-- /container -->

    </main>

    <footer class="container">
      <p>&copy; Company 2020-2021</p>
    </footer>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  </body>
</html>
