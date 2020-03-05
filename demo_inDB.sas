/* The LIBREF of the THREAD SET statement data source /*
/* determines where the code will execute */
proc ds2;
/* Create identical threads.  One uses the data from SAS /*
/* and the other data in Teradata*/
/* Both threads are stored in SAS datasets */
thread ds2_sas.th_SAS/overwrite=yes;
   vararray double contrib[*] qtr:;
   dcl double Total;
   METHOD RUN();
      dcl int q;
      /* SAS Data set is the source */
      set ds2_sas.two_recipients;
      Total=0;
      do q=1 to dim(contrib);
         Total+contrib[q]*1.25;
      end;
END;
endthread;
run;

thread ds2_sas.th_TD/overwrite=yes;
   vararray double contrib[*] qtr:;
   dcl double Total;
   METHOD RUN();
      dcl int q;
      /* Teradata table is the source */
      set ds2_td.two_recipients;
      Total=0;
      do q=1 to dim(contrib);
         Total+contrib[q]*1.25;
      end;
END;
endthread;
run;
quit;

proc ds2;
data ds2_sas.ThreadTest_SAS(overwrite=yes);
   DCL thread ds2_sas.th_SAS th;
   METHOD RUN();
      SET FROM th threads=4;
   END;
enddata;
run;
quit;

proc sql outobs=10;
title "ds2_td.ThreadTest_TD";
select Employee_ID, Qtr1,Qtr2,Qtr3,Qtr4,Total
   from ds2_SAS.ThreadTest_SAS 
   order by Employee_ID
; 
quit;

proc ds2;
data ds2_td.ThreadTest_TD(overwrite=yes);
   DCL thread ds2_sas.th_TD th;
   METHOD RUN();
      SET FROM th threads=4;
   END;
enddata;
run;
quit;

proc sql outobs=10;
title "ds2_td.ThreadTest_TD";
select Employee_ID, Qtr1,Qtr2,Qtr3,Qtr4,Total
   from ds2_td.ThreadTest_TD 
   order by Employee_ID
; 
quit;

