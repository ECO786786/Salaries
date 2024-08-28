/*
	Employment type 
*/

WITH RankedSalaries AS (
    SELECT 
        employment_type,
        salary_in_usd,
        ROW_NUMBER() OVER (PARTITION BY employment_type ORDER BY salary_in_usd) AS rn,
        COUNT(*) OVER (PARTITION BY employment_type) AS cnt
    FROM 
        data_salaries
)
SELECT 
    employment_type,
    ROUND(AVG(salary_in_usd), 2) AS median_salary,
    MIN(salary_in_usd) AS min_salary,
    MAX(salary_in_usd) AS max_salary
FROM 
    RankedSalaries
WHERE 
    -- Select the middle value(s) depending on odd/even count of salaries
    rn IN ((cnt + 1) / 2, (cnt + 2) / 2)
GROUP BY 
    employment_type
ORDER BY 
    median_salary DESC;

/*

This SQL code calculates the median, minimum, and maximum salaries for different employment types, then orders the results by median salary in descending order. Here's a concise explanation:

1. RankedSalaries CTE:

Ranking Salaries: Salaries are ranked within each employment_type using ROW_NUMBER(), sorted in ascending order.

Counting Salaries: The total number of salaries for each employment type is counted using COUNT().

2. Main Query:

Median Salary Calculation:

For an odd number of salaries, it selects the middle salary.

For an even number of salaries, it averages the two middle salaries to get the median.

MIN and MAX Salaries: The lowest and highest salaries are retrieved for each employment type.

Grouping: The results are grouped by employment_type, summarising salary data for each type.

Ordering: The results are ordered by median salary in descending order to highlight the highest paying employment types.

*/
