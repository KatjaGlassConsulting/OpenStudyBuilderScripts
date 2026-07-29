/* XPORT read path of %download_and_convert_xpt, from
 * scripts/read_trial_domains_to_json.sas.
 *
 * The upstream macro downloads a Trial Design XPT file over PROC HTTP, then
 * reads it back through the XPORT engine and PROC COPY:
 *     LIBNAME xptfile XPORT "&outpath/&l_name" ACCESS=readonly ENCODING=ANY;
 *     PROC COPY INLIB=xptfile OUTLIB=outlib; RUN;
 * The network download is replaced here by writing a small mock TA (Trial
 * Arms) domain to a local v5 transport file, then reading it back through the
 * exact same XPORT + PROC COPY path so the bundle is self-contained. */

%let outpath = %sysfunc(pathname(work));

/* mock SDTM Trial Arms (TA) domain */
data work.ta;
  length studyid $12 domain $2 armcd $8 arm $40 taetord 8 etcd $8 element $40;
  infile datalines dsd;
  input studyid $ domain $ armcd $ arm $ taetord etcd $ element $;
  datalines;
CDISCPILOT01,TA,PLACEBO,Placebo,1,SCRN,Screening
CDISCPILOT01,TA,PLACEBO,Placebo,2,PLAC,Placebo Treatment
CDISCPILOT01,TA,XANHI,Xanomeline High,1,SCRN,Screening
CDISCPILOT01,TA,XANHI,Xanomeline High,2,XANH,Xanomeline High Dose
;
run;

/* stand in for the PROC HTTP download: write a local v5 transport file */
libname xptout xport "&outpath/ta.xpt";
proc copy inlib=work outlib=xptout;
  select ta;
run;
libname xptout clear;

/* --- the read path of %download_and_convert_xpt, unchanged --- */
libname outlib "&outpath";
LIBNAME xptfile XPORT "&outpath/ta.xpt" ACCESS=readonly ENCODING = ANY;
PROC COPY INLIB=xptfile OUTLIB=outlib;
RUN;
LIBNAME xptfile clear;

proc print data=outlib.ta noobs;
  var armcd arm taetord element;
run;
