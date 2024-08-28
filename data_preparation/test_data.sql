/* After cleaning the data, the number of rows is 10,113. */

SELECT COUNT(*) AS no_of_rows
FROM data_salaries;

/* After data cleaning, there are 10 columns remaining. */

SELECT COUNT(*) AS column_count 
FROM information_schema.columns
WHERE TABLE_NAME = 'data_salaries';

/* Data Types for Each Column */ 

SELECT COLUMN_NAME, DATA_TYPE 
FROM information_schema.columns
WHERE TABLE_NAME = 'data_salaries';
