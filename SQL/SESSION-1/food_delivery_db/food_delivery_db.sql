create database  food_delivery_db;

use food_delivery_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    signup_date DATE
);

INSERT INTO customers
(customer_name, email, phone, city, signup_date)
VALUES
('Ravi Patel', 'ravi.fd@example.com', '9876500001', 'Ahmedabad', '2025-01-05'),
('Amit Shah', 'amit.fd@example.com', '9876500002', 'Ahmedabad', '2025-01-12'),
('Priya Mehta', 'priya.fd@example.com', '9876500003', 'Vadodara', '2025-02-01'),
('Neha Joshi', 'neha.fd@example.com', '9876500004', 'Surat', '2025-02-10'),
('Rahul Desai', 'rahul.fd@example.com', '9876500005', 'Ahmedabad', '2025-02-18'),
('Karan Singh', 'karan.fd@example.com', '9876500006', 'Gandhinagar', '2025-03-03'),
('Meera Patel', 'meera.fd@example.com', '9876500007', 'Vadodara', '2025-03-15'),
('Sahil Verma', 'sahil.fd@example.com', '9876500008', 'Surat', '2025-04-01'),
('Pooja Shah', 'pooja.fd@example.com', '9876500009', 'Ahmedabad', '2025-04-10'),
('Jay Mehta', 'jay.fd@example.com', '9876500010', 'Gandhinagar', '2025-04-20');

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_name VARCHAR(150) NOT NULL,
    city VARCHAR(50),
    cuisine VARCHAR(50),
    rating DECIMAL(2,1),
    opening_time TIME,
    closing_time TIME
);

INSERT INTO restaurants
(restaurant_name, city, cuisine, rating, opening_time, closing_time)
VALUES
('Spice Garden', 'Ahmedabad', 'North Indian', 4.5, '11:00:00', '23:00:00'),
('Pizza Hub', 'Ahmedabad', 'Italian', 4.2, '10:30:00', '23:30:00'),
('South Bowl', 'Ahmedabad', 'South Indian', 4.4, '07:00:00', '22:00:00'),
('Green Leaf', 'Vadodara', 'Healthy Food', 4.6, '08:00:00', '22:00:00'),
('Punjabi Tadka', 'Surat', 'Punjabi', 4.1, '11:00:00', '23:00:00'),
('Burger Point', 'Gandhinagar', 'Fast Food', 4.0, '10:00:00', '23:00:00'),
('Royal Biryani', 'Ahmedabad', 'Biryani', 4.7, '11:00:00', '00:00:00'),
('Cafe Coffee Day', 'Ahmedabad', 'Cafe', 4.3, '08:00:00', '23:00:00');

CREATE TABLE menu_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    item_name VARCHAR(150) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
);

INSERT INTO menu_items
(restaurant_id, item_name, category, price, is_available)
VALUES
(1, 'Paneer Butter Masala', 'Main Course', 220.00, TRUE),
(1, 'Butter Naan', 'Bread', 45.00, TRUE),
(1, 'Veg Biryani', 'Rice', 180.00, TRUE),

(2, 'Margherita Pizza', 'Pizza', 249.00, TRUE),
(2, 'Farmhouse Pizza', 'Pizza', 399.00, TRUE),
(2, 'Garlic Bread', 'Starter', 149.00, TRUE),

(3, 'Masala Dosa', 'South Indian', 120.00, TRUE),
(3, 'Idli Sambar', 'South Indian', 90.00, TRUE),
(3, 'Vada', 'South Indian', 70.00, TRUE),

(4, 'Veg Salad', 'Healthy', 160.00, TRUE),
(4, 'Paneer Wrap', 'Healthy', 190.00, TRUE),
(4, 'Fruit Bowl', 'Healthy', 140.00, TRUE),

(5, 'Chole Bhature', 'Punjabi', 180.00, TRUE),
(5, 'Dal Makhani', 'Main Course', 210.00, TRUE),

(6, 'Classic Burger', 'Burger', 180.00, TRUE),
(6, 'Cheese Burger', 'Burger', 220.00, TRUE),

(7, 'Chicken Biryani', 'Biryani', 320.00, TRUE),
(7, 'Mutton Biryani', 'Biryani', 380.00, TRUE),

(8, 'Cappuccino', 'Beverage', 160.00, TRUE),
(8, 'Cold Coffee', 'Beverage', 190.00, TRUE);

CREATE TABLE delivery_partners (
    partner_id INT PRIMARY KEY AUTO_INCREMENT,
    partner_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    vehicle_type VARCHAR(30),
    city VARCHAR(50),
    joining_date DATE
);

INSERT INTO delivery_partners
(partner_name, phone, vehicle_type, city, joining_date)
VALUES
('Vijay Kumar', '9000000001', 'Bike', 'Ahmedabad', '2025-01-10'),
('Rakesh Patel', '9000000002', 'Bike', 'Ahmedabad', '2025-01-20'),
('Suresh Shah', '9000000003', 'Bike', 'Vadodara', '2025-02-05'),
('Manish Joshi', '9000000004', 'Bike', 'Surat', '2025-02-15'),
('Akash Verma', '9000000005', 'Bike', 'Ahmedabad', '2025-03-01'),
('Nitin Desai', '9000000006', 'Scooter', 'Gandhinagar', '2025-03-10'),
('Deepak Singh', '9000000007', 'Bike', 'Ahmedabad', '2025-04-01'),
('Harsh Mehta', '9000000008', 'Bike', 'Ahmedabad', '2025-04-15');


CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    partner_id INT,
    order_date DATETIME NOT NULL,
    delivery_address VARCHAR(255),
    order_status VARCHAR(30),
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id),
    FOREIGN KEY (partner_id)
        REFERENCES delivery_partners(partner_id)
);

INSERT INTO orders
(customer_id, restaurant_id, partner_id, order_date, delivery_address, order_status, total_amount)
VALUES
(1, 1, 1, '2025-09-01 12:30:00', 'Navrangpura, Ahmedabad', 'Delivered', 485.00),
(2, 2, 2, '2025-09-01 19:15:00', 'Satellite, Ahmedabad', 'Delivered', 548.00),
(3, 4, 3, '2025-09-02 13:00:00', 'Alkapuri, Vadodara', 'Delivered', 350.00),
(4, 5, 4, '2025-09-02 20:30:00', 'Adajan, Surat', 'Delivered', 390.00),
(5, 7, 5, '2025-09-03 21:00:00', 'Bopal, Ahmedabad', 'Delivered', 640.00),
(6, 6, 6, '2025-09-04 14:00:00', 'Sector 21, Gandhinagar', 'Delivered', 400.00),
(7, 3, 3, '2025-09-04 09:30:00', 'Gotri, Vadodara', 'Delivered', 240.00),
(8, 2, 4, '2025-09-05 18:45:00', 'Vesu, Surat', 'Delivered', 498.00),
(9, 1, 1, '2025-09-06 13:20:00', 'Maninagar, Ahmedabad', 'Delivered', 355.00),
(10, 8, 6, '2025-09-06 17:10:00', 'Sector 7, Gandhinagar', 'Delivered', 350.00),
(1, 7, 7, '2025-09-07 20:10:00', 'Navrangpura, Ahmedabad', 'Delivered', 320.00),
(2, 3, 8, '2025-09-08 08:30:00', 'Chandkheda, Ahmedabad', 'Delivered', 300.00),
(5, 2, 2, '2025-09-08 19:40:00', 'Bopal, Ahmedabad', 'Preparing', 399.00),
(3, 4, 3, '2025-09-09 12:15:00', 'Alkapuri, Vadodara', 'Out for Delivery', 380.00),
(7, 1, 1, '2025-09-10 20:30:00', 'Gotri, Vadodara', 'Cancelled', 265.00);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (item_id)
        REFERENCES menu_items(item_id)
);

INSERT INTO order_items
(order_id, item_id, quantity, unit_price)
VALUES
(1, 1, 2, 220.00),
(1, 2, 1, 45.00),
(2, 4, 1, 249.00),
(2, 5, 1, 399.00),
(3, 10, 1, 160.00),
(3, 11, 1, 190.00),
(4, 13, 1, 180.00),
(4, 14, 1, 210.00),
(5, 17, 2, 320.00),
(6, 15, 1, 180.00),
(6, 16, 1, 220.00),
(7, 7, 2, 120.00),
(8, 4, 2, 249.00),
(9, 1, 1, 220.00),
(9, 2, 3, 45.00),
(10, 19, 1, 160.00),
(10, 20, 1, 190.00),
(11, 17, 1, 320.00),
(12, 7, 1, 120.00),
(12, 8, 2, 90.00),
(13, 5, 1, 399.00),
(14, 10, 1, 160.00),
(14, 11, 1, 190.00),
(15, 1, 1, 220.00),
(15, 2, 1, 45.00);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL UNIQUE,
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    payment_date DATETIME,
    amount DECIMAL(10,2),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

INSERT INTO payments
(order_id, payment_method, payment_status, payment_date, amount)
VALUES
(1, 'UPI', 'Paid', '2025-09-01 12:31:00', 485.00),
(2, 'Credit Card', 'Paid', '2025-09-01 19:16:00', 548.00),
(3, 'UPI', 'Paid', '2025-09-02 13:01:00', 350.00),
(4, 'Cash', 'Paid', '2025-09-02 20:31:00', 390.00),
(5, 'UPI', 'Paid', '2025-09-03 21:01:00', 640.00),
(6, 'Credit Card', 'Paid', '2025-09-04 14:01:00', 400.00),
(7, 'UPI', 'Paid', '2025-09-04 09:31:00', 240.00),
(8, 'UPI', 'Paid', '2025-09-05 18:46:00', 498.00),
(9, 'Cash', 'Paid', '2025-09-06 13:21:00', 355.00),
(10, 'UPI', 'Paid', '2025-09-06 17:11:00', 350.00),
(11, 'Credit Card', 'Paid', '2025-09-07 20:11:00', 320.00),
(12, 'UPI', 'Paid', '2025-09-08 08:31:00', 300.00),
(13, 'UPI', 'Paid', '2025-09-08 19:41:00', 399.00),
(14, 'UPI', 'Paid', '2025-09-09 12:16:00', 380.00),
(15, 'UPI', 'Refunded', '2025-09-10 20:31:00', 265.00);

-- Session 2 --

CREATE TABLE zomato_reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    rating DECIMAL(2,1),
    city VARCHAR(50),
    review_text VARCHAR(255),
    review_date DATE
);

INSERT INTO zomato_reviews
(name, rating, city, review_text, review_date)
VALUES
('Spice Garden', 4.5, 'Ahmedabad', 'Great food and service', '2025-09-01'),
('Pizza Hub', 4.2, 'Ahmedabad', 'Good pizza and quick delivery', '2025-09-02'),
('South Bowl', 4.4, 'Ahmedabad', 'Tasty South Indian food', '2025-09-03'),
('Green Leaf', 4.6, 'Vadodara', 'Fresh and healthy meals', '2025-09-04'),
('Punjabi Tadka', 4.1, 'Surat', 'Good Punjabi dishes', '2025-09-05'),
('Burger Point', 4.0, 'Gandhinagar', 'Nice burgers', '2025-09-06'),
('Royal Biryani', 4.7, 'Ahmedabad', 'Excellent biryani', '2025-09-07'),
('Cafe Corner', 4.3, 'Vadodara', 'Good coffee and snacks', '2025-09-08'),
('Food Junction', 3.9, 'Ahmedabad', 'Average experience', '2025-09-09'),
('Urban Kitchen', 4.8, 'Surat', 'Amazing food quality', '2025-09-10');

-- Display only name and rating

SELECT name, rating
FROM zomato_reviews;

SELECT * FROM payments;

-- SESSION 3 --
SELECT *
FROM restaurants
WHERE rating >= 4.5;

-- SESSION 4 --

UPDATE restaurants SET restaurant_name = 'Sunrise Cafe' WHERE restaurant_id = 1;
UPDATE restaurants SET restaurant_name = 'Chai Point Cafe' WHERE restaurant_id = 5;
UPDATE restaurants SET restaurant_name = 'Green Leaf Cafe' WHERE restaurant_id = 7;

SELECT *
FROM restaurants
WHERE restaurant_name LIKE '%Cafe';

-- SESSION 5 --

-- 1. Find unique payment methods -- 
SELECT DISTINCT payment_method
FROM payments;

-- 3. 5 most recent order
SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 5;