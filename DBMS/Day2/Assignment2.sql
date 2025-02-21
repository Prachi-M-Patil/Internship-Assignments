create table TblEmployees_2(
empId int primary key identity(1,1),
emp_Name varchar(40) not null,
email varchar(40) unique,
departmentId int,
ManagerId int,
hireDate Date not null,
salary int,
foreign key (departmentId) references TblDepartment_1(departmentId),
foreign key (ManagerId) references TblEmployees_2(empId)
);


create table TblDepartment_1(
departmentId int primary key,
DepartmentName varchar(50)
);

create table TblSalary_2(
empId int,
baseSalary decimal(10,2),
bonus decimal(10,2),
foreign key (empId) references TblEmployees_2(empId)
);

INSERT INTO TblDepartment_1 (departmentId, DepartmentName) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing'),
(5, 'Sales'),
(6, 'Operations'),
(7, 'R&D');

INSERT INTO TblEmployees_2 (emp_Name, email, departmentId, ManagerId, hireDate, salary) VALUES
('John Doe', 'john.doe@example.com', 1, NULL, '2020-01-15', 50000),
('Jane Smith', 'jane.smith@example.com', 2, 1, '2019-03-22', 60000),
('Alice Johnson', 'alice.johnson@example.com', 3, 1, '2021-05-10', 55000),
('Bob Brown', 'bob.brown@example.com', 4, 2, '2018-07-18', 70000),
('Charlie Davis', 'charlie.davis@example.com', 5, 2, '2022-09-25', 45000),
('Diana Evans', 'diana.evans@example.com', 6, 3, '2020-11-30', 65000),
('Frank Green', 'frank.green@example.com', 7, 3, '2021-02-14', 48000);

INSERT INTO TblSalary_2 (empId, baseSalary, bonus) VALUES
(1, 50000, 5000),
(2, 60000, 6000),
(3, 55000, 5500),
(4, 70000, 7000),
(5, 45000, 4500),
(6, 65000, 6500),
(7, 48000, 4800);

--task1--
select e.emp_Name, d.DepartmentName, e.hireDate
from TblEmployees_2 e inner join TblDepartment_1 d On e.empId = d.departmentId;

--task2--
select e.empId, e.emp_Name
from TblEmployees_2 e
LEFT JOIN TblEmployees_2 m ON e.ManagerId = m.empId
where m.empId IS NULL;

--task3--
select d.departmentId, d.DepartmentName
from TblDepartment_1 d left join TblEmployees_2 e On d.departmentId = e.departmentId
WHERE e.empId IS NULL;

INSERT INTO TblDepartment_1 (departmentId, DepartmentName) VALUES
(8, 'Legal'),
(9, 'Customer Support');

INSERT INTO TblEmployees_2 (emp_Name, email, departmentId, ManagerId, hireDate, salary) VALUES
('George Harris', 'george.harris@example.com', 1, 1, '2023-01-10', 52000),
('Helen King', 'helen.king@example.com', 2, 2, '2023-02-15', 58000),
('Ian Lewis', 'ian.lewis@example.com', 3, 3, '2023-03-20', 54000);

--task4--
select e.empId , e.emp_Name, (e.salary + s.bonus) as total_salary 
from TblEmployees_2 e JOIN TblSalary_2 s On e.empId = s.empId;

--task5--
select Top 1 e.empId , e.emp_Name, (e.salary + s.bonus) as total_salary 
from TblEmployees_2 e JOIN TblSalary_2 s On e.empId = s.empId
order by total_salary desc;

--task6--
select e.empId , e.emp_Name 
from TblEmployees_2 e LEFT JOIN TblEmployees_2 m on e.ManagerId = m.empId
where e.salary > m.salary;

--task7--
CREATE VIEW HR_EmployeeSalaryView AS
SELECT 
    e.empId,
    e.emp_Name,
    d.DepartmentName,
    s.baseSalary,
    s.bonus,
    (s.baseSalary + s.bonus) AS totalSalary
FROM 
    TblEmployees_2 e
JOIN 
    TblSalary_2 s ON e.empId = s.empId
JOIN 
    TblDepartment_1 d ON e.departmentId = d.departmentId;

--task 8-- 
SELECT empId, emp_Name, hireDate
FROM TblEmployees_2
WHERE DATEDIFF(YEAR, hireDate, GETDATE()) > 3;

--task 9--
SELECT d.DepartmentName, COUNT(e.empId) AS NumberOfEmployees
FROM TblDepartment_1 d
LEFT JOIN TblEmployees_2 e ON d.departmentId = e.departmentId
GROUP BY d.DepartmentName;

