<cfsetting showdebugoutput="no">
<cfscript>
myQuery = queryNew("storeid,name,lat,lng,address,city,state,country,zip,phone,category,hours","Integer,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar", 
[ 
  {storeid=1,name="Chipotle North Carolina",lat='35.87226',lng='-78.62179',address='6102 Falls of Neuse Rd,Raleigh,North Carolina,27609',city='Raleigh',state='North Carolina',country='United States',zip='',phone='919-922-6662',category='restaurant',hours='10am - 6pm'}, 
  {storeid=2,name="Chipotle Mexican Grill",lat='35.86614',lng='-78.70659',address='6602 Glenwood ave ste 3,Raleigh,North Carolina,27612',city='Raleigh',state='North Carolina',country='United States',zip='',phone='919-941-0059',category='restaurant',hours='10am - 6pm'}, 
  {storeid=3,name="Chipotle North Carolina",lat='44.930810',lng='-93.347877',address='5480 Excelsior Blvd.,St. Louis Park,Minnesota,55416',city='St. Louis Park',state='Minnesota',country='United States',zip='',phone='952-922-1970',category='restaurant',hours='10am - 6pm'},
  {storeid=4,name="Chipotle Minneapolis",lat='44.9553438',lng='-93.29719699999998',address='2600 Hennepin Ave.,Minneapolis,Minnesota,55404',city='St. Louis Park',state='Minnesota',country='United States',zip='',phone='612-377-6035',category='restaurant',hours='10am - 6pm'},
  {storeid=5,name="Chipotle Golden Valley",lat='44.983935',lng='-93.380542',address='515 Winnetka Ave. N,Golden Valley,Minnesota,55427',city='N,Golden Valley',state='Minnesota',country='United States',zip='',phone='763-544-2530',category='restaurant',hours='10am - 6pm'},
  {storeid=6,name="Chipotle Hopkins",lat='44.924363',lng='-93.410158',address='786 Mainstreet,Hopkins,Minnesota,55443',city='Minneapolis',state='Minnesota',country='United States',zip='',phone='952-935-0044',category='resturant',hours='10am - 6pm'} ,
  {storeid=7,name="mcdonald's",lat='35.90285',lng='-78.89508',address='6102 Falls of Neuse Rd,Raleigh,North Carolina,27609',city='Raleigh',state='North Carolina',country='United States',zip='',phone='+19194719669',category='restaurant',hours='10am - 6pm'}, 
  {storeid=8,name="mcdonald's",lat='35.88046',lng='-78.85010',address='6602 Glenwood ave ste 3,Raleigh,North Carolina,27612',phone='+19194719669',city='Raleigh',state='North Carolina',country='United States',zip='',category='restaurant',hours='10am - 6pm'}, 
  {storeid=9,name="mcdonald's",lat='44.97774',lng='-93.270909',address='5480 Excelsior Blvd.,St. Louis Park,Minnesota,55416',city='Raleigh',state='Minnesota',country='United States',zip='',phone='+19194719669',category='restaurant',hours='10am - 6pm'},
  {storeid=10,name="mcdonald's",lat='35.83330',lng='-78.77062',address='Raleigh',city='Raleigh',state='North Carolina',country='United States',zip='',phone='+19194719669',category='cafe',hours='10am - 6pm'},
  {storeid=11,name="mcdonald's",lat='35.84026',lng='-78.85697',address='Raleigh',city='Raleigh',state='North Carolina',country='United States',zip='',phone='+191947196690',category='cafe',hours='10am - 6pm'},
  {storeid=12,name="mcdonald's",lat='35.83288',lng='-78.76994',address='Raleigh',city='Raleigh',state='North Carolina',country='United States',zip='',phone='+19194719669',category='cafe',hours='10am - 6pm'} ,

  {storeid=13,name="Walmart",lat='43.67842',lng='-79.34441',address='Toronto',city='Toronto',state='Ontario',country='Canada',zip='',phone='+19194719669',category='cafe',hours='10am - 6pm'} ,
  {storeid=14,name="Walmart",lat='43.84414',lng='-79.25432',address='Toronto',city='Toronto',state='Ontario',country='Canada',zip='',phone='+19194719669',category='restaurant',hours='10am - 6pm'} ,
  {storeid=15,name="Walmart",lat='43.82117',lng='-79.45601',address='Toronto',city='Toronto',state='Ontario',country='Canada',zip='',phone='+19194719669',category='cafe',hours='10am - 6pm'} ,
  {storeid=16,name="Walmart",lat='43.81115',lng='-79.19961',address='Toronto',city='Toronto',state='Ontario',country='Canada',zip='',phone='+19194719669',category='restaurant',hours='10am - 6pm'} 


]); 
    //writeOutput("The new query is:")
    //writeDump(myQuery)
</cfscript>
	<cfquery name="myQuery" dbtype="query" >
    	select * from myQuery 
        where 
        	1 = 1
        <cfif isDefined("url.state") and url.state neq 'All' >    	
        	and state = '#trim(url.state)#'
        <cfelseif isdefined("url.country") and url.country neq 'All'>
            and country = '#trim(url.country)#'
        </cfif>    
    </cfquery>




<cfset count = 0 >

  <cfsavecontent variable="myjson">
  {
      "type":"FeatureCollection",
      "features":[
          <cfoutput query="myQuery">
          <cfset count = count + 1  >
          {
          "geometry":{
              "type":"Point",
              "coordinates":[
                  #lng#,
                  #lat#
              ]
          },
          "type":"Feature",
          "properties":{
             "category":"#category#",
              "hours":"#hours#",
              "description":"Modern twists on classic pastries. We're part of a larger chain of patisseries and cafes.",
              "name":"#name#",
              "phone":"#phone#",
              "storeid":"#storeid#",
              "stateabv":"#state#"        
              }
          }
          <cfif count lt myQuery.recordcount>
          ,
          </cfif>
          </cfoutput>       
          ]
  }
  </cfsavecontent>
  <!---<cfoutput>#myjson#</cfoutput>--->



