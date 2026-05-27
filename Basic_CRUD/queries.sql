SELECT
    id,
    first_name || ' ' || last_name AS "Full Name",
    job_title AS "Job Title"
FROM employees;

SELECT
    id,
    first_name || ' ' || last_name AS full_name,
    job_title,
    salary
FROM employees
WHERE salary > 1000
ORDER BY id;