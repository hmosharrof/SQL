
--Table Name
sp_tables;

--1. Which shippers do we have? We have a table called Shippers. Return all the fields from all the shippers

SELECT * FROM SHIPPERS;

--2. Certain fields from Categories table. We only want to see two columns, CategoryName and Description.

SELECT CategoryName, Description  FROM Categories;

--3. Sales Representatives. We’d like to see just the FirstName, LastName, and HireDate of all the employees with the Title of Sales Representative. Write a SQL statement that returns only those employees.

SELECT FirstName, LastName, HireDate FROM Employees WHERE Title = 'Sales Representative';

--4.Sales Representatives in the United States, Now we’d like to see the same columns as above, but only for those employees that both have the title of Sales Representative, and also are in the United States.

SELECT FirstName, LastName, HireDate FROM Employees WHERE TITLE = 'Sales Representative' AND Country = 'USA'; 

--5. Orders placed by specific EmployeeID, Show all the orders placed by a specific employee. The EmployeeID for this Employee (Steven Buchanan) is 5.

SELECT OrderID, OrderDate FROM Orders WHERE EmployeeID = 5;

--6.Suppliers and ContactTitles. In the Suppliers table, show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not Marketing Manager.

select SupplierID, ContactName, ContactTitle from Suppliers where ContactTitle NOT IN ('Marketing Manager' );

--7.Products with “queso” in ProductName. In the products table, we’d like to see the ProductID and ProductName for those products where the ProductName includes the string “queso”.

select ProductID, ProductName from Products where ProductName Like '%queso%';

--8.Orders shipping to France or Belgium. Looking at the Orders table, there’s a field called ShipCountry. Write a query that shows the OrderID, CustomerID, and ShipCountry for the orders where the ShipCountry is either France or Belgium.

select OrderID, CustomerID, ShipCountry from orders where ShipCountry in ('France', 'Belgium')

--9.Orders shipping to any country in Latin America

select OrderID ,CustomerID ,OrderDate ,ShipCountry from Orders where ShipCountry in ('Brazil', 'Mexico', 'Argentina', 'Venezuela')

--10.Employees, in order of age. For all the employees in the Employees table, show the FirstName, LastName, Title, and BirthDate. Order the results by BirthDate, so we have the oldest employees first.

select FirstName, LastName, Title, BirthDate from Employees order by BirthDate

--11.Showing only the Date with a DateTime field. In the output of the query above, showing the Employees in order of BirthDate, we see the time of the BirthDate field, which we don’t want. Show only the date portion of the BirthDate field.

select FirstName, LastName, Title, convert(date, BirthDate) as DateOnlyBirthDate  from Employees 

--12.Employees full name. Show the FirstName and LastName columns from the Employees table, and then create a new column called FullName, showing FirstName and LastName joined together in one column, with a space in-between.

select FirstName, LastName, CONCAT(FirstName, ' ', LastName) as FullName from Employees

--13.OrderDetails amount per line item. In the OrderDetails table, we have the fields UnitPrice and Quantity. Create a new field, TotalPrice, that multiplies these two together. We’ll ignore the Discount field for now.
--In addition, show the OrderID, ProductID, UnitPrice, and Quantity. Order by OrderID and ProductID.

select OrderID,ProductID, UnitPrice, Quantity, (UnitPrice*Quantity) as TotalPrice from OrderDetails

--14.How many customers do we have in the Customers table? Show one value only, and don’t rely on getting the recordcount at the end of a resultset.

select count(customerid) as TotalCustomers from Customers

--15.When was the first order?

Select MIN(OrderDate) as FirstOrder from Orders

--16.Show a list of countries where the Northwind company has customers.

select distinct Country from Customers order by Country

--17.Contact titles for customers. Show a list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle.

select ContactTitle,count(ContactTitle) TotalContactTitle from Customers group by ContactTitle order by 2 desc

--18.Products with associated supplier names.We’d like to show, for each product, the associated Supplier. Show the ProductID, ProductName, and the CompanyName of the Supplier. Sort by ProductID.

select p.ProductID,p.ProductName,s.CompanyName as Supplier 
from  Products as p join Suppliers as s 
on p.SupplierID=s.SupplierID;

--19.Orders and the Shipper that was used. We’d like to show a list of the Orders that were made, including the Shipper that was used. Show the OrderID, OrderDate (date only), and CompanyName of the Shipper, and sort by OrderID.In order to not show all the orders (there’s more than 800), show only those rows with an OrderID of less than 10300.

select o.OrderID, convert(date, o.OrderDate) as OrderDate, s.CompanyName 
From Orders o join Shippers s
on o.ShipVia=s.ShipperID
where OrderID<10300;