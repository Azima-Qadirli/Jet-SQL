--Retrieve a list of products along with the name of the category they belong to.
select * from Products
select * from Categories

select ProductName,CategoryName from Products p
join Categories c
on p.CategoryID = c.CategoryID

select ProductName ,
(select CategoryName from Categories c
where c.CategoryID = p.CategoryID
)from Products p


--Find orders that include products from the category "Beverages".
select * from [Order Details]
select * from Products
select * from Categories
select * from Orders


select distinct o.OrderID from Orders o
join [Order Details] od
on o.OrderID = od.OrderID
join Products p
on od.ProductID = p.ProductID
join Categories c
on p.CategoryID = c.CategoryID
where CategoryName = 'Beverages'

select OrderID from Orders
where OrderID in (select distinct  OrderID from [Order Details] where ProductID in (select ProductID from Products where CategoryID in (select CategoryID from Categories where CategoryName = 'Beverages')))


--Retrieve categories that have more than 10 products.
select * from products
select * from Categories


select c.CategoryID,c.CategoryName  ,count(p.ProductID ) Categories from Categories c
join Products p 
on c.CategoryID = p.CategoryID
group by c.CategoryID,c.CategoryName
having count(p.ProductID )>10

select c.CategoryID,c.CategoryName from Categories c where c.CategoryID in (select p.CategoryID from Products p
group by p.CategoryID having count(p.ProductID)>10)


--Find the names of products supplied by "Exotic Liquids".
select * from Products
select * from Suppliers



select p.SupplierID,p.ProductID from Products p
join Suppliers s
on p.SupplierID = s.SupplierID
where s.CompanyName ='Exotic Liquids'

select ProductID from Products  where SupplierID in (select SupplierID from Suppliers where CompanyName = 'Exotic Liquids')

--Find orders that include the product "Chai".
select * from [Order Details]
select ProductID from products


select distinct od.OrderID from [Order Details] od
join Products p
on od.ProductID = p.ProductID
where p.ProductName = 'Chai'


select distinct od.OrderID from [Order Details] od where od.ProductID in 
(select p.ProductID from Products p where p.ProductName = 'Chai' )


--List customers who have placed orders handled by employee "Nancy Davolio".
select * from Customers
select * from Employees
select * from Orders

select distinct  c.CustomerID from customers c
join Orders o
on c.CustomerID = o.CustomerID
join Employees e
on o.EmployeeID = e.EmployeeID
where e.FirstName + ' ' + e.LastName = 'Nancy Davolio'

select distinct c.CustomerID from Customers c where c.CustomerID in (select o.CustomerID from Orders o where o.EmployeeID in (select e.EmployeeID from Employees e where e.FirstName+' '+e.LastName = 'Nancy Davolio'))


--Find customers who haven't ordered the product "Chocolade".
select * from Customers
select * from Orders
select * from Products
select * from [Order Details]

select c.CustomerID,c.ContactName from Customers c
where c.CustomerID not in (
select o.CustomerID from Orders o
join [Order Details] od
on o.OrderID = od.OrderID
join Products p
on od.ProductID = p.ProductID
where p.ProductName = 'Chocolade'
)


select  c.CustomerID,c.ContactName from  Customers c where c.CustomerID not in(select o.CustomerID from Orders o where o.OrderID in (select od.OrderID from [Order Details] od where od.ProductID in (select p.ProductID from Products p where p.ProductName ='Chocolade')))


--Retrieve products with a higher unit price than any product in the "Beverages" category.
select * from Products 
select * from Categories

select p.CategoryID,max(p.UnitPrice) OrderPrice from Products p
join Categories c
on p.CategoryID = c.CategoryID
where c.CategoryName = 'Beverages'
group by  p.CategoryID

select p.CategoryID,p.ProductName,p.UnitPrice from Products p where UnitPrice = (select max(p.UnitPrice)from Products p where CategoryID in (select c.CategoryID from Categories c where CategoryName = 'Beverages'))

--Retrieve customers who have placed orders shipped to a specific region, e.g., "Western Europe".
select * from Customers
select * from Orders
--Western Europe olan customer null olduguna gore regiona ID yazdim

select distinct   c.CustomerID from Customers c
join Orders o 
on c.CustomerID=o.CustomerID
where c.Region = 'ID'

select c.CustomerID from Customers c where CustomerID in (select o.CustomerID from Orders o where c.Region ='ID')


--List products that have been ordered in quantities greater than 100.
select * from Products 
select * from [Order Details]


select distinct p.ProductID from Products p
join [Order Details] od
on p.ProductID = od.ProductID
where od.Quantity >100

select p.ProductID from Products p where p.ProductID in (select  od.ProductID from  [Order Details] od where od.Quantity>100)


--Retrieve products with the maximum unit price.
select ProductID,ProductName,UnitPrice from Products 
where UnitPrice in (select max(UnitPrice )from Products)

