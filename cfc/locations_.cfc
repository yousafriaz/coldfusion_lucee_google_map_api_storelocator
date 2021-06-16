<!--- This can go to restful application for securit purpose--->
<cfcomponent namespace="Location" >


    <cffunction name="getLocation" access="remote" returntype="any">
    
    	<cfspreadsheet action="read" src="../data/exported_excel.xls"  query="myCSV" rows="2-83" headerrow="1">
        
        <cfquery name="myLocations" dbtype="query" >
        	select 		
            		id as storeid,
                        name,
            		lat,
                        lng,
                        address + ',' + city + ',' + state + ',' + country + ',' + zip as address,
                        city,
                        state,
                        country,
                        zip,
                        phone1 as phone,
                        'cafe' as category,
                        hours1 as hours
            	
            from myCSV
        </cfquery>

    
<!---	This is Test Query in case you dont want to use Excel abd still want to see this working , then comment cfquery tag above and uncomment cfscript tag
<cfscript>
        // this needs to be replaced with actual call to cfquery
        myLocations = queryNew("storeid,name,lat,lng,address,city,state,country,zip,phone,category,hours","Integer,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar,Varchar", 
        [ 
          {storeid="1",name="Chipotle North Carolina",lat='35.87226',lng='-78.62179',address='6102 Falls of Neuse Rd,Raleigh,North Carolina,27609',city='Raleigh',state='North Carolina',country='United States',zip='',phone='919-922-6662',category='restaurant',hours='10am - 6pm'}, 
          {storeid="2",name="Chipotle Mexican Grill",lat='35.86614',lng='-78.70659',address='6602 Glenwood ave ste 3,Raleigh,North Carolina,27612',city='Raleigh',state='North Carolina',country='United States',zip='',phone='919-941-0059',category='restaurant',hours='10am - 6pm'}, 
          {storeid="3",name="Chipotle North Carolina",lat='44.930810',lng='-93.347877',address='5480 Excelsior Blvd.,St. Louis Park,Minnesota,55416',city='St. Louis Park',state='Minnesota',country='United States',zip='',phone='952-922-1970',category='restaurant',hours='10am - 6pm'},
          {storeid="4",name="Chipotle Minneapolis",lat='44.9553438',lng='-93.29719699999998',address='2600 Hennepin Ave.,Minneapolis,Minnesota,55404',city='St. Louis Park',state='Minnesota',country='United States',zip='',phone='612-377-6035',category='restaurant',hours='10am - 6pm'},
          {storeid="5",name="Chipotle Golden Valley",lat='44.983935',lng='-93.380542',address='515 Winnetka Ave. N,Golden Valley,Minnesota,55427',city='N,Golden Valley',state='Minnesota',country='United States',zip='',phone='763-544-2530',category='restaurant',hours='10am - 6pm'},
          {storeid="6",name="Chipotle Hopkins",lat='44.924363',lng='-93.410158',address='786 Mainstreet,Hopkins,Minnesota,55443',city='Minneapolis',state='Minnesota',country='United States',zip='',phone='952-935-0044',category='restaurant',hours='10am - 6pm'} ,
          {storeid="7",name="mcdonald's",lat='35.90285',lng='-78.89508',address='6102 Falls of Neuse Rd,Raleigh,North Carolina,27609',city='Raleigh',state='North Carolina',country='United States',zip='',phone='+19194719669',category='restaurant',hours='10am - 6pm'}, 
          {storeid="8",name="mcdonald's",lat='35.88046',lng='-78.85010',address='6602 Glenwood ave ste 3,Raleigh,North Carolina,27612',phone='+19194719669',city='Raleigh',state='North Carolina',country='United States',zip='',category='restaurant',hours='10am - 6pm'}, 
          {storeid="9",name="mcdonald's",lat='44.97774',lng='-93.270909',address='5480 Excelsior Blvd.,St. Louis Park,Minnesota,55416',city='Raleigh',state='Minnesota',country='United States',zip='',phone='+19194719669',category='restaurant',hours='10am - 6pm'},
          {storeid="10",name="mcdonald's",lat='35.83330',lng='-78.77062',address='Raleigh',city='Raleigh',state='North Carolina',country='United States',zip='',phone='+19194719669',category='cafe',hours='10am - 6pm'},
          {storeid="11",name="mcdonald's",lat='35.84026',lng='-78.85697',address='Raleigh',city='Raleigh',state='North Carolina',country='United States',zip='',phone='+191947196690',category='cafe',hours='10am - 6pm'},
          {storeid="12",name="mcdonald's",lat='35.83288',lng='-78.76994',address='Raleigh',city='Raleigh',state='North Carolina',country='United States',zip='',phone='+19194719669',category='cafe',hours='10am - 6pm'} ,
          {storeid="13",name="Walmart",lat='43.67842',lng='-79.34441',address='Toronto',city='Toronto',state='Ontario',country='Canada',zip='',phone='+19194719669',category='cafe',hours='10am - 6pm'} ,
          {storeid="14",name="Walmart",lat='43.84414',lng='-79.25432',address='Toronto',city='Toronto',state='Ontario',country='Canada',zip='',phone='+19194719669',category='restaurant',hours='10am - 6pm'} ,
          {storeid="15",name="Walmart",lat='43.82117',lng='-79.45601',address='Toronto',city='Toronto',state='Ontario',country='Canada',zip='',phone='+19194719669',category='cafe',hours='10am - 6pm'} ,
          {storeid="16",name="Walmart",lat='43.81115',lng='-79.19961',address='Toronto',city='Toronto',state='Ontario',country='Canada',zip='',phone='+19194719669',category='restaurant',hours='10am - 6pm'} ,

          {storeid="17",name="Unites States Postal Office",lat='32.75116',lng='-117.24705',address='4833 Santa Monica Ave, San Diego, CA 92107',city='San Diego',state='California',country='United States',zip='',phone='+18002758777',category='postoffice',hours='10am - 6pm'} ,
          {storeid="18",name="Unites States Postal Office",lat='32.76906',lng='-117.06028',address='6401 El Cajon Blvd, San Diego, CA 92115',city='San Diego',state='California',country='United States',zip='',phone='+18002758777',category='restaurant',hours='10am - 6pm'} ,
          {storeid="19",name="Unites States Postal Office",lat='32.71939',lng='-117.15572',address='815 E St, San Diego, CA 92101',city='San Diego',state='California',country='United States',zip='',phone='+18002758777',category='postoffice',hours='10am - 6pm'} ,

          {storeid="20",name="Unites States Postal Office",lat='29.96028',lng='-95.55866',address='12955 Willow Pl Dr W, Houston, TX 77070',city='Houston',state='Texas',country='United States',zip='',phone='+18002758777',category='restaurant',hours='10am - 6pm'} ,
          {storeid="21",name="Unites States Postal Office",lat='29.87912',lng='-95.41476',address='7511 N Shepherd Dr, Houston, TX 77088',city='Houston',state='Texas',country='United States',zip='',phone='+18002758777',category='postoffice',hours='10am - 6pm'} ,
          {storeid="22",name="Unites States Postal Office",lat='29.79528',lng='-95.21656',address='550 Maxey Rd, Houston, TX 77013',city='Houston',state='Texas',country='United States',zip='',phone='+18002758777',category='restaurant',hours='10am - 6pm'} 
    
    
        
        
        ]); 
            //writeOutput("The new query is:")
            //writeDump(myQuery)
</cfscript>
--->    
    	


		<cfreturn myLocations>
    </cffunction>


    <cffunction name="myLocationData" access="remote" returnFormat="JSON"  >
    
	<cfset myQuery = getLocation() >
                
    	<cfif isdefined("url.storeids") and trim(url.storeids) neq '' >
        	<cfset lst_storeids = reReplace(urldecode(url.storeids), "[[:space:]]", "", "ALL") > 
            
        </cfif>
            
        <cfquery name="myQuery" dbtype="query"  >
            select 
				* 
            from myQuery 
            
            where 
                1 = 1
            <cfif isDefined("url.state") and url.state neq 'All' >    	
                and state = '#trim(url.state)#'
            <cfelseif isdefined("url.country") and url.country neq 'All'>
                and country = '#trim(url.country)#'
            <cfelseif isdefined("url.strname") and trim(url.strname) neq ''>
                and lower(name) LIKE '%#trim(lcase(url.strname))#%' 
            <cfelseif isdefined("url.storeids") and trim(url.storeids) neq ''>
            	and storeid IN (<cfqueryparam list="yes" value="#lst_storeids#">)
            </cfif> 
            
        </cfquery>
    
	<!---<cfif isdefined("url.storeids") and (myQuery.RecordCount GT 3)>
                Remove all rows beyond 3 (index 3 and
                greater from the Java stand point).
            
            <cfset myQuery.RemoveRows(
                JavaCast( "int", 3 ),
                JavaCast( "int", myQuery.RecordCount - 3 )
                ) />
        
        </cfif> --->
            
    
    <cfset count = 0 >
    
      <cfsavecontent variable="myjson">
      	<cfif not isdefined("url.cluster") >
          {
              "type":"FeatureCollection",
              "features":[
                  <cfoutput query="myQuery">
                  <cfset count = count + 1  >
                  {
                  "geometry":{
                      "type":"Point",
                      "coordinates":[#lng#,#lat#]
                  },
                  "type":"Feature",
                  "properties":{
                     "category":"#category#",
                      "hours":"#hours#",
                      "address":"#address#",
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
      
      	<cfelse>
        
        [
        <cfoutput query="myQuery">
            {lat:#lng# , lng:#lat# },
        </cfoutput>
        ]
        
        
        
        </cfif>
        
        
        
        
      </cfsavecontent>
      <!---<cfoutput>#myjson#</cfoutput>--->
    

    
        <cfreturn myjson >
    </cffunction>
    
<cffunction name="getLocationDetails" access="remote" returntype="query">
    <cfargument name="storeid" required="no">

    	<cfspreadsheet action="read" src="../data/updated_data.xlsx"  query="myCSV" rows="2-83" headerrow="1">
        
        <cfquery name="myLocations" dbtype="query" >
        	select 		
            			id as storeid,
                        address + ',<br>' + city + ', ' + state + ',<br>' + country + ', ' + zip as address,
                        address + ',' + city + ', ' + state + ',' + country + ',' + zip as addressF,
                        *
            	
            from myCSV
            where 1 = 1 
            <cfif isdefined("arguments.storeid") and arguments.storeid neq ''>
            	and id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.storeid#">
            </cfif>
        </cfquery>

    
    	<cfreturn myLocations>
</cffunction>


   <cffunction name="getDistance" access="remote" returntype="any">
   	<cfargument name="origins" required="yes">
    <cfargument name="destinations" required="yes">
   
   	<cfhttp url="https://maps.googleapis.com/maps/api/distancematrix/json?origins=35.8299874,-78.8474981&destinations=32.75116,-117.24705|32.76906,-117.06028&key=#request.googlemapkey#"></cfhttp>

	<cfdump var="#cfhttp.FileContent#">
   
   
   </cffunction> 
    
  
  </cfcomponent>
