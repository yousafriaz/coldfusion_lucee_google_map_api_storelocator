<!---
/*****************************************************************************	
Application to create google mapping application
/******************************************************************************
--->



<cfcomponent displayname="Application" output="true" hint="Handle the application.">
 
 
	<!--- Set up the application. --->
	<cfset THIS.Name = "GoogleMappingApplication" />
	<cfset THIS.SessionManagement = true />
    <cfset THIS.ClientManagement = True >
	<cfset THIS.SetClientCookies = true />
	<cfset THIS.applicationTimeOut = createTimeSpan(0,2,0,0) >
    <cfset THIS.sessionTimeOut = createTimeSpan(0,2,0,0) >
    <cfset THIS.serialization.preserveCaseForStructKey = true />
    <cfset THIS.serialization.preserveCaseForQueryColumn= true />

<!---    <cfsetting
        requesttimeout="3600"
        showdebugoutput="yes"
        enablecfoutputonly="false"
        />
--->    
    
	<cffunction
		name="OnApplicationStart"
		access="public"
		returntype="boolean"
		output="false"
		hint="Fires when the application is first created.">
 
		
		<!--- Return out. --->
		<cfreturn true />
	</cffunction>
   
   
  <cffunction name="onMissingTemplate">
      <cfargument name="targetPage" type="string" required=true/>
      <!--- Use a try block to catch errors. --->
      <cftry>
          <!--- Log all errors. --->
          <cflog type="error" text="Missing template: #Arguments.targetPage#">
          <!--- Display an error message. --->
          <cfoutput>
              <h3>#Arguments.targetPage# could not be found.</h2>
              <p>You requested a non-existent ColdFusion page.<br />
                  Please check the URL.</p>
          
		  </cfoutput>
          <cfreturn true />
          <!--- If an error occurs, return false and the default error
              handler will run. --->
          <cfcatch>
              <cfreturn false />
          </cfcatch>
      </cftry>
  </cffunction>  
  
  <cffunction name="OnRequestStart">
  	
	<cfif cgi.SERVER_NAME eq "localhost" OR  cgi.SERVER_NAME eq "127.0.0.1" OR  cgi.SERVER_NAME eq "192.168.1.164"  >
    	<cfset request.defaultDir 			= "c:\inetpub\wwwroot\mygooglemap">
        <cfset request.Email 				= "email@gmail.com">
        <cfset request.googlemapkey			="YOUR_API_KEY">
        
    <cfelse>
		<cfset request.defaultDir 			= "e:\inetpub\wwwroot\googlemap">    
        <cfset request.Email 				= "email@gmail.com">
        <cfset request.googlemapkey_old		="YOUR_API_KEY"> 
        <cfset request.googlemapkey			="YOUR_API_KEY"> 
    
    </cfif>
    
  
	    
	<cfif structKeyExists(url,'reset')>
  		<cfset OnApplicationStart() />
	</cfif>

	<!--- If requires SSL but not using SSL, redirect
    <cfset Application.usingSSL = (cgi.https eq "on") />
    <cfif Application.requiresSSL AND NOT Application.usingSSL>
         <cfset local.protocol = "https://" />
         
         <cfset local.url = (
            local.protocol &
            cgi.server_name &
            cgi.script_name &
            "?" &
            cgi.query_string
        ) />
            
        <cflocation url="#local.url#" addtoken="false" />
    </cfif> --->
    
  </cffunction>
    
</cfcomponent>    


