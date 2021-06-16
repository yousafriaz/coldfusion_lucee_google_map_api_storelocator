<!--- This pulls legal name of business also with rest of information based on address , lat .lng , radius given., --->
<cfsetting showdebugoutput="no">
<cfspreadsheet action="read" src="../../data/data.xlsx"  query="myCSV" rows="2-82" headerrow="1" >
<cfset count = 0 >
        <cfquery name="myLocations" dbtype="query">
        	select 		
            			id,
                        address + ' ' + address2 + ',' + city + ',' + state + ',' + country + ',' + zip as address1,
                        *
                        
            from myCSV
        </cfquery>


<!---<cfhttp url="https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=4747 US-19, New Port Richey, FL 34652, USA&inputtype=textquery&fields=formatted_address,geometry,name,place_id&locationbias=circle%3A100%4034.0559572%2C-118.2708558&key=">
https://maps.googleapis.com/maps/api/place/textsearch/json?query=1608 Baker Ct ##6, Panama City, FL 32401, USA&location=30.1657037,-85.6867841&radius=10000&key=
--->

<cfset myQuery = QueryNew("id,
								name,lat,
								lng,
								address,
								city,
								state,
								country,
								zip,
								phone1,
								category,
								hours,
								hours1,
								hours2,
								hours3,
								hours4,
								hours5,
								hours6,
								hours7,
								business_status,
								toll_free,
								hotline,
								fax,
								email_primary,
								email_secondary,
								web,
								contact,
								executive_director
								"
								,
								"Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar,
								Varchar
								")> 

<cfset QueryAddRow(MyQuery, #myLocations.recordcount#)>


<cfoutput query="myLocations">
<cfset count = count + 1 >

	<cfhttp url="https://maps.googleapis.com/maps/api/place/textsearch/json?query=#myLocations.name#&location=#myLocations.lat#,#mylocations.lng#&radius=100&key=#request.googlemapkey#"></cfhttp>
	<!---<cfdump var="#cfhttp#">--->
<cfset data = deserializeJson(cfhttp.FileContent) > 	

<!---<cfdump var="#data#">
--->
<cfif data.status neq 'ZERO_RESULTS'>
	<cfset data = data.results[1]>
    <!---<cfdump var="#data#">--->
    
    
		<cfset QuerySetCell(myQuery, "id", "#myLocations.id#",#count#)> 
        <cfset QuerySetCell(myQuery, "name", "#data.name#",#count#)> 
        <cfset QuerySetCell(myQuery, "lat", "#data.geometry.location.lat#",#count#)> 
        <cfset QuerySetCell(myQuery, "lng", "#data.geometry.location.lng#",#count#)> 
        <cfset QuerySetCell(myQuery, "address", "#data.formatted_address#",#count#)> 
        <cfset QuerySetCell(myQuery, "city", "#myLocations.city#",#count#)> 
        <cfset QuerySetCell(myQuery, "state", "#myLocations.state#",#count#)> 
        <cfset QuerySetCell(myQuery, "country", "#myLocations.country#",#count#)> 
        <cfset QuerySetCell(myQuery, "zip", "#myLocations.zip#",#count#)> 
        <cfset QuerySetCell(myQuery, "phone1", "#myLocations.phone1#",#count#)> 
        <cfset QuerySetCell(myQuery, "category", "resturant",#count#)> 
        <cfset QuerySetCell(myQuery, "hours", "",#count#)> 
        <cfset QuerySetCell(myQuery, "hours1", "#myLocations.hours1#",#count#)> 
        <cfset QuerySetCell(myQuery, "hours2", "#myLocations.hours2#",#count#)> 
        <cfset QuerySetCell(myQuery, "hours3", "#myLocations.hours3#",#count#)> 
        <cfset QuerySetCell(myQuery, "hours4", "#myLocations.hours4#",#count#)> 
        <cfset QuerySetCell(myQuery, "hours5", "#myLocations.hours5#",#count#)> 
        <cfset QuerySetCell(myQuery, "hours6", "#myLocations.hours6#",#count#)> 
        <cfset QuerySetCell(myQuery, "hours7", "#myLocations.hours7#",#count#)> 
        <cfset QuerySetCell(myQuery, "business_status", "#data.business_status#",#count#)> 
        <cfset QuerySetCell(myQuery, "toll_free", "#myLocations.toll_free#",#count#)> 
        <cfset QuerySetCell(myQuery, "hotline", "#myLocations.hotline#",#count#)> 
        <cfset QuerySetCell(myQuery, "fax", "#myLocations.fax#",#count#)> 
        <cfset QuerySetCell(myQuery, "email_primary", "#myLocations.email_primary#",#count#)> 
        <cfset QuerySetCell(myQuery, "email_secondary", "#myLocations.email_secondary#",#count#)> 
        <cfset QuerySetCell(myQuery, "web", "#myLocations.web#",#count#)> 
        <cfset QuerySetCell(myQuery, "contact", "#myLocations.contact#",#count#)> 
        <cfset QuerySetCell(myQuery, "executive_director", "#myLocations.executive_director#",#count#)> 

<cfelse>
		<cfset QuerySetCell(myQuery, "id", "#myLocations.id#",#count#)> 
        <cfset QuerySetCell(myQuery, "name", "#myLocations.name#",#count#)> 
        <cfset QuerySetCell(myQuery, "lat", "#myLocations.lat#",#count#)> 
        <cfset QuerySetCell(myQuery, "lng", "#myLocations.lng#",#count#)> 
        <cfset QuerySetCell(myQuery, "address", "#myLocations.address#",#count#)> 
        <cfset QuerySetCell(myQuery, "city", "#myLocations.city#",#count#)> 
        <cfset QuerySetCell(myQuery, "state", "#myLocations.state#",#count#)> 
        <cfset QuerySetCell(myQuery, "country", "#myLocations.country#",#count#)> 
        <cfset QuerySetCell(myQuery, "zip", "#myLocations.zip#",#count#)> 
        <cfset QuerySetCell(myQuery, "phone1", "#myLocations.phone1#",#count#)> 
        <cfset QuerySetCell(myQuery, "category", "resturant",#count#)> 
        <cfset QuerySetCell(myQuery, "hours", "",#count#)> 
        <cfset QuerySetCell(myQuery, "hours1", "#myLocations.hours1#",#count#)> 
        <cfset QuerySetCell(myQuery, "hours2", "#myLocations.hours2#",#count#)> 
        <cfset QuerySetCell(myQuery, "hours3", "#myLocations.hours3#",#count#)> 
        <cfset QuerySetCell(myQuery, "hours4", "#myLocations.hours4#",#count#)> 
        <cfset QuerySetCell(myQuery, "hours5", "#myLocations.hours5#",#count#)> 
        <cfset QuerySetCell(myQuery, "hours6", "#myLocations.hours6#",#count#)> 
        <cfset QuerySetCell(myQuery, "hours7", "#myLocations.hours7#",#count#)> 
        <cfset QuerySetCell(myQuery, "business_status", "",#count#)> 
        <cfset QuerySetCell(myQuery, "toll_free", "#myLocations.toll_free#",#count#)> 
        <cfset QuerySetCell(myQuery, "hotline", "#myLocations.hotline#",#count#)> 
        <cfset QuerySetCell(myQuery, "fax", "#myLocations.fax#",#count#)> 
        <cfset QuerySetCell(myQuery, "email_primary", "#myLocations.email_primary#",#count#)> 
        <cfset QuerySetCell(myQuery, "email_secondary", "#myLocations.email_secondary#",#count#)> 
        <cfset QuerySetCell(myQuery, "web", "#myLocations.web#",#count#)> 
        <cfset QuerySetCell(myQuery, "contact", "#myLocations.contact#",#count#)> 
        <cfset QuerySetCell(myQuery, "executive_director", "#myLocations.executive_director#",#count#)> 

</cfif>

</cfoutput>

<!---<cfdump var="#myQuery#">
--->
<cfset reportFileName = "exported_excel" />
<cfset reportFileName = reportFileName & ".xls" />

<cfset sObj = SpreadsheetNew()>
<cfset SpreadSheetAddRows(sObj,myQuery,1,1,"true",[""],true)>
<!---<cfscript>
    //Use an absolute path for the files. 
    //theDir=GetDirectoryFromPath(GetCurrentTemplatePath());
    //theFile=theDir & "exported.xlsx";
    //Create two empty ColdFusion spreadsheet objects. 
    theSheet = SpreadsheetNew("ExportedData");
    //Populate each object with a query. 
    SpreadsheetAddRows(theSheet,myQuery,1,1,"true",[""],true);
</cfscript>--->

<cfspreadsheet action="write" filename="../../data/#reportFileName#" name="sObj" 
    sheetname="myData" overwrite=true>
