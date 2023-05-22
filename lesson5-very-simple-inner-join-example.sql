DROP DATABASE IF EXISTS my_simple_inner_join_test;
CREATE DATABASE my_simple_inner_join_test;
USE my_simple_inner_join_test;

-- Create an order table.
CREATE TABLE orders (order_id INT, customer_id INT, order_date DATE);

-- Create a customer table.
CREATE TABLE customers (customer_id INT, customer_name VARCHAR(10));

-- Populate the order table.
INSERT INTO orders VALUES
  (10308, 2, '1996-09-18'),
  (10309, 37, '1996-09-19'),
  (10310, 77, '1996-09-20');
  
-- Populate the customer table.
INSERT INTO customers VALUES
  (1, 'Alfred'),
  (2, 'Ana'),
  (3, 'Anotonio');
  
-- Simple inner join of orders and customers tables.
-- Returns one row where customer_id=2 from both tables.
SELECT * FROM orders
  INNER JOIN customers
  ON orders.customer_id = customers.customer_id;

-- Add new data (rows) to orders table.
INSERT INTO orders VALUES
  (10309, 3, '1996-09-18'),
  (10311, 2, '1996-09-18');
  
-- Returns three rows, where customer_id=2 or customer_id=3 in both tables.
-- Note customer_id=2 ('Ana') has two separate orders, hence an extra row. 
SELECT * FROM orders
  INNER JOIN customers
  ON orders.customer_id = customers.customer_id;

-- Now returns two rows, where customer_id=2 in both tables.
SELECT * FROM orders
  INNER JOIN customers
  ON orders.customer_id = customers.customer_id
  WHERE orders.customer_id = 2;
