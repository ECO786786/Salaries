/*
	Impact of Remote Work on Salaries
*/

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

/*

This SQL code calculates the median, minimum, and maximum salaries for different experience levels, then orders the experience levels by median salary in descending order. Here's a concise explanation:

1. RankedSalaries CTE:

Ranking Salaries: For each experience_level, salaries are ranked using ROW_NUMBER(), ordered by salary in ascending order.

Counting Salaries: The total number of salaries for each experience level is calculated using COUNT().

2. Main Query:

Median Salary Calculation:

If the count of salaries (cnt) is odd, it selects the middle salary.
If the count is even, it averages the two middle salaries.

MIN and MAX Salaries: These functions return the lowest and highest salaries for each experience level.
Grouping: The results are grouped by experience_level, so each group represents a different level of experience.

Ordering: The experience levels are ordered by median salary in descending order to list the highest-paying experience levels first.

*/
