USE WAREHOUSE DEMO_WAREHOUSE;
USE DATABASE DEMO_DATABASE;

--create table and load table in database
CREATE OR REPLACE TABLE AJ_SALES_DATA
( order_id varchar(60) primary key,
  order_date varchar(60),
  ship_date varchar(60),
  ship_mode varchar(60),
  customer_name varchar(60),
  segment varchar(60),
  state varchar(60),
  country varchar(60),
  market varchar(60),
  region varchar(60),
  product_id varchar(60),
  category varchar(60),
  sub_category varchar(60),
  product_name varchar(500),
  sales number(10,0),
  quantity int,
  discount float,
  profit float,
  shipping_cost float,
  order_priority varchar(60),
  year number(10,0) );
  
DESCRIBE TABLE AJ_SALES_DATA;
SELECT * FROM AJ_SALES_DATA;

----1 SET PRIMARY KEY 

--Load the given dataset with primary key in order date
ALTER TABLE AJ_SALES_DATA
DROP PRIMARY KEY;

--ADD Primary key in order date column
ALTER TABLE AJ_SALES_DATA
ADD PRIMARY KEY (order_date);
 DESCRIBE TABLE AJ_SALES_DATA;
  
----2 CHECK THE ORDER DATE AND SHIP DATE TYPE AND THINK IN WHICH DATA TYPE YOU HAVE TO CHANGE
   select * from AJ_SALES_DATA
   ORDER BY ORDER_DATE,SHIP_DATE;

----3 EXTACT THE LAST NUMBER AFTER THE - AND CREATE OTHER COLUMN AND UPDATE IT

ALTER TABLE AJ_SALES_DATA
ADD COLUMN ORDER_EXTRACT varchar(15);

UPDATE AJ_SALES_DATA
SET Order_extract = SUBSTR(ORDER_ID ,9);
SELECT ORDER_ID, order_extract FROM AJ_SALES_DATA;

----4 FLAG ,IF DISCOUNT IS GREATER THEN 0 THEN  YES ELSE FALSE AND PUT IT IN NEW COLUMN FOR EVERY ORDER ID 

SELECT Order_id ,Discount,
     CASE
     When Discount > 0 then 'YES'
     Else 'FALSE'
     End as Discount_Type
     from AJ_SALES_DATA;

----5 FIND OUT HOW MUCH DAYS TAKEN FOR EACH ORDER TO PROCESS FOR THE SHIPMENT FOR EVERY ORDER ID

--Create a new column called ship days and calculate how many days it takes 
--for each order to process for the shipment for every order id
SELECT ORDER_ID,ORDER_DATE,SHIP_DATE,
datediff(day, SHIP_DATE,ORDER_DATE) as SHIP_DAYS
FROM AJ_SALES_DATA;

----6 FLAG THE PROCESS DAY AS BY RATING

--IF IT TAKES LESS OR EQUAL 3  DAYS MAKE 5
--LESS OR EQUAL THAN 6 DAYS  BUT MORE THAN 3 MAKE 4
--LESS THAN 10 BUT MORE THAN 6 MAKE 3
--MORE THAN 10 MAKE IT 2 FOR EVERY ORDER ID  
SELECT ORDER_ID,ORDER_DATE,SHIP_DATE,
datediff(day, SHIP_DATE,ORDER_DATE) as SHIP_DAYS,
CASE
  WHEN SHIP_DAYS<=3 THEN 5
  WHEN SHIP_DAYS BETWEEN 3 AND 6 THEN 4
  WHEN SHIP_DAYS BETWEEN 6 AND 10 THEN 3
  ELSE 2
  END AS RATING
  FROM AJ_SALES_DATA;


