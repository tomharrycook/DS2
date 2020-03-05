title "Overloading the ADD() method";
proc ds2;
data;
   dcl char(2) W1 W2;
   dcl varchar(15) Phrase;
   dcl double N1 N2 Total;
   dcl varchar(5) V1 V2;
   dcl integer D1 D2;
   /* Overloaded ADD method */
   method add(char(50) first, char(50) second) returns varchar(101);
      return catx('+',first,second);
   end;
   method add(double first, double second) returns double;
      return sum(first,second);
   end;
   method init();
   /* Assign some values for testing */
     W1='20';
     W2='30';
     N1=20;
     N2=30;
     V1='V1';
     V2='V2';
     D1=20;
     D2=30;
   /* Add the words */
     Phrase=add(W1, W2);
   /* Add the numbers */
     Total=add(N1,N2);
     output;
   /* What happens when types are not exactly matched?*/
     Phrase='';
     N1=.;
     N2=.;
     Total=.;
     Phrase=add(V1, V2);
     output;
   end;
enddata;
run;
quit;
title;
