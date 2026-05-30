/*
    Description: Queries utilizing built-in functions
    for strings, math operations, regex and timestamps
    (CTEs used)
*/
-- QUERY 1
CREATE VIEW view_river_info
AS SELECT
       CONCAT_WS(' ', 'The river', river_name,
              'flows into the', outflow,
              'and is', length, 'kilometers long.') AS "River Information"
FROM rivers
ORDER BY river_name;

-- QUERY 2
CREATE VIEW view_continents_countries_currencies_details
AS
SELECT CONCAT(cont.continent_name, ': ', cont.continent_code)                             AS continent_details,
       CONCAT_WS(' - ', countr.country_name, countr.capital, countr.area_in_sq_km, 'km2') AS country_information,
       CONCAT(curr.description, ' (', curr.currency_code, ')')                            AS currencies
FROM continents AS cont
         JOIN countries AS countr ON cont.continent_code = countr.continent_code
         JOIN currencies AS curr ON countr.currency_code = curr.currency_code
ORDER BY country_information, currencies;

-- QUERY 3
ALTER TABLE countries
ADD COLUMN capital_code CHAR(2);

UPDATE countries
SET capital_code = SUBSTRING(capital, 1, 2);

-- QUERY 4
SELECT
    SUBSTRING(description, 5)
FROM currencies;

--QUERY 5
SELECT
    UNNEST(REGEXP_MATCHES("River Information", '([0-9]{1,4})')) AS river_length
FROM view_river_info;

--QUERY 6
SELECT
    REPLACE(mountain_range, 'a', '@') AS replace_a,
    REPLACE(mountain_range, 'A', '$') AS replace_A
FROM mountains;

--QUERY 7
SELECT
    capital,
    TRANSLATE(capital, 'áãåçéíñóú', 'aaaceinou') AS translated_name
FROM countries;

--QUERY 8
SELECT
    continent_name,
    TRIM(LEADING FROM continent_name) AS trim
FROM continents;

--QUERY 9
SELECT
    continent_name,
    TRIM(TRAILING FROM continent_name) AS trim
FROM continents;

--QUERY 10
SELECT
    LTRIM('M' FROM peak_name) AS left_trim,
    RTRIM('m' FROM peak_name) AS right_trim
FROM peaks;

--QUERY 11
WITH mountain_info AS (
    SELECT CONCAT(m.mountain_range, ' ', p.peak_name) AS mountain_information
    FROM mountains AS m
    JOIN peaks AS p ON m.id = p.mountain_id
)
SELECT
    mountain_information,
    LENGTH(mountain_information) AS characters_length,
    BIT_LENGTH(mountain_information) AS bits_of_a_tring
FROM mountain_info;

--QUERY 12
SELECT
    population,
    LENGTH(CAST(population AS VARCHAR))
FROM countries;

--QUERY 13
SELECT
    peak_name,
    LEFT(peak_name, 4) AS positive_left,
    LEFT(peak_name, -4) AS negative_left
FROM peaks;

--QUERY 14
SELECT
    peak_name,
    RIGHT(peak_name, 4) AS positive_right,
    RIGHT(peak_name, GREATEST(LENGTH(peak_name) - 4, 0)) AS negative_right
FROM peaks;

--QUERY 15
UPDATE countries
SET iso_code = UPPER(LEFT(country_name, 3))
WHERE iso_code IS NULL;

--QUERY 16
UPDATE countries
SET country_code = REVERSE(LOWER(country_code));

--QUERY 17
SELECT
    CONCAT(elevation, ' ', REPEAT('-', 3), REPEAT('>', 2), ' ', peak_name) AS "Elevation --->> Peak Name"
FROM peaks
WHERE elevation >= 4884;

--QUERY 18
CREATE TABLE bookings_calculation
AS SELECT
       booked_for
FROM bookings
WHERE apartment_id = 93;

ALTER TABLE bookings_calculation
ADD COLUMN multiplication NUMERIC,
ADD COLUMN modulo NUMERIC;

UPDATE bookings_calculation
SET
    multiplication = booked_for * 50,
    modulo = booked_for % 50;

--QUERY 19
SELECT
    latitude,
    ROUND(latitude, 2) AS round,
    TRUNC(latitude, 2) AS trunc
FROM apartments;

--QUERY 20
SELECT
    longitude,
    @longitude AS abs
FROM apartments;

--QUERY 21
ALTER TABLE bookings
ADD COLUMN billing_day TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP;

SELECT
    TO_CHAR(billing_day, 'DD "Day" MM "Month" YYYY "Year" HH24:MI:SS') AS "Billing Day"
FROM bookings;

--QUERY 22
WITH unified_timestamp AS (
    SELECT booked_at AT TIME ZONE 'UTC' AS tc
    FROM bookings
)
SELECT
    EXTRACT(YEAR FROM tc) AS "YEAR",
    EXTRACT(MONTH FROM tc) AS "MONTH",
    EXTRACT(DAY FROM tc) AS "DAY",
    EXTRACT(HOUR FROM tc) AS "HOUR",
    EXTRACT(MINUTE FROM tc) AS "MINUTE",
    ROUND(EXTRACT(SECOND FROM tc), 0) AS "SECOND"
FROM unified_timestamp;

--QUERY 23
SELECT
    user_id,
    AGE(starts_at, booked_at) AS early_birds
FROM bookings
WHERE AGE(starts_at, booked_at) >= '10 months';

--QUERY 24
SELECT
    companion_full_name,
    email
FROM users
WHERE companion_full_name ILIKE '%aNd%' AND email NOT LIKE '%@gmail';

--QUERY 25
SELECT
    LEFT(first_name, 2) AS initials,
    COUNT(*) AS users_count
FROM users
GROUP BY initials
ORDER BY users_count DESC, initials;

--QUERY 26
SELECT
    SUM(booked_for) AS total_value
FROM bookings
WHERE apartment_id = 90;

--QUERY 27
SELECT
    AVG(multiplication) AS average_value
FROM bookings_calculation;