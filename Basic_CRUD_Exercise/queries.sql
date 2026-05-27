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
SELECT id,
       first_name || ' ' || middle_name || ' ' || last_name as "full_name",
       hire_date
FROM employees
ORDER BY hire_date
OFFSET 9;

--QUERY 6


--QUERY 7
