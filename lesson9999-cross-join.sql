
DROP DATABASE IF EXISTS clothing;
CREATE DATABASE clothing;
USE clothing;

CREATE TABLE sizes(size VARCHAR(3));

CREATE TABLE clothing_types(clothes VARCHAR (30));

INSERT INTO sizes VALUES ('s'), ('m'), ('l');

INSERT INTO clothing_types VALUES ('jeans'), ('jacket'), ('shirts');

SELECT * FROM clothing_types CROSS JOIN sizes;