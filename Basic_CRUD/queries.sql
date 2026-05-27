-- QUERY 1
SELECT
    id,
    first_name || ' ' || last_name AS "Full Name",
    job_title AS "Job Title"
FROM employees;

-- QUERY 2
SELECT
    id,
    first_name || ' ' || last_name AS full_name,
    job_title,
    salary
FROM employees
WHERE salary > 1000
ORDER BY id;

-- QUERY 3
SELECT
    *
FROM employees
WHERE salary >= 1000 AND department_id = 4
ORDER BY id;

-- QUERY 4
INSERT INTO
    employees(first_name, last_name, job_title, department_id, salary)
VALUES
    ('Samantha', 'Young', 'Housekeeping', '4', '900'),
    ('Roger', 'Palmer', 'Waiter', '3', '928.33');

SELECT * from employees;

--QUERY 5
UPDATE
    employees
SET
    salary = salary + 100
WHERE job_title = 'Manager';

SELECT * from employees
WHERE job_title = 'Manager';