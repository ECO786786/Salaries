-- Salary by Job Title
WITH RankedSalaries AS (
    SELECT 
        job_title,
        salary_in_usd,
        ROW_NUMBER() OVER (PARTITION BY job_title ORDER BY salary_in_usd) AS rn,
        COUNT(*) OVER (PARTITION BY job_title) AS cnt
    FROM 
        data_salaries
)
SELECT 
    job_title,
	COUNT(job_title),
    ROUND(AVG(salary_in_usd), 2) AS median_salary,
    MIN(salary_in_usd) AS min_salary,
    MAX(salary_in_usd) AS max_salary
FROM 
    RankedSalaries
WHERE 
    -- Select the middle value(s) depending on odd/even count of salaries
    rn IN ((cnt + 1) / 2, (cnt + 2) / 2)
GROUP BY 
    job_title
ORDER BY 
    median_salary DESC
LIMIT 10;
