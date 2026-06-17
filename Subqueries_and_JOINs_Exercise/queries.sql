/*
    Description: JOIN clause, Subqueries, Ranking functions and CTEs
*/
--QUERY 1
SELECT
    CONCAT(a.address, ' ', a.address_2) AS apartment_address,
    b.booked_for AS nights
FROM apartments AS a
JOIN bookings AS b ON a.apartment_id = b.apartment_id
ORDER BY a.apartment_id;

--QUERY 2
SELECT
    a.name,
    a.country,
    TO_CHAR(b.booked_at, 'YYYY-MM-DD')
FROM apartments AS a
LEFT JOIN bookings AS b on a.apartment_id = b.apartment_id
LIMIT 10;

--QUERY 3
SELECT
    b.booking_id,
    TO_CHAR(b.starts_at, 'YYYY-MM-DD'),
    b.apartment_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM bookings AS b
RIGHT JOIN customers AS c ON c.customer_id = b.customer_id
ORDER BY customer_name
LIMIT 10;

--QUERY 4
SELECT
    b.booking_id,
    a.name AS apartment_owner,
    a.apartment_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM
    apartments AS a
    FULL JOIN bookings AS b ON a.apartment_id = b.apartment_id
    FULL JOIN customers AS c ON c.customer_id = b.customer_id
ORDER BY b.booking_id, apartment_owner, customer_name;

--QUERY 5
SELECT
    b.booking_id,
    c.first_name
FROM bookings AS b
CROSS JOIN customers AS c ON c.customer_id = b.customer_id
ORDER BY c.irst_name;

--QUERY 6
SELECT
    b.booking_id,
    b.apartment_id,
    c.companion_full_name
FROM bookings AS b
JOIN customers AS c
USING (customer_id)
WHERE b.apartment_id IS NULL;

--QUERY 7
SELECT
    b.apartment_id,
    b.booked_for,
    c.first_name,
    c.country
FROM bookings AS b
INNER JOIN customers AS c
USING (customer_id)
WHERE c.job_type LIKE 'Lead';

--QUERY 8
SELECT
    COUNT(*)
FROM bookings AS b
INNER JOIN customers AS c
USING (customer_id)
WHERE c.last_name LIKE 'Hahn';

--QUERY 9
SELECT
    a.name,
    SUM(b.booked_for)
FROM apartments AS a
JOIN bookings AS b
USING (apartment_id)
GROUP BY a.name
ORDER BY a.name;

--QUERY 10
SELECT
    a.country,
    COUNT(b.booking_id) AS booking_count
FROM apartments AS a
JOIN bookings AS b
USING (apartment_id)
WHERE b.booked_at > '2021-05-18 07:52:09.904+03' AND b.booked_at < '2021-09-17 19:48:02.147+03'
GROUP BY a.country
ORDER BY booking_count DESC, a.country;

--QUERY 11
SELECT
    mc.country_code,
    m.mountain_range,
    p.peak_name,
    p.elevation
FROM mountains AS m
JOIN peaks AS p ON p.mountain_id = m.id
JOIN mountains_countries AS mc ON mc.mountain_id = m.id
WHERE p.elevation > 2835 AND mc.country_code LIKE 'BG'
ORDER BY p.elevation DESC;

--QUERY 12
SELECT
    mc.country_code,
    COUNT(m.mountain_range) AS mountain_range_count
FROM mountains AS m
JOIN mountains_countries AS mc ON mc.mountain_id = m.id
WHERE mc.country_code IN ('US', 'RU', 'BG')
GROUP BY mc.country_code
ORDER BY mountain_range_count DESC;

--QUERY 13
SELECT
    c.country_name,
    r.river_name
FROM countries_rivers AS cr
JOIN rivers AS r ON r.id = cr.river_id
RIGHT JOIN countries AS c USING (country_code)
WHERE c.continent_code LIKE 'AF'
ORDER BY c.country_name
LIMIT 5;

--QUERY 14
SELECT
    MIN(average_continent_area) AS min_average_area
FROM (
        SELECT
            AVG(area_in_sq_km) AS average_continent_area
        FROM countries
        GROUP BY continent_code
     ) AS min_average;

--QUERY 15
SELECT
    COUNT(*) AS countries_without_mountains
FROM countries
WHERE country_code NOT IN (
    SELECT
        country_code
    FROM
        mountains_countries
    );

--QUERY 16
CREATE TABLE monasteries (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    monastery_name VARCHAR(255),
    country_code CHAR(2)
);

INSERT INTO monasteries(monastery_name, country_code)
VALUES
      ('Rila Monastery "St. Ivan of Rila"', 'BG'),
      ('Bachkovo Monastery "Virgin Mary"', 'BG'),
      ('Troyan Monastery "Holy Mother''s Assumption"', 'BG'),
      ('Kopan Monastery', 'NP'),
      ('Thrangu Tashi Yangtse Monastery', 'NP'),
      ('Shechen Tennyi Dargyeling Monastery', 'NP'),
      ('Benchen Monastery', 'NP'),
      ('Southern Shaolin Monastery', 'CN'),
      ('Dabei Monastery', 'CN'),
      ('Wa Sau Toi', 'CN'),
      ('Lhunshigyia Monastery', 'CN'),
      ('Rakya Monastery', 'CN'),
      ('Monasteries of Meteora', 'GR'),
      ('The Holy Monastery of Stavronikita', 'GR'),
      ('Taung Kalat Monastery', 'MM'),
      ('Pa-Auk Forest Monastery', 'MM'),
      ('Taktsang Palphug Monastery', 'BT'),
      ('Sümela Monastery', 'TR');

ALTER TABLE countries
ADD COLUMN three_rivers BOOLEAN DEFAULT FALSE;

UPDATE countries
SET three_rivers = (
                SELECT
                    COUNT(*) >= 3
                FROM countries_rivers AS cr
				WHERE cr.country_code = countries.country_code
                );

SELECT
    m.monastery_name,
    c.country_name
FROM monasteries AS m
JOIN countries AS c USING (country_code)
WHERE NOT c.three_rivers
ORDER BY m.monastery_name;

--QUERY 17
UPDATE countries
SET country_name = 'Burma'
WHERE country_name = 'Myanmar';

INSERT INTO monasteries(monastery_name, country_code)
VALUES
    ('Hanga Abbey', (SELECT country_code FROM countries WHERE country_name = 'Tanzania')),
    ('Myin-Tin-Daik', (SELECT country_code FROM countries WHERE country_name = 'Myanmar'));

SELECT
    con.continent_name,
    cou.country_name,
    COUNT(m.id) AS monasteries_count
FROM countries AS cou
JOIN continents AS con USING (continent_code)
LEFT JOIN monasteries AS m USING (country_code)
WHERE NOT cou.three_rivers
GROUP BY cou.country_name, con.continent_name
ORDER BY monasteries_count DESC, cou.country_name;

--QUERY 18
SELECT
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname LIKE 'public'
ORDER BY tablename, indexname;

--QUERY 19
CREATE VIEW "continent_currency_usage"
AS
SELECT
    ra.continent_code,
    ra.currency_code,
    ra.currency_usage
FROM (
    SELECT
        ct.continent_code,
        ct.currency_code,
        ct.currency_usage,
        DENSE_RANK() OVER (PARTITION BY ct.continent_code ORDER BY ct.currency_usage DESC) AS ranking
    FROM (
        SELECT
            continent_code,
            currency_code,
            COUNT(currency_code) AS currency_usage
        FROM countries
        GROUP BY continent_code, currency_code
        HAVING COUNT(currency_code) > 1
        ) AS ct
    ) AS ra
WHERE ranking = 1
ORDER BY currency_usage DESC;

--QUERY 20
WITH "row_number" AS (
    SELECT
        c.country_name,
		COALESCE(p.peak_name, '(no highest peak)') AS highest_peak_name,
        COALESCE(p.elevation, 0) AS highest_peak_elevation,
        COALESCE(m.mountain_range, '(no mountain)') AS mountain,
        ROW_NUMBER() OVER(PARTITION BY country_name ORDER BY p.elevation DESC) AS row_num
    FROM
        countries AS c
        LEFT JOIN mountains_countries AS mc USING (country_code)
        LEFT JOIN mountains AS m ON m.id = mc.mountain_id
        LEFT JOIN peaks AS p USING (mountain_id)
)
SELECT
    country_name,
    highest_peak_name,
    highest_peak_elevation,
    mountain
FROM "row_number"
WHERE row_num = 1
ORDER BY country_name, highest_peak_elevation DESC;