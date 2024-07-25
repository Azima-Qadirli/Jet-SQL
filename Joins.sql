--15. List the names of customers who have ordered products from the 'Beverages' category
select distinct c.CustomerID,c.ContactName from customers c --burda distinct yaza bilerikki unique olan customerleri cixarsin
inner join Orders o 
on o.CustomerID = c.CustomerID
inner join [Order Details] OD
on OD.OrderID = o.OrderID
inner join Products p
on p.ProductID = od.ProductID
inner join Categories cat
on cat.CategoryID = p.CategoryID
where CategoryName = 'Beverages'

select * from Customers 
select * from Categories
select * from Products
select * from Orders
select * from [Order Details]

--16. List the names of employees and the number of orders they have handled
select * from Employees
select * from Orders

select e.EmployeeID,count(o.OrderID) Orders from Employees e
inner join Orders o
on o.EmployeeID = e.EmployeeID
group by e.EmployeeID
order by count(o.OrderID)

--17. Find the average discount given on orders
select * from Orders
select * from [Order Details]

select o.OrderID,avg(OD.Discount) Discount from orders o
inner join [Order Details] OD
on o.OrderID = OD.OrderID
group by o.OrderID
order by avg(OD.Discount)

--18. List all suppliers located in a specific country (e.g., 'USA')
select s.SupplierID,s.ContactName from Suppliers s
join Suppliers Sup
on s.SupplierID = Sup.SupplierID
where S.Country = 'USA'

--19. Retrieve the top 5 customers who have placed the highest number of orders
select top 5 c.CustomerID ,c.ContactName from  Customers c
join Orders o
on c.CustomerID = o.CustomerID
group by c.ContactName,c.CustomerID
order by count(o.OrderID)desc


--20. Task: Retrieve Sales Information for Each Product
--Objective: Write a query to retrieve a list of products along with the total quantity sold and the total sales amount for each product. 
--Sort the results by the total sales amount in descending order.
select p.ProductID,p.ProductName,sum(od.Quantity) TotalSold,sum(od.Quantity*od.UnitPrice) TotalSales from Products p
join [Order Details] od
on p.ProductID = od.ProductID
group by p.ProductID,p.ProductName
order by sum(od.UnitPrice*od.Quantity) desc

--21. Task: Retrieve Basic Customer Order Information
--Objective: Write a query to retrieve a list of all customers and their most recent order details, including the customer name, order ID, order date, 
--and total order amount. 
--Sort the results by customer name.
select o.OrderID,o.OrderDate,c.CustomerID,sum(od.Quantity*od.UnitPrice)TotalOrder from Orders o
inner join Customers c
on c.CustomerID=o.CustomerID
left join [Order Details] od
on od.OrderID=o.OrderID
where 
    o.OrderDate = (
        select max(OrderDate)
        from Orders
        where CustomerID = c.CustomerID
)
group by o.OrderID,o.OrderDate,c.ContactName,c.CustomerID

--22. Task: Retrieve Supplier and Product Order Information
--Objective: Write a query to retrieve a list of suppliers and their products, along with the total number of orders and total sales amount for each product. 
--Sort the results by supplier name and then by total sales amount in descending order.
select * from Suppliers
select * from Products
select * from Orders
select * from [Order Details]

select s.ContactName,p.ProductName,count(od.OrderID)TotalOrderNumber,sum(od.Quantity*od.UnitPrice)TotalSales from Suppliers s
inner join Products p
on s.SupplierID = p.SupplierID
left join [Order Details] od
on od.ProductID = p.ProductID
group by s.ContactName,p.ProductName
order by s.ContactName , sum(od.Quantity*od.UnitPrice) desc