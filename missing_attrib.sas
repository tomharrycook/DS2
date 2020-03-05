data test1;
   length A $4;
   attrib A informat=$CHAR4.;
   format B comma10.2;
   label A='Text' B='Number';
   a=' xx ';
   b=10000.00000;
run;    /*missing_attrib.sas*/
PROC DS2;
data test2 (overwrite=YES);
   dcl char(4) A having informat $char4. label 'Text';
   dcl double B having format comma10.2 label 'Number';
   method run();
      a=' xx ';
	  b=10000.00000;
   end;
run;
QUIT;  /*missing_attrib.sas*/
