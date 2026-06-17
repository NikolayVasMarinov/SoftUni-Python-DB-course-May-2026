/*
    Description:
*/
--QUERY 1
SELECT
    CONCAT(a.address, ' ', a.address_2) AS apartment_address,
    b.booked_for AS nights
FROM apartments AS a
JOIN bookings AS b on a.apartment_id = b.apartment_id
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
RIGHT JOIN customers AS c on c.customer_id = b.customer_id
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
    FULL JOIN bookings AS b on a.apartment_id = b.apartment_id
    FULL JOIN customers AS c on c.customer_id = b.customer_id
ORDER BY b.booking_id, apartment_owner, customer_name;

--QUERY 5
SELECT
    b.booking_id,
    c.first_name
FROM bookings AS b
RIGHT JOIN customers AS c on c.customer_id = b.customer_id
ORDER BY c.irst_name;

--QUERY 6


--QUERY 7


--QUERY 8


--QUERY 9


--QUERY 10


--QUERY 11


--QUERY 12


--QUERY 13


--QUERY 14


--QUERY 15


--QUERY 18


--QUERY 19


--QUERY 20