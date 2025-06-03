# SQL Retail Sales Analysis 

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sales_project_db`

This project showcases fundamental SQL skills commonly used by data analysts to clean, explore, and analyze retail sales data. It involves creating a retail sales database, conducting exploratory data analysis (EDA), and using SQL queries to answer key business questions.

## Objectives

1. **Database Setup**: Initialize and populate a retail sales database using the provided dataset.
2. **Data Cleaning**: Detect and eliminate records containing null or missing values to ensure data quality.
3. **Exploratory Data Analysis (EDA)**: Conduct initial analysis to explore data patterns, trends, and structure.
4. **Business Insights**: Leverage SQL queries to answer targeted business questions and extract actionable insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sales_project_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sales_project_db;

CREATE TABLE retail_sales
        (
        transactions_id INT PRIMARY KEY,
        sale_date DATE,
        sale_time TIME,
        customer_id INT,
        gender VARCHAR(15),
        age INT,
		category VARCHAR(15),
        quantiy INT,
        price_per_unit FLOAT,
        cogs FLOAT,
        total_sale FLOAT
        );

```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT *
FROM retail_sales
WHERE transactions_id is null
     OR
	 sale_date is null
	 OR
	 sale_time is null
	 OR
	 customer_id is null
	 OR
	 gender is null
	 OR
	 age is null
	 OR
	 category is null
	 OR
	 quantiy is null 
	 OR
	 price_per_unit is null
	 OR 
	 cogs is null
	 OR
	 total_sale is null;

DELETE FROM retail_sales
WHERE transactions_id is null
     OR
	 sale_date is null
	 OR
	 sale_time is null
	 OR
	 customer_id is null
	 OR
	 gender is null
	 OR
	 age is null
	 OR
	 category is null
	 OR
	 quantiy is null 
	 OR
	 price_per_unit is null
	 OR 
	 cogs is null
	 OR
	 total_sale is null;

ALTER TABLE retail_sales
RENAME COLUMN quantiy TO quantity;


SELECT COUNT(*) AS total_sale
FROM retail_sales


SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales

SELECT DISTINCT category AS total_category
FROM retail_sales

```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT(*)
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022**:
```sql

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity > 3
  AND EXTRACT(MONTH FROM sale_date) = 11
  AND EXTRACT(YEAR FROM sale_date) = 2022;

```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT category,
   sum(total_sale) as total_sales,
   count(*) as total_order
FROM retail_sales
GROUP BY 1
```

4. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT *
FROM retail_sales
WHERE total_sale >1000;
```

5. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
COUNT(transactions_id)as total_orders,gender,category
FROM retail_sales
GROUP BY gender,category 
order by 1
```

6. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT * FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) as year,
        EXTRACT(MONTH FROM sale_date) as month,
        AVG(total_sale) as avg_sale,
        RANK() OVER(
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) as rank
    FROM retail_sales
    GROUP BY 1, 2
) as R1
WHERE rank = 1;

```

7. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT customer_id,sum(total_sale) as sales
FROM retail_sales
group by 1
order by sales desc
limit 5
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql

SELECT count(distinct customer_id)as unique_customers,category
FROM retail_sales
group by 2
```

9. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql

SELECT 
   CASE
   WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'MORNING'
   WHEN EXTRACT(HOUR FROM sale_time)between 12 AND 17 THEN 'AFTERNOON'
   ELSE 'EVENING'
   END AS SHIFTS,
   COUNT(*) as orders_total
FROM retail_sales
GROUP BY SHIFTS;

```

## Findings

- **Customer Demographics**: The data reflects a range of age groups among customers, with purchases spanning various categories like Clothing and Beauty.
- **High-Value Transactions**: Multiple transactions exceeded 1000 in total sales, suggesting the presence of premium-level purchases.
- **Sales Trends**: Analyzing sales by month reveals fluctuations that help pinpoint high-demand periods.
- **Customer Insights**: The analysis highlights top customers by spending and uncovers the most frequently purchased product categories.

## Reports

- **Sales Summary**: A comprehensive overview capturing total sales figures, customer demographics, and category-level performance.
- **Trend Analysis**: Key observations on sales fluctuations by month and time-of-day shifts.
- **Customer Insights**: Highlights of top-spending customers and the number of unique buyers per product category.



## Conclusion

Through this project, I applied SQL skills to analyze retail sales data in a practical context. I began by creating and cleaning the database to ensure data accuracy, then performed exploratory analysis to understand customer demographics and category performance. I used SQL queries to answer real business questions, such as identifying peak sales periods and top-spending customers. This project helped me strengthen my understanding of data analysis using SQL and gain hands-on experience in extracting insights that support business decision-making.



