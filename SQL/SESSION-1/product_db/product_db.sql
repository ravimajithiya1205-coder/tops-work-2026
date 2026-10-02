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
