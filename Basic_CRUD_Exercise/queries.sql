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

--QUERY 10

--QUERY 11

--QUERY 12

--QUERY 13

--QUERY 14

--QUERY 15

--QUERY 16

--QUERY 17

--QUERY 18

--QUERY 19

--QUERY 20

--QUERY 21

--QUERY 22

--QUERY 23

--QUERY 24

--QUERY 25

