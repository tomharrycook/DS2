proc ds2;
/*This package is permanently stored in a SAS table called Mark1*/
/*The table contains nothing more than the encrypted SOURCE code*/
/*for the methods defined in this package*/
package ds2_sas.Mark1 /overwrite=yes;
   /* Overloaded ADD method */
   method add(char(50) first, char(50) second) returns char(101);
      return catx('+',first,second);
   end;
   method add(double first, double second) returns double;
      return sum(first,second);
   end;
   /* Let's make the ADD method self-documenting */
   /* by overloading it yet again                */
   method add();
      PUT;
      PUT 'Mark1 Package ADD() method syntax ***********************************';
      PUT 'The ADD() method accepts 2 parameters.';
      PUT ' - If the parameters are DOUBLE, it returns the sum.';
      PUT ' - If the parameters are CHARACTER, it returns the concatenation.';
      PUT ' - If no parameters are passed, syntax help is printed in the SAS log.';
      PUT '*********************************************************************';
      PUT;
   end;
endpackage;
run;
quit;

proc ds2;
data _null_;
/*To use methods from a package, first declare an instance of the package.*/
/*For example, this instance of the ds2_td.Mark1 package is called Calc:*/
   dcl package ds2_sas.Mark1 calc();
   method init();
   /*Package methods are executed using instance.method(parameters) notation */
   /*Test the self-documenting feature of the ADD method*/
      calc.add(); 
   end;
enddata;
run;
quit;
title;

title "Using a Package";
proc ds2;
data;
   dcl package ds2_sas.Mark1 calc();
   dcl char(2) W1 W2;
   dcl char(5) Phrase;
   dcl double N1 N2 Total;
   method init();
   /* Add the words */
     W1='20';
     W2='30';
     Phrase=calc.add(W1, W2);
   /* Add the numbers */
     N1=20;
     N2=30;
     Total=calc.add(N1,N2);
     output;
   end;
enddata;
run;
quit;
title;
