-- Top 10 Salary by Job Title  
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

-- Bottom 10 Salary by Job Title  
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
    median_salary ASC
LIMIT 10;

-- Summary Statistics for Salary by Experience Level
SELECT 
    experience_level,
    ROUND(AVG(salary_in_usd),2) AS avg_salary,
    MIN(salary_in_usd) AS min_salary,
    MAX(salary_in_usd) AS max_salary
FROM data_salaries
GROUP BY experience_level
ORDER BY avg_salary DESC;
-- 2nd edition 
WITH RankedSalaries AS (
    SELECT 
        experience_level,
        salary_in_usd,
        ROW_NUMBER() OVER (PARTITION BY experience_level ORDER BY salary_in_usd) AS rn,
        COUNT(*) OVER (PARTITION BY experience_level) AS cnt
    FROM 
        data_salaries
)
SELECT 
    experience_level,
    ROUND(AVG(salary_in_usd), 2) AS median_salary,
    MIN(salary_in_usd) AS min_salary,
    MAX(salary_in_usd) AS max_salary
FROM 
    RankedSalaries
WHERE 
    -- Select the middle value(s) depending on odd/even count of salaries
    rn IN ((cnt + 1) / 2, (cnt + 2) / 2)
GROUP BY 
    experience_level
ORDER BY 
    median_salary DESC;

-- Impact of Remote Work on Salaries
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

-- 
WITH salary_stats AS (
    SELECT
        employee_residence,
        salary_in_usd,
        COUNT(*) OVER (PARTITION BY employee_residence) AS num_employees,
        ROUND(AVG(salary_in_usd) OVER (PARTITION BY employee_residence), 2) AS avg_salary,
        MIN(salary_in_usd) OVER (PARTITION BY employee_residence) AS min_salary,
        MAX(salary_in_usd) OVER (PARTITION BY employee_residence) AS max_salary,
        ROW_NUMBER() OVER (PARTITION BY employee_residence ORDER BY salary_in_usd) AS rn,
        COUNT(*) OVER (PARTITION BY employee_residence) AS total_count
    FROM data_salaries
    WHERE employee_residence = company_location
),
median_calc AS (
    SELECT
        employee_residence,
        num_employees,
        avg_salary,
        min_salary,
        max_salary,
        ROUND(
            CASE 
                WHEN total_count % 2 = 0 THEN 
                    (SELECT AVG(salary_in_usd) 
                     FROM salary_stats 
                     WHERE rn IN (total_count / 2, total_count / 2 + 1) 
                     AND employee_residence = s.employee_residence)
                ELSE 
                    (SELECT salary_in_usd 
                     FROM salary_stats 
                     WHERE rn = (total_count + 1) / 2 
                     AND employee_residence = s.employee_residence)
            END, 2
        ) AS median_salary
    FROM salary_stats s
    GROUP BY employee_residence, num_employees, avg_salary, min_salary, max_salary, total_count
),
top_10_residences AS (
    SELECT
        employee_residence,
        num_employees,
        avg_salary,
        min_salary,
        max_salary,
        median_salary
    FROM median_calc
    ORDER BY num_employees DESC
    LIMIT 10
)
SELECT
    employee_residence,
    num_employees,
    avg_salary,
    min_salary,
    max_salary,
    median_salary
FROM top_10_residences
ORDER BY avg_salary DESC;
