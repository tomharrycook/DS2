proc ds2;
data _null_;
   method INIT();
      dcl double rc;
      /* The SQLEXEC function is great for executing hard-coded SQL queries */
      rc=sqlexec('drop table ds2_td.JustTesting2');
      put RC=;
      rc=sqlexec('create table ds2_td.JustTesting2 (id int, Name VarChar(20), Salary double)');
      put RC=;
   end;
   enddata;
run;

/* Print results to output */
title "Empty table created by SQLEXEC function";
data;
   method run();
      set ds2_td.JustTesting2;
   end;
enddata;
run;

data _null_;
   /* The SQLSTMT package enables DS2 variable values as parameters in */
   /* the SQL statement so that the values do not have to be hard-coded */
   dcl package sqlstmt sql_ins (/* First argument define the SQL statement to be executed */
                                /* use question marks ti identify positional parameters in the query*/
                                'insert into ds2_td.JustTesting2 (id,Name,Salary) values (?, ?, ?)'
                                /* Second argument binds the parameters to the DS2 variables i,n and s */
                                ,[i n s])
   ;
   /* Here we declare the variables that are bound to the sqlstmt package */
   dcl varchar(20) N;
   dcl int i;
   dcl double s;
   method init();
      /* Local variables we will use for processing */
      dcl varchar(20) Names[10]; /* Array of names */
      dcl double rc; /* Return code */

      rc=streaminit(123); /* Seed the random number process */
      /* Assign values to each element of the Names array */
      Names :=('Andressa','Baxter','Charlie','Doug','Edith','Fred','Greg','Hailey','Inigo','Jennifer');

      do i=1 to 10;
        /*Populate the variables bound to the SQLSTMT package */
        N=Names[i];
        S=ROUND(50000+RAND('NORMAL')*10000);
        put i= n= s=;
        /* Execute the SQL statement defined in the SQLSTMT package*/
        sql_ins.execute();
      end;

   end;
   enddata;
run;
/* Print results to output */
title "Table with rows added by the SQLSTMT package";
data;
   method run();
      set ds2_td.JustTesting2;
   end;
enddata;
run;

/* Drop the table we created */
data _null_;
   method INIT();
      dcl double rc;
      rc=sqlexec('drop table ds2_td.JustTesting2');
   end;
   enddata;
run;
quit;

