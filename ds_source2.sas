data _null_;
   if _n_ =1 then do;
      foo = '**> Starting';
      put foo;
   end;
   set ds2_sas.banks end=last;
   put _all_;
   if last then do;
      bar = '**> I quit!';
      put bar;
   end;
run;
