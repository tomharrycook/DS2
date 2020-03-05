data test1;
   COMMENT Comment 1;
   * Comment 2;
   set ds2_sas.continent;
   where Continent_ID=96;
   put _all_;
run;          /*miss_comment.sas*/

PROC DS2;
data test2 (overwrite=YES);
   /*Comment 1*/
   /*Comment 2*/
   method run();
      set {select * 
              from ds2_sas.continent
              where Continent_ID=96};
      put _all_;
   end;
run;
QUIT;       /*missing_comment.sas*/
