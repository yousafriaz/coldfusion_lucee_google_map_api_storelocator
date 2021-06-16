<cfsetting showdebugoutput="no">
<cfspreadsheet action="read" src="../../data/data.xlsx"  query="myCSV" rows="2-82" headerrow="1" >
<cfset count = 1 >
        <cfquery name="myLocations" dbtype="query">
        	select 		
            			id,
                        address + ' ' + address2 + ',' + city + ',' + state + ',' + country + ',' + zip as address1,
                        *
                        
            from myCSV
        </cfquery>
        
       
	   <table>
	   <tr>
       <th>id</th>
       <th>name</th>
       <th>lat</th>
       <th>lng</th>
       <th>place_id</th>
       <th>f_address</th>
       <th>address</th>
       <th>address2</th>
       <th>city</th>
       <th>state</th>
       <th>zip</th>
       <th>country</th>
       <th>phone1</th>
       <th>toll_free</th>
       <th>hotline</th>
       <th>fax</th>
       <th>email_primary</th>
       <th>email_secondary</th>
       <th>web</th>
       <th>contact</th>
       <th>executive_director/th>
       <th>board_leader</th>
       <th>year_founded</th>
       <th>hours1</th>
       <th>hours2</th>
       <th>hours3</th>
       <th>hours4</th>
       <th>hours5</th>
       <th>hours6</th>
       <th>hours7</th>
       <th>Services_Programs
</th>
       <th>Anti_Violence
</th>
       <th>Arts_Culture
</th>
       <th>Civic_Engagement
</th>
       <th>Community_Outreach_Education
</th>
       <th>hotlines
</th>
       <th>information_Education
</th>
       <th>legal
</th>
       <th>mental_health
</th>
       <th>older_adult
</th>
       <th>physical_health
</th>
       <th>youth
</th>
       <th>Social_media
</th>
       <th>facebook_url
</th>
       <th>twitter_url
</th>
       <th>donation_url
</th>
       <th>volunteer_url
</th>
       <th>instagram_url
</th>
       
       
       
       </tr>
	   
	   <cfoutput query="myLocations">
       <cfhttp url="https://maps.googleapis.com/maps/api/geocode/json?address=#myLocations.address1#&key=#request.googlemapkey#"></cfhttp>
       <cfset data = deserializeJson(cfhttp.FileContent) > 
       
<!---       <cfdump var="#data#">
       
       <cfdump var="#data.results[1].geometry.location#">
       
       #myLocations.storeid# , #myLocations.name#, #myLocations.address1# , <b>#data.results[1].geometry.location.lat# , #data.results[1].geometry.location.lng# </b> , #data.results[1].place_id#<br>
       ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- <br>
 --->      
	   <tr>
       <td> #myLocations.id#</td>
       <td> #myLocations.name#</td>
       <td> #data.results[1].geometry.location.lat#</td>
       <td> #data.results[1].geometry.location.lng#</td>
       <td> #data.results[1].place_id#</td>
       <td> #data.results[1].formatted_address#</td>
       <td> #myLocations.address#</td>
       <td> #myLocations.address2#</td>
       <td> #myLocations.city#</td>
       <td> #myLocations.state#</td>
       <td> #myLocations.zip#</td>
       <td> #myLocations.country#</td>
       <td> #myLocations.phone1#</td>
       <td> #myLocations.toll_free#</td>
       <td> #myLocations.hotline#</td>
       <td> #myLocations.fax#</td>
       <td> #myLocations.email_primary#</td>
       <td> #myLocations.email_secondary#</td>
       <td> #myLocations.web#</td>
       <td> #myLocations.contact#</td>
       <td> #myLocations.executive_director#</td>
       <td> #myLocations.board_leader#</td>
       <td> #myLocations.year_founded#</td>
       <td> #myLocations.hours1#</td>
       <td> #myLocations.hours2#</td>
       <td> #myLocations.hours3#</td>
       <td> #myLocations.hours4#</td>
       <td> #myLocations.hours5#</td>
       <td> #myLocations.hours6#</td>
       <td> #myLocations.hours7#</td>
       <td> #myLocations.Services_Programs#</td>
       <td> #myLocations.Anti_Violence#</td>
       <td> #myLocations.Arts_Culture#</td>
       <td> #myLocations.Civic_Engagement#</td>
       <td> #myLocations.Community_Outreach_Education#</td>
       <td> #myLocations.information_Education#</td>
       <td> #myLocations.legal#</td>
       <td> #myLocations.mental_health#</td>
       <td> #myLocations.older_adult#</td>
       <td> #myLocations.physical_health#</td>
       <td> #myLocations.youth#</td>
       <td> #myLocations.Social_media#</td>
       <td> #myLocations.facebook_url#</td>
       <td> #myLocations.twitter_url#</td>
       <td> #myLocations.donation_url#</td>
       <td> #myLocations.volunteer_url#</td>
       <td> #myLocations.instagram_url#</td>
       
       </tr>
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   </cfoutput>	
       
       </table>