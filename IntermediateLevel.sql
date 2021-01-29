

--20. Categories, and the total products in each category. For this problem, we’d like to see the total number of products in each category. Sort the results by the total number of products, in descending order.

Select c.CategoryName, count(p.UnitsInStock) as TotalProducts
from Categories as c join Products as p
on c.CategoryID=p.CategoryID
group by CategoryName
order by TotalProducts desc;

--21.Total customers per country/city. In the Customers table, show the total number of customers per Country and City.

select country, city, count(*) as TotalCustomer from Customers 
group by Country, City
order by TotalCustomer desc;

--22. Products that need reordering. What products do we have in our inventory that should be reordered? For now, just use the fields UnitsInStock and ReorderLevel, where UnitsInStock is less than the ReorderLevel, ignoring the fields UnitsOnOrder and Discontinued. Order the results by ProductID.

select ProductID, ProductName, sum(UnitsInStock) as UnitsInStock, sum(ReorderLevel) as ReorderLevel  
from Products
where UnitsInStock < ReorderLevel
group by ProductID, ProductName;

--23. Products that need reordering, continued. Now we need to incorporate these fields—UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued—into our calculation. We’ll define “products that need reordering” with the following:
--UnitsInStock plus UnitsOnOrder are less than or equal to ReorderLevel
-- The Discontinued flag is false (0).

select ProductID, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued 
from products
where (UnitsInStock + UnitsOnOrder) <= ReorderLevel and Discontinued = 0

--24. Customer list by region. A salesperson for Northwind is going on a business trip to visit customers, and would like to see a list of all customers, sorted by region, alphabetically.
--However, he wants the customers with no region (null in the Region field) to be at the end, instead of at the top, where you’d normally find the null values. Within the same region, companies should be sorted by CustomerID.

select CustomerID, CompanyName, Region
from customers 
order by 
	CASE 
		when Region is null then 1 
		else 0 
	End ASC, Region, CustomerID

--25. High freight charges. Some of the countries we ship to have very high freight charges. We'd like to investigate some more shipping options for our customers, to be able to offer them lower freight charges. Return the three ship countries with the highest average freight overall, in descending order by average freight.

Select top 3 ShipCountry, AVG(Freight) AverageFreight 
from Orders 
group by ShipCountry 
order by AverageFreight desc

--26.  High freight charges - 2015. We're continuing on the question above on high freight charges. Now, instead of using all the orders we have, we only want to see orders from the year 2015.

Select  top 3 ShipCountry, AVG(Freight) as AverageFreight
from Orders 
where YEAR(convert(Date, OrderDate)) = '2015'
group by ShipCountry 
order by AverageFreight desc 

--27.  High freight charges with between. The Between statement is inclusive. when you run this, it gives Sweden as the ShipCountry with the third highest freight charges. However, this is wrong - it should be France.

select top 3 ShipCountry, AVG(Freight) as AverageFreight
from Orders  
where OrderDate Between '01/01/2015' and '12/31/2015'
group by ShipCountry
order by AverageFreight desc

--28. 28. High freight charges - last year. We're continuing to work on high freight charges. We now want to get the three ship countries with the highest average freight charges. But instead of filtering for a particular year, we want to use the last 12 months of order data, using as the end date the last OrderDate in Orders.
 

-- First, get the last OrderDate in Orders. Write a simple select statement to get the highest value in the OrderDate field using the Max aggregate function.
-- Hint
--You should have something like this: Select Max(OrderDate) from Orders
--Now you need to get the date 1 year before the last order date. Create a simple select statement that subtracts 1 year from the last order date
--You can use the DateAdd function for this. Note that within DateAdd, you can use the subquery you created above. Look online for some examples if you need to.
--Hint
--You should have something like this: Select Dateadd(yy, -1, (Select Max(OrderDate) from Orders))
--Now you just need to put it in the where clause.
 
Select  top 3 ShipCountry, AVG(Freight) as AverageFreight
from Orders 
where OrderDate >= Dateadd(yy, -1, (select  max(OrderDate) from Orders)) 
group by ShipCountry 
order by AverageFreight desc 


--29.  Inventory list. We're doing inventory, and need to show information like the below, for all orders. Sort by OrderID and Product ID.
--select * from Employees
--select * from Orders
--select * from OrderDetails
--select * from Products

select Employees.EmployeeID, Employees.LastName, Orders.OrderID, Products.ProductName, OrderDetails.Quantity
from Employees   join Orders on Employees.EmployeeID=Orders.EmployeeID 
join OrderDetails on Orders.OrderID=OrderDetails.OrderID
join Products on OrderDetails.ProductID = Products.ProductID


--30. Customers with no orders. There are some customers who have never actually placed an order. Show these customers.

select Customers_CustomerID = Customers.CustomerID ,Orders_CustomerID = Orders.CustomerID  
from Customers left join orders on Orders.CustomerID=Customers.CustomerID
where Orders.CustomerID   is null

--31. Customers with no orders for EmployeeID 4
--One employee (Margaret Peacock, EmployeeID 4) has placed the most orders. However, there are some customers who've never placed an order with her. Show only those customers who have never placed an order with her.

select Customers_CustomerID = Customers.CustomerID ,Orders_CustomerID = Orders.CustomerID  
from Customers left join orders on Orders.CustomerID=Customers.CustomerID and Orders.EmployeeID=4
where Orders.CustomerID is null
