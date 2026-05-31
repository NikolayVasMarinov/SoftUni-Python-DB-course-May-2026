/*
    Description:
*/
--QUERY 1
SELECT
    COUNT(id)
FROM wizard_deposits;

--QUERY 2
SELECT
    SUM(deposit_amount)
FROM wizard_deposits;

--QUERY 3
SELECT
    ROUND(AVG(magic_wand_size), 3)
FROM wizard_deposits;

--QUERY 4
SELECT
    MIN(deposit_charge)
FROM wizard_deposits;

--QUERY 5
SELECT
    MAX(age)
FROM wizard_deposits;

--QUERY 6
SELECT
    deposit_group,
    SUM(deposit_interest)
FROM wizard_deposits
GROUP BY deposit_group
ORDER BY SUM(deposit_interest) DESC;

--QUERY 7
SELECT
    magic_wand_creator,
    MIN(magic_wand_size)
FROM wizard_deposits
GROUP BY magic_wand_creator
ORDER BY MIN(magic_wand_size)
LIMIT 5;

--QUERY 8
SELECT
    deposit_group,
    is_deposit_expired,
    FLOOR(AVG(deposit_interest))
FROM wizard_deposits
WHERE deposit_start_date > '1985-01-01'
GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group DESC, is_deposit_expired;

--QUERY 9
SELECT
    last_name,
    COUNT(notes)
FROM wizard_deposits
WHERE notes LIKE '%Dumbledore%'
GROUP BY last_name;

--QUERY 10
CREATE VIEW view_wizard_deposits_with_expiration_date_before_1983_08_17
AS
SELECT
    CONCAT(first_name, ' ', last_name) AS wizard_name,
    deposit_start_date AS start_date,
    deposit_expiration_date AS expiration_date,
    deposit_amount AS amount
FROM wizard_deposits
WHERE deposit_expiration_date <= '1983-08-17'
GROUP BY wizard_name, start_date, expiration_date, amount
ORDER BY expiration_date;

--QUERY 11
SELECT
    magic_wand_creator,
    MAX(deposit_amount)
FROM wizard_deposits
GROUP BY magic_wand_creator
HAVING MAX(deposit_amount) NOT BETWEEN 20000 AND 40000
ORDER BY MAX(deposit_amount) DESC
LIMIT 3;

--QUERY 12
SELECT
    CASE
        WHEN age BETWEEN 0 AND 10 THEN '[0-10]'
        WHEN age BETWEEN 11 AND 20 THEN '[11-20]'
        WHEN age BETWEEN 21 AND 30 THEN '[21-30]'
        WHEN age BETWEEN 31 AND 40 THEN '[31-40]'
        WHEN age BETWEEN 41 AND 50 THEN '[41-50]'
        WHEN age BETWEEN 51 AND 60 THEN '[51-60]'
    ELSE '[61+]'
    END AS age_group,
    COUNT(id)
FROM wizard_deposits
GROUP BY age_group
ORDER BY age_group;

--QUERY 13
SELECT
    COUNT(CASE WHEN department_id = 1 THEN id END) AS "Engineering",
    COUNT(CASE WHEN department_id = 2 THEN id END) AS "Tool Design",
    COUNT(CASE WHEN department_id = 3 THEN id END) AS" Sales",
    COUNT(CASE WHEN department_id = 4 THEN id END) AS "Marketing",
    COUNT(CASE WHEN department_id = 5 THEN id END) AS "Purchasing",
    COUNT(CASE WHEN department_id = 6 THEN id END) AS "Research and Development",
    COUNT(CASE WHEN department_id = 7 THEN id END) AS "Production"
FROM employees
WHERE department_id BETWEEN 1 AND 7;

--QUERY 14
UPDATE employees
SET
    salary = CASE
                 WHEN hire_date < '2015-01-16' THEN salary + 2500
                 WHEN hire_date < '2020-03-04' THEN salary + 1500
                 ELSE salary
             END,
    job_title = CASE
                    WHEN hire_date < '2015-01-16' THEN CONCAT('Senior ', job_title)
                    WHEN hire_date < '2020-03-04' THEN CONCAT('Mid-', job_title)
                    ELSE job_title
                END;

--QUERY 15
SELECT
    job_title,
    CASE
        WHEN AVG(salary) > 45800 THEN 'Good'
        WHEN AVG(salary) >= 27500 THEN 'Medium'
        ELSE 'Need Improvement'
    END AS category
FROM employees
GROUP BY job_title
ORDER BY category, job_title;

--QUERY 16


--QUERY 17


--QUERY 18


--QUERY 19


--QUERY 20

