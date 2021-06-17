# coldfusion_lucee_google_map_api_storelocator_location_finder_application
ColdFusion - Javascript - googleMap Api : have not tried this with lucee but i dont see reason why this should not work 

This Application uses Adobe COLDFUSION 2016 along with Javascript and google map APi 

original data source is excel file from where it reads data , 

cfc is located in /cfc/location_.cfc

you need to make changes to GOOGLE MAP API KEY in app.js files and line { 141 - 152 } and Application.cfc 69 , 75 , i am using 2 set of key's one for prod and one for localhost 
testing . 

Business Logic

app.js is file which contains all business logic

DATA:

we have recieved data in excel from our business side , which includes name of business , lat , lng and lots of other info , which is located in data.xlsx file , 

I have looped around this excel and used /alt/examples/find_place_export_excel.cfm to call google https://maps.googleapis.com/maps/api/place/textsearch/json?query api to get 

accurate data and make data file off this especially name , lat / lng info instead of relying on business side data .( which was causing issues any way )

Final Data file is located in /data/exported_excel.xls exported of /alt/examples/find_place_export_excel.cfm file . 

Features : 
Cluster Display,

Reset Map,

Filter by State,

Filter by Country,

Distance Matrix ,

closest Location ,

5 closest location from specific address,

search business by name ,


Following google map api services needs to be enabled

Places API	,	

Distance Matrix API	,

Maps JavaScript API		,

Geocoding API	,

Street View Static API,
