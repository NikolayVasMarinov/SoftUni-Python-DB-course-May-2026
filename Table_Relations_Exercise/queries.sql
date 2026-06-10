/*
    Description:
*/
--QUERY 1
CREATE TABLE products (
    product_name VARCHAR(100)
);

INSERT INTO products
VALUES
    ('Broccoli', 'Shampoo', 'Toothpaste', 'Candy');

ALTER TABLE products
ADD COLUMN id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY;

--QUERY 2
ALTER TABLE products
DROP CONSTRAINT "products_pkey";

--QUERY 3
CREATE DATABASE customst_db;

CREATE TABLE passports (
    id INT GENERATED ALWAYS AS IDENTITY (START WITH 100 INCREMENT BY 1) PRIMARY KEY,
    nationality VARCHAR(50)
);

INSERT INTO passports(nationality)
VALUES
    ('N34FG21B'),
    ('K65LO4R7'),
    ('ZE657QP2');

CREATE TABLE people (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    salary NUMERIC(10, 2),
    passport_id INT REFERENCES passports(id)
);

INSERT INTO people(first_name, salary, passport_id)
VALUES
    ('Roberto', 43300.0000, 101),
    ('Tom', 56100.0000, 102),
    ('Yana', 60200.0000, 100);

--QUERY 4


--QUERY 5


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
