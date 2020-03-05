/*missing_merge_2.sas*/
proc ds2;
data sales (overwrite=YES);
   keep Customer_ID Total;
   method run();
      set {select c.Customer_ID
                 ,Total_Retail_Price 
              from ds2_sas.order_fact f
                   full join 
                   ds2_sas.customer_dim c
              on f.Customer_ID=c.Customer_ID
              order by 1};
      by customer_id;
      if first.customer_id then Total=0;
      Total+total_retail_price;
      if last.customer_id then output;
   end;
   enddata;
run;
quit;                  
