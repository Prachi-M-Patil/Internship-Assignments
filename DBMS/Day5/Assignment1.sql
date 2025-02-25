--Day 5 Assignment--
--Prachi Patil 
-- Customer Table
CREATE TABLE CustomerTbl (
    ID INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(20),
    address VARCHAR(255)
);

-- Rooms Table
CREATE TABLE RoomsTbl (
    Room_ID INT PRIMARY KEY,
    room_type VARCHAR(40),
    pricePerNight VARCHAR(255),
	status varchar(40)
);
-- Bookings Table
CREATE TABLE BookingsTbl (
    Booking_ID INT PRIMARY KEY,
    customer_id INT,
    Room_ID INT,
    checkIn_Date DATE,
    checkOut_Date DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES CustomerTbl(ID),
    FOREIGN KEY (Room_ID) REFERENCES RoomsTbl(Room_ID)
);

-- Payments Table
CREATE TABLE PaymentsTbl (
    Payment_ID INT PRIMARY KEY,
    booking_id INT,
    payment_date DATE,
    pay_method VARCHAR(255),
    amount DECIMAL(10, 2),
    FOREIGN KEY (booking_id) REFERENCES BookingsTbl(Booking_ID)
);

-- Services Table
CREATE TABLE ServicesTbl (
    Service_ID INT PRIMARY KEY,
    serviceName VARCHAR(255),
    price DECIMAL(10, 2),

);

-- Employees Table
CREATE TABLE EmployeesTbl (
    Employee_ID INT PRIMARY KEY,
    emp_name VARCHAR(255),
    position VARCHAR(255),
    salary DECIMAL(10, 2),
    HireDate DATE,
    ManagerId INT,
	FOREIGN KEY (ManagerId) REFERENCES EmployeesTbl(Employee_ID)

);


-- Hotel_Branch Table
CREATE TABLE Hotel_Branch (
    Branch_ID INT PRIMARY KEY,
    branch_Name VARCHAR(255),
    Location VARCHAR(255)
);

-- Service_Requests Table
CREATE TABLE Service_Requests_Tbl (
    request_ID INT PRIMARY KEY,
    booking_id INT,
    service_id INT,
    req_date DATE,
    quantity INT,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (booking_id) REFERENCES BookingsTbl(Booking_ID),
    FOREIGN KEY (service_id) REFERENCES ServicesTbl(Service_ID)
);


-- Insert data into CustomerTbl
INSERT INTO CustomerTbl (ID, name, email, phone, address) VALUES
(1, 'John Doe', 'john.doe@example.com', '1234567890', '123 Main St'),
(2, 'Jane Smith', 'jane.smith@example.com', '0987654321', '456 Elm St'),
(3, 'Alice Johnson', 'alice.johnson@example.com', '5555555555', '789 Oak St'),
(4, 'Bob Brown', 'bob.brown@example.com', '4444444444', '101 Pine St'),
(5, 'Carol White', 'carol.white@example.com', '3333333333', '202 Maple St');

-- Insert data into RoomsTbl
INSERT INTO RoomsTbl (Room_ID, room_type, pricePerNight, status) VALUES
(1, 'Single', '100.00', 'Available'),
(2, 'Double', '150.00', 'Occupied'),
(3, 'Suite', '300.00', 'Available'),
(4, 'Single', '100.00', 'Occupied'),
(5, 'Double', '150.00', 'Available');

-- Insert data into BookingsTbl
INSERT INTO BookingsTbl (Booking_ID, customer_id, Room_ID, checkIn_Date, checkOut_Date, TotalAmount) VALUES
(1, 1, 2, '2025-02-20', '2025-02-25', 750.00),
(2, 2, 4, '2025-02-18', '2025-02-22', 400.00),
(3, 3, 1, '2025-02-21', '2025-02-23', 200.00),
(4, 4, 3, '2025-02-19', '2025-02-24', 1500.00),
(5, 5, 5, '2025-02-20', '2025-02-26', 900.00);

-- Insert data into PaymentsTbl
INSERT INTO PaymentsTbl (Payment_ID, booking_id, payment_date, pay_method, amount) VALUES
(1, 1, '2025-02-20', 'Credit Card', 750.00),
(2, 2, '2025-02-18', 'Debit Card', 400.00),
(3, 3, '2025-02-21', 'Cash', 200.00),
(4, 4, '2025-02-19', 'Credit Card', 1500.00),
(5, 5, '2025-02-20', 'Debit Card', 900.00);

-- Insert data into ServicesTbl
INSERT INTO ServicesTbl (Service_ID, serviceName, price) VALUES
(1, 'Room Cleaning', 50.00),
(2, 'Laundry', 30.00),
(3, 'Spa', 100.00),
(4, 'Gym', 20.00),
(5, 'Breakfast', 15.00);

-- Insert data into EmployeesTbl
INSERT INTO EmployeesTbl (Employee_ID, emp_name, position, salary, HireDate, ManagerId) VALUES
(1, 'Michael Scott', 'Manager', 50000.00, '2020-01-15', NULL),
(2, 'Dwight Schrute', 'Assistant Manager', 40000.00, '2020-02-20', 1),
(3, 'Jim Halpert', 'Sales', 35000.00, '2020-03-25', 1),
(4, 'Pam Beesly', 'Receptionist', 30000.00, '2020-04-30', 1),
(5, 'Stanley Hudson', 'Sales', 35000.00, '2020-05-10', 1);

-- Insert data into Hotel_Branch
INSERT INTO Hotel_Branch (Branch_ID, branch_Name, Location) VALUES
(1, 'Downtown', '123 Main St'),
(2, 'Uptown', '456 Elm St'),
(3, 'Suburb', '789 Oak St'),
(4, 'Airport', '101 Pine St'),
(5, 'Beachside', '202 Maple St');

-- Insert data into Service_Requests_Tbl
INSERT INTO Service_Requests_Tbl (request_ID, booking_id, service_id, req_date, quantity, total_price) VALUES
(1, 1, 1, '2025-02-21', 1, 50.00),
(2, 2, 2, '2025-02-19', 2, 60.00),
(3, 3, 3, '2025-02-22', 1, 100.00),
(4, 4, 4, '2025-02-20', 3, 60.00),
(5, 5, 5, '2025-02-23', 2, 30.00);


--3) Queries--
SELECT 
    c.name AS customer_name,
    r.room_type,
    b.checkIn_Date,
    b.TotalAmount
FROM 
    CustomerTbl c
JOIN 
    BookingsTbl b ON c.ID = b.customer_id
JOIN 
    RoomsTbl r ON b.Room_ID = r.Room_ID;

--3.2 get a list of employees along with their manager--
SELECT 
    e1.emp_name AS Employee,
    e2.emp_name AS Manager
FROM 
    EmployeesTbl e1
LEFT JOIN 
    EmployeesTbl e2 ON e1.ManagerId = e2.Employee_ID;


-- Insert data into RoomsTbl
INSERT INTO RoomsTbl (Room_ID, room_type, pricePerNight, status) VALUES
(6, 'Single', '100.00', 'Available'),
(7, 'Double', '150.00', 'Available'),
(8, 'Suite', '300.00', 'Available');

-- Insert data into BookingsTbl (excluding Room_IDs 6, 7, and 8)
INSERT INTO BookingsTbl (Booking_ID, customer_id, Room_ID, checkIn_Date, checkOut_Date, TotalAmount) VALUES
(6, 1, 1, '2025-02-20', '2025-02-25', 500.00),
(7, 2, 2, '2025-02-18', '2025-02-22', 600.00),
(8, 3, 3, '2025-02-21', '2025-02-23', 700.00);

--3.3--
SELECT 
    r.Room_ID,
    r.room_type,
    r.pricePerNight,
    r.status
FROM 
    RoomsTbl r
LEFT JOIN 
    BookingsTbl b ON r.Room_ID = b.Room_ID
WHERE 
    b.Booking_ID IS NULL;



--4 views--

CREATE VIEW active_bookings AS
SELECT 
    c.name AS customerName,
    r.room_type AS roomType,
    b.checkIn_Date AS checkinDate,
    b.checkOut_Date AS checkoutDate
FROM 
    CustomerTbl c
JOIN 
    BookingsTbl b ON c.ID = b.customer_id
JOIN 
    RoomsTbl r ON b.Room_ID = r.Room_ID
WHERE 
    getDate() BETWEEN b.checkIn_Date AND b.checkOut_Date;



--5 indexing--
--create an index on roomType in the Rooms table to optimize room searches
CREATE INDEX idx_room_type ON RoomsTbl(room_type);

--5.2--
--create a composite index on checkinDate and checkOutDate in the bookings table
CREATE INDEX idx_checkin_checkout_dates ON BookingsTbl(checkIn_Date, checkOut_Date);

--6 stored procedure--
--create a stored procedure to get total revenue generated in a given month
Go
create procedure getMonthlyRevenue
	@year int,
	@month int
As
Begin
	Select
		SUM(TotalAmount) as TotalRevenue
	From BookingsTbl
	Where YEAR(checkIn_Date) = @Year AND MONTH(checkIn_Date) = @Month
	or 
	YEAR(checkOut_Date) = @Year AND MONTH(checkOut_Date) = @Month;
END;

Select * from BookingsTbl

--execution--
EXEC GetMonthlyRevenue @Year = 2025, @Month = 2;

--write a user-defined function to calculate the total number of days a customer stayed
Go
CREATE FUNCTION fn_CalculateTotalNoOfDays (@customerId INT)
RETURNS int
AS
BEGIN
    DECLARE @TotalDays int;

    SELECT @TotalDays = sum(dateDiff(day, checkIn_Date, checkOut_Date))
	from bookingsTbl
	where customer_id = @customerId;
	return @TotalDays;
END;

SELECT dbo.fn_CalculateTotalNoOfDays(1) AS TotalStayDays;


--7 Triggers--
--implement a trigger to automatically update the rooms table status to 'Available' when a booking is canceled
Go
CREATE TRIGGER trg_UpdateRoomStatusOnCancellation
ON BookingsTbl
AFTER DELETE
AS
BEGIN
    UPDATE RoomsTbl
    SET status = 'Available'
    WHERE Room_ID = (SELECT deleted.Room_ID FROM deleted);
END;

DELETE FROM Service_Requests_Tbl
WHERE booking_id IN (SELECT Booking_ID FROM BookingsTbl WHERE Room_ID = 5);

DELETE FROM PaymentsTbl
WHERE booking_id IN (SELECT Booking_ID FROM BookingsTbl WHERE Room_ID = 5);

DELETE FROM BookingsTbl
WHERE Room_ID = 5;


select * from BookingsTbl

   
--8 Security and privileges
--create a user role hotel manager with access to all bookings and payment details
create role hotelManager;
Grant Select, Insert, Update, Delete on BookingsTbl To hotelManager;
Grant Select, Insert, Update, Delete on PaymentsTbl To hotelManager;

create role FrontDeskStaff;
Grant Select on Rooms To FrontDeskStaff;

--9 Backup and Restore--
Backup Database JIBE_Main_Training
to Disk = 'C:\Backup\j2Db_Backup.bak'
with format, init;

--9.2 restore
restore database JIBE_Main_Training
From Disk = 'C:\Backup\j2Db_Backup.bak'
With Replace;


--10. full text search--
--enable full text search
exec sp_fulltext_database 'enable';

create fulltext catalog RoomCatalog As Default;

CREATE UNIQUE INDEX idx_room_id ON RoomsTbl(Room_ID);

CREATE FULLTEXT INDEX ON RoomsTbl(room_type)
KEY INDEX idx_room_id;

select * from RoomsTbl;

--implement search
SELECT Room_ID, room_type, pricePerNight, status
FROM RoomsTbl
WHERE CONTAINS(room_type, ' Dou');
