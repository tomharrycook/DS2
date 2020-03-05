/*diff_quotes.sas*/
proc ds2;
data _null_;
   method init();
   /*Double quotes indicate NAMES*/
   dcl varchar(15) "My Var";
   /*Single quotes indicate VALUES*/
   "My Var"='This is my text';
   put "My Var";
   end;
enddata;
run;
quit;

proc ds2;
data _null_;
   method init();
   dcl varchar(15) "My Var";
   /*Double quoted NAMES are case sensitive*/
   "My Var"='This is my text';
   put "my var";
   end;
enddata;
run;
quit;

%let macvar=This is my text;
proc ds2;
data _null_;
   method init();
   dcl varchar(15) "My Var";
   /*Macro values do not resolve in single quotes*/
   "My Var"='&macvar';
   put "My Var";
   end;
enddata;
run;
quit;

proc ds2;
data _null_;
   method init();
   dcl varchar(15) "My Var";
   /*DOUBLE quotes resolve a macro variable as a NAME*/
   "My Var"="&macvar";
   put "My var";
   end;
enddata;
run;
quit;

proc ds2;
data _null_;
   method init();
   dcl varchar(15) "My Var";
   /*Solution: use %TSLIT to resolve macro variables as VALUES*/
   "My Var"=%TSLIT(&macvar);
   put "My Var";
   end;
enddata;
run;
quit;
