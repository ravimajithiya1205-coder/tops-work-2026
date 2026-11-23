-- =========================================================
-- FILE: recharge_export.sql
-- =========================================================

USE recharge_usage_db;

SELECT
    circle,
    plan_inr,
    COUNT(*) AS subscriber_count,
    ROUND(AVG(data_gb_used), 1) AS avg_data_gb_used
FROM subscribers
GROUP BY circle, plan_inr
ORDER BY
    CASE circle
        WHEN 'Gujarat' THEN 1
        WHEN 'Maharashtra' THEN 2
        WHEN 'Rajasthan' THEN 3
        WHEN 'MP' THEN 4
    END,
    plan_inr;

-- In MySQL Workbench:
-- Execute the SELECT, then right-click the Result Grid
-- and choose "Export Recordset to an External File".
-- Select CSV, include column names/header, and save as:
-- circle_plan_summary.csv
