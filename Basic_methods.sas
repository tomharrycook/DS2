PROC DS2;
data _null_;
   method init();
      dcl varchar(20) foo;
      foo = '**> Starting';
      put foo;
   end; 
   method run();
      set ds2_sas.banks;
      put _all_;
   end;
   method term();
      dcl char(11) bar;
      bar = '**> I quit!';
      put bar;
   end;
run;
QUIT;
