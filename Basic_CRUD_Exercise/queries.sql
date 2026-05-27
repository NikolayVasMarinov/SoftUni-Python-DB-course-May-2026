/*
    Description: Selecting, inserting, updating and deleting data from tables
*/
-- QUERY 1
SELECT * FROM cities;

-- QUERY 2
ALTER TABLE cities
RENAME COLUMN area to area_km2;

SELECT
    name || ' ' || state as "cities_information",
    area_km2
FROM cities;

-- QUERY 3
ALTER TABLE cities
RENAME COLUMN area_km2 to area;

SELECT DISTINCT ON (name)
    name,
    area as "area_km2"
FROM cities
ORDER BY name DESC;

-- QUERY 4
SELECT
    id,
    first_name || ' ' || last_name as "full_name",
    job_title
FROM employees
ORDER BY first_name LIMIT 50;

--QUERY 5
SELECT
    id,
    first_name || ' ' || middle_name || ' ' || last_name as "full_name",
    hire_date
FROM employees
ORDER BY hire_date OFFSET 9;

--QUERY 6
SELECT
    id,
    number || ' ' || street as "address",
    city_id
FROM addresses
WHERE id >= 20;

--QUERY 7
SELECT
    number || ' ' || street as "address",
    city_id
FROM addresses
WHERE city_id >= 0 AND city_id % 2 = 0
ORDER BY city_id;

--QUERY 8
SELECT
    name,
    start_date,
    end_date
FROM projects
WHERE start_date >= '2016-06-01 07:00:00' AND end_date < '2023-06-04 00:00:00'
ORDER BY start_date;

--QUERY 9
SELECT
    number,
    street
FROM addresses
WHERE id BETWEEN 50 AND 100 OR number < 1000;

--QUERY 10
SELECT
    employee_id,
    project_id
FROM employees_projects
WHERE employee_id IN (200, 250) AND project_id NOT IN (50, 100);

--QUERY 11
SELECT
    name,
    start_date
FROM projects
WHERE name IN ('Mountain', 'Road', 'Touring') LIMIT 20;

--QUERY 12
SELECT
    first_name || ' ' || last_name as "full_name",
    job_title,
    salary
FROM employees
WHERE salary IN (12500, 14000, 23600, 25000) LIMIT 20
ORDER BY salary DESC;

--QUERY 13
SELECT
    id,
    first_name,
    last_name
FROM employees
WHERE middle_name IS NULL
LIMIT 3;

--QUERY 14
INSERT INTO
    departments(department, manager_id)
VALUES
    ('Finance', 3),
	('Information Services', 42),
	('Document Control', 90),
	('Quality Assurance', 274),
	('Facilities and Maintenance', 218),
	('Shipping and Receiving', 85),
	('Executive', 109);

--QUERY 15
CREATE TABLE company_chart
AS SELECT
       first_name || ' ' || last_name as "full_name",
       job_title,
       department_id,
       manager_id
FROM employees;

--QUERY 16
UPDATE projects
SET end_date = start_date + INTERVAL '5 months'
WHERE end_date IS NULL;

--QUERY 17
UPDATE
    employees
SET
    salary = salary + 1500,
    job_title = CONCAT('Senior ', job_title)
WHERE
    hire_date BETWEEN 'January 1, 1998' AND 'January 5, 2000';

--QUERY 18
DELETE FROM addresses
WHERE city_id IN (5, 17, 20, 30);

--QUERY 19
CREATE VIEW view_company_chart
AS SELECT
       full_name,
       job_title
FROM company_chart
WHERE manager_id = 184;

--QUERY 20
CREATE VIEW view_addresses
AS SELECT
       CONCAT(e.first_name, ' ', e.last_name) AS "full_name",
       e.department_id,
       CONCAT(number, ' ', street) AS "address"
FROM
    employees as e,
    addresses as a
WHERE e.address_id = a.id
ORDER BY address;

--QUERY 21

--QUERY 22

--QUERY 23

--QUERY 24

--QUERY 25

