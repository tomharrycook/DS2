/* Stolen from the DS2 Documentation */
proc fcmp outlib = ds2_sas.fcmp_functions.package1;
   subroutine swapper(a,b);
      outargs a,b;
      _b = b; b = a; a = _b;
   endsub;
run;
quit;

options cmplib=ds2_sas.fcmp_functions;
data _null_;
   x=10;
   y=42;
   put 'before:' x= y=;
   /* Test the new FCMP function */
   call swapper(x,y);
   put 'after:' x= y=;
run;

proc ds2;
   /* Import the FCMP function definitions into a DS2 pacakge. This */
   /* only needs to be done once */
   package ds2_sas.imported_fcmp_funcs / overwrite=yes language='fcmp' table='ds2_sas.fcmp_functions';
run;
quit;

/* Using the imported FCMP functions in a DS2 program */
proc ds2;
data _null_;
   /* Use this package like any other DS2 package */
   /* Instantiate the package for this DS2 data program */
   dcl package ds2_sas.imported_fcmp_funcs FCMP1();
   method init();
      dcl double x y;
      x=10;
      y=42;
      put 'before:' x= y=;
      /* Execute the FCMP function from the package instance */
      FCMP1.swapper(x,y);
      put 'after:' x= y=;
   end;
enddata;
run;
quit;
