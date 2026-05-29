/*
    Description: Selecting, inserting, updating and deleting data from tables
*/
-- QUERY 1
SELECT
    title
FROM books
WHERE title LIKE 'The%';

-- QUERY 2
UPDATE books
SET
    title = REPLACE(title, 'The', '***')
WHERE title LIKE 'The%'
RETURNING title;

-- QUERY 3
SELECT
    id,
    side * height / 2 AS area
FROM triangles;

-- QUERY 4
SELECT
    title,
    TRUNC(cost, 3) AS modified_price
FROM books;

--QUERY 5
SELECT
    first_name,
    last_name,
    EXTRACT(YEAR FROM born) as year
FROM authors;

--QUERY 6
SELECT
    last_name AS "Last Name",
    TO_CHAR(born, 'DD (Dy) Mon YYYY') AS "Date of Birth"
FROM authors;

--QUERY 7
SELECT
    title
FROM books
WHERE title LIKE 'Harry Potter%';