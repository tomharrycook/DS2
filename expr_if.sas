proc ds2;
data _null_;
   method init();
      dcl bigint x;
      dcl varchar test;
      test=if NULL(x) then 'True' else 'False'; 
      put test=; 
   end;
enddata;
run;
quit;

/*The IFN function plays a similar role in a DATA step*/
/*but will set _ERROR_=1 when y=0 or y=. because IFN */
/*evaluates all of the expressions before returning a value*/
/*(greedy evaluation)*/
data _null_;
   y=1;
/*   y=0;*/
   x=1;
   z=ifn(y ne 0,x/y,.);
   put x= y= z=; 
run;

/*The IF operator plays a similar role to IFN in a DS2 DATA program*/
/*but _ERROR_ does not get set to 1 when y=0 or y=. because IF evaluates */
/*only the RESULT expression specified by the conditional EXPRESSION */
/*(lazy evaluation)*/
proc ds2;
data _null_;
   method init();
      dcl double x y z;
      y=1;
/*      y=0;*/
   x=1;
      z= if y then x/y else .; 
      put x= y= z=; 
   end;
enddata;
run;
quit;
