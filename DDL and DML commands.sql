
--1)SQL CRUD Operations Homework

--Objective:
--The objective of this homework is to practice SQL CRUD operations. CRUD stands for Create, Read, Update, and Delete, which are the four basic functions of persistent storage. In this homework, you will perform these operations on a database table.

--Database Schema:
--Consider a simple database with a table named students having the following schema:


--CREATE TABLE students (
--    id 
--    name 
--    age 
--    gender 
--    grade
--);
--Tasks:
--Perform the following CRUD operations on the students table:

--Create Operations:
--Insert a new student record with the following details:
--Name: John Doe
--Age: 20
--Gender: Male
--Grade: A

--Read Operations:
--Retrieve all the records from the students table.

--Update Operations:
--Update the record for the student with id = 1 and change the grade to "B".

--Delete Operations:
--Delete the record for the student with id = 2.
use C#06

Create table student(
id int,
[name] nvarchar(20),
age int,
gender char(6),
grade char(1)
)

Insert into student([name],age,gender,grade)
Values('John Doe',20,'Male','A')

select * from student

update student
set id = 1 , grade = 'B'

select * from student

delete from student
where id = 2


--2) Creating Sample Tables:(Foreign keylerden ve joinlerden istifade etmeden!!!)
--Create two sample tables named Employees and Departments with the following columns:
--Employees: EmployeeID, FirstName, LastName, DepartmentID
--Departments: DepartmentID, DepartmentName
--Inserting Sample Data:
--Insert some sample data into the Employees and Departments tables.
--Performing Joins:
--Write SQL queries for the following scenarios using appropriate joins:
--Task 4.1: Retrieve the list of all employees along with their department names.
--Task 4.2: Retrieve the list of all departments along with the count of employees in each department.

use C#06

create table Employees(
EmployeeID int,
FirstName nvarchar(20),
LastName nvarchar(20),
DepartmentID int
)

create table Departments(
DepartmentID int,
DepartmentName nvarchar(20)
)

Insert into Employees(EmployeeID,FirstName,LastName,DepartmentID)
Values(1,'Nijat','Soltanov',123),(2,'Azima','Qadirli',456),(3,'Yusif','Pirquliyev',789)

select * from Employees

Insert into Departments(DepartmentID,DepartmentName)
Values(123,'JetA'),(456,'JetB'),(789,'JetC')



select * from Departments

select e.FirstName+ ' ' + e.LastName as FullName,d.DepartmentName 
from Employees e
join Departments d
on e.DepartmentID = d.DepartmentID

  Select * , (Select DepartmentName from Departments d
where e.DepartmentID = d.DepartmentID )
from Employees e   --it has to be written as subquery,because joins are not appropriate way to solve this task due to relations of tables



select d.DepartmentName,count(e.EmployeeID)  as CountOfEmployees
from Departments d
left join Employees e
on d.DepartmentID = e.DepartmentID
group by d.DepartmentName



--3) Create a table for storing information about books in a library. Include columns for BookID, Title, Author, PublishedYear, and Genre.

--Alter the table created in task 1 to add a column for ISBN number.

--Drop the Genre column from the table created in task 1.

--Truncate the table to remove all records but keep the structure.


use C#06

create table Book(
BookID int,
Title nvarchar(20),
Author nvarchar(50),
PublishedYear datetime2,
Genre nvarchar(10)
)

INSERT INTO Book (BookID, Title, Author, PublishedYear, Genre)
VALUES (1, 'The Great Gatsby', 'F. Scott Fitzgerald', '1925-04-10', 'Fiction')



Alter table Book 
add ISBN int

select * from Book

alter table Book
drop column Genre

alter table Book 
add Genre nvarchar(10)

Truncate table Book
