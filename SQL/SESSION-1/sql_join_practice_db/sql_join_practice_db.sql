
CREATE DATABASE IF NOT EXISTS sql_join_practice_db;
USE sql_join_practice_db;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    city VARCHAR(100)
);

-- No foreign key on user_id so orphan orders are allowed
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    product VARCHAR(100),
    amount DECIMAL(10,2)
);

INSERT INTO Users (user_id, username, city)
VALUES
(1, 'Ravi', 'Ahmedabad'),
(2, 'Priya', 'Surat'),
(3, 'Amit', 'Vadodara'),
(4, 'Neha', 'Rajkot');

INSERT INTO Orders (order_id, user_id, product, amount)
VALUES
(101, 1, 'Pizza', 350.00),
(102, 1, 'Burger', 180.00),
(103, 2, 'Biryani', 250.00),
(104, 2, 'Sandwich', 120.00),
(105, 1, 'Pasta', 220.00),
(106, 99, 'Coffee', 90.00);

CREATE TABLE CustomerSegments (
    segment_id INT PRIMARY KEY,
    segment_name VARCHAR(100) NOT NULL
);

INSERT INTO CustomerSegments (segment_id, segment_name)
VALUES
(1, 'Premium'),
(2, 'Regular'),
(3, 'New');


ALTER TABLE Users
ADD COLUMN segment_id INT;

ALTER TABLE Users
ADD CONSTRAINT fk_users_segment
FOREIGN KEY (segment_id)
REFERENCES CustomerSegments(segment_id);

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

UPDATE Users
SET segment_id = CASE user_id
    WHEN 1 THEN 1
    WHEN 2 THEN 2
    WHEN 3 THEN 3
    WHEN 4 THEN 3
END;


-- SESSION-8 --

-- INNER JOIN
SELECT
    u.username,
    o.product
FROM Users AS u
INNER JOIN Orders AS o
    ON u.user_id = o.user_id
ORDER BY u.user_id, o.order_id;

-- LEFT JOIN
SELECT
    u.username,
    o.product
FROM Users AS u
LEFT JOIN Orders AS o
    ON u.user_id = o.user_id
ORDER BY u.user_id, o.order_id;

-- RIGHT JOIN
SELECT
    o.order_id,
    o.user_id,
    u.username,
    o.product,
    o.amount
FROM Users AS u
RIGHT JOIN Orders AS o
    ON u.user_id = o.user_id
ORDER BY o.order_id;

-- Customer segments and total order amount
SELECT
    u.username,
    cs.segment_name,
    COALESCE(SUM(o.amount), 0) AS total_order_amount
FROM Users AS u
INNER JOIN CustomerSegments AS cs
    ON u.segment_id = cs.segment_id
LEFT JOIN Orders AS o
    ON u.user_id = o.user_id
GROUP BY
    u.user_id,
    u.username,
    cs.segment_id,
    cs.segment_name
ORDER BY u.user_id;

-- SESSION-9 --

CREATE TABLE influencers (
    influencer_id INT PRIMARY KEY,
    influencer_name VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE brands (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(100),
    city VARCHAR(100)
);

INSERT INTO influencers VALUES
(1, 'Aarav Patel', 'Ahmedabad'),
(2, 'Diya Shah', 'Mumbai'),
(3, 'Kabir Mehta', 'Delhi');

INSERT INTO brands VALUES
(1, 'Brand A', 'Ahmedabad'),
(2, 'Brand B', 'Surat'),
(3, 'Brand C', 'Delhi');

-- PLAYLISTS
CREATE TABLE playlists (
    id INT PRIMARY KEY,
    playlist_name VARCHAR(100),
    parent_playlist_id INT NULL
);

-- OFFERS
CREATE TABLE offers (
    offer_id INT PRIMARY KEY,
    offer_title VARCHAR(150)
);

INSERT INTO offers VALUES
(1, '10% Off on Electronics'),
(2, 'Free Delivery'),
(3, 'Special Fashion Discount');

-- EMPLOYEES
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT NULL
);

INSERT INTO employees VALUES
(1, 'Meera', NULL),
(2, 'Raj', 1),
(3, 'Anjali', 1),
(4, 'Dev', 2),
(5, 'Kiran', NULL);


-- SESSION-9 --

-- FULL OUTER JOIN using LEFT JOIN, RIGHT JOIN and UNION
SELECT
    i.influencer_name,
    b.brand_name,
    i.city
FROM influencers AS i
LEFT JOIN brands AS b
    ON i.city = b.city;
    
SELECT
    i.influencer_name,
    b.brand_name,
    b.city
FROM influencers AS i
RIGHT JOIN brands AS b
    ON i.city = b.city
WHERE i.influencer_id IS NULL;

-- SELF JOIN for nested playlists
SELECT
    child.playlist_name AS playlist_name,
    parent.playlist_name AS parent_playlist_name
FROM playlists AS child
LEFT JOIN playlists AS parent
    ON child.parent_playlist_id = parent.id
ORDER BY child.id;

-- CROSS JOIN for personalized offers
SELECT
    u.username,
    o.offer_title
FROM users AS u
CROSS JOIN offers AS o
ORDER BY u.user_id, o.offer_id;
