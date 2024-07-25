--Task 6: Total Sales by Customer
--Write a query to find the total sales amount for each customer, showing only those customers with total sales greater than $1000.
select OrderID,sum(Quantity*UnitPrice) as[total sales] from [Order Details]
group by OrderID
having sum(Quantity*UnitPrice)>1000
order by OrderID

select c.ContactName,c.CustomerID,sum(od.UnitPrice*od.Quantity) TotalSales from Customers c
join Orders o 
on o.CustomerID = c.CustomerID
join [Order Details] od
on od.OrderID = o.OrderID
group by c.ContactName,c.CustomerID
having sum(od.UnitPrice*od.Quantity)>1000

--Task 7: Average Order Quantity by Product
--Write a query to find the average order quantity for each product, 
--showing only those products with an average order quantity greater than 10.
select * from [Order Details]

select ProductId, avg(Quantity) as[order quantity] from [Order Details]
group by ProductID
having avg(Quantity)>10
order by ProductID

--Task 8: Total Sales by Employee
--Write a query to find the total sales amount for each employee, 
--showing only those employees with total sales greater than $5000.
select OrderID,sum(UnitPrice*Quantity) from [Order Details]
group by OrderID
having sum(UnitPrice*Quantity)>5000
order by OrderID


select * from [Order Details]
select EmployeeID,sum(UnitPrice*Quantity) from Orders O 
join [Order Details] OD on OD.OrderID = O.OrderID
group by EmployeeID
having sum(UnitPrice*Quantity)>5000
order by EmployeeID

--Task 9: Average Discount by Product
--Write a query to find the average discount given on each product, 
--showing only those products with an average discount greater than 5%.
select ProductID,avg(Discount) from [Order Details]
group by ProductID
having avg(Discount)>0.05
order by ProductID

--Task 10: Count Orders by Employee
--Write a query to count the number of orders handled by each employee, 
--showing only those employees who have handled more than 50 orders.

select EmployeeID,count(OrderID) as [Order Count] from Orders
group by EmployeeID
having count(OrderID)>50

select e.EmployeeID ,count(o.OrderID) Orders from Employees e
join Orders o
on o.EmployeeID = e.EmployeeID
group by e.EmployeeID
having count(o.OrderID)>50


--Task 11: Monthly Sales by Year
--Write a query to find the total sales amount for each month of each year, 
--showing only those months with total sales greater than $10000.

select * from [Order Details]
select * from Orders

select year(OrderDate) as[year],month(OrderDate) as[month],sum(OD.Quantity*OD.UnitPrice) as[total sales] from Orders O
join [Order Details] OD on OD.OrderID = O.OrderID
group by year(OrderDate),month(OrderDate)
having sum(OD.Quantity*OD.UnitPrice)>10000
order by year(OrderDate), month(orderdate)

--Task 12: Average Order Value by Year
--Write a query to find the average order value for each year, 
--showing only those years with an average order value greater than $500.

select year(OrderDate),avg(OD.UnitPrice*OD.Quantity) from Orders O
join [Order Details] OD on OD.OrderID=O.OrderID
group by year(OrderDate)
having avg(OD.UnitPrice*OD.Quantity)>500
order by year(OrderDate)


--Task 13: Total Quantity Sold by Year
--Write a query to find the total quantity of products sold each year, 
--showing only those years with total quantity sold greater than 1000 units.
select * from [Order Details]
select * from Orders

select year(OrderDate),sum(OD.quantity) from Orders O
join [Order Details] OD on OD.OrderId = O.OrderID
group by year(OrderDate)
having sum(OD.Quantity)>1000


--Task 14: Total Freight by Country
--Write a query to find the total freight charges for each country, 
--showing only those countries with total freight charges greater than $1000.
select ShipCountry,sum(Freight) as[Freight charges] from orders
group by ShipCountry
having sum(Freight) > 1000


--Task 15: Average Freight by Country
--Write a query to find the average freight charges for each country, 
--showing only those countries with an average freight charge greater than $50.
select ShipCountry,avg(Freight) as[freight charges] from Orders
group by ShipCountry
having avg(Freight)>50

--Task 17: Total Sales by Category and Year
--Write a query to find the total sales amount for each product category for each year, 
--showing only those categories with total sales greater than $10000 in any year.
select ProductID, sum(Quantity*UnitPrice) as[Total sales] from [Order Details]
group by ProductID
having sum(Quantity*UnitPrice)>10000
order by ProductID