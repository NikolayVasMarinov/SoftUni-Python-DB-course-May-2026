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


--QUERY 12


--QUERY 13


--QUERY 14


--QUERY 15


--QUERY 18


--QUERY 19


--QUERY 20