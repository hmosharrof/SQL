--all the cites of customers located in California and the number of customers in each city.
SELECT	
	 city, 
	 count(*) as "No of Custoemrs"
FROM sales.customers
WHERE state = 'CA'
GROUP BY city
ORDER BY city

--the city in California which has more than 10 customers:

SELECT	
	 city, 
	 count(*) as "No of Custoemrs"
FROM sales.customers
WHERE state = 'CA'
GROUP BY city
HAVING count(*) >10
ORDER BY city


-- OFFSET and FETCH
-- fetch expensive products skip the most expensive one

select
	product_name,
	list_price
from production.products
order by 
	list_price DESC,
	product_id
OFFSET 1 ROWS				/*skip the first row*/
FETCH NEXT 10 ROWS ONLY;	

--The SELECT TOP clause allows you to limit the number of rows or percentage of rows returned in a query result set.

--top 10 most expensive products.

SELECT TOP 10
	product_name,
	list_price
FROM production.products
ORDER BY list_price DESC;


--TOP to return a percentage of rows
--The production.products table has 321 rows, therefore, one percent of 321 is a fraction value (3.21), SQL Server rounds it up to the next whole number which is four (4) in this case.

SELECT TOP 1 PERCENT 
	product_name,
	list_price
FROM production.products
ORDER BY list_price DESC;

--TOP 3 with TIES to include rows that match the values in the last row
--Because the statement used TOP WITH TIES, it returned three more products whose list prices are the same as the third one.


SELECT TOP 3 WITH TIES
	product_name,
	list_price
FROM production.products
ORDER BY list_price DESC;

--get distinct cities from sales.customers table

SELECT 
	DISTINCT city 
FROM sales.customers
ORDER BY 1 ASC;

-- finds the distinct city and state of all customers.

SELECT 
	DISTINCT city, state
FROM sales.customers;

--DISTINCT vs. GROUP BY
--The following statement uses the GROUP BY clause to return distinct cities together with state and zip code from the sales.customers table

SELECT
	city,
	state,
	zip_code
FROM sales.customers
GROUP BY city, state, zip_code
ORDER BY city, state, zip_code;

-- we can use distinct to get the same result which we get from the above example.

SELECT 
	DISTINCT city,
	state,
	zip_code
FROM sales.customers;

--Both DISTINCT and GROUP BY clause reduces the number of returned rows in the result set by removing the duplicates.

--However, you should use the GROUP BY clause when you want to apply an aggregate function on one or more columns.

-- retrieves all products with the category id 1 from products table

SELECT 
	product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM production.products
WHERE category_id = 1;

-- returns products that meet two conditions: category id is 1 and the model is 2018.

SELECT 
	product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM production.products
WHERE category_id = 1 AND model_year = 2018;

-- finds the products whose list price is greater than 300 and model is 2018.

SELECT 
	product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM production.products
WHERE list_price > 300 AND model_year = 2018;

-- You can replace multiple OR operators by the IN operator

SELECT 
	product_name,
	brand_id
FROM production.products
WHERE brand_id IN (1,2,3);

-- Using OR operator with AND operator

SELECT 
	product_name,
	brand_id,
	list_price
FROM production.products
WHERE (brand_id = 1 OR brand_id = 2) 
	 AND list_price > 500
ORDER BY product_name, brand_id ASC,
		list_price DESC;


--Using SQL Server IN operator with a subquery
-- find out the product names and list prices of the products whose products located in the store id one and has the quantity greater than or equal to 30
/*the solution has two parts. First in subquery from stocks table we retrive the products id which are stored in store ide 1  and quantity >=30
Then in outer query will retrive the product name and list_price of those product id which we get from the subquery*/

SELECT 
	product_id,
	product_name,
	list_price
FROM production.products
WHERE product_id in (
SELECT product_id
FROM production.stocks
WHERE store_id =1 AND quantity >= 30);

--finds the products whose list prices are between 149.99 and 199.99

SELECT
	product_id,
	product_name,
	list_price
FROM production.products
WHERE list_price  BETWEEN 149.99 AND 199.99;

-- retrieves the customers whose last name starts with the letter t and ends with the letter s
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE last_name LIKE 't%s'