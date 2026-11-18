
-- GYM MEMBERSHIP DATABASE

-- SESSION 17

CREATE DATABASE IF NOT EXISTS gym_membership_db;
USE gym_membership_db;

-- 1. MEMBERS TABLE
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100) NOT NULL
);

INSERT INTO members (member_id, member_name) VALUES
(1, 'Aarav Patel'),
(2, 'Riya Shah'),
(3, 'Krish Mehta'),
(4, 'Ananya Desai'),
(5, 'Dev Joshi'),
(6, 'Diya Trivedi'),
(7, 'Arjun Parmar'),
(8, 'Mira Patel'),
(9, 'Vivaan Shah'),
(10, 'Ishita Mehta'),
(11, 'Reyansh Desai'),
(12, 'Kiara Joshi'),
(13, 'Aditya Shah'),
(14, 'Saanvi Patel'),
(15, 'Kabir Mehta');


-- GYM ACTIVITY TABLE
CREATE TABLE gym_activity (
    member_id INT PRIMARY KEY,
    visits_last_30_days INT,
    monthly_fee_inr INT,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO gym_activity
(member_id, visits_last_30_days, monthly_fee_inr)
VALUES
(1,  2,  900),
(2,  0,  1100),
(3,  3,  1000),
(4,  5,  1300),
(5,  7,  1500),
(6,  8,  1200),
(7,  10, 1600),
(8,  12, 1750),
(9,  14, 1800),
(10, 16, 1900),
(11, 18, 2000),
(12, 20, 2200),
(13, 22, 2300),
(14, 25, 2400),
(15, 28, 2500);


-- MEMBER ENGAGEMENT USING CASE WHEN

SELECT
    member_id,
    visits_last_30_days,
    CASE
        WHEN visits_last_30_days >= 16 THEN 'Regular'
        WHEN visits_last_30_days BETWEEN 8 AND 15 THEN 'Occasional'
        ELSE 'Dormant'
    END AS engagement
FROM gym_activity
ORDER BY member_id;


--  MONTHLY FEE CATEGORIES

SELECT
    CASE
        WHEN monthly_fee_inr < 1200 THEN 'Basic'
        WHEN monthly_fee_inr BETWEEN 1200 AND 1799 THEN 'Standard'
        ELSE 'Premium'
    END AS fee_category,
    COUNT(*) AS total_members,
    SUM(monthly_fee_inr) AS total_fees_inr
FROM gym_activity
GROUP BY fee_category
ORDER BY
    CASE fee_category
        WHEN 'Basic' THEN 1
        WHEN 'Standard' THEN 2
        WHEN 'Premium' THEN 3
    END;

-- CHURN RISK ANALYSIS

SELECT
    m.member_name,
    ga.visits_last_30_days,
    CASE
        WHEN ga.visits_last_30_days < 4 THEN 'Churn Risk'
        WHEN ga.visits_last_30_days < 8 THEN 'Watch'
        ELSE 'Healthy'
    END AS risk_label
FROM members AS m
INNER JOIN gym_activity AS ga
    ON m.member_id = ga.member_id
ORDER BY ga.visits_last_30_days ASC;


-- VALIDATION CHECKS

-- Check that there are exactly 15 members and 15 activity rows
SELECT
    (SELECT COUNT(*) FROM members) AS total_members,
    (SELECT COUNT(*) FROM gym_activity) AS total_activity_rows;

-- Check that every member has one activity record
SELECT
    m.member_id,
    m.member_name,
    COUNT(ga.member_id) AS activity_records
FROM members AS m
LEFT JOIN gym_activity AS ga
    ON m.member_id = ga.member_id
GROUP BY m.member_id, m.member_name
ORDER BY m.member_id;

-- Confirm that all three risk labels appear
SELECT
    CASE
        WHEN visits_last_30_days < 4 THEN 'Churn Risk'
        WHEN visits_last_30_days < 8 THEN 'Watch'
        ELSE 'Healthy'
    END AS risk_label,
    COUNT(*) AS total_members
FROM gym_activity
GROUP BY risk_label;
