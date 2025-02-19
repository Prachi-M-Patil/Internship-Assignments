create table patientsrecord(
patientId int primary key,
patient_name varchar(60),
age int,
disease varchar(40),
doctorAssigned varchar(50)
);

INSERT INTO patientsrecord (patientId, patient_name, age, disease, doctorAssigned) VALUES
(1, 'John Doe', 45, 'Hypertension', 'Dr. Smith'),
(2, 'Jane Smith', 30, 'Diabetes', 'Dr. Johnson'),
(3, 'Alice Johnson', 25, 'Asthma', 'Dr. Brown'),
(4, 'Bob Brown', 50, 'Arthritis', 'Dr. Davis'),
(5, 'Charlie Davis', 35, 'Migraine', 'Dr. Wilson'),
(6, 'Diana Evans', 40, 'Heart Disease', 'Dr. Taylor'),
(7, 'Eve Foster', 28, 'Allergies', 'Dr. Anderson'),
(8, 'Frank Green', 60, 'Chronic Pain', 'Dr. Thomas'),
(9, 'Grace Harris', 55, 'Cancer', 'Dr. Martinez'),
(10, 'Henry Irving', 65, 'Alzheimer\s', 'Dr. Lee');

INSERT INTO patientsrecord (patientId, patient_name, age, disease, doctorAssigned) VALUES
(11, 'Grace', 45, 'Hypertension', 'Dr. Smith');

select * from patientsrecord;

select patient_name from patientsrecord
where age > 60;

select patient_name from patientsrecord
where doctorAssigned = 'Dr. Smith';

select disease, COUNT(*) AS patient_count
from patientsrecord
group by disease;
