
-- SESSION-10 --

CREATE DATABASE IF NOT EXISTS sql_union_practice_db;
USE sql_union_practice_db;

CREATE TABLE AppOrders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    amount DECIMAL(10,2),
    order_date DATE
);

CREATE TABLE InStoreOrders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO AppOrders
    (order_id, customer_name, amount, order_date)
VALUES
    (101, 'Ravi', 450.00, '2026-10-20'),
    (102, 'Priya', 320.00, '2026-10-21'),
    (103, 'Amit', 550.00, '2026-10-22');

INSERT INTO InStoreOrders
    (order_id, customer_name, amount, order_date)
VALUES
    (201, 'Neha', 250.00, '2026-10-20'),
    (202, 'Karan', 400.00, '2026-10-21'),
    (203, 'Priya', 350.00, '2026-10-23');
    

-- UNION: Unique customer names

SELECT customer_name
FROM AppOrders

UNION

SELECT customer_name
FROM InStoreOrders
ORDER BY customer_name;

-- UNION ALL: Display every order

SELECT
    order_id,
    customer_name,
    amount,
    order_date
FROM AppOrders

UNION ALL

SELECT
    order_id,
    customer_name,
    amount,
    order_date
FROM InStoreOrders
ORDER BY order_date, order_id;

-- Demonstrate the difference

USE sql_union_practice_db;

-- Add one more Priya order to each table
INSERT INTO AppOrders
    (order_id, customer_name, amount, order_date)
VALUES
    (104, 'Priya', 320.00, '2026-10-21');

INSERT INTO InStoreOrders
    (order_id, customer_name, amount, order_date)
VALUES
    (204, 'Priya', 320.00, '2026-10-21');
