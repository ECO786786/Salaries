/*
Salaries by Work Arrangement
*/
WITH RankedSalaries AS (
    SELECT 
        remote_ratio,
        salary_in_usd,
        ROW_NUMBER() OVER (PARTITION BY remote_ratio ORDER BY salary_in_usd) AS rn,
        COUNT(*) OVER (PARTITION BY remote_ratio) AS cnt
    FROM 
        data_salaries
)
SELECT 
    remote_ratio,
    ROUND(AVG(salary_in_usd), 2) AS median_salary,
    MIN(salary_in_usd) AS min_salary,
    MAX(salary_in_usd) AS max_salary
FROM 
    RankedSalaries
WHERE 
    -- Select the middle value(s) depending on odd/even count of salaries
    rn IN ((cnt + 1) / 2, (cnt + 2) / 2)
GROUP BY 
    remote_ratio
ORDER BY 
    median_salary DESC;
