/* Top 10 Job Titles by Salary */

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

/*
This SQL code calculates the median, minimum, and maximum salaries for different job titles, then lists the top 10 job titles with the highest median salaries.

1. RankedSalaries CTE:
ROW_NUMBER() assigns a unique rank to each salary within each job title, sorted by salary.
COUNT() counts the total number of salaries for each job title.

2. Main Query:
Median Salary: The median is calculated by averaging the middle salary(s) using the rank. If there’s an odd number of salaries, it selects the middle one. If even, it averages the two middle values.
MIN and MAX Salaries: These return the lowest and highest salary for each job title.

3. Results:
The query groups by job title, orders by median salary in descending order, and limits the output to the top 10 job titles with the highest median salaries.

*/

/* 10 Lowest Paying Job Titles */

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

/*
This SQL code identifies the job titles with the lowest median salaries by calculating the median, minimum, and maximum salaries, and then lists the bottom 10 job titles.

1. RankedSalaries CTE:
ROW_NUMBER() assigns a rank to each salary within each job title, ordered by salary.
COUNT() calculates the total number of salaries for each job title.

2. Main Query:
Median Salary: The median is derived by selecting the middle salary(s) based on the rank. For an odd count, it picks the middle value; for even, it averages the two middle values.
MIN and MAX Salaries: These provide the lowest and highest salary for each job title.

3. Results:
The query groups the data by job title, orders it by median salary in ascending order, and returns the bottom 10 job titles with the lowest median salaries.

*/
