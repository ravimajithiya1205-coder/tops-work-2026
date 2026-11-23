-- =========================================================
-- FILE: recharge_load.sql
-- =========================================================

CREATE DATABASE IF NOT EXISTS recharge_usage_db;
USE recharge_usage_db;

DROP TABLE IF EXISTS subscribers;

CREATE TABLE subscribers (
    subscriber_id VARCHAR(5) PRIMARY KEY,
    circle VARCHAR(20) NOT NULL,
    plan_inr INT NOT NULL,
    data_gb_used DECIMAL(4,1) NOT NULL,
    recharge_date DATE NOT NULL,
    churned TINYINT NOT NULL,
    CHECK (circle IN ('Gujarat', 'Maharashtra', 'Rajasthan', 'MP')),
    CHECK (plan_inr IN (149, 239, 299, 479, 719)),
    CHECK (data_gb_used BETWEEN 0.5 AND 60.0),
    CHECK (churned IN (0, 1))
);

-- OPTION A: MySQL Workbench Table Data Import Wizard (recommended)
-- 1. Execute this file through CREATE TABLE.
-- 2. In SCHEMAS, right-click recharge_usage_db > Table Data Import Wizard.
-- 3. Select recharge_usage.csv.
-- 4. Select subscribers as the destination table.
-- 5. Map columns in this order:
--    subscriber_id, circle, plan_inr, data_gb_used, recharge_date, churned.
-- 6. Finish the wizard.

-- OPTION B: LOAD DATA LOCAL INFILE
-- Replace the path below with the actual full path to recharge_usage.csv.
-- Enable local_infile in your MySQL client/server if required.
--
-- LOAD DATA LOCAL INFILE 'C:/YOUR_FOLDER/recharge_usage.csv'
-- INTO TABLE subscribers
-- CHARACTER SET utf8mb4
-- FIELDS TERMINATED BY ','
-- OPTIONALLY ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS
-- (subscriber_id, circle, plan_inr, data_gb_used, recharge_date, churned);

-- Verify the import:
SELECT COUNT(*) AS total_subscribers
FROM subscribers;
-- Expected: 200

SELECT *
FROM subscribers
ORDER BY subscriber_id
LIMIT 10;





