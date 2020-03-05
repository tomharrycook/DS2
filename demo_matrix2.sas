proc ds2;
data x(keep =(a1 a2 a3)) y(keep=(b1 b2 b3 b4))/overwrite=yes;
   vararray double a[3];
   vararray double b[4];
   method init();
      dcl int i j;
      /* Create output for matrix a. */
      do i=1 to 4;
         do j=1 to 3;
            a[j]=2 * j + i;
         end;
         output x;
      end;

      /* Create output for matrix b. */
      do i=1 to 3;
         do j=1 to 4;
            b[j]=3 * j - 2 * i;
         end;

         output y;
      end;
   end;
   enddata;
run;
quit;

proc ds2;
data z(keep =(v1 v2 v3 v4))/overwrite=yes;
   drop i;
   vararray double v[4];
   vararray double a[3];
   vararray double b[4];
   dcl package matrix ma mb;
   dcl package matrix r;
   method init();
      dcl int i;
      ma=_new_ [this] matrix(4,3);
      mb=_new_ [this] matrix(3,4);

      /* Read matrix a (row-by-row). */
      do i=1 to 4;
         set x;
         ma.in(a, i);
      end;

      /* Read matrix b (row-by-row). */
      do i=1 to 3;
         set y;
         mb.in(b, i);
      end;
   end;
   method term();
      dcl int i;
      /* Multiply the matrices. */
      r=ma.mult(mb);
      /* Write the result. */
      do i=1 to 4;
         r.out(v, i);
         output;
      end;
   end;
   enddata;
run;
quit;
