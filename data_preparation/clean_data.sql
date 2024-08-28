/*
    Detect duplicate rows
*/

SELECT *
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY work_year, experience_level, employment_type, job_title, salary, salary_currency, salary_in_usd, 
                         employee_residence, remote_ratio, company_location, company_size 
            ORDER BY 
                work_year, experience_level, employment_type, job_title, salary, salary_currency, salary_in_usd, 
                employee_residence, remote_ratio, company_location, company_size
        ) AS rn
    FROM  
        data_salaries
) subquery
WHERE 
    rn > 1;

/*
   Remove duplicate rows
*/

WITH CTE AS (
    SELECT 
        ctid,
        ROW_NUMBER() OVER (
            PARTITION BY work_year, experience_level, employment_type, job_title, salary, salary_currency, salary_in_usd, 
                         employee_residence, remote_ratio, company_location, company_size 
            ORDER BY 
                work_year, experience_level, employment_type, job_title, salary, salary_currency, salary_in_usd, 
                employee_residence, remote_ratio, company_location, company_size
        ) AS rn
    FROM 
        data_salaries
)
DELETE FROM data_salaries
WHERE ctid IN (
    SELECT ctid
    FROM CTE
    WHERE rn > 1
);

/* Check for Null Values: Ensure that all columns contain no null values. */

SELECT COUNT(work_year) AS work_year
FROM data_salaries
WHERE work_year IS NULL;

SELECT COUNT(experience_level) AS experience_level
FROM data_salaries
WHERE experience_level IS NULL;

SELECT COUNT(employment_type) AS employment_type
FROM data_salaries
WHERE employment_type IS NULL;

SELECT COUNT(job_title) AS job_title 
FROM data_salaries
WHERE job_title IS NULL;

SELECT COUNT(salary) AS job_title 
FROM data_salaries
WHERE salary IS NULL;

SELECT COUNT(salary_currency) AS job_title 
FROM data_salaries
WHERE salary_currency IS NULL;

SELECT COUNT(salary_in_usd) AS job_title 
FROM data_salaries
WHERE salary_in_usd IS NULL;

SELECT COUNT(employee_residence) AS job_title 
FROM data_salaries
WHERE employee_residence IS NULL;

SELECT COUNT(remote_ratio) AS job_title 
FROM data_salaries
WHERE remote_ratio IS NULL;

SELECT COUNT(company_location) AS job_title 
FROM data_salaries
WHERE company_location IS NULL;

SELECT COUNT(company_size) AS job_title 
FROM data_salaries
WHERE company_size IS NULL;

/* 
   Inconsistent Format: To streamline the data, I plan to consolidate all salary values into a single currency by removing the salary and salary_currency columns. This will make the dataset more consistent and easier to work with. 
*/ 

ALTER TABLE data_salaries
DROP COLUMN salary;

ALTER TABLE data_salaries
DROP COLUMN salary_currency;


