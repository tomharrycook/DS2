proc ds2;
data _null_;
   dcl double SAS_Time having format time.;
   dcl time DS2_Time;
   method run();
      set ds2_sas.sas_datetimes;
      DS2_Time=to_time(SAS_Time); 
      put SAS_Time= DS2_Time=; 
   end;
enddata;
run;
quit;
