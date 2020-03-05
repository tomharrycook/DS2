PROC DS2;
data _null_;
   DCL double MyVar[3];
   method init();
      DCL varchar(12) MyVar;
      MyVar='Just Testing';
      Put MyVar=;
   end;
   method term();
      do i=1 to dim(MyVar);
         MyVar[i]=10**i;
         put MyVar[i]=;
      end;
   end;
run;
QUIT;

