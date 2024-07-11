-- Total sales per month

SELECT 
    YEAR(order_date) AS order_year, 
    MONTH(order_date) AS order_month, 
    SUM(sell_price * quantity) AS total_sales
FROM 
    df_orders
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

-- Which product category has the highest sales 

select category , sum(sell_price * quantity) as sales
from df_orders 
GROUP BY category
ORDER BY sales desc;

-- Average order value by customer segment 
 
SELECT segment, AVG(order_value) AS average_order_value
FROM (
    SELECT segment, order_id, SUM(sell_price * quantity) AS order_value
    FROM df_orders
    GROUP BY segment, order_id
) AS order_totals
GROUP BY segment;

-- find the top 10 highest revenue generating products

Select product_id, sum(sell_price * quantity) as sales 
from df_orders
group by product_id
order by sales desc
LIMIT 10;

-- find top 5 highest selling products in each region 
with cte as(
select region , product_id , sum(sell_price * quantity) as regional_sales
from df_orders
group by region , product_id)
select * from(
select * , row_number() over (partition by region order by regional_sales desc) as rn
from cte) A 
where rn<=5;

-- for month over growth comparison for 2022 and 2023 
with cte as(
SELECT YEAR(order_date) as order_year , MONTH(order_date) as order_month , sum(sell_price * quantity) as sales_year_month
from df_orders 
GROUP BY order_year , order_month
-- ORDER BY order_year , order_month
)
select order_month, 
sum(case when order_year = 2022 then sales_year_month else 0 end) as sales_2022 ,
sum(case when order_year = 2023 then sales_year_month else 0 end) as sales_2023
from cte
GROUP BY order_month
ORDER BY order_month