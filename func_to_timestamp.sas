proc ds2;
data _null_;
   dcl double SAS_Datetime /*having format datetime.*/;
   dcl timestamp DS2_Timestamp;
   method run();
      set ds2_sas.sas_datetimes;
      DS2_Timestamp=to_timestamp(SAS_datetime); 
      put SAS_DateTime= DS2_Timestamp=; 
   end;
enddata;
run;
quit;
