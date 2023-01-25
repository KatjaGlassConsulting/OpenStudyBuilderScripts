* CURL example to get API results from OpenStudyBuilder
*
* Remark - you can get the current bearer token by executing by calling the API from the browser and copy the token
*   goto - https://openstudybuilder.northeurope.cloudapp.azure.com/api/docs*/Studies/get_all_studies_get
*   click "authorize" top right lock symbol, then "authorize"
*   click "try it out"
*   remove everything from the "filters" field
*   click "execute"
*   copy the bearer token from the CURL command (long string after "-H 'Authorization: Bearer ")
*;

OPTIONS QUOTELENMAX;

/* define the bearer token and API endpoint variable */ 
%let bearer_token = eyJ0eXAiOi....; /* enter your token here */
%let api_endpoint = https://openstudybuilder.northeurope.cloudapp.azure.com/api/studies; 

/* make the API call */ 
FILENAME response temp; 

PROC HTTP URL="&api_endpoint" METHOD="GET" OUT=response;
	debug level = 1;
	HEADERS 
		"Authorization" = "Bearer &bearer_token"
		"accept" =  "application/json"; 
RUN;

/* get the JSON file into a dataset */
DATA resultJson;
	INFILE response;
	ATTRIB text FORMAT=$2000.;
	INPUT;
	text = _INFILE_;
	PUT text=;
RUN;

/* Read in the JSON into a library */
LIBNAME response JSON;