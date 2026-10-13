
/*
===============================================================================
PROJECT: WORKFORCE INTELLIGENCE & EMPLOYEE ATTRITION ANALYTICS
MODULE: SQL BUSINESS ANALYSIS
PURPOSE: Analyze employee attrition, workforce composition, overtime patterns,
         job-role retention, and compensation by performance rating.

DATA SOURCE:
IBM HR Analytics Employee Attrition & Performance dataset
Cleaned dataset: HR_Employee_Attrition_Clean.csv

TOOLS:
MySQL / MySQL Workbench

BUSINESS OBJECTIVES:
1. Measure overall employee attrition.
2. Identify department and overtime groups with elevated attrition.
3. Compare attrition rates across job roles.
4. Determine which roles contribute most to employee exits.
5. Explore monthly income differences across performance ratings.

IMPORTANT:
- The script assumes the imported table is named `employees`.
- It assumes the database is named `Workforce_Intelligence`.
- If your existing table is in another database, change the USE statement
  to your actual database name.
- The script only reads data; it does not update or delete employee records.
===============================================================================
*/


-- ============================================================================
-- 1. DATABASE SELECTION
-- ============================================================================

-- Create the database if it does not already exist.
CREATE DATABASE IF NOT EXISTS Workforce_Intelligence;

-- Select the database containing the employees table.
USE Workforce_Intelligence;


/*
If the employees table is stored in a different database, select that database
instead. Do not import the CSV again if the table already exists there.
*/


-- ============================================================================
-- 2. DATA VALIDATION
-- BUSINESS QUESTION: Does the imported table contain the expected data?
-- ============================================================================

-- 2.1 Check the total number of employee records.
SELECT
    COUNT(*) AS total_employees
FROM employees;


-- 2.2 Check for missing employee identifiers.
SELECT
    COUNT(*) AS missing_employee_ids
FROM employees
WHERE EmployeeNumber IS NULL;


-- 2.3 Check for duplicate employee identifiers.
SELECT
    EmployeeNumber,
    COUNT(*) AS record_count
FROM employees
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;


-- 2.4 Check for missing values in important analytical fields.
SELECT
    SUM(CASE WHEN Attrition IS NULL THEN 1 ELSE 0 END)
        AS missing_attrition,
    SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END)
        AS missing_department,
    SUM(CASE WHEN JobRole IS NULL THEN 1 ELSE 0 END)
        AS missing_job_role,
    SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END)
        AS missing_monthly_income,
    SUM(CASE WHEN OverTime IS NULL THEN 1 ELSE 0 END)
        AS missing_overtime
FROM employees;


/*
INTERPRETATION:
The cleaned dataset is expected to contain 1,470 employee records.
The missing-ID, duplicate-ID, and missing-field checks should return no
identified data-quality issues, based on the earlier Python validation.
*/


-- ============================================================================
-- 3. OVERALL ATTRITION ANALYSIS
-- BUSINESS QUESTION: How many employees left, and what is the attrition rate?
-- ============================================================================

SELECT
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    SUM(
        CASE
            WHEN Attrition = 'No' THEN 1
            ELSE 0
        END
    ) AS active_employees,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percent

FROM employees;


/*
EXPECTED RESULT:
Total employees: 1,470
Employees who left: 237
Active employees: 1,233
Attrition rate: approximately 16.12%

BUSINESS INTERPRETATION:
This establishes the baseline attrition rate against which workforce
segments can be compared.
*/


-- ============================================================================
-- 4. ATTRITION BY DEPARTMENT AND OVERTIME
-- BUSINESS QUESTION: Which department-overtime groups have higher attrition?
-- ============================================================================

SELECT
    Department,
    OverTime,

    COUNT(*) AS employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percent

FROM employees

GROUP BY
    Department,
    OverTime

ORDER BY
    attrition_rate_percent DESC,
    employees_left DESC;


/*
BUSINESS INTERPRETATION:
Compare overtime and non-overtime groups within each department.
Higher observed attrition among overtime employees can justify reviewing
workload, staffing, and scheduling.

LIMITATION:
These are observational associations. The results do not establish that
overtime directly causes employees to leave.
*/


-- ============================================================================
-- 5. ATTRITION BY JOB ROLE
-- BUSINESS QUESTION: Which job roles have the highest attrition rates?
-- ============================================================================

SELECT
    JobRole,

    COUNT(*) AS employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percent

FROM employees

GROUP BY JobRole

ORDER BY
    attrition_rate_percent DESC,
    employees_left DESC;


/*
BUSINESS INTERPRETATION:
This analysis highlights job roles that may need further retention analysis.
Consider both attrition rate and employee count when prioritizing roles:
a high rate in a small group and a large number of exits in a large group
represent different workforce challenges.
*/


-- ============================================================================
-- 6. SHARE OF TOTAL EMPLOYEE EXITS BY JOB ROLE
-- BUSINESS QUESTION: Which roles account for the largest share of all exits?
-- ============================================================================

SELECT
    JobRole,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / NULLIF(
            SUM(
                CASE
                    WHEN Attrition = 'Yes' THEN 1
                    ELSE 0
                END
            ) OVER (),
            0
        ),
        2
    ) AS share_of_total_exits_percent

FROM employees

GROUP BY JobRole

ORDER BY employees_left DESC;


/*
BUSINESS INTERPRETATION:
This identifies which roles contribute most to the total number of exits.
It complements the attrition-rate analysis: a role can have a high exit
rate without accounting for the largest number of departures.
*/


-- ============================================================================
-- 7. PERFORMANCE RATING AND MONTHLY INCOME
-- BUSINESS QUESTION: How does monthly income vary by performance rating?
-- ============================================================================

SELECT
    PerformanceRating,

    COUNT(*) AS employees,

    ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income,

    MIN(MonthlyIncome) AS min_monthly_income,

    MAX(MonthlyIncome) AS max_monthly_income

FROM employees

GROUP BY PerformanceRating

ORDER BY PerformanceRating;


/*
BUSINESS INTERPRETATION:
Compare average monthly income and income ranges across performance ratings.

LIMITATION:
Differences in average income do not establish whether employees are
underpaid or overpaid. Job level, job role, experience, and other factors
should be considered before drawing compensation conclusions.
*/


-- ============================================================================
-- 8. FINAL PROJECT RECONCILIATION
-- BUSINESS QUESTION: Do the main workforce totals match the expected values?
-- ============================================================================

SELECT
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    SUM(
        CASE
            WHEN Attrition = 'No' THEN 1
            ELSE 0
        END
    ) AS active_employees,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS attrition_rate_percent

FROM employees;


/*
FINAL DELIVERABLE:
This script documents the data validation checks and five core business
analyses used in the Workforce Intelligence & Employee Attrition Analytics
project.

Use the findings alongside the Python EDA and Power BI dashboard.
Ensure all reported values are verified against the actual query results.
*/
