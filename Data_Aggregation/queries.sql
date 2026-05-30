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


--QUERY 4


--QUERY 5


--QUERY 6


--QUERY 7
