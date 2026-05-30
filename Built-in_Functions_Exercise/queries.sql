/*

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


--QUERY 26


--QUERY 27