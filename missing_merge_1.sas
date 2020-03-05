/*missing_merge.sas*/
proc sort data=ds2_sas.order_fact
          out=order_fact;
   by customer_id;
run;

proc ds2;
data sales (overwrite=YES);
   keep Customer_ID Total;
   method run();
      merge order_fact 
            ds2_sas.customer_dim;
      by customer_id;
      if first.customer_id then Total=0;
      Total+total_retail_price;
      if last.customer_id then output;
   end;
run;
quit;


