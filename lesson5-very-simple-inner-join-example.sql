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
SELECT * FROM orders
  INNER JOIN customers
  ON orders.customer_id = customers.customer_id;

/*
-- Uncomment code block to add more data to table before performing inner join.
-- Add new data (row) to orders table.
INSERT INTO orders VALUES
  (10311, 3, '1996-09-18');
  
-- Simple inner join of orders and customers tables.
SELECT * FROM orders
  INNER JOIN customers
  ON orders.customer_id = customers.customer_id;
*/
