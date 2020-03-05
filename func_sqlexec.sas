proc ds2;
data _null_;
   method INIT();
      dcl double rc;
      rc=sqlexec('create table ds2_td.JustTesting as 
                     select * from ds2_sas.banks');
   end;
   enddata;
run;
data _null_;
   method RUN();
      SET ds2_td.JustTesting;
      put _all_;
   end;
   enddata;
run;
data _null_;
   method INIT();
      dcl double rc;
      rc=sqlexec('DROP table ds2_td.JustTesting');
   end;
   enddata;
run;
quit;