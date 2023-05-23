DROP DATABASE IF EXISTS test;
CREATE DATABASE test;

USE test;

CREATE TABLE orders (order_id INT, customer_id INT, order_date DATE);

CREATE TABLE customers (customer_id INT, customer_name VARCHAR(10));

INSERT INTO orders VALUES 
(10308, 2, '1996-09-18'), 
(10309, 37, '1996-09-19'), 
(10310, 77, '1996-09-20');

INSERT INTO customers VALUES (1, 'Alfreds'), (2, 'Ana'), (3, 'Antonio');

INSERT INTO orders VALUES 
(10309, 3, '1996-09-18');
INSERT INTO orders VALUES 
(10311, 2, '1996-09-18');

SELECT * 
FROM orders 
INNER JOIN customers 
ON orders.customer_id =customers.customer_id
WHERE orders.customer_id = 2;

ALTER TABLE customers ADD PRIMARY KEY (customer_id);

-- Uncommenting this line will make it fail. 
-- ALTER TABLE orders ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;

SELECT * 
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id;

SELECT *
FROM orders
RIGHT JOIN customers
ON orders.customer_id = customers.customer_id;
