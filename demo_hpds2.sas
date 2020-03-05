/*Starting Program*/
proc ds2;
data from_hpds2(overwrite=yes);
   vararray double contrib[*] qtr:;
   dcl double Total;
   METHOD RUN();
   dcl int q;
   set ds2_td._t;
   Total=0;
   do q=1 to dim(contrib);
      Total+contrib[q]*1.25;
   end;
   END;
enddata;
run;
quit;


/*Convert the SET query to a view*/
proc FedSQL;
drop view ds2_td._t;
create view ds2_td._t as
   select Employee_ID, qtr1
         ,qtr2 ,qtr3 ,qtr4 
    from ds2_sas.employee_donations
    where find(recipients,'%')>0
;
quit;








/*Convert to HPDS2*/
proc hpds2  in=ds2_td._t
            out=work.from_hpds2;
data ds2gtf.out(overwrite=yes);
   vararray double contrib[*] qtr:;
   dcl double Total;
   METHOD RUN();
   dcl int q;
   set ds2gtf.in;
   Total=0;
   do q=1 to dim(contrib);
      Total+contrib[q]*1.25;
   end;
   END;
enddata;
run;
quit;
