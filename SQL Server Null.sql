/*
NULL and three-valued logic
In the database world, NULL is used to indicate the absence of any data value. For example, at the time of recording the customer information, the email may be unknown, so it is recorded as NULL in the database.

Normally, the result of a logical expression is TRUE or FALSE. However, when NULL is involved in the logical evaluation, the result is UNKNOWN . This is called a three-valued logic: TRUE, FALSE, and UNKNOWN.
The results of the following comparisons are UNKNOWN:

NULL = 0
NULL <> 0
NULL > 0
NULL = NULL
*/

--finds the customers who do not have phone number recorded in the  customers table

SELECT 
	customer_id,
	first_name,
	last_name,
	phone
FROM sales.customers
WHERE phone IS NULL;

--To test whether a value is NULL or not, you always use the IS NULL operator.

SELECT 
	customer_id,
	first_name,
	last_name,
	phone
FROM sales.customers
WHERE phone IS NOT NULL;

