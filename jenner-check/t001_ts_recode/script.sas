/* Trial Summary (TS) recode from scripts/read_trial_domains_to_json.sas.
 *
 * The upstream script downloads the CDISC pilot Trial Design XPT files and
 * then patches two TS parameter values ("coding issue is available which
 * needs to be fixed"). That DATA step is reproduced here verbatim, running
 * against a small mock TS domain in place of the downloaded pilot data so it
 * is self-contained. The conditional-assignment logic is unchanged. */

%let outpath = %sysfunc(pathname(work));
libname dat "&outpath";

/* mock SDTM Trial Summary (TS) domain, as %download_and_convert_xpt would
   have populated dat.ts from the pilot Trial Design XPT files */
data dat.ts;
  length studyid $12 domain $2 tsseq 8 tsparmcd $8 tsparm $40 tsval $200;
  infile datalines dsd;
  input studyid $ domain $ tsseq tsparmcd $ tsparm $ tsval $;
  datalines;
CDISCPILOT01,TS,1,TITLE,Trial Title,PLACEHOLDER TITLE
CDISCPILOT01,TS,2,TDIGRP,Diagnosis Group,PLACEHOLDER GROUP
CDISCPILOT01,TS,3,SSTDTC,Study Start Date,2013-07-01
CDISCPILOT01,TS,4,PLANSUB,Planned Subjects,300
;
run;

/* the recode step exactly as written in read_trial_domains_to_json.sas */
DATA dat.ts;
	SET dat.ts;
	IF tsparmcd = "TDIGRP" THEN tsval = "Patients with Probable Mild to Moderate Alzheimer's Disease";
	IF tsparmcd = "TITLE"  THEN tsval = "Safety and Efficacy of the Xanomeline Transdermal Therapeutic System (TTS) in Patients with Mild to Moderate Alzheimer's Disease.";
RUN;

proc print data=dat.ts noobs;
  var tsparmcd tsparm tsval;
run;
