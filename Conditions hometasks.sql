--Easy: Retrieve all customers whose contact name contains the substring "Maria".
select * from Customers
where ContactName like '%Maria%'

--Medium: Retrieve all employees who are in the 'Sales' or 'Marketing' departments.
select * from Employees
where Title like 'Sales%' or Title like  'Marketing%'

--Medium: Retrieve all orders with a Freight charge between $50 and $200.
select * from Orders
where Freight between 50 and 200
order by Freight

--Hard: Retrieve all employees who were hired between January 1, 1992, and December 31, 1995.
select * from Employees
where HireDate between '1992-01-01' and '1995-12-31'
order by HireDate

--Easy: Retrieve all customers located in 'Berlin' who have postal codes starting with '1'.
select * from Customers
where City = 'Berlin' and PostalCode like '1%'

--Medium: Retrieve all employees who are either in the 'Sales Representative' position or have been hired after January 1, 1995.
select * from Employees
where Title = 'Sales Representative' or HireDate > '1995-01-01'

--Hard: Retrieve all products that have a UnitPrice between $20 and $50 and a UnitsInStock greater than 100.
select * from Products
where UnitPrice between 20 and 50  and UnitsInStock>100
order by UnitPrice

--Hard: Retrieve all suppliers who are either located in 'Tokyo' or whose company name starts with 'Exotic'.
select * from Suppliers
where City = 'Tokyo' or CompanyName like 'Exotic%'

--Hard: Retrieve the top 10 customers who are either from 'London' or 'Paris' and order them by CompanyName in ascending order.
select top 10 * from Customers
where city = 'London' or city = 'Paris'
order by CompanyName asc

--Medium: Retrieve 30% of orders placed in the year 1996.
select top 30 percent * from Orders
where YEAR(OrderDate)='1996'

--Easy: Retrieve all products with NULL values in the ReorderLevel column.
select * from Products
where ReorderLevel is null

--Easy: Retrieve all products with non-NULL values in the UnitsInStock column.
select * from Products
where UnitsInStock is not null

--Medium: Retrieve all products whose names start with 'C'.
select * from Products
where ProductName like 'C%'

--Hard: Retrieve all orders placed between '1996-01-01' and '1996-03-31' that were shipped after '1996-04-15'.
select * from Orders
where OrderDate between '1996-01-01' and '1996-03-31' and  ShippedDate > '1996-04-15'