CREATE DATABASE hr_analytics;
-- ============================================================
-- PROJECT: HR EMPLOYEE ATTRITION & WORKFORCE ANALYTICS
-- TABLE: hr_employees
-- DATASET SIZE: 1,240 employee records
-- PURPOSE: Analyse employee attrition and workforce patterns
-- ============================================================

USE hr_analytics;

-- 1. DATA EXPLORATION

-- Business Question:
-- How many employee records are available?

SELECT COUNT(*) AS total_employees
FROM hr_employees;

-- Finding:
-- The dataset contains 1,240 employee records.


-- Business Question:
-- What does the employee data look like?

SELECT *
FROM hr_employees
LIMIT 5;

-- Finding:
-- The table contains employee details such as department,
-- salary, satisfaction, tenure and attrition.


-- Business Question:
-- What are the columns and their data types?

DESCRIBE hr_employees;


-- Business Question:
-- How many employees stayed and how many left?

SELECT
    attrition,
    COUNT(*) AS employee_count,
    ROUND(COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM hr_employees), 2) AS percentage
FROM hr_employees
GROUP BY attrition;

-- Finding:
-- 1,063 employees stayed and 177 employees left.
-- Overall attrition is approximately 14.27%.


-- 2. DEPARTMENT ANALYSIS

-- Business Question:
-- Which departments have the most employee exits?

SELECT
    department,
    COUNT(*) AS employees_left
FROM hr_employees
WHERE attrition = 'Yes'
GROUP BY department
ORDER BY employees_left DESC;

-- Finding:
-- Sales has the highest number of exits (60),
-- followed by Operations (46) and Engineering (36).


-- Business Question:
-- Which departments have the highest attrition rate?

SELECT
    department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        AS employees_left,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS attrition_rate
FROM hr_employees
GROUP BY department
ORDER BY attrition_rate DESC;

-- Finding:
-- Sales has the highest attrition rate at 23.72%.
-- HR has the lowest rate at 5.83%.


-- 3. EMPLOYEE ANALYSIS

-- Business Question:
-- Which employees have left the organisation?

SELECT
    employee_id,
    department,
    job_title,
    age,
    annual_salary_inr,
    satisfaction_score,
    exit_reason
FROM hr_employees
WHERE attrition = 'Yes'
ORDER BY department;

-- Finding:
-- This query helps review employee exits and
-- compare their department, salary and satisfaction.


-- Business Question:
-- How many employees have a satisfaction score below 3?

SELECT
    COUNT(*) AS low_satisfaction_employees
FROM hr_employees
WHERE satisfaction_score < 3;

-- Finding:
-- This identifies employees reporting lower satisfaction.
-- It does not mean all these employees will leave.


-- Business Question:
-- What is the average salary of employees?

SELECT
    ROUND(AVG(annual_salary_inr), 2) AS average_salary,
    MIN(annual_salary_inr) AS lowest_salary,
    MAX(annual_salary_inr) AS highest_salary
FROM hr_employees;

-- Finding:
-- This gives an overview of salary levels in the dataset.


-- Business Question:
-- Does average satisfaction differ between employees
-- who stayed and employees who left?

SELECT
    attrition,
    ROUND(AVG(satisfaction_score), 2) AS average_satisfaction
FROM hr_employees
GROUP BY attrition;

-- Finding:
-- Employees who stayed had an average satisfaction
-- score of 3.61, compared with 2.78 for employees who left.


-- 4. TENURE ANALYSIS

-- Business Question:
-- How can employees be grouped based on their tenure?

SELECT
    employee_id,
    department,
    tenure_years,
    CASE
        WHEN tenure_years < 2 THEN 'Less than 2 years'
        WHEN tenure_years < 5 THEN '2 to 5 years'
        ELSE 'More than 5 years'
    END AS tenure_group,
    attrition
FROM hr_employees
ORDER BY tenure_years;

-- Finding:
-- This groups employees by their years of service
-- and helps compare attrition across tenure groups.


-- 5. FILTERING DEPARTMENTS

-- Business Question:
-- Which departments have more than 20 employee exits?

SELECT
    department,
    COUNT(*) AS employees_left
FROM hr_employees
WHERE attrition = 'Yes'
GROUP BY department
HAVING COUNT(*) > 20
ORDER BY employees_left DESC;

-- Finding:
-- Sales, Operations and Engineering have more than
-- 20 employee exits each.


-- 6. SUBQUERY ANALYSIS

-- Business Question:
-- Which departments have an attrition rate higher
-- than the overall organisation's attrition rate?

SELECT
    department,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS attrition_rate
FROM hr_employees
GROUP BY department
HAVING
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
    * 100.0 / COUNT(*) >
    (
        SELECT COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hr_employees)
        FROM hr_employees
        WHERE attrition = 'Yes'
    )
ORDER BY attrition_rate DESC;

-- Finding:
-- This identifies departments performing worse than
-- the overall attrition rate of the organisation.


-- 7. CTE ANALYSIS

-- Business Question:
-- Can we compare employee count and exits across departments
-- in one result?

WITH department_summary AS (
    SELECT
        department,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
            AS employees_left
    FROM hr_employees
    GROUP BY department
)
SELECT
    department,
    total_employees,
    employees_left,
    ROUND(employees_left * 100.0 / total_employees, 2)
        AS attrition_rate
FROM department_summary
ORDER BY attrition_rate DESC;

-- Finding:
-- The CTE makes department-level workforce analysis
-- easier to read and reuse.


-- 8. WINDOW FUNCTION

-- Business Question:
-- How do departments rank based on their attrition rate?

WITH department_summary AS (
    SELECT
        department,
        ROUND(
            SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
            * 100.0 / COUNT(*), 2
        ) AS attrition_rate
    FROM hr_employees
    GROUP BY department
)
SELECT
    department,
    attrition_rate,
    RANK() OVER (ORDER BY attrition_rate DESC)
        AS attrition_rank
FROM department_summary;

-- Finding:
-- Sales ranks first because it has the highest
-- department attrition rate.


-- 9. EXIT REASON ANALYSIS

-- Business Question:
-- What are the main reasons employees leave?

SELECT
    exit_reason,
    COUNT(*) AS employee_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM hr_employees
         WHERE attrition = 'Yes'), 2
    ) AS percentage
FROM hr_employees
WHERE attrition = 'Yes'
GROUP BY exit_reason
ORDER BY employee_count DESC;

-- Finding:
-- Better compensation is the most common exit reason,
-- followed by limited growth and work-life balance.


-- 10. DATA QUALITY CHECKS

-- Business Question:
-- Are there any duplicate employee IDs?

SELECT
    employee_id,
    COUNT(*) AS record_count
FROM hr_employees
GROUP BY employee_id
HAVING COUNT(*) > 1;

-- Finding:
-- No duplicate employee IDs were found.


-- Business Question:
-- Are there any exit dates earlier than hire dates?

SELECT *
FROM hr_employees
WHERE exit_date < hire_date;

-- Finding:
-- No invalid exit dates were found.


-- Business Question:
-- Are exit dates missing for employees who left?

SELECT COUNT(*) AS missing_exit_dates
FROM hr_employees
WHERE attrition = 'Yes'
AND exit_date IS NULL;

-- Finding:
-- Check the result. A value of 0 means all employees
-- marked as left have an exit date.


-- Business Question:
-- Are exit reasons missing for employees who left?

SELECT COUNT(*) AS missing_exit_reasons
FROM hr_employees
WHERE attrition = 'Yes'
AND exit_reason IS NULL;

CREATE DATABASE hr_analytics;


-- ============================================================
-- PROJECT: HR EMPLOYEE ATTRITION & WORKFORCE ANALYTICS
-- TOOL: MySQL 8.0
-- TABLE: hr_employees
-- DATASET SIZE: 1,240 employee records
-- PURPOSE: Analyse employee attrition and workforce patterns
-- ============================================================

USE hr_analytics;

-- 1. DATA EXPLORATION

-- Business Question:
-- How many employee records are available?

SELECT COUNT(*) AS total_employees
FROM hr_employees;

-- Finding:
-- The dataset contains 1,240 employee records.


-- Business Question:
-- What does the employee data look like?

SELECT *
FROM hr_employees
LIMIT 5;

-- Finding:
-- The table contains employee details such as department,
-- salary, satisfaction, tenure and attrition.


-- Business Question:
-- What are the columns and their data types?

DESCRIBE hr_employees;


-- Business Question:
-- How many employees stayed and how many left?

SELECT
    attrition,
    COUNT(*) AS employee_count,
    ROUND(COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM hr_employees), 2) AS percentage
FROM hr_employees
GROUP BY attrition;

-- Finding:
-- 1,063 employees stayed and 177 employees left.
-- Overall attrition is approximately 14.27%.


-- 2. DEPARTMENT ANALYSIS

-- Business Question:
-- Which departments have the most employee exits?

SELECT
    department,
    COUNT(*) AS employees_left
FROM hr_employees
WHERE attrition = 'Yes'
GROUP BY department
ORDER BY employees_left DESC;

-- Finding:
-- Sales has the highest number of exits (60),
-- followed by Operations (46) and Engineering (36).


-- Business Question:
-- Which departments have the highest attrition rate?

SELECT
    department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        AS employees_left,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS attrition_rate
FROM hr_employees
GROUP BY department
ORDER BY attrition_rate DESC;

-- Finding:
-- Sales has the highest attrition rate at 23.72%.
-- HR has the lowest rate at 5.83%.


-- 3. EMPLOYEE ANALYSIS

-- Business Question:
-- Which employees have left the organisation?

SELECT
    employee_id,
    department,
    job_title,
    age,
    annual_salary_inr,
    satisfaction_score,
    exit_reason
FROM hr_employees
WHERE attrition = 'Yes'
ORDER BY department;

-- Finding:
-- This query helps review employee exits and
-- compare their department, salary and satisfaction.


-- Business Question:
-- How many employees have a satisfaction score below 3?

SELECT
    COUNT(*) AS low_satisfaction_employees
FROM hr_employees
WHERE satisfaction_score < 3;

-- Finding:
-- This identifies employees reporting lower satisfaction.
-- It does not mean all these employees will leave.


-- Business Question:
-- What is the average salary of employees?

SELECT
    ROUND(AVG(annual_salary_inr), 2) AS average_salary,
    MIN(annual_salary_inr) AS lowest_salary,
    MAX(annual_salary_inr) AS highest_salary
FROM hr_employees;

-- Finding:
-- This gives an overview of salary levels in the dataset.


-- Business Question:
-- Does average satisfaction differ between employees
-- who stayed and employees who left?

SELECT
    attrition,
    ROUND(AVG(satisfaction_score), 2) AS average_satisfaction
FROM hr_employees
GROUP BY attrition;

-- Finding:
-- Employees who stayed had an average satisfaction
-- score of 3.61, compared with 2.78 for employees who left.


-- 4. TENURE ANALYSIS

-- Business Question:
-- How can employees be grouped based on their tenure?

SELECT
    employee_id,
    department,
    tenure_years,
    CASE
        WHEN tenure_years < 2 THEN 'Less than 2 years'
        WHEN tenure_years < 5 THEN '2 to 5 years'
        ELSE 'More than 5 years'
    END AS tenure_group,
    attrition
FROM hr_employees
ORDER BY tenure_years;

-- Finding:
-- This groups employees by their years of service
-- and helps compare attrition across tenure groups.


-- 5. FILTERING DEPARTMENTS

-- Business Question:
-- Which departments have more than 20 employee exits?

SELECT
    department,
    COUNT(*) AS employees_left
FROM hr_employees
WHERE attrition = 'Yes'
GROUP BY department
HAVING COUNT(*) > 20
ORDER BY employees_left DESC;

-- Finding:
-- Sales, Operations and Engineering have more than
-- 20 employee exits each.


-- 6. SUBQUERY ANALYSIS

-- Business Question:
-- Which departments have an attrition rate higher
-- than the overall organisation's attrition rate?

SELECT
    department,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS attrition_rate
FROM hr_employees
GROUP BY department
HAVING
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
    * 100.0 / COUNT(*) >
    (
        SELECT COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hr_employees)
        FROM hr_employees
        WHERE attrition = 'Yes'
    )
ORDER BY attrition_rate DESC;

-- Finding:
-- This identifies departments performing worse than
-- the overall attrition rate of the organisation.


-- 7. CTE ANALYSIS

-- Business Question:
-- Can we compare employee count and exits across departments
-- in one result?

WITH department_summary AS (
    SELECT
        department,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
            AS employees_left
    FROM hr_employees
    GROUP BY department
)
SELECT
    department,
    total_employees,
    employees_left,
    ROUND(employees_left * 100.0 / total_employees, 2)
        AS attrition_rate
FROM department_summary
ORDER BY attrition_rate DESC;

-- Finding:
-- The CTE makes department-level workforce analysis
-- easier to read and reuse.


-- 8. WINDOW FUNCTION

-- Business Question:
-- How do departments rank based on their attrition rate?

WITH department_summary AS (
    SELECT
        department,
        ROUND(
            SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
            * 100.0 / COUNT(*), 2
        ) AS attrition_rate
    FROM hr_employees
    GROUP BY department
)
SELECT
    department,
    attrition_rate,
    RANK() OVER (ORDER BY attrition_rate DESC)
        AS attrition_rank
FROM department_summary;

-- Finding:
-- Sales ranks first because it has the highest
-- department attrition rate.


-- 9. EXIT REASON ANALYSIS

-- Business Question:
-- What are the main reasons employees leave?

SELECT
    exit_reason,
    COUNT(*) AS employee_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM hr_employees
         WHERE attrition = 'Yes'), 2
    ) AS percentage
FROM hr_employees
WHERE attrition = 'Yes'
GROUP BY exit_reason
ORDER BY employee_count DESC;

-- Finding:
-- Better compensation is the most common exit reason,
-- followed by limited growth and work-life balance.


-- 10. DATA QUALITY CHECKS

-- Business Question:
-- Are there any duplicate employee IDs?

SELECT
    employee_id,
    COUNT(*) AS record_count
FROM hr_employees
GROUP BY employee_id
HAVING COUNT(*) > 1;

-- Finding:
-- No duplicate employee IDs were found.


-- Business Question:
-- Are there any exit dates earlier than hire dates?

SELECT *
FROM hr_employees
WHERE exit_date < hire_date;

-- Finding:
-- No invalid exit dates were found.


-- Business Question:
-- Are exit dates missing for employees who left?

SELECT COUNT(*) AS missing_exit_dates
FROM hr_employees
WHERE attrition = 'Yes'
AND exit_date IS NULL;

-- Finding:
-- Check the result. A value of 0 means all employees
-- marked as left have an exit date.


-- Business Question:
-- Are exit reasons missing for employees who left?

SELECT COUNT(*) AS missing_exit_reasons
FROM hr_employees
WHERE attrition = 'Yes'
AND exit_reason IS NULL;

-- Finding:
-- Check the result to see whether exit reasons
-- are available for all employees who left.

