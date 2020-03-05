/* Base SAS Library */
%let path=S:\Workshop;
libname ds2_sas "&path";

/* Teradata Library */
libname ds2_td teradata server=/**/ database=/**/ user=/**/ password=/**/;

ods html close;
ods html newfile=proc path="%sysfunc(pathname(work))";
