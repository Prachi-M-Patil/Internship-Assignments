create table EmpTablerecords(
empId int primary key,
emp_Name varchar(2),
email varchar unique,
department varchar,
salary decimal(10,2),
joiningDate Date
);

INSERT INTO EmpTablerecords (empId, emp_Name, email, department, salary, joiningDate) VALUES
(1, 'AB', 'ab@ex.com', 'HR', 50000.00, '2023-01-15'),
(2, 'CD', 'cd@example.com', 'Finance', 60000.00, '2023-02-20'),
(3, 'EF', 'ef@example.com', 'IT', 70000.00, '2023-03-25');


SELECT * FROM EmpTablerecords;

ALTER TABLE EmpTablerecords
ALTER COLUMN emp_name varchar(100);
