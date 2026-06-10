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
CREATE DATABASE car_manufacture_db;

CREATE TABLE manufacturers (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(15),
);

CREATE TABLE models (
    id INT GENERATED ALWAYS AS IDENTITY (START WITH 1000 INCREMENT BY 1) PRIMARY KEY,
    model_name VARCHAR(20),
    manufacturer_id INT REFERENCES manufacturers(id)
);

CREATE TABLE production_years (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    established_on DATE,
    manufacturer_id INT REFERENCES manufacturers(id)
);

INSERT INTO manufacturers(name)
VALUES
    ('BMW'),
    ('Tesla'),
    ('Lada');

INSERT INTO models(model_name, manufacturer_id)
VALUES
    ('X1', 1),
    ('i6', 1),
    ('Model S', 2),
    ('Model X', 2),
    ('Model 3', 2),
    ('Nova', 3);

INSERT INTO production_years(established_on, manufacturer_id)
VALUES
    ('1916-03-01', 1),
    ('2003-01-01', 2),
    ('1966-05-01', 3);

--QUERY 6
CREATE DATABASE photo_shooting_db;

CREATE TABLE customers (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(15),
    date DATE
);

CREATE TABLE photos (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    url TEXT,
    place VARCHAR(100),
    customer_id INT REFERENCES customers(id)
);

INSERT INTO customers(name, date)
VALUES
    ('Bella', '2022-03-25'),
    ('Philip', '2022-07-05');

INSERT INTO photos(url, place, customer_id)
VALUES
    ('bella_1111.com', 'National Theatre', 1),
    ('bella_1112.com', 'Largo', 1),
    ('bella_1113.com', 'The View Restaurant', 1),
    ('philip_1121.com', 'Old Town', 2),
    ('philip_1122.com', 'Rowing Canal', 2),
    ('philip_1123.com', 'Roman Theater', 2);

--QUERY 8
CREATE DATABASE study_session_db;

CREATE TABLE students (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_name VARCHAR(20)
);

CREATE TABLE exams (
    id INT GENERATED ALWAYS AS IDENTITY (START WITH 101 INCREMENT BY 1) PRIMARY KEY,
    exam_name VARCHAR(30)
);

CREATE TABLE study_halls (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    study_hall_name VARCHAR(30),
    exam_id INT REFERENCES exams(id)
);

CREATE TABLE students_exams (
    student_id INT REFERENCES students(id),
    exam_id INT REFERENCES exams(id),

    CONSTRAINT pk_students_exams
        PRIMARY KEY (student_id, exam_id)
);

INSERT INTO students(student_name)
VALUES
    ('Mila'),
    ('Toni'),
    ('Ron');

INSERT INTO exams(exam_name)
VALUES
    ('Python Advanced'),
    ('Python OOP'),
    ('PostgreSQL');

INSERT INTO study_halls(study_hall_name, exam_id)
VALUES
    ('Open Source Hall', 102),
    ('Inspiration Hall', 101),
    ('Creative Hall', 103),
    ('Masterclass Hall', 103),
    ('Information Security Hall', 103);

INSERT INTO students_exams(student_id, exam_id)
VALUES
    (1, 101),
    (1, 102),
    (2, 101);

--QUERY 9


--QUERY 10


--QUERY 11


--QUERY 12


--QUERY 13


--QUERY 14


--QUERY 15
