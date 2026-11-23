
-- SOCIETY ENERGY DATABASE

-- SESSION 18

DROP DATABASE IF EXISTS society_energy_db;

CREATE DATABASE society_energy_db;

USE society_energy_db;


-- CREATE meter_readings TABLE

CREATE TABLE meter_readings (
    reading_id INT PRIMARY KEY,
    flat_no VARCHAR(10) NOT NULL,
    wing CHAR(1) NOT NULL,
    reading_date DATE NOT NULL,
    units_kwh INT NOT NULL,
    rate_per_unit DECIMAL(4,2) NOT NULL
);

INSERT INTO meter_readings
(reading_id, flat_no, wing, reading_date, units_kwh, rate_per_unit)
VALUES

-- WING A

(1, 'A-101', 'A', '2026-07-15', 180, 5.50),
(2, 'A-101', 'A', '2026-08-15', 210, 6.00),
(3, 'A-101', 'A', '2026-09-15', 230, 6.50),

(4, 'A-102', 'A', '2026-07-15', 250, 6.00),
(5, 'A-102', 'A', '2026-08-15', 270, 6.50),
(6, 'A-102', 'A', '2026-09-15', 290, 7.00),

(7, 'A-103', 'A', '2026-07-15', 150, 5.75),
(8, 'A-103', 'A', '2026-08-15', 170, 6.25),
(9, 'A-103', 'A', '2026-09-15', 190, 6.75),

(10, 'A-104', 'A', '2026-07-15', 300, 6.50),
(11, 'A-104', 'A', '2026-08-15', 320, 7.00),
(12, 'A-104', 'A', '2026-09-15', 340, 7.50),


-- WING B

(13, 'B-201', 'B', '2026-07-15', 100, 5.50),
(14, 'B-201', 'B', '2026-08-15', 120, 6.00),
(15, 'B-201', 'B', '2026-09-15', 140, 6.50),

(16, 'B-202', 'B', '2026-07-15', 200, 6.00),
(17, 'B-202', 'B', '2026-08-15', 220, 6.50),
(18, 'B-202', 'B', '2026-09-15', 240, 7.00),

(19, 'B-203', 'B', '2026-07-15', 350, 6.50),
(20, 'B-203', 'B', '2026-08-15', 370, 7.00),
(21, 'B-203', 'B', '2026-09-15', 390, 7.50),

(22, 'B-204', 'B', '2026-07-15', 90, 5.75),
(23, 'B-204', 'B', '2026-08-15', 110, 6.25),
(24, 'B-204', 'B', '2026-09-15', 130, 6.75),


-- WING C

(25, 'C-301', 'C', '2026-07-15', 400, 7.00),
(26, 'C-301', 'C', '2026-08-15', 420, 7.25),
(27, 'C-301', 'C', '2026-09-15', 450, 7.50),

(28, 'C-302', 'C', '2026-07-15', 160, 5.50),
(29, 'C-302', 'C', '2026-08-15', 180, 6.00),
(30, 'C-302', 'C', '2026-09-15', 200, 6.50),

(31, 'C-303', 'C', '2026-07-15', 260, 6.00),
(32, 'C-303', 'C', '2026-08-15', 280, 6.50),
(33, 'C-303', 'C', '2026-09-15', 300, 7.00),

(34, 'C-304', 'C', '2026-07-15', 310, 6.50),
(35, 'C-304', 'C', '2026-08-15', 330, 7.00),
(36, 'C-304', 'C', '2026-09-15', 350, 7.50);


--  MONTHLY FLAT BILL VIEW
-- VIEW NAME: v_monthly_flat_bill

CREATE OR REPLACE VIEW v_monthly_flat_bill AS
SELECT
    flat_no,
    wing,
    MONTH(reading_date) AS bill_month,
    units_kwh,
    ROUND(units_kwh * rate_per_unit, 2) AS bill_amount_inr
FROM meter_readings;


-- Check monthly bill view
SELECT * FROM v_monthly_flat_bill;

-- SIMPLE WING A VIEW
-- VIEW NAME: v_wing_a_readings

CREATE OR REPLACE VIEW v_wing_a_readings AS
SELECT *
FROM meter_readings
WHERE wing = 'A';


-- Check Wing A readings
SELECT * FROM v_wing_a_readings;


-- UPDATE THROUGH VIEW
-- Correct units for flat A-103 in September

UPDATE v_wing_a_readings
SET units_kwh = 200
WHERE reading_id = 9;


-- Check the updated record through the view
SELECT *
FROM v_wing_a_readings
WHERE reading_id = 9;


-- Verify the change in the original base table
SELECT *
FROM meter_readings
WHERE reading_id = 9;


-- Expected units_kwh: 200

--  CREATE WING SUMMARY DASHBOARD VIEW
-- VIEW NAME: v_wing_summary

CREATE OR REPLACE VIEW v_wing_summary AS
SELECT
    wing,
    SUM(units_kwh) AS total_units,
    ROUND(AVG(units_kwh * rate_per_unit), 2) AS average_bill_inr
FROM meter_readings
GROUP BY wing;


-- Check wing summary dashboard
SELECT * FROM v_wing_summary;


-- =========================================================
--  NON-UPDATABLE VIEW EXAMPLE
-- =========================================================

-- The following UPDATE is intentionally commented out.
-- Do NOT remove the comment and execute it.
--
-- UPDATE v_wing_summary
-- SET total_units = 5000
-- WHERE wing = 'A';
--
-- Expected MySQL Error: 1288
-- The target table v_wing_summary of the UPDATE is not updatable.
--
-- Reason:
-- This view uses GROUP BY, SUM() and AVG().
-- Aggregate views are not directly updatable.


-- =========================================================
-- FINAL VALIDATION
-- =========================================================

-- Check total readings
SELECT COUNT(*) AS total_readings
FROM meter_readings;

-- Expected: 36


-- Check number of flats
SELECT COUNT(DISTINCT flat_no) AS total_flats
FROM meter_readings;

-- Expected: 12


-- Check readings per wing
SELECT
    wing,
    COUNT(*) AS total_readings,
    COUNT(DISTINCT flat_no) AS total_flats
FROM meter_readings
GROUP BY wing
ORDER BY wing;


-- Check all three views exist
SHOW FULL TABLES
WHERE Table_type = 'VIEW';


-- SESSION 19

USE society_energy_db;


-- SET RECURSIVE CTE LIMIT

SET SESSION cte_max_recursion_depth = 100000;

DROP TABLE IF EXISTS meter_readings_big;

CREATE TABLE meter_readings_big (
    reading_id INT PRIMARY KEY,
    flat_no VARCHAR(10) NOT NULL,
    reading_date DATE NOT NULL,
    units_kwh INT NOT NULL
);


-- INSERT 100,000 ROWS USING RECURSIVE CTE

INSERT INTO meter_readings_big
    (reading_id, flat_no, reading_date, units_kwh)
WITH RECURSIVE numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 100000
)
SELECT
    n AS reading_id,

    CONCAT(
        CHAR(65 + (MOD(n, 200) DIV 50)),
        '-',
        101 + MOD(n, 50)
    ) AS flat_no,

    DATE_ADD(
        '2024-01-01',
        INTERVAL MOD(n - 1, 731) DAY
    ) AS reading_date,

    90 + MOD(n, 361) AS units_kwh

FROM numbers;


-- CHECK INSERTED DATA

SELECT COUNT(*) AS total_records
FROM meter_readings_big;

-- Expected: 100000


-- Check distinct flats
SELECT COUNT(DISTINCT flat_no) AS total_flats
FROM meter_readings_big;

-- Expected: 200


-- Check date range
SELECT
    MIN(reading_date) AS first_reading_date,
    MAX(reading_date) AS last_reading_date
FROM meter_readings_big;

-- Expected: 2024-01-01 to 2025-12-31


-- Check sample records
SELECT *
FROM meter_readings_big
LIMIT 10;

-- LOOKUP QUERY BEFORE INDEX

SELECT *
FROM meter_readings_big
WHERE flat_no = 'B-107';


-- EXPLAIN BEFORE INDEX

EXPLAIN
SELECT *
FROM meter_readings_big
WHERE flat_no = 'B-107';


-- CREATE INDEX ON flat_no


CREATE INDEX idx_flat_no
ON meter_readings_big (flat_no);


-- Refresh table statistics
ANALYZE TABLE meter_readings_big;


-- Run the same lookup query again

SELECT *
FROM meter_readings_big
WHERE flat_no = 'B-107';


-- EXPLAIN AFTER INDEX

EXPLAIN
SELECT *
FROM meter_readings_big
WHERE flat_no = 'B-107';


--  OCTOBER 2025 QUERY WITHOUT DATE INDEX


-- Query 1: Using YEAR() and MONTH()

SELECT *
FROM meter_readings_big
WHERE YEAR(reading_date) = 2025
  AND MONTH(reading_date) = 10;


-- EXPLAIN QUERY 1

EXPLAIN
SELECT *
FROM meter_readings_big
WHERE YEAR(reading_date) = 2025
  AND MONTH(reading_date) = 10;



-- CREATE INDEX ON reading_date


CREATE INDEX idx_reading_date
ON meter_readings_big (reading_date);


ANALYZE TABLE meter_readings_big;


-- OCTOBER 2025 QUERY USING DATE RANGE


-- Query 2: Using date range conditions

SELECT *
FROM meter_readings_big
WHERE reading_date >= '2025-10-01'
  AND reading_date < '2025-11-01';


-- EXPLAIN QUERY 2

EXPLAIN
SELECT *
FROM meter_readings_big
WHERE reading_date >= '2025-10-01'
  AND reading_date < '2025-11-01';


-- FINAL INDEX VALIDATION


-- Check all indexes on the table

SHOW INDEX
FROM meter_readings_big;


-- Check total records again

SELECT COUNT(*) AS total_records
FROM meter_readings_big;


-- Check October 2025 records

SELECT COUNT(*) AS october_2025_readings
FROM meter_readings_big
WHERE reading_date >= '2025-10-01'
  AND reading_date < '2025-11-01';


-- Check all four wings

SELECT
    LEFT(flat_no, 1) AS wing,
    COUNT(DISTINCT flat_no) AS total_flats,
    COUNT(*) AS total_readings
FROM meter_readings_big
GROUP BY LEFT(flat_no, 1)
ORDER BY wing;


