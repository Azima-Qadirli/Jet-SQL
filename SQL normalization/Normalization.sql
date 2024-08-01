--1)Aşağıdakı sturukturda db qurursunuz:
--Students (Id, Fullame,Point,GroupId)
--Groups (Id,No)
--Exams (Id,SubjectName,StartDate,EndDate)
--StudentExams(StudentId,ExamId,ResultPoint)


--SQL-də DDL commandları vasitərsiylə dbsturukturunu qurub DML commandları vasitəsi ilə datalar insert edin.Daha sonra isə aşağıdakı select querylərini yazın

--- Bütün student dataları görsənir və hər bir student datasının yaninda oxuduğu qrupun No dəyəri görsənir
--- Bütün Student dataları görsənir və hər bir studentin yanında o studentin examlərinin sayı görsənir
--- Heç bir exam-i olmayan subject datalarını select edən query
--- Dünən baş vermiş bütün examləri select edən query və hər bir exam datasının yanında studentlərinin sayı və subjectinin adı görsənsin
--- Bütün studentExam dataları select edən query və hər bir studentExam datasının yanında onun studentinin fullname dəyəri və o studentin qrup nömrəsi görsənir
--- Bütün studentləri select edən query və hər bir studentin yanında onun bütün imtahanlarının ortalama result dəyəri görsənir


Create table Groups(
GroupId int primary key not null,
[No] int 
)




create table Students(
Id int Primary key identity,
Fullname nvarchar(100),
Point int,
GroupId int foreign key references Groups(GroupId) not null
)

create table Exams(
Id int primary key identity,
SubjectName nvarchar(100),
StartDate datetime2,
EndDate datetime2
)

create table StudentExams(
StudentId int foreign key references Students(Id),
ExamId int foreign key references Exams(Id),
ResultPoint int 
)

INSERT INTO Groups (GroupId,No) VALUES (1,135), (2,140), (3,250);

select * from Groups


insert into Students (Fullname,Point,GroupId)
Values('Nijat Soltanov',95,1),('Azima Qadirli',90,2),('Yusif Pirquliyev',100,3),('Isa Sadigov',80,1),('Leyla Heydarova',75,2)
select * from Students


insert into Exams(SubjectName,StartDate,EndDate)
Values('Math', '2024-07-31', '2024-07-31'),('English', '2024-07-30', '2024-07-30'),('Science', '2024-08-01', '2024-08-01'),('History','2024-08-05','2024-08-05')

select * from Exams

insert into StudentExams(StudentId,ExamId,ResultPoint)
Values(1, 1, 95),(1, 2, 89),(2, 1, 78),(2, 3, 82),(3, 2, 91),(3, 3, 85),(4, 1, 90),(5,2,95)
select * from StudentExams



--Query1--Bütün student dataları görsənir və hər bir student datasının yaninda oxuduğu qrupun No dəyəri görsənir

select s.Id,s.Fullname,s.Point,s.GroupId,g.No from Students s
join Groups g
on g.GroupId = s.GroupId


--Query2--Bütün Student dataları görsənir və hər bir studentin yanında o studentin examlərinin sayı görsənir

select s.Id,s.Fullname,s.Point,count(se.ExamId) [NumberOfExams]  from Students s
left join StudentExams se
on se.StudentId = s.Id
group by s.Id,s.Fullname,s.Point


--Query3--Heç bir exam-i olmayan subject datalarını select edən query
select e.Id,e.SubjectName from Exams e
join StudentExams se
on se.ExamId = e.Id
where se.ExamId is  null
--where se.ExamId is not null


--Query4--Dünən baş vermiş bütün examləri select edən query və hər bir exam datasının yanında studentlərinin sayı və subjectinin adı görsənsin
select e.Id,e.SubjectName,count(se.StudentId) [Yesterday's Exam] from Exams e
left join  StudentExams se
on se.ExamId = e.Id
where e.StartDate = CONVERT(date,DATEADD(day,-1,GetDate()))
group by e.Id,e.SubjectName


--Query5--Bütün studentExam dataları select edən query və hər bir studentExam datasının yanında onun studentinin fullname dəyəri və o studentin qrup nömrəsi görsənir

select * from StudentExams se
 join Students s
on se.StudentId = s.Id

--Query6--Bütün studentləri select edən query və hər bir studentin yanında onun bütün imtahanlarının ortalama result dəyəri görsənir
select s.Id,s.Fullname,avg(se.ResultPoint) [AverageOfResult] from Students s
join StudentExams se
on s.Id = se.StudentId
group by s.Id,s.Fullname




--2) Creating Sample Tables:
--Create two sample tables named Employees and Departments with the following columns:
--Employees: EmployeeID, FirstName, LastName, DepartmentID
--Departments: DepartmentID, DepartmentName
--Inserting Sample Data:
--Insert some sample data into the Employees and Departments tables.
--Performing Joins:
--Write SQL queries for the following scenarios using appropriate joins:
--Task 2.1: Retrieve the list of all employees along with their department names.
--Task 2.2: Retrieve the list of all departments along with the count of employees in each department.

create table Departments(
DepartmentID int primary key not null,
DepartmentName nvarchar(100)
)

create table Employees(
EmployeeId int primary key not null,
FirstName nvarchar(100),
LastName nvarchar(100),
DepartmentID int foreign key references Departments(DepartmentId)
)

Insert into Departments(DepartmentID,DepartmentName)
Values(1,'IT'),(2,'Marketing '),(3,'Financial'),(4,'Human Resources')

select * from Departments

Insert into  Employees(EmployeeId,FirstName,LastName,DepartmentID)
Values(1,'Nijat','Soltanov',1),(2,'Azima','Qadirli',1),(3,'Yusif','Pirquliyev',2),(4,'Isa','Sadigov',3),(5,'Leyla','Heydarova',4)

select * from Employees


--Task 2.1: Retrieve the list of all employees along with their department names.
select e.FirstName+' '+e.LastName [FullName],d.DepartmentName from Employees e
join Departments d
on e.DepartmentID = d.DepartmentId


--Task 2.2: Retrieve the list of all departments along with the count of employees in each department.

select d.DepartmentId,d.DepartmentName ,count(e.EmployeeId) [CountOfEmployees] from Departments d
join Employees e
on d.DepartmentId = e.DepartmentID
group by d.DepartmentId,d.DepartmentName