/*
    Description:
*/
-- QUERY 1
SELECT
    department_id,
    COUNT(id) AS employee_count
FROM employees
GROUP BY department_id
ORDER BY department_id;

--QUERY 2
SELECT
    department_id,
    COUNT(salary) AS employee_count
FROM employees
GROUP BY department_id
ORDER BY department_id;

-- QUERY 3
SELECT
    department_id,
    SUM(salary) AS total_salaries
FROM employees
GROUP BY department_id
ORDER BY department_id;

--QUERY 4
SELECT
    department_id,
    MAX(salary) AS total_salaries
FROM employees
GROUP BY department_id
ORDER BY department_id;

--QUERY 5
SELECT
    department_id,
    MIN(salary) AS total_salaries
FROM employees
GROUP BY department_id
ORDER BY department_id;

--QUERY 6
SELECT
    department_id,
    AVG(salary) AS total_salaries
FROM employees
GROUP BY department_id
ORDER BY department_id;

--QUERY 7
SELECT
    department_id,
    SUM(salary) AS "Total Salary"
FROM employees
GROUP BY department_id
HAVING "Total Salary" < 4200
ORDER BY department_id;

--QUERY 8