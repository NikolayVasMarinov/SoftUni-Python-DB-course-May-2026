/*
    Description:
*/
--QUERY 1
SELECT
    COUNT(id)
FROM wizard_deposits;

--QUERY 2
SELECT
    SUM(deposit_amount)
FROM wizard_deposits;

--QUERY 3
SELECT
    ROUND(AVG(magic_wand_size), 3)
FROM wizard_deposits;

--QUERY 4
SELECT
    MIN(deposit_charge)
FROM wizard_deposits;

--QUERY 5
SELECT
    MAX(age)
FROM wizard_deposits;

--QUERY 6
SELECT
    deposit_group,
    SUM(deposit_interest)
FROM wizard_deposits
GROUP BY deposit_group
ORDER BY SUM(deposit_interest) DESC;

--QUERY 7
SELECT
    magic_wand_creator,
    MIN(magic_wand_size)
FROM wizard_deposits
GROUP BY magic_wand_creator
ORDER BY MIN(magic_wand_size)
LIMIT 5;

--QUERY 8
SELECT
    deposit_group,
    is_deposit_expired,
    FLOOR(AVG(deposit_interest))
FROM wizard_deposits
WHERE deposit_start_date > '1985-01-01'
GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group DESC, is_deposit_expired;

--QUERY 9
SELECT
    last_name,
    COUNT(notes)
FROM wizard_deposits
WHERE notes LIKE '%Dumbledore%'
GROUP BY last_name;

--QUERY 10
CREATE VIEW view_wizard_deposits_with_expiration_date_before_1983_08_17
AS
SELECT
    CONCAT(first_name, ' ', last_name) AS wizard_name,
    deposit_start_date AS start_date,
    deposit_expiration_date AS expiration_date,
    deposit_amount AS amount
FROM wizard_deposits
WHERE deposit_expiration_date <= '1983-08-17'
GROUP BY wizard_name, start_date, expiration_date, amount
ORDER BY expiration_date;

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

