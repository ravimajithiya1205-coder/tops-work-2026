-- =========================================================
-- FILE: recharge_new_rows.sql
-- DATABASE: recharge_usage_db
-- PURPOSE: Insert 20 new prepaid subscribers (S0201-S0220)
-- =========================================================

USE recharge_usage_db;

-- Check existing row count before insertion
SELECT COUNT(*) AS records_before
FROM subscribers;

-- Insert 20 new subscribers
INSERT INTO subscribers
    (subscriber_id, circle, plan_inr, data_gb_used, recharge_date, churned)
VALUES
('S0201', 'Gujarat',      149, 12.5, '2026-07-03', 0),
('S0202', 'Gujarat',      239, 28.4, '2026-07-12', 0),
('S0203', 'Gujarat',      299, 35.7, '2026-08-05', 1),
('S0204', 'Gujarat',      479, 42.1, '2026-09-18', 0),
('S0205', 'Gujarat',      719, 55.2, '2026-10-21', 0),

('S0206', 'Maharashtra',  149,  8.6, '2026-07-08', 1),
('S0207', 'Maharashtra',  239, 19.3, '2026-07-26', 0),
('S0208', 'Maharashtra',  299, 31.8, '2026-08-14', 0),
('S0209', 'Maharashtra',  479, 46.5, '2026-09-09', 0),
('S0210', 'Maharashtra',  719, 58.7, '2026-10-29', 1),

('S0211', 'Rajasthan',    149,  5.4, '2026-07-17', 0),
('S0212', 'Rajasthan',    239, 22.6, '2026-08-02', 0),
('S0213', 'Rajasthan',    299, 34.9, '2026-08-27', 1),
('S0214', 'Rajasthan',    479, 40.3, '2026-09-22', 0),
('S0215', 'Rajasthan',    719, 53.8, '2026-10-11', 0),

('S0216', 'MP',            149,  0.8, '2026-07-21', 1),
('S0217', 'MP',            239, 17.2, '2026-08-11', 0),
('S0218', 'MP',            299, 29.5, '2026-09-03', 0),
('S0219', 'MP',            479, 44.7, '2026-09-30', 0),
('S0220', 'MP',            719, 59.6, '2026-10-25', 1);

-- Confirm exactly 20 new IDs are present
SELECT COUNT(*) AS inserted_subscribers
FROM subscribers
WHERE subscriber_id BETWEEN 'S0201' AND 'S0220';

-- Confirm final total (expected 220 if the original 200 remain)
SELECT COUNT(*) AS total_subscribers
FROM subscribers;
