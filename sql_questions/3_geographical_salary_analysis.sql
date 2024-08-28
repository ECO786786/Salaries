/*
	Geographical Salary Analysis
*/

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
ORDER BY median_salary DESC;

/*

This SQL code calculates salary statistics (average, minimum, maximum, and median) for employees based on their residence and limits the results to the top 10 locations with the most employees. It then orders these locations by median salary in descending order. Here's a breakdown:

1. salary_stats CTE:

Calculates basic statistics: For each employee_residence, the code calculates the count of employees (num_employees), average salary (avg_salary), minimum salary (min_salary), maximum salary (max_salary), and ranks each salary within its location using ROW_NUMBER().

Filters by location: It only includes records where the employee's residence matches the company's location (employee_residence = company_location).

2. median_calc CTE:

Calculates the median salary:

If the count of salaries is even, it averages the two middle values.
If odd, it selects the exact middle value.
Groups by employee_residence to summarize the statistics, including the calculated median salary.

3. top_10_residences CTE:

Selects the top 10 locations with the highest number of employees (num_employees).
Orders these locations by num_employees in descending order to ensure the most populated locations are considered.

4. Final Query:

Retrieves the salary statistics (average, minimum, maximum, and median) for the top 10 locations.
Orders by median salary in descending order to show the locations with the highest median salary first.

*/
