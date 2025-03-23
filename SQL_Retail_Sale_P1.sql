SELECT * FROM Retail_Sales

CREATE TABLE Retail_Sales
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


Select Count(*) from retail_Sales

Select * from retail_Sales
Where cogs is NULL

Select * from retail_Sales
Where
	transactions_id	Is Null
	OR
	sale_date Is Null
	OR
	sale_time is Null
	OR
	customer_id is  Null
	OR
	gender is  Null
	OR
	age is  Null
	OR
	category  is Null
	OR
	quantiy is  Null
	OR
	price_per_unit is  Null
	OR
	cogs is  Null
	OR
	total_sale is  Null

Delete from retail_Sales
Where
	transactions_id	Is Null
	OR
	sale_date Is Null
	OR
	sale_time is Null
	OR
	customer_id is  Null
	OR
	gender is  Null
	OR
	age is  Null
	OR
	category  is Null
	OR
	quantiy is  Null
	OR
	price_per_unit is  Null
	OR
	cogs is  Null
	OR
	total_sale is  Null

--Data Exploration---
--How Many Sales we have?--
Select Count(*) as Total_sales from retail_Sales

--How Many Customers we have?--
Select Count(*) as Total_Customers from retail_sales

--How Many Unique Customers We have?--
Select COUNT(DISTINCT customer_id) as Unique_Customers from retail_sales

--How Many Unique Categories We have?--
Select DISTINCT Category as Unique_Categoriess from retail_sales


--Data Analysis & Business Problems--

--1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
Select * from retail_sales
where sale_date = '2022-11-05';

--2.	Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM retail_sales
	WHERE category = 'Clothing'
	AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantiy >= 4
	
	
--3. Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
	Category,
	Sum(Total_sale),
FROM retail_sales
Order BY 1,

--4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
		ROUND(AVG(age),2) as Avarage_Age
FROM retail_sales
WHERE Category = 'Beauty'

--5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale >= 1000;

--6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
	category,
	gender,
	COUNT (*) as total_transactions
FROM retail_sales
GROUP BY 
	category,
	gender

--7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT 
	year,
	month,
	Avarge_sale
FROM
(
	SELECT
		EXTRACT(YEAR FROM sale_date) as Year, --This is to EXTRACT data from date formate.
		EXTRACT(MONTH FROM sale_date) as Month,
		AVG(Total_sale) as Avarge_sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(Total_sale)DESC) as Rank --Window  Fun To Rank or arrange VALUES
	FROM retail_sales
	GROUP BY 1,2
)as t1 -- This is that we assign the whole SELECT STATEMENT to as t1
WHERE Rank = 1


--8. **Write a SQL query to find the top 5 customers based on the highest total sales **
Select 
	customer_id,
	Sum(total_sale) as Total_Sales
FROM retail_sales
GROUP BY customer_id
ORDER BY Total_Sales DESC
LIMIT 5
--9. Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT
	Category,
	Count(DISTINCT Customer_id)
FROM retail_sales
GROUP BY Category

--10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH Total_Orders AS ( -- A Common Table Expression (CTE) is a temporary result set that you can reference within a SQL query. It makes complex queries easier to read and manage.

SELECT *,
	CASE
		WHEN EXTRACT (HOUR FROM Sale_time) <12 THEN  'Morning'
		WHEN EXTRACT (HOUR FROM Sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as Shift
FROM retail_sales
)

Select
	Shift,
	COUNT(*) as total_sales
from Total_Orders
GROUP BY shift


------------END OF THE PROJECT-----------










