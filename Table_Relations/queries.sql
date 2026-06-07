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


--QUERY 5
