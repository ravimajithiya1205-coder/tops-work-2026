
-- ============================================================
-- FOOD DELIVERY ASSESSMENT DATABASE
-- DATABASE: food_delivery_assessment_db
-- ============================================================


-- SECTION 0: CREATE DATABASE

DROP DATABASE IF EXISTS food_delivery_assessment_db;

CREATE DATABASE food_delivery_assessment_db;

USE food_delivery_assessment_db;


-- ============================================================
-- SECTION 0.1: CREATE TABLES
-- ============================================================


-- TABLE 1: CUSTOMERS

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    city VARCHAR(50),
    signup_date DATE
);


-- TABLE 2: RESTAURANTS

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    cuisine VARCHAR(50),
    rating DECIMAL(3,1)
);


-- TABLE 3: DELIVERY PARTNERS

CREATE TABLE delivery_partners (
    partner_id INT PRIMARY KEY,
    partner_name VARCHAR(100),
    city VARCHAR(50),
    vehicle_type VARCHAR(30)
);


-- TABLE 4: ORDERS

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    partner_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_status VARCHAR(30),
    total_amount DECIMAL(10,2),

    INDEX idx_orders_restaurant_id (restaurant_id),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id),

    FOREIGN KEY (partner_id)
        REFERENCES delivery_partners(partner_id)
);


-- TABLE 5: DELIVERY RECORDS

CREATE TABLE delivery_records (
    delivery_record_id INT PRIMARY KEY,
    delivery_partner_id INT NOT NULL,
    delivery_time_minutes INT NOT NULL,
    delivered_at DATETIME,

    INDEX idx_delivery_partner_id (delivery_partner_id),

    FOREIGN KEY (delivery_partner_id)
        REFERENCES delivery_partners(partner_id)
);


-- ============================================================
-- SECTION 0.2: INSERT SAMPLE CUSTOMERS
-- 100 CUSTOMERS
-- ============================================================

INSERT INTO customers
(customer_id, customer_name, email, city, signup_date)
VALUES
(1, 'Aarav Patel', 'aarav@example.com', 'Ahmedabad', '2025-01-10'),
(2, 'Riya Shah', 'riya@example.com', 'Surat', '2025-02-12'),
(3, 'Krish Mehta', 'krish@example.com', 'Ahmedabad', '2025-03-15'),
(4, 'Ananya Desai', 'ananya@example.com', 'Surat', '2025-04-20'),
(5, 'Dev Joshi', 'dev@example.com', 'Ahmedabad', '2025-05-11'),
(6, 'Diya Trivedi', 'diya@example.com', 'Surat', '2025-06-17'),
(7, 'Arjun Parmar', 'arjun@example.com', 'Ahmedabad', '2025-07-22'),
(8, 'Mira Patel', 'mira@example.com', 'Surat', '2025-08-13'),
(9, 'Vivaan Shah', 'vivaan@example.com', 'Ahmedabad', '2025-09-05'),
(10, 'Ishita Mehta', 'ishita@example.com', 'Surat', '2025-10-09'),
(11, 'Reyansh Desai', 'reyansh@example.com', 'Ahmedabad', '2025-11-14'),
(12, 'Kiara Joshi', 'kiara@example.com', 'Surat', '2025-12-18'),
(13, 'Aditya Shah', 'aditya@example.com', 'Ahmedabad', '2025-12-20'),
(14, 'Saanvi Patel', 'saanvi@example.com', 'Surat', '2025-12-22'),
(15, 'Kabir Mehta', 'kabir@example.com', 'Ahmedabad', '2025-12-25');


-- Add customers 16 to 100
-- Generated using a recursive CTE

INSERT INTO customers
(customer_id, customer_name, email, city, signup_date)
WITH RECURSIVE customer_numbers AS (
    SELECT 16 AS n
    UNION ALL
    SELECT n + 1
    FROM customer_numbers
    WHERE n < 100
)
SELECT
    n,
    CONCAT('Customer ', n),
    CONCAT('customer', n, '@example.com'),
    CASE WHEN MOD(n, 2) = 0
         THEN 'Ahmedabad'
         ELSE 'Surat'
    END,
    DATE_ADD('2025-01-01', INTERVAL n DAY)
FROM customer_numbers;


-- ============================================================
-- SECTION 0.3: INSERT RESTAURANTS
-- ============================================================

INSERT INTO restaurants
(restaurant_id, restaurant_name, city, cuisine, rating)
VALUES
(1, 'Food Palace', 'Ahmedabad', 'Indian', 4.5),
(2, 'Spice Hub', 'Ahmedabad', 'Chinese', 4.3),
(3, 'Royal Kitchen', 'Ahmedabad', 'Gujarati', 4.1),
(4, 'Surat Food House', 'Surat', 'Indian', 4.6),
(5, 'Tasty Corner', 'Surat', 'Italian', 4.4),
(6, 'Street Bites', 'Surat', 'Fast Food', 4.0);


-- ============================================================
-- SECTION 0.4: INSERT DELIVERY PARTNERS
-- ============================================================

INSERT INTO delivery_partners
(partner_id, partner_name, city, vehicle_type)
VALUES
(1, 'Rahul Kumar', 'Ahmedabad', 'Bike'),
(2, 'Amit Shah', 'Ahmedabad', 'Bike'),
(3, 'Karan Patel', 'Surat', 'Scooter'),
(4, 'Vishal Mehta', 'Surat', 'Bike'),
(5, 'Rohan Joshi', 'Ahmedabad', 'Scooter'),
(6, 'Nikhil Desai', 'Surat', 'Bike');


-- ============================================================
-- SECTION 0.5: INSERT 145 ORDERS
-- ============================================================

INSERT INTO orders
(order_id, customer_id, restaurant_id, partner_id,
 order_date, order_status, total_amount)

WITH RECURSIVE order_numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM order_numbers
    WHERE n < 145
)

SELECT
    n,

    MOD(n - 1, 100) + 1,

    CASE
        WHEN n <= 60 THEN 1
        WHEN n <= 110 THEN 2
        WHEN n <= 120 THEN 3
        WHEN n <= 130 THEN 4
        WHEN n <= 140 THEN 5
        ELSE 6
    END,

    MOD(n - 1, 6) + 1,

    DATE_ADD('2026-10-01', INTERVAL MOD(n - 1, 31) DAY),

    CASE
        WHEN MOD(n, 10) = 0 THEN 'Preparing'
        ELSE 'Delivered'
    END,

    CASE
        WHEN MOD(n - 1, 100) + 1 = 1 THEN 3000.00
        ELSE 2200.00
    END

FROM order_numbers;


-- ============================================================
-- SECTION 0.6: INSERT DELIVERY TIME RECORDS
-- ============================================================

INSERT INTO delivery_records
(delivery_record_id, delivery_partner_id,
 delivery_time_minutes, delivered_at)
VALUES
(1, 1, 20, '2026-10-01 12:00:00'),
(2, 1, 22, '2026-10-02 12:00:00'),
(3, 1, 24, '2026-10-03 12:00:00'),

(4, 2, 25, '2026-10-01 13:00:00'),
(5, 2, 26, '2026-10-02 13:00:00'),
(6, 2, 27, '2026-10-03 13:00:00'),

(7, 3, 30, '2026-10-01 14:00:00'),
(8, 3, 31, '2026-10-02 14:00:00'),
(9, 3, 32, '2026-10-03 14:00:00'),

(10, 4, 35, '2026-10-01 15:00:00'),
(11, 4, 36, '2026-10-02 15:00:00'),
(12, 4, 37, '2026-10-03 15:00:00'),

(13, 5, 40, '2026-10-01 16:00:00'),
(14, 5, 42, '2026-10-02 16:00:00'),
(15, 5, 44, '2026-10-03 16:00:00'),

(16, 6, 50, '2026-10-01 17:00:00'),
(17, 6, 52, '2026-10-02 17:00:00'),
(18, 6, 54, '2026-10-03 17:00:00');


-- ============================================================
-- SECTION 0.7: DATABASE VALIDATION
-- ============================================================

SELECT COUNT(*) AS total_customers FROM customers;
-- Expected: 100

SELECT COUNT(*) AS total_restaurants FROM restaurants;
-- Expected: 6

SELECT COUNT(*) AS total_delivery_partners FROM delivery_partners;
-- Expected: 6

SELECT COUNT(*) AS total_orders FROM orders;
-- Expected: 145

SELECT COUNT(*) AS total_delivery_records FROM delivery_records;
-- Expected: 18


-- ============================================================
-- SECTION A: CONCEPT APPLICATION
-- ============================================================


-- ------------------------------------------------------------
-- S1: GROUP BY AND HAVING
-- Find restaurants with revenue > 100000
-- and at least 50 orders in October 2026.
-- ------------------------------------------------------------

SELECT
    r.restaurant_id,
    r.restaurant_name,
    SUM(o.total_amount) AS total_revenue,
    COUNT(o.order_id) AS total_orders
FROM restaurants AS r
INNER JOIN orders AS o
    ON r.restaurant_id = o.restaurant_id
WHERE o.order_date >= '2026-10-01'
  AND o.order_date < '2026-11-01'
GROUP BY
    r.restaurant_id,
    r.restaurant_name
HAVING
    SUM(o.total_amount) > 100000
    AND COUNT(o.order_id) >= 50;


-- ------------------------------------------------------------
-- S2: LEFT JOIN
-- Show every customer and their latest order.
-- Include customers who have never ordered.
-- ------------------------------------------------------------

WITH ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_status,
        total_amount,

        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date DESC, order_id DESC
        ) AS rn

    FROM orders
)

SELECT
    c.customer_id,
    c.customer_name,
    ro.order_id,
    ro.order_date,
    ro.order_status,
    ro.total_amount
FROM customers AS c
LEFT JOIN ranked_orders AS ro
    ON c.customer_id = ro.customer_id
   AND ro.rn = 1
ORDER BY c.customer_id;


-- ------------------------------------------------------------
-- S3: SCALAR SUBQUERY
-- Find delivery agents faster than overall average.
-- ------------------------------------------------------------

SELECT
    dp.partner_id,
    dp.partner_name,
    AVG(dr.delivery_time_minutes) AS avg_delivery_time
FROM delivery_partners AS dp
INNER JOIN delivery_records AS dr
    ON dp.partner_id = dr.delivery_partner_id
GROUP BY
    dp.partner_id,
    dp.partner_name
HAVING
    AVG(dr.delivery_time_minutes) < (
        SELECT AVG(delivery_time_minutes)
        FROM delivery_records
    )
ORDER BY avg_delivery_time;


-- ------------------------------------------------------------
-- S4: RANK AND DENSE_RANK
-- Top 3 revenue positions within each city.
-- ------------------------------------------------------------

WITH restaurant_revenue AS (
    SELECT
        r.city,
        r.restaurant_id,
        r.restaurant_name,
        SUM(o.total_amount) AS total_revenue
    FROM restaurants AS r
    INNER JOIN orders AS o
        ON r.restaurant_id = o.restaurant_id
    GROUP BY
        r.city,
        r.restaurant_id,
        r.restaurant_name
),

ranked_restaurants AS (
    SELECT
        city,
        restaurant_id,
        restaurant_name,
        total_revenue,

        RANK() OVER (
            PARTITION BY city
            ORDER BY total_revenue DESC
        ) AS revenue_rank,

        DENSE_RANK() OVER (
            PARTITION BY city
            ORDER BY total_revenue DESC
        ) AS dense_revenue_rank

    FROM restaurant_revenue
)

SELECT *
FROM ranked_restaurants
WHERE revenue_rank <= 3
ORDER BY city, revenue_rank, restaurant_id;


-- ------------------------------------------------------------
-- S5: CASE WHEN
-- ------------------------------------------------------------

SELECT
    c.customer_id,
    c.customer_name,

    COALESCE(SUM(o.total_amount), 0) AS lifetime_spend,

    CASE
        WHEN COALESCE(SUM(o.total_amount), 0) > 5000
            THEN 'Platinum'

        WHEN COALESCE(SUM(o.total_amount), 0) >= 2000
            THEN 'Gold'

        ELSE 'Standard'
    END AS customer_tier

FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id

GROUP BY
    c.customer_id,
    c.customer_name

ORDER BY lifetime_spend DESC;


-- ------------------------------------------------------------
-- S6: INDEXING
-- ------------------------------------------------------------

SHOW INDEX FROM orders;

EXPLAIN
SELECT
    r.restaurant_name,
    r.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_revenue
FROM restaurants AS r
INNER JOIN orders AS o
    ON r.restaurant_id = o.restaurant_id
GROUP BY
    r.restaurant_id,
    r.restaurant_name,
    r.city;

