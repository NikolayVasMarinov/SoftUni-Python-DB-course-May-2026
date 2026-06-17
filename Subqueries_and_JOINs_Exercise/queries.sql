/*
    Description:
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

--QUERY 18


--QUERY 19


--QUERY 20