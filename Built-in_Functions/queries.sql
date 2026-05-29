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


-- QUERY 4


--QUERY 5


--QUERY 6


--QUERY 7