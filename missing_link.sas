data _null_;
   set ds2_sas.banks;
   do Year=1 to 5;
      capital=sum(capital,5000);
      link calc;
   end;
   put Name '5-year bottom line:'
       Capital dollar8.;
return;
calc:
do Q=1 to 4;
   capital=sum(capital
          ,capital*(rate/4));
end;
return;
run;             /*missing_link.sas*/


proc ds2;
data _null_;
method calc(double c, double r)
       returns double; 
   do Q=1 to 4;
      c=sum(c,c*(r/4));
   end;
   return c;
end;
method run();
   set ds2_sas.banks;
   do Year=1 to 5;
      capital=sum(capital,5000);
      capital=calc(capital,rate);
   end;
   put Name '5-year bottom line:'
       Capital dollar8.;
end;
run;
quit;             /*missing_link.sas*/
