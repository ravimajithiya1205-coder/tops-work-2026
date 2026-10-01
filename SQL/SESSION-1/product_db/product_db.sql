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