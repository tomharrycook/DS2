proc ds2;
data _null_;
   method init();
      dcl int x ;
      dcl varchar(4) test;
      x=ceil(ranuni(0)*3);
      test=SELECT (X)
              when (1) 'Air' 
              when (2) 'Rail' 
              otherwise 'Car' end; 
      put test= x=; 
   end;
enddata;
run;
quit;
