--Easy: Retrieve the first 5 products from the Products table.
SELECT TOP 5 * FROM Products;

--Easy: Retrieve all products ordered by ProductName in ascending order.
SELECT * FROM Products
Order by ProductName asc;

--Easy: Retrieve the top 10% of products with the highest UnitPrice.
Select Top 10 Percent * From Products
Order By UnitPrice desc;

--Medium: Retrieve all orders ordered by OrderDate in descending order.
SELECT * FROM Orders
ORDER BY OrderDate DESC;

--Medium: Retrieve the bottom 20% of products with the lowest UnitsInStock.
Select Top 20 Percent * From Products
Order by UnitsInStock asc;

--Medium: Retrieve the top 10 most expensive products.
Select Top 10 * from Products
Order by UnitPrice Desc;


--Medium: List the top 10 orders with the highest freight charges
Select Top 10 * From Orders
Order By Freight desc;