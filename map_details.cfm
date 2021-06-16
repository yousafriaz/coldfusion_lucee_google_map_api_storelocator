<cfsetting showdebugoutput="no">
<cfset objMyQuery = createobject("component","cfc/locations_")>
<cfset qryLocationDetail = objMyQuery.getLocationDetails(storeid="#url.id#")>

<!---<cfdump var="#qryLocationDetail#">--->

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">

    <title>Goolge Map Project</title>

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

	<style>
	.col-md {
    height:450px !important;
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


/*.container{ max-height:1000px !important};*/
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
<cfoutput>
      <div class="container">
        <!-- Example row of columns -->
        <div class="row">
          <div class="col-md">
            <h2>#qryLocationDetail.name#</h2>
            <p class="notification">#qryLocationDetail.address#</p>
            
            <a target="_blank" class="btn btn-outline-primary" href="#qryLocationDetail.web#" title="{Center URL}">
                            Website<br>
                            
                            <i class="fas fa-external-link-alt"></i>
                        </a>

            <a target="_blank" class="btn btn-outline-primary" href="https://www.google.com/maps/dir/Current+Location/#URLEncodedFormat(qryLocationDetail.addressF)#" title="{Center URL}">
                            Directions<br>
                            
                            <i class="fas fa-external-link-alt"></i>
                        </a>
 
 
 
 
 
            
    <!-- This is new -->
<!---    <div class="btn-group">
        <button type="button" id="allbus" class="btn btn-success">Reset Map</button>
        <button type="button" id="others" class="btn btn-primary"> Clear Pin</button>
        <button type="button" id="cafes" class="btn btn-danger">Near By Locations</button>
    </div>
--->    <br><br>
        
        <h4>Contacts</h4>
        #qryLocationDetail.contact# #qryLocationDetail.email_primary#<br>
        #qryLocationDetail.email_secondary#

		<br>
        <h4>Phone Numbers</h4>
        #qryLocationDetail.phone1# 
            
<!---        <br><br>
        <h4>Social Media</h4>
    	{facebook} {instagram} {donation}
        <br><br>
--->            
        <br><br>
         <h4>Hours</h4>
        #qryLocationDetail.hours1#<br>
        #qryLocationDetail.hours2#<br>
        #qryLocationDetail.hours3#<br>
        #qryLocationDetail.hours4#<br>
        #qryLocationDetail.hours5#<br>
        #qryLocationDetail.hours6#<br>
        #qryLocationDetail.hours7#<br>    
        <br>
        
<!---            <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
           <p><a class="btn btn-secondary" href="" role="button">View details &raquo;</a></p>---> 
          </div>
          <div class="col-md-8" id="mapdetails" >
            <h2>Heading</h2>
            <p></p>
            <p><a class="btn btn-secondary" href="" role="button">View details &raquo;</a></p>
          </div>
        </div>
			
                <script src="app.js"></script>
    			<script async defer src="https://maps.googleapis.com/maps/api/js?key=#request.googlemapkey#&libraries=places&callback=initMapDetail">
    			</script>

        
		
      </div> <!-- /container -->
</cfoutput>
    </main>
	<br><br><br><br><br><br><br>
    <footer class="container"><hr>
      <p>&copy; Company 2017-2018</p>
    </footer>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  </body>
</html>
