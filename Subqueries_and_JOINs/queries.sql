/*
    Description:
*/
-- QUERY 1
SELECT
    t.town_id,
    t.name,
    a.address_text
FROM
    addresses AS a
    JOIN towns AS t on t.town_id = a.town_id
WHERE t.name IN ('San Francisco', 'Sofia', 'Carnation')
ORDER BY t.town_id, a.address_id;

--QUERY 2
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    d.department_id,
    d.name
FROM
    employees AS e
    JOIN departments AS d ON e.employee_id = d.manager_id
ORDER BY e.employee_id
LIMIT 5;

--QUERY 3


--QUERY 4
