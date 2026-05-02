-- Creating the first table
CREATE Table retail_sales 
			(
				transactions_id	int,
				sale_date date,
				sale_time time,	
				customer_id	int,
				gender varchar(15),
				age	int,
				category varchar(15),	
				quantiy	int,
				price_per_unit float,
				cogs float,
				total_sale float
			)


-- Checking for null values

select * from retail_sales 
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;

-- cleaning data

Delete from retail_sales
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;

-- Data Exploration

-- How many categories do we have?
SELECT COUNT(DISTINCT category)
FROM retail_sales;

-- How many individual sales do we have?
SELECT count(*) as Total_Sale FROM retail_sales;

-- How many unique customers do we have?
SELECT count(distinct customer_id) FROM retail_sales;

-- How many males and females do we have?
SELECT
gender, count(*)
FROM retail_sales
GROUP by gender;

-- Data analysis and Key business problems with answers

-- How many sales were made on a specific date?
SELECT * 
from retail_sales
WHERE sale_date = '2022-07-01';

-- Retreiving all data related to sales made in a specific month, more than a specific quantity and with a specific category
SELECT *
from retail_sales
where category = 'Clothing'
	and	
	TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
	AND
	quantiy >= 4;

-- Calculate total sales by category and number of sales

SELECT 
	category,
	sum(total_sale) as net_sale,
	count(*) as total_orders
FROM retail_sales
group by 1;

-- Calculating average ages of customers for specific categories

SELECT
	ROUND(avg(age),2) as average_age
from retail_sales
where category = 'Beauty';

-- Find all transactions with sales above 1000

SELECT *
from retail_sales
where total_sale > 1000;

-- Find total transactions by each gender in each category

Select 
	gender,
	category,
	count(transactions_id) as total_orders
from retail_sales
group by 1, 2;

-- Find avg sales for each month of year and find best month for each year

Select * from 
(
	SELECT
		EXTRACT(YEAR from sale_date) as year,
		Extract(MONTH from sale_date) as month,
		avg(total_sale) as Average_Sale,
		rank() over(PARTITION BY EXTRACT(YEAR from sale_date) ORDER by avg(total_sale) DESC) as rank
	from retail_sales
	group by 1,2
) as t1
WHERE rank = 1;

-- Find top 5 customers based on highest sales

SELECT
	customer_id,
	sum(total_sale) as total_spending
FROM retail_sales
GROUP by 1
ORDER by 2 DESC
LIMIT 5;

-- Unique customers that purchased items from each category

SELECT
	category,
	count (distinct customer_id) as unique_custs
from retail_sales
group by 1;

-- Create shifts according to sale timings, find number of orders per shift

WITH Shift_sales
AS 
(
	SELECT *,
		CASE
			WHEN EXTRACT(hour from sale_time) < 12 THEN 'Morning'
			WHEN extract(hour from sale_time) between 12 and 17 THEN 'Afternoon'
			ELSE 'Evening'
		END as Shift
	from retail_sales
)
Select 
	Shift, 
	count(*) as total_orders
from Shift_sales
group by 1;

-- End of Project