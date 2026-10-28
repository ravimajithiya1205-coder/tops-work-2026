create database product_db;

use product_db;

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(50)
);

INSERT INTO products (id, name, price, category) VALUES
(1, 'Smartphone', 24999.00, 'Electronics'),
(2, 'Laptop', 55999.00, 'Electronics'),
(3, 'Bluetooth Speaker', 1499.00, 'Electronics'),
(4, 'Cotton T-Shirt', 399.00, 'Clothing'),
(5, 'Denim Jeans', 1299.00, 'Clothing'),
(6, 'Notebook', 120.00, 'Stationery'),
(7, 'Office Chair', 6499.00, 'Furniture'),
(8, 'Water Bottle', 350.00, 'Kitchen'),
(9, 'USB Cable', 250.00, 'Electronics'),
(10,'Study Table', 8999.00, 'Furniture');

SELECT * FROM products;

-- SESSION 3 --

SELECT *
FROM products
WHERE category <> 'Electronics'
   OR price < 500;
   

-- SESSION 4 --

SELECT *
FROM products
WHERE price BETWEEN 500 AND 1500;


-- SESSION 5 --

ALTER TABLE products ADD sold_count INT;

UPDATE products SET sold_count = 1 WHERE id = 1;
UPDATE products SET sold_count = 5 WHERE id = 2;
UPDATE products SET sold_count = 4 WHERE id = 3;
UPDATE products SET sold_count = 5 WHERE id = 4;
UPDATE products SET sold_count = 6 WHERE id = 5;
UPDATE products SET sold_count = 2 WHERE id = 6;
UPDATE products SET sold_count = 4 WHERE id = 7;
UPDATE products SET sold_count = 3 WHERE id = 8;
UPDATE products SET sold_count = 5 WHERE id = 9;
UPDATE products SET sold_count = 1 WHERE id = 10;

-- 4. Top 10 products by sold count

SELECT name, sold_count
FROM products
ORDER BY sold_count DESC
LIMIT 10;

-- Products with their category's average price --
SELECT
    p1.product_name,
    p1.product_price,
    p1.product_category,
    (
        SELECT AVG(p2.product_price)
        FROM product_db.products AS p2
        WHERE p2.product_category = p1.product_category
    ) AS avg_category_price
FROM product_db.products AS p1;

-- SESSION-12 --

USE product_db;

CREATE TABLE cte_flipkart_orders_practice (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO cte_flipkart_orders_practice
    (order_id, user_id, order_date, total_amount)
VALUES
    (1, 101, '2023-01-10', 12000),
    (2, 102, '2023-01-20', 18000),
    (3, 103, '2023-02-05', 15000),
    (4, 104, '2023-02-15', 25000),
    (5, 101, '2023-03-12', 30000),
    (6, 105, '2023-03-20', 22000),
    (7, 102, '2023-03-25', 28000),
    (8, 103, '2023-04-08', 10000),
    (9, 104, '2024-01-15', 50000),
    (10, 105, '2023-04-18', 12000);
    
WITH MonthlyTotals AS (
    SELECT
        MONTH(order_date) AS sales_month,
        SUM(total_amount) AS total_sales
    FROM product_db.cte_flipkart_orders_practice
    WHERE order_date >= '2023-01-01'
      AND order_date < '2024-01-01'
    GROUP BY MONTH(order_date)
)
SELECT sales_month, total_sales
FROM MonthlyTotals
ORDER BY total_sales DESC
LIMIT 1;

-- Create a recursive CTE to generate a list of dates for the next 7 days starting from today in a table called CalendarDays (columns: day_date). --

WITH RECURSIVE CalendarDays AS (
    SELECT CURDATE() AS day_date

    UNION ALL

    SELECT DATE_ADD(day_date, INTERVAL 1 DAY)
    FROM CalendarDays
    WHERE day_date < DATE_ADD(CURDATE(), INTERVAL 6 DAY)
)
SELECT day_date
FROM CalendarDays;
