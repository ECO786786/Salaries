/*
    Company Size and Salary Correlation
*/

WITH RankedSalaries AS (
    SELECT 
        company_size,
        salary_in_usd,
        ROW_NUMBER() OVER (PARTITION BY company_size ORDER BY salary_in_usd) AS rn,
        COUNT(*) OVER (PARTITION BY company_size) AS cnt
    FROM 
        data_salaries
)
SELECT 
    company_size,
    ROUND(AVG(salary_in_usd), 2) AS median_salary,
    MIN(salary_in_usd) AS min_salary,
    MAX(salary_in_usd) AS max_salary
FROM 
    RankedSalaries
WHERE 
    -- Select the middle value(s) depending on odd/even count of salaries
    rn IN ((cnt + 1) / 2, (cnt + 2) / 2)
GROUP BY 
    company_size
ORDER BY 
    median_salary DESC;

/*

This SQL code calculates the median, minimum, and maximum salaries for different company sizes, then orders the results by median salary in descending order. Here's a concise explanation:

1. RankedSalaries CTE:
Ranking Salaries: Within each company_size, salaries are ranked using ROW_NUMBER(), sorted in ascending order.

Counting Salaries: The total number of salaries for each company size is counted using COUNT().

2. Main Query:

Median Salary Calculation:
For odd counts of salaries, it selects the middle salary.
For even counts, it averages the two middle salaries to determine the median.

MIN and MAX Salaries: These functions return the lowest and highest salaries for each company size.

Grouping: The results are grouped by company_size to summarize the salary data for each company size category.

Ordering: The query orders the company sizes by median salary in descending order, showing the highest-paying company sizes first.

*/
