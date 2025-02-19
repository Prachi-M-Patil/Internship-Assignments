
--DML--

Create table MyOrders(
orderId int Primary key,
cust_name varchar(60),
product_name varchar(60),
quantity int,
price decimal(10,2),
order_date Date

);

INSERT INTO MyOrders (orderId, cust_name, product_name, quantity, price, order_date) VALUES
(1, 'John Doe', 'Laptop', 1, 75000.00, '2023-01-15'),
(2, 'Jane Smith', 'Smartphone', 2, 50000.00, '2023-01-20'),
(3, 'Alice Johnson', 'Headphones', 3, 4500.00, '2023-02-05'),
(4, 'Bob Brown', 'Monitor', 1, 15000.00, '2023-02-10'),
(5, 'Charlie Davis', 'Keyboard', 5, 2500.00, '2023-02-15'),
(6, 'Diana Evans', 'Mouse', 4, 1200.00, '2023-03-01'),
(7, 'Eve Foster', 'Printer', 1, 8500.00, '2023-03-10'),
(8, 'Frank Green', 'Tablet', 2, 30000.00, '2023-03-20'),
(9, 'Grace Harris', 'Webcam', 3, 3500.00, '2023-04-01'),
(10, 'Henry Irving', 'External Hard Drive', 2, 6000.00, '2023-04-05');

select * from MyOrders;

UPDATE MyOrders
SET quantity = 20
WHERE cust_name = 'John Doe' AND product_name = 'Laptop';

Delete Myorders
where order_date > '2023-03-10';
