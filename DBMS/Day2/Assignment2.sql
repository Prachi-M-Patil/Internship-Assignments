CREATE TABLE EmployeeTbl (
    empId INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 18),
    salary DECIMAL(10,2),
    departmentId INT,
    CONSTRAINT Fk_department FOREIGN KEY (departmentId) REFERENCES Departments(departmentId)
);


create table Departments(
departmentId int primary key,
departmentName varchar(50) not null
); 

INSERT INTO Departments (departmentId, departmentName) VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'Engineering'),
(4, 'Marketing');


INSERT INTO EmployeeTbl (empId, name, age, salary, departmentId) VALUES
(1, 'John Doe', 30, 50000.00, 1),
(2, 'Jane Smith', 25, 60000.00, 2),
(3, 'Alice Johnson', 28, 70000.00, 3),
(4, 'Bob Brown', 35, 55000.00, 4),
(5, 'Charlie Davis', 22, 45000.00, 1),
(6, 'Diana Prince', 27, 65000.00, 3),
(7, 'Evan Green', 32, 52000.00, 2);

select * from EmployeeTbl;

UPDATE EmployeeTbl
SET departmentId = 3
WHERE empId = 1;



create table Department1(
departmentName varchar(50) not null,
rating int
); 
ALTER TABLE Department1
ADD departmentId INT IDENTITY(1,1);

ALTER TABLE Department1
ADD CONSTRAINT PK_department PRIMARY KEY (departmentId);

alter table EmployeeTbl
drop column departmentId;

ALTER TABLE EmployeeTbl
ADD departmentName VARCHAR(50);

CREATE TABLE EmployeeTbl1 (
    empId INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 18),
    salary DECIMAL(10,2),
    departmentId INT,
);


ALTER TABLE EmployeeTbl1
ADD CONSTRAINT FK_DeptId
FOREIGN KEY (departmentId) REFERENCES Departments(departmentId);


