PROC DS2;
data _null_;
   dcl double Temp F;
   method f2c(IN_OUT double T);
   /* Farenheit to Celsius */
      T=((T-32)*5)/9;
   end;
   method init();
      do F=32 to 212 by 45;
         Temp=F;
         PUT Temp 'degrees Fahrenheit';
         f2c(Temp);
         PUT Temp 'degrees Celsius';
      end;
   end;
enddata;
run;
QUIT;
