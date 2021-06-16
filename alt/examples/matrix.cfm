<cfhttp url="https://maps.googleapis.com/maps/api/distancematrix/json?origins=35.8299874,-78.8474981&destinations=32.75116,-117.24705|32.76906,-117.06028&key=#request.googlemapkey#"></cfhttp>

<cfdump var="#cfhttp.FileContent#">