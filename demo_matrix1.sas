proc ds2;
data _null_;
   method init();
      dcl double i j;
     /* DS2 Arrays*/
      dcl double a[3, 2];
      dcl double b[2, 3];
      dcl double c[3, 3];
      /* Matrix instantiations */
      dcl package matrix m1;
      dcl package matrix m2;
      dcl package matrix result;
      a :=(/* Assign values to the 3X2 array */
          1, 2
        , 3, 4 
        , 5, 6
          );
      b := (/* Assign values to the 2X3 array */
          1, 3, 5
        , 7, 9, 11
           );
      /* Assign values from the arrays to matricies */
      m1=_new_ matrix(a, 3, 2);
      m2=_new_ matrix(b, 2, 3);
      /* Multiply the matricies */
      result=m1.mult(m2);
      /* Assign result matrix values to a DS2 array */
      result.toarray(c);

      PUT 'BEGIN RESULTS:****************************';
      put;
      do i=1 to 3;
         put 'Row ' i;
         put c[i,1] c[i,2] c[i,3];
         put;
      end;
      PUT 'END RESULTS:******************************';
   end;
   enddata;
run;
quit;
