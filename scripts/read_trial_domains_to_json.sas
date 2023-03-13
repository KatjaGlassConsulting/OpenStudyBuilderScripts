%************************************************************************************************************************;
%* Project    : OpenStudyBuilderScripts
%* Purpose    : Download Trial Domain XPT files from GitHub and create JSON file
%*                 - SDTM pilot study:         https://github.com/phuse-org/phuse-scripts/tree/master/data/sdtm/TDF_SDTM_v1.0
%*                 - pre-clinical pilot study: https://github.com/phuse-org/phuse-scripts/tree/master/data/send/CBER-POC-Pilot-Study4-Vaccine
%* Author     : Katja Glass
%* Creation   : 2023-03-13
%* SAS Version: SAS 9.4
%* License    : UNLICENSE
%************************************************************************************************************************;


*************************************************************************************************;
* Macro to download XPT files from an URL, e.g. like in GitHub and convert these to SAS datasets;
*************************************************************************************************;

%MACRO download_and_convert_xpt(url = , files = , outpath = );
	%LOCAL l_i l_name;
	LIBNAME outlib "&outpath";
	
	%DO l_i = 1 %TO %SYSFUNC(COUNTW(&files%STR( )));
		%LET l_name = %SCAN(&files, &l_i).xpt;
		FILENAME out_xpt "&outpath/&l_name";
 
		PROC HTTP
			URL = "&url/&l_name"
			METHOD = "get" OUT = out_xpt;
		RUN;
		
		%PUT blub = "&url/&l_name";
		
		LIBNAME xptfile XPORT "&outpath/&l_name" ACCESS=readonly ENCODING = ANY;		
		PROC COPY INLIB=xptfile OUTLIB=outlib;		
		RUN;
		LIBNAME xptfile;
	%END;
%MEND;
	
*************************************************************************************************;
* Macro to convert sas files to JSON format;
*************************************************************************************************;

%MACRO create_json(outfile = , datasets = , libpath = );
	%LOCAL l_i l_name;
	LIBNAME inlib "&libpath";
	FILENAME out_json "&outfile" ENCODING = "utf-8";
	
	PROC JSON OUT = out_json PRETTY NOSASTAGS;
		%DO l_i = 1 %TO %SYSFUNC(COUNTW(&datasets%STR( )));
			%LET l_name = %SCAN(&datasets,&l_i);
			WRITE VALUES "&l_name";
			WRITE OPEN ARRAY;
			EXPORT inlib.&l_name;
			WRITE CLOSE;
		%END;
	RUN;
%MEND;

*************************************************************************************************;
* Download and convert files 
* 1) SDTM pilot study;
* 2) Pre-clinic pilot study;
*************************************************************************************************;

* 1) SDTM pilot study;
%download_and_convert_xpt(
	url = https://github.com/phuse-org/phuse-scripts/raw/master/data/sdtm/TDF_SDTM_v1.0, 
	files = ta te ti ts tv, 
	outpath = /home/u49641771/sas-dev/openStudyBuilder/out);

* coding issue is available which needs to be fixed;
LIBNAME dat "/home/u49641771/sas-dev/openStudyBuilder/out";
DATA dat.ts;
	SET dat.ts;
	IF tsparmcd = "TDIGRP" THEN tsval = "Patients with Probable Mild to Moderate Alzheimer's Disease";
	IF tsparmcd = "TITLE"  THEN tsval = "Safety and Efficacy of the Xanomeline Transdermal Therapeutic System (TTS) in Patients with Mild to Moderate Alzheimer's Disease.";
RUN;

%create_json(
	outfile = /home/u49641771/sas-dev/openStudyBuilder/out/trial_domains.json, 
	datasets = ta te ti ts tv, 
	libpath = /home/u49641771/sas-dev/openStudyBuilder/out);
	
* 2) Pre-clinic pilot study;	
%download_and_convert_xpt(
	url = https://github.com/phuse-org/phuse-scripts/raw/master/data/send/CBER-POC-Pilot-Study4-Vaccine, 
	files = ta te ts tx, 
	outpath = /home/u49641771/sas-dev/openStudyBuilder/out);

%create_json(
	outfile = /home/u49641771/sas-dev/openStudyBuilder/out/trial_domains_study4_vacc.json, 
	datasets = ta te ts tx, 
	libpath = /home/u49641771/sas-dev/openStudyBuilder/out);	