# Analysing factors influencing data professional salaries from 2020 to 2024

## Background

The technology industry has seen rapid changes in employment trends, especially with the rise of remote work and changes in company sizes. Understanding the factors that influence salaries for data professionals can help companies attract and retain talent, and it can also help professionals make informed career decisions.

## Data Source

The dataset was obtained from [Kaggle](https://www.kaggle.com/datasets/chopper53/data-engineer-salary-in-2024/data).

## Problem Statement

How do job titles, experience levels, employment types, remote work ratios, company locations, and company sizes influence the salaries of data professionals from 2020 to 2024?

## Objectives

1. Salary distribution: Analyse the distribution of salaries across different job titles and experience levels.

2. Remote work impact: Investigate how the ratio of remote work affects salary levels.

3. Employment type analysis: Examine the differences in salaries based on employment types (full-time, part-time, contract, etc.).

4. Geographical impact: Study how the location of the employee and the company influences salary.

5. Company size effect: Evaluate the impact of company size on the salary of data professionals.

## Data Metrics

- work_year: Year of data collection (e.g. 2024).

- experience_level: Employee experience level (EX: Executives, SE: Senior, MI: Mid-Level, EL: Entry-Level).

- employment_type: Employment type (FT: Full-time, PT: Part-time, C: Contract, F: Freelance).

- job_title: Employee's job title (e.g. AI Engineer).

- salary: Employee's salary in local currency (e.g. 202,730 USD).

- salary_currency: Currency of the salary (e.g. USD).

- salary_in_usd: Salary converted to USD for standardisation.

- employee_residence: Employee's country of residence.

- remote_ratio: Remote work ratio (0: In-office, 50: Hybrid, 100: Fully remote).

- company_location: Company's location.

- company_size: Company size by employees (S: Small, M: Medium, L: Large).

## Tools Used

- PostgreSQL: Used to query the data jobs dataset and uncover key insights. SQL queries are located in the [sql_questions folder](/sql_questions/).

- PowerBI: Used to visualise the datasets and provide interactive reports and dashboards.

## Salary Analysis Insights

![job salary dashboard](assets/data_jobs_salary.pdf)

### 1. Top Median Salaries by Role

- Analytical Engineering Manager: Highest median salary at $399,880.00, likely due to the role's newness and limited data. Such specialised roles often command higher pay.

- Other High Earning Roles: Data Science Tech Lead ($375,000.00) and Head of Machine Learning ($330,000.00) are also top earners, reflecting the high responsibility and expertise required.

### 2. Lowest Median Salaries by Role

- Principal Data Architect: Surprisingly low median salary at $38,154.00, potentially due to location outside the US.

- CRM Data Analyst: Median salary of $40,000.00, typical of analyst roles that generally offer lower pay.

### 3. Salaries by Experience Level

- Executives (EX): Median salary is $192,000.00.

- Entry-Level (EN): Lowest median salary at $80,769.00.

- Salaries increase predictably with experience.

### 4. Salaries by Work Arrangement

- Office Workers: Highest median salary at $140,100.00.

- Remote Workers: Competitive median salary at $137,785.50.

- Hybrid Workers: Lowest median salary at $66,022.00.

### 5. Country-Specific Insights

- US: Leads with a median salary of $147,500.00, reflecting its strong tech market.

- Canada: Close second at $137,665.00.

- Australia: Median salary at $105,600.00, Germany at $79,425.00, showing regional disparities.

### 6. Company Size and Salaries

- Medium Sized Companies: Highest median salary at $140,250.00.

- Large Companies: $108,000.00.

- Small Companies: $72,000.00, reflecting limited resources.

### 7. Salaries by Employment Type

- Full-Time Employees: Highest median salary at $139,152.00.

- Freelancers: Lowest median at $47,777.50, due to work variability.

### 8. Impact of Outliers

- Outliers, such as Qatar's initial highest salary, were addressed by focusing on countries with more participants, providing a clearer salary landscape.

## Recommendations

### 1. For Employers:

- Attracting Top Talent: To attract top talent, especially in emerging and specialised roles like Analytical Engineering Manager, consider offering competitive salaries that reflect the scarcity of expertise in these areas.

- Compensation Packages: Ensure that compensation packages for remote and hybrid roles remain competitive, as these work arrangements are increasingly in demand and can help attract a wider pool of candidates.

- Geographic Salary Adjustments: Consider adjusting salaries based on location to remain competitive globally. For example, offering higher salaries in regions like the US and Canada where median pay is already high can help attract and retain top talent.

- Support for Growth: For companies with smaller budgets, focus on offering other forms of value, such as career growth opportunities, flexible work environments, and strong company culture, to compensate for lower salaries.

### 2. For Job Seekers:

- Target High Paying Markets: If possible, aim to work in high paying markets like the US or Canada, especially in specialised roles or sectors where your skills are in high demand.

- Consider Experience Level: As salaries increase significantly with experience, focus on building your expertise and advancing your career to achieve higher compensation over time.

- Evaluate Work Arrangements: Weigh the benefits of different work arrangements. While office roles currently offer higher median pay, remote work may offer other benefits like work life balance, which could be more valuable depending on your priorities.

- Negotiating Salary: When negotiating salary, consider the median salaries for your role, experience level, and location to ensure you are being compensated fairly.

### 3. For Policy Makers and Educators:

- Address Salary Disparities: Consider policies that address salary disparities across regions and roles, especially for critical positions that are underpaid despite their importance.

- Support for Emerging Roles: Invest in training programs and education to increase the supply of skilled workers in emerging fields, which can help stabilise salaries and fill talent gaps.

- Promote Career Advancement: Encourage continuous professional development to help workers move up the salary ladder, contributing to a more skilled and competitive workforce.
