DROP DATABASE IF EXISTS manufacturer;
CREATE DATABASE manufacturer;
USE manufacturer;

CREATE TABLE clothing (
  clothing_id INT AUTO_INCREMENT PRIMARY KEY, 
  clothing_type VARCHAR(20),
  clothing_style VARCHAR(10)
); 

CREATE TABLE dyes (
  dye_id INT AUTO_INCREMENT PRIMARY KEY,
  dye_colour VARCHAR(20), dye_type VARCHAR(10)
);

CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  clothing_id INT,
  dye_id INT, CONSTRAINT clothing_id FOREIGN KEY (clothing_id) REFERENCES clothing (clothing_id)
);

ALTER TABLE products ADD FOREIGN KEY (dye_id) REFERENCES dyes(dye_id);