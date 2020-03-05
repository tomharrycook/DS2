data test1;
   set ds2_sas.continent;
   where Continent_ID > 93;
   if Continent_ID=96 then delete;
run;        /*missing_subset.sas*/

PROC DS2;
data test2 (overwrite=YES);
   method run();
      set {select * 
              from ds2_sas.continent
              where Continent_ID>93};
      if Continent_ID ne 96;
   end;
run;
QUIT;       /*miss_subseting.sas*/
