select * from df_orders;

-- Changing the format of the columns to lower case

ALTER TABLE df_orders
CHANGE `Order Date` order_date DATETIME, 
CHANGE `Order ID` order_id bigint,
CHANGE `Ship Mode` ship_mode text,
CHANGE `Segment` segment text,
CHANGE `Country` country text,
Change `City` city text,
Change `State` state text,
Change `Region` region text,
Change `Category` category text,
Change `Sub Category` sub_category text,
CHANGE `Cost Price` cost_price bigint,
Change `Quantity` quantity bigint,
CHANGE `Discount Percent` discount_percent bigint,
CHANGE `Postal Code` postal_code bigint,
CHANGE `List Price` list_price bigint,
CHANGE `Product ID` product_id text,
-- Adding columns
ADD column discount DECIMAL(10,2),
ADD column sell_price DECIMAL(10,2);
--
-- Creating an empty table 
-- 
CREATE TABLE order_info (
    order_id int primary key,
	order_date date,
    ship_mode varchar(20),
    segment varchar(20),
    country varchar(20),
    city varchar(20),
    state varchar(20),
    postal_code varchar(20),
    region varchar(20),
    category varchar(20),
    sub_category varchar(20),
    product_id varchar(20),
    quantity int,
    discount decimal(7,2),
    sale_price decimal(7,2),
    profit decimal(7,2)
    );
-- 
UPDATE df_orders
SET discount = list_price * discount_percent * 0.01 , 
    sell_price = list_price - (list_price * discount_percent * 0.01);
-- 
DROP TABLE df_orders; 
--
DROP DATABASE hkdf;
--
ALTER TABLE df_orders
DROP COLUMN cost_price , 
DROP COLUMN list_price , 
DROP COLUMN discount_percent;

-- find the top 10 highest revenue generating products

Select product_id, sum(sell_price * quantity) as sales 
from df_orders
group by product_id
order by sales desc
LIMIT 10;