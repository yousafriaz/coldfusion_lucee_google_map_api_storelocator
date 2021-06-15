# storelocator
ColdFusion - Javascript - googleMap Api

This Application uses Adobe COLDFUSION 2016 along with Javascript and google map APi 
original data source is excel file from where it reads data , 
cfc is located in /cfc/location_cfc
you need to make changes to GOOGLE MAP API KEY in app.js files and line { 141 - 152 } , i am using 2 set of key's one for prod and one for localhost testing . 
and Application.cfc 69 , 75

DATA:
we have recieved data in excel from our business side , which includes name of business , lat , lng and lots of other info , which is located in data.xlsx file , 
I have looped around this excel and used /alt/examples/find_place_export_excel.cfm to call google https://maps.googleapis.com/maps/api/place/textsearch/json?query api to get accurate data and make data file off this especially name , lat / lng info instead of relying on business side data .( which was causing issues any way )

Final Data file is located in /data/exported_excel.xls exported of /alt/examples/find_place_export_excel.cfm file . 
