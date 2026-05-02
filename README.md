# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Table Setup

- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql

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
```

### 2. Data Exploration & Cleaning

- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
- **Data Exploration**: Find out how many categories we have, individual sales, unique customers and male/female customer count.

```sql
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

SELECT COUNT(DISTINCT category)
FROM retail_sales;

SELECT count(*) as Total_Sale FROM retail_sales;
SELECT count(distinct customer_id) FROM retail_sales;
SELECT
gender, count(*)
FROM retail_sales
GROUP by gender;
```

### 3. Data Analysis & Findings

The following SQL query templates were developed to answer specific business questions:

1. **How many sales were made on a specific date?**:
```sql
SELECT * 
from retail_sales
WHERE sale_date = '2022-07-01';
```

2. **Retreiving all data related to sales made in a specific month, more than a specific quantity and with a specific category**:
```sql
SELECT *
from retail_sales
where category = 'Clothing'
	and	
	TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
	AND
	quantiy >= 4;
```

3. **Calculate total sales by category and number of sales.**:
```sql
SELECT 
	category,
	sum(total_sale) as net_sale,
	count(*) as total_orders
FROM retail_sales
group by 1;
```

4. **Calculating average ages of customers for specific categories.**:
```sql
SELECT
	ROUND(avg(age),2) as average_age
from retail_sales
where category = 'Beauty';
```

5. **Find all transactions with sales above 1000.**:
```sql
SELECT *
from retail_sales
where total_sale > 1000;
```

6. **Find total transactions by each gender in each category.**:
```sql
Select 
	gender,
	category,
	count(transactions_id) as total_orders
from retail_sales
group by 1, 2;
```

7. **Find avg sales for each month of year and find best month for each year.**:
```sql
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
```

8. **Find top 5 customers based on highest sales**:
```sql
SELECT
	customer_id,
	sum(total_sale) as total_spending
FROM retail_sales
GROUP by 1
ORDER by 2 DESC
LIMIT 5;
```

9. **Unique customers that purchased items from each category.**:
```sql
SELECT
	category,
	count (distinct customer_id) as unique_custs
from retail_sales
group by 1;
```

10. **Create shifts according to sale timings, find number of orders per shift**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## Author - Maaz Khan

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

Thank you for your support, and I look forward to connecting with you!
