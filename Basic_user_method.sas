PROC DS2;
data _null_;
   method c2f(double Tc) returns double;
   /* Celsius to Farenheit */
      return (((Tc*9)/5)+32);
   end;
   method init();
      dcl double Degc DegF;
      do DegC=0 to 30 by 15;
         DegF=c2f(DegC);
         PUT DegC= DegF=;
      end;
   end;
enddata;
run;
QUIT;
