SELECT * FROM public.employees
ORDER BY employee_id ASC 

CREATE DATABASE retail_sales;

CREATE TABLE transactions (
	transactions_id	int primary key,
	sale_date DATE,	
	sale_time TIME,	
	customer_id	INT,
	gender VARCHAR(15),
	age	INT,
	category VARCHAR(15),
	quantiy INT,	
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
)
ALTER TABLE transactions
RENAME COLUMN total_sale TO total_sales 


SELECT * FROM transactions
limit 10

SELECT
	COUNT(*)
FROM transactions

SELECT * FROM transactions
WHERE 
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR 
	cogs IS NULL
	OR
	total_sales IS NULL;

DELETE FROM transactions
WHERE 
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR 
	cogs IS NULL
	OR
	total_sales IS NULL;

SELECT * FROM transactions
-- Data Exploration


-- How many sales we have? المقصود هنا عدد عمليات البيع مش اجمالي البيع كفلوس
SELECT 
	COUNT(*) AS TOTAL_SALES
FROM transactions

-- How many uniuque customers we have ?

SELECT
	 COUNT(distinct customer_id)
FROM transactions



-- Data Analysis & Business Key Problems & Answers


-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT *
FROM transactions
where sale_date = '2022-11-05'



-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022

SELECT *
FROM transactions
WHERE category = 'Clothing'
	AND
	quantity >2
	AND
	TO_CHAR(sale_date,'yyyy-mm') = '2022-11' 


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT
	category,
	SUM(total_sales) AS total_sales
FROM transactions
GROUP BY category
ORDER BY category DESC;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
	AVG(age) as avg_age
FROM transactions
WHERE category ='Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM transactions
WHERE total_sales > 1000

-- Q.6 Write a sql query to find all transaction for customers who total sales over 4000
SELECT 
	customer_id,
	SUM(total_sales) AS total_sales
FROM transactions
GROUP BY customer_id
HAVING SUM(total_sales) > 4000
ORDER BY SUM(total_sales) DESC;



-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
	category,
	gender,
	COUNT(*)
FROM transactions
GROUP 
	BY 
	category, 
	gender
ORDER BY 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT * 
FROM transactions
SELECT * 
FROM (
SELECT
	DATE_PART('year',sale_date) as yr, --EXTRACT(year from sale_date) as yr
	DATE_PART('month',sale_date) as mth,
	AVG(total_sales) AS total_sales,
	RANK() OVER(PARTITION BY DATE_PART('year',sale_date) ORDER BY AVG(total_sales) DESC) AS rank
FROM transactions
GROUP 
	BY
	DATE_PART('year',sale_date),
 	DATE_PART('month',sale_date)
	ORDER BY 1,3 DESC
) AS T1
WHERE rank = 1
	
	
    
-- ORDER BY 1, 3 DESC

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
	customer_id,
	SUM(total_sales) as total_sales
FROM transactions
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5



-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
	COUNT(DISTINCT customer_id) as unique_customer,
	category
FROM transactions
GROUP BY category



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
SELECT * FROM transactions
WITH hourly_sale
AS

(SELECT
	*,
	CASE
		WHEN DATE_PART('HOURS',sale_time) < 12 THEN 'Morning'
		WHEN DATE_PART('HOURS',sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		else 'Evening'
	END AS shift
FROM transactions)
SELECT 
	shift,
	COUNT(*)
FROM hourly_sale
GROUP BY shift


SELECT
		DATE_PART('HOURS',sale_time) AS HOUR
 FROM transactions
-- End of project



	
	
	
	





