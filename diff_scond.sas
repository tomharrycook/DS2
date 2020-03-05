/*Default is WARNING*/
/*options DS2SCOND=WARNING;*/
options DS2SCOND=ERROR;
options DS2SCOND=NONE;
options DS2SCOND=NOTE;
proc ds2 
/*  scond=NONE*/
;
data newbanks(overwrite=YES);
   method run();
      set ds2_sas.banks;
      Total=sum(Rate,.05)*50000;
   end;
enddata;
run;
quit; 

proc ds2 SCOND=NONE;
data newbanks(overwrite=YES);
   method run();
      set ds2_sas.banks;
      Total=sum(Rate,.05)*50000;
   end;
enddata;
run;
quit; 

proc ds2;
data newbanks(overwrite=YES);
/*   dcl double Total;*/
   method run();
      set ds2_sas.banks;
      Total=sum(Rate,.05)*50000;
   end;
enddata;
run;
quit; 

proc ds2 SCOND=ERROR;
data newbanks(overwrite=YES);
/*   dcl double Total;*/
   method run();
      set ds2_sas.banks;
      Total=sum(Rate,.05)*50000;
   end;
enddata;
run;
quit; 

