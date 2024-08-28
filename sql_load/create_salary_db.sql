CREATE TABLE data_salaries (
    id SERIAL PRIMARY KEY,
    work_year INTEGER,
    experience_level VARCHAR(2),
    employment_type VARCHAR(2),
    job_title VARCHAR(255),
    salary DECIMAL(10, 2), -- Salary in original currency
    salary_currency VARCHAR(3), -- Currency code (e.g., USD, EUR)
    salary_in_usd DECIMAL(10, 2), -- Salary converted to USD for consistency
    employee_residence VARCHAR(255),
    remote_ratio INTEGER,
    company_location VARCHAR(255),
    company_size VARCHAR(1)
);
