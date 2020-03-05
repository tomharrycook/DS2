data results;
   length name treatment $ 8 gender $ 1;
   if _N_ = 1 then do;
      /* Create a Hash object for use as a lookup table */
      /* and load the Hash table from a SAS dataset */
      declare hash people(dataset:'ds2_sas.trials_participants');
      /* Define which variable(s) will be used as the lookup key */
      people.defineKey('name');
      /* Define which variable(s) will be returned as data from the lookup */
      people.defineData('gender', 'treatment');
      /* Definitions for this hash object are complete */
      people.defineDone();
   end;
   /* use the SET statement to iterate over the trials_weight data */
   /* keys in that table to match the keys in the hash package data */
   set ds2_sas.trials_weight;
   /* Look up the Treatment and Gender in the Hash object */
   /* If found, gender and treatment will be populated, so output */
   if people.find() = 0 then output;
   format date DATE9.;
run;
title "Treatment Results - DATA Step HASH lookup";
proc print data=results;
   var date name gender weight treatment;
run;
title;

PROC DS2;
data results_ds2(overwrite=yes);
   dcl char(8) name treatment;
   dcl char(1) gender;
   dcl double "date" having format date9.;
   /* Declare a Hash object for use as a lookup table */
   /* 8 is the default hashexpr, used to set hash object size */
   /* Hash table will be loaded from a SAS dataset */
   declare package hash people(8,'ds2_sas.trials_participants');
	method init();
      dcl integer rc;
      /* Define which variable(s) will be used as the lookup key */
      rc = people.defineKey('name');
      /* Define which variable(s) will be returned as data from the lookup */
      /* DS2 defineData() accepts only one variable name at a time */
      rc = people.defineData('gender');
      rc = people.defineData('treatment');
      /* Definitions for this hash object are complete */
      rc=people.defineDone();
   end;
	method run();
      /* use the SET statement to iterate over the trials_weight data */
      /* keys in that table to match the keys in the hash package data */
      set ds2_sas.trials_weight;
      /* Look up the Treatment and Gender in the Hash object */
      /* If found, gender and treatment will be populated, so output */
      if (people.find() = 0) then output;
   end;
enddata;
run;
quit;

title "Treatment Results - DS2 HASH Package Lookup";
proc print data=results_ds2;
   var date name gender weight treatment;
run;
title;
