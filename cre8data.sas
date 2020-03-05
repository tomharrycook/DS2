DATA ds2_sas.banks;
    LENGTH Name             $ 26
           Rate               8 ;
    INFILE DATALINES   TRUNCOVER DSD DLM=',';
    INPUT Name :$26. Rate :??COMMA10.;
datalines4;
Carolina Bank and Trust,0.0318
State Savings Bank,0.0321
National Savings and Trust,0.0328
;;;;

DATA DS2_SAS.SAS_DATETIMES;
   infile DATALINES DSD TRUNCOVER DLM=',';
   INPUT 
         ID :32.16
         SAS_Date :32.16
         SAS_Time :32.16
         SAS_Datetime :32.16
   ;
   FORMAT 
         ID Z4.
         SAS_Date DATE9.
         SAS_Time TIME.
         SAS_Datetime DATETIME.
   ;
DATALINES4;
1,13720,0,1185408000.000
2,13720,1800,1185409800.000
3,13720,3600,1185411600.000
;;;;

data ds2_sas.trials_participants;
input name $ gender:$1. treatment $;
datalines;
John M Placebo
Ronald M Drug-A
Barbara F Drug-B
Alice F Drug-A
;

data ds2_sas.trials_weight(drop=i);
input date:DATE9. @;
do i = 1 to 4;
input name $ weight @;
output;
end;
/* For brevity, only two dates are listed below */
datalines;
05May2006 Barbara 125 Alice 130 Ronald 170 John 160
04Jun2006 Barbara 122 Alice 133 Ronald 168 John 155
;


proc fedsql;
  drop table ds2_td.banks;
  drop table DS2_td.SAS_DATETIMES;
quit;

DATA ds2_td.banks;
    LENGTH Name             $ 26
           Rate               8 ;
    INFILE DATALINES   TRUNCOVER DSD DLM=',';
    INPUT Name :$26. Rate :??COMMA10.;
datalines4;
Carolina Bank and Trust,0.0318
State Savings Bank,0.0321
National Savings and Trust,0.0328
;;;;

DATA DS2_td.SAS_DATETIMES;
   infile DATALINES DSD TRUNCOVER DLM=',';
   INPUT 
         ID :32.16
         SAS_Date :32.16
         SAS_Time :32.16
         SAS_Datetime :32.16
   ;
   FORMAT 
         ID Z4.
         SAS_Date DATE9.
         SAS_Time TIME.
         SAS_Datetime DATETIME.
   ;
DATALINES4;
1,13720,0,1185408000.000
2,13720,1800,1185409800.000
3,13720,3600,1185411600.000
;;;;


PROC FEDSql;
/*Create identical views in SAS and TERADATA*/
drop table ds2_sas.two_recipients;
create table ds2_sas.two_recipients as
   select Employee_ID, qtr1
         ,qtr2 ,qtr3 ,qtr4 
      from ds2_sas.employee_donations
      where find(recipients,'%')>0
   ;
drop table ds2_td.two_recipients;
create table ds2_td.two_recipients as
   select Employee_ID, qtr1
         ,qtr2 ,qtr3 ,qtr4 
      from ds2_td.employee_donations
      where find(recipients,'%')>0
   ;
quit;
