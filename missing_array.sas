data test1;
   array N [5];
   array C [5] $ 1 _temporary_; 
   do i=1 to dim(n);
      N[i]=dim(n)-I;
   end;
   do i=1 to dim(c);
      C[i]=BYTE(64+I);
      put C[i]= @;
   end;
   put _all_;
run;       /*missing_array.sas*/

PROC DS2;
data test2 (overwrite=YES);
   vararray double N[5];
   method run();
      dcl char(1) C[5];
      do i=1 to dim(n);
         N[i]=dim(n)-I;
      end;
      do i=1 to dim(c);
         C[i]=BYTE(64+I);
      end;
      put C[*]=;
      put _all_;
   end;
run;
QUIT;     /*missing_array.sas*/
