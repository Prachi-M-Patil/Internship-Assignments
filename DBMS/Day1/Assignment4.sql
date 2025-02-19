create table TicketBooking(
bookingId int primary key,
customerName varchar(70),
movieName varchar(70),
seatBooked varchar(40),
totalPrice decimal(10,2)
);

INSERT INTO TicketBooking (bookingId, customerName, movieName, seatBooked, totalPrice) VALUES
(1, 'John Doe', 'Inception', 'A1', 300.00),
(2, 'Jane Smith', 'The Matrix', 'B2', 350.00),
(3, 'Alice Johnson', 'Interstellar', 'C3', 400.00),
(4, 'Bob Brown', 'Avatar', 'D4', 450.00),
(5, 'Charlie Davis', 'Titanic', 'E5', 500.00);


BEGIN TRANSACTION;
Begin Transaction before_update;

save transaction before_update;

UPDATE TicketBooking
SET totalPrice = 342.00
WHERE bookingId = 1;

ROLLBACK TRANSACTION before_update;

COMMIT TRANSACTION;

select * from TicketBooking;

-- If the customer cancels, rollback to the savepoint


COMMIT;

