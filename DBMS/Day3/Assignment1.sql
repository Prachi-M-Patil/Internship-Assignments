create table Bookorder (
orderId int Primary key,
custId int,
book_id int,
quantity int not null check(quantity > 0),
order_date Date default getDate(),
foreign key (custId) references BSCustomer(custId),
foreign key (book_id) references BSBooks(book_id)

);

create table BSCustomer(
custId int primary key,
cust_name varchar(50),
email varchar(40),
phone varchar(20)
);

create table BSBooks(
book_id int primary key,
book_name varchar(50) not null,
author varchar(50),
price decimal(10,2) not null,
availableQuantity int not null
);

INSERT INTO BSCustomer (custId, cust_name, email, phone) VALUES
(1, 'John Doe', 'john.doe@example.com', '123-456-7890'),
(2, 'Jane Smith', 'jane.smith@example.com', '234-567-8901'),
(3, 'Alice Johnson', 'alice.johnson@example.com', '345-678-9012'),
(4, 'Bob Brown', 'bob.brown@example.com', '456-789-0123'),
(5, 'Charlie Davis', 'charlie.davis@example.com', '567-890-1234'),
(6, 'Diana Evans', 'diana.evans@example.com', '678-901-2345'),
(7, 'Frank Green', 'frank.green@example.com', '789-012-3456');

INSERT INTO BSBooks (book_id, book_name, author, price, availableQuantity) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 10.99, 50),
(2, '1984', 'George Orwell', 8.99, 30),
(3, 'To Kill a Mockingbird', 'Harper Lee', 12.99, 40),
(4, 'Pride and Prejudice', 'Jane Austen', 9.99, 25),
(5, 'The Catcher in the Rye', 'J.D. Salinger', 11.99, 35),
(6, 'Moby-Dick', 'Herman Melville', 14.99, 20),
(7, 'War and Peace', 'Leo Tolstoy', 19.99, 15);

INSERT INTO Bookorder (orderId, custId, book_id, quantity, order_date) VALUES
(1, 1, 1, 2, '2025-02-20'),
(2, 2, 2, 1, '2025-02-19'),
(3, 3, 3, 3, '2025-02-18'),
(4, 4, 4, 1, '2025-02-17'),
(5, 5, 5, 2, '2025-02-16'),
(6, 6, 6, 1, '2025-02-15'),
(7, 7, 7, 4, '2025-02-14');


INSERT INTO Bookorder (orderId, custId, book_id, quantity, order_date) VALUES
(8, 1, 1, 2, '2025-02-22'),
(9, 2, 2, 1, '2025-02-12'),
(10, 3, 3, 2, '2025-02-14'),
(11, 4, 4, 3, '2025-02-15'),
(15, 5, 5, 2, '2025-02-26');


/* queries */
--1--
select custId, cust_name
from BSCustomer
where custId in (select distinct custId from Bookorder);

--2--
select book_id , book_name
from BSBooks
where book_id not in (select distinct custId from Bookorder);

--3--
select book_id ,  book_name
from BSBooks
where availableQuantity=0;

--4--
select book_id ,  book_name, price
from BSBooks
where price = (select max(price) from BSBooks
				where book_id in (select distinct book_id from Bookorder));



--With Join--
--5--
SELECT c.custId, c.cust_name, c.email, c.phone
FROM BSCustomer c
LEFT JOIN Bookorder o ON c.custId = o.custId
WHERE o.custId IS NULL;


--insert records--
INSERT INTO BSCustomer (custId, cust_name, email, phone) VALUES
(8, 'George White', 'george.white@example.com', '890-123-4567'),
(9, 'Hannah Black', 'hannah.black@example.com', '901-234-5678'),
(10, 'Ivy Blue', 'ivy.blue@example.com', '012-345-6789'),
(11, 'Jack Grey', 'jack.grey@example.com', '123-456-7891'),
(12, 'Karen Red', 'karen.red@example.com', '234-567-8902'),
(13, 'Liam Yellow', 'liam.yellow@example.com', '345-678-9013'),
(14, 'Mia Pink', 'mia.pink@example.com', '456-789-0124');

--6--
SELECT o.orderId, o.custId, o.book_id, o.quantity, o.order_date
FROM Bookorder o
LEFT JOIN BSCustomer c ON o.custId = c.custId
WHERE c.custId IS NULL;

--7--
select c.custId, c.cust_name, sum(b.price * o.quantity) As total_spending
from BSCustomer c
JOIN Bookorder o ON c.custId =  o.custId
JOIN BSBooks b ON o.book_id = b.book_id
GROUP BY c.custId, c.cust_name;

--8--
SELECT TOP 1 c.custId, c.cust_name, cs.total_spending
FROM BSCustomer c
INNER JOIN (
    SELECT o.custId, SUM(b.price * o.quantity) AS total_spending
    FROM Bookorder o
    INNER JOIN BSBooks b ON o.book_id = b.book_id
    GROUP BY o.custId
) cs ON c.custId = cs.custId
ORDER BY cs.total_spending DESC;

--9--
Select c.custId, c.cust_name, max(o.order_date) as Latest_order_date
from BSCustomer c inner join Bookorder o ON c.custId = o.custId
group by c.custId , c.cust_name;









