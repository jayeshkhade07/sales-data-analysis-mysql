-- PROJECT: SALES DATA ANALYSIS USING MYSQL
-- DATABASE: sales_analysis_project
-- =====================================================
--- DATABASE CREATION
create database IF NOT EXISTS 
sales_analysis_project;

use sales_analysis_project;

--- TABLE CREATION
create table if not exists sales(
sale_id int primary key, product_name varchar(50), category varchar(50),
 quantity int, price decimal(10,2), sale_date date, city varchar(50));
 
--- INSERT SALES DATA
 insert into sales(sale_id, product_name, category, quantity, price, sale_date, city)
 values
 (1,'Laptop', 'Electronics', 2, 45000.00, '2026-01-05', 'Mumbai'),
 (2, 'Mobile','Electronics', 5, 15000.00, '2026-01-07', 'Pune'),
 (3, 'Chair', 'Furniture', 4, 2500.00, '2026-01-10', 'Mumbai'),
 (4, 'Table', 'Furniture', 2, 6000.00, '2026-01-12', 'Nashik'),
 (5, 'Headphones','Electronics', 3, '2000.00', '2026-01-15', 'Pune'),
 (6, 'Keyboard', 'Electronics', 6, 1200.00, '2026-01-18', 'Nagpur'),
 (7, 'Desk', 'Furniture', 3, '8000.00', '2026-01-20', 'Nashik'),
 (8, 'Mouse', 'Electronics', 10, '500.00', '2026-01-22', 'Mumbai'),
 (9, 'Office Chair', 'Furniture', 2, '5500.00', '2026-01-25', 'Pune'),
 (10, 'Monitor', 'Electronics', 3, '12000.00', '2026-01-28', 'Nagpur');
 
-------------- DATA CLEANING USING UPDATE
--- Correct the category name
  update sales 
  set category = 'Furniture'
  where sale_id = 9;
  
  --- Standardize the city name
  update sales
  set city = 'Pune'
  where sale_id = 2;
  
------------- TEMPORARY INSERT AND DELETE DEMONSTRATION
--- Insert one temporary record
  insert into sales
  (sale_id, product_name, category, quantity, price, sale_date, city)
  values(11, 'Tablet', 'Electronics', 2, 10000.00, '2026-02-01', 'Thane');
  
---- Delete only the temporary record 
  delete from sales
  where sale_id = 11;
  
------------------  DATA VERIFICATION
--- Display all sales records
  select * from sales;
  
  
 
------------------  BASIC SALES ANALYSIS

---- Calculate total sales
 select 
 sum(quantity * price) as total_sales 
 from sales;
 
---- Count total sales records
  select category,count(*) as total_product
 from sales
 group by category 
 order by total_product desc;
  
---- Calculate total quantity sold
select product_name, sum(quantity) as total_quantity_sold, sum(quantity * price) as total_sales
 from sales 
 group by product_name
 order by total_quantity_sold desc;
 
--------------------- CITY-WISE SALES ANALYSIS
---- Total sales by city
 select city, sum(quantity * price) as total_sales
 from sales
 group by city 
 order by total_sales desc;
 
---- Average sales value by city
  select city, round(avg(quantity * price),2) as average_sales
 from sales
 group by city
 order by average_sales desc;
 
---- Highest single-record sale in each city
  select city, max(quantity * price) as highest_sale
 from sales
 group by city
 order by highest_sale desc;
 
---- Display products and prices sorted by city
select city, product_name, price
 from sales
 order by city, price desc;
 
 ------------------- CATEGORY-WISE SALES ANALYSIS
 ---- Total sales and quantity by category
 select category, sum(quantity * price) as total_sales, sum(quantity) as total_quantity
 from sales
 group by category
 order by total_sales desc;
 
---- Category-wise sales and average price
select category, sum(quantity * price) as total_sales, round(avg(price),2) as average_price
from sales
group by category 
order by total_sales desc;

---- Category with the highest sales
 select category, sum(quantity * price) as total_sales
 from sales
 group by category
 order by total_sales desc 
 limit 1;
 
---- Category with the lowest sales
select category,sum(quantity * price) as total_sales
 from sales
 group by category 
 order by total_sales asc
 limit 1;
 
---- Count sales records by category
SELECT category, COUNT(*) AS total_records
FROM sales
GROUP BY category
ORDER BY total_records DESC;

---- Quantity sold and average price by category
select category, sum(quantity) as total_quantity, round(avg(price), 2) as average_price
from sales
group by category 
order by sum(quantity) desc;

-------------------- PRODUCT-WISE SALES ANALYSIS
---- Total quantity and sales by product
SELECT product_name,
       SUM(quantity) AS total_quantity_sold,
       SUM(quantity * price) AS total_sales
FROM sales
GROUP BY product_name
ORDER BY total_quantity_sold DESC;

----  Average price by product
select product_name, round(avg(price), 2) as average_price
 from sales
 group by product_name
 order by average_price desc;
 
---- Product with the highest unit price
select product_name, price
 from sales
 order by price desc
 limit 1;
 
---- Top five products by unit price
 select product_name, price
 from sales
 order by price desc
 limit 5;
 
---- Product sales above 5,000
 select product_name, price,(quantity * price) as total_sales
 from sales
 where quantity * price > 5000
 order by total_sales desc;
 
---- Electronics products sorted by price
 select product_name, quantity, price, city
 from sales
 where category = 'Electronics'
 order by price desc;
 
---- Products with quantity of at least three
select product_name,sum(quantity) as total_quantity, sum(quantity * price) as total_sales
from sales
group by product_name
having sum(quantity) >= 3
order by total_sales desc;

---- Highest and lowest unit price by product
select product_name, sum(quantity) as total_quantity,
 max(price) as highest_price, 
 min(price) as lowest_price
 from sales
 group by product_name
 order by highest_price desc;
 
------------------- MONTHLY SALES ANALYSIS
---- Monthly sales with month name
 select date_format(sale_date, '%Y-%M') as sales_month,sum(quantity * price) as total_sales
 from sales
 group by date_format(sale_date, '%Y-%M')
 order by sales_month;
 
---- Sales by year and month number
select year(sale_date) as sales_year, month(sale_date) as sales_month, 
sum(quantity * price) as total_sales
from sales
group by year(sale_date), month(sale_date)
order by sales_year, sales_month;

----------------------- FILTERING AND DATE ANALYSIS
---- Find sales records from 2026
 select * 
from sales
where year(sale_date) = 2026;

---- Find the record with Sale ID 1
select sale_id, product_name, sale_date
from sales
where sale_id = 1;