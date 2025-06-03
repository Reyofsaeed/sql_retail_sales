- SQL Retail Sales Analysis 

--Create Table
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


SELECT *
FROM retail_sales
LIMIT 10
---
SELECT
   count(*)
FROM retail_sales

--- DATA CLEANING
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


-----DATA EXPLORATION

-- How many sales do we have ?

SELECT COUNT(*) AS total_sale
FROM retail_sales
-- How many uniuque customers do we have ?

SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales
--
SELECT DISTINCT category AS total_category
FROM retail_sales

-----Data Analysis & business key problems & Answers

--Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT count(*)
FROM retail_sales
WHERE sale_date = '2022-11-05';

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022 ?


SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity > 3
  AND EXTRACT(MONTH FROM sale_date) = 11
  AND EXTRACT(YEAR FROM sale_date) = 2022;


--Write a SQL query to calculate the total sales (total_sale) for each category?

SELECT category,
   sum(total_sale) as total_sales,
   count(*) as total_order
FROM retail_sales
GROUP BY 1

--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:



SELECT AVG (total_sale)AS month_avg_sales,
EXTRACT(month from sale_date) as month,
EXTRACT(year from sale_date) as year
FROM retail_sales
GROUP BY 2 , 3
order by 1 desc;

--Write a SQL query to find all transactions where the total_sale is greater than 1000:

SELECT *
FROM retail_sales
WHERE total_sale >1000;


--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category


SELECT COUNT(transactions_id)as total_orders,gender,category
FROM retail_sales
GROUP BY gender,category 
order by 1

  --- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year


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


---*Write a SQL query to find the top 5 customers based on the highest total sales **:


SELECT customer_id,sum(total_sale) as sales
FROM retail_sales
group by 1
order by sales desc
limit 5



--Write a SQL query to find the number of unique customers who purchased items from each category:


SELECT count(distinct customer_id)as unique_customers,category
FROM retail_sales
group by 2



--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

SELECT 
   CASE
   WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'MORNING'
   WHEN EXTRACT(HOUR FROM sale_time)between 12 AND 17 THEN 'AFTERNOON'
   ELSE 'EVENING'
   END AS SHIFTS,
   COUNT(*) as orders_total
FROM retail_sales
GROUP BY SHIFTS;


--END OF PROJECT 
   




