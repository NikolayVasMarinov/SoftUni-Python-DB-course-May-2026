/*
    Description:
*/
-- QUERY 1
CREATE TABLE mountains (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE peaks (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50),
    mountain_id INT,

    CONSTRAINT fk_peaks_mountains
        FOREIGN KEY (mountain_id)
        REFERENCES mountains(id)
);

--QUERY 2
SELECT
    v.driver_id,
    v.vehicle_type,
    CONCAT(c.first_name, ' ', c.last_name) AS driver_name
FROM
    campers AS c
    JOIN vehicles AS v ON c.id = v.driver_id;

-- QUERY 3
SELECT
    r.start_point,
    r.end_point,
    r.leader_id,
    CONCAT(c.first_name, ' ', c.last_name) AS leader_name
FROM
    campers AS c
    JOIN routes AS r ON c.id = r.leader_id;

--QUERY 4
DROP TABLE mountains;
DROP TABLE peaks;

CREATE TABLE mountains (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE peaks (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50),
    mountain_id INT,

    CONSTRAINT fk_mountain_id
        FOREIGN KEY (mountain_id)
        REFERENCES mountains(id) ON DELETE CASCADE
);

--QUERY 5
CREATE DATABASE project_management;

CREATE TABLE clients (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE projects (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    client_id INT,
    project_lead_id INT,

    CONSTRAINT fk_client_id
        FOREIGN KEY (client_id)
            REFERENCES clients(id)
);

CREATE TABLE employees (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    project_id INT,

    CONSTRAINT fk_project_id
        FOREIGN KEY (project_id)
            REFERENCES projects(id)
);

ALTER TABLE projects
ADD CONSTRAINT fk_project_lead_id
        FOREIGN KEY (project_lead_id)
            REFERENCES employees(id);