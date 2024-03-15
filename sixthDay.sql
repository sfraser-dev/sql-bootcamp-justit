
-- ---------------------------------------------------------------

-- Lesson uses the following datasets: Cities, Countries
CREATE DATABASE World;
CREATE TABLE Country(country_id varchar(2) PRIMARY KEY, country_name VARCHAR(30) NOT NULL);


CREATE TABLE Cities(city_id INT PRIMARY KEY AUTO_INCREMENT, country_id varchar(2), city_name VARCHAR(30)
 NOT NULL,
 FOREIGN KEY (country_id) REFERENCES country(country_id));--  What's this doing?

-- Now import data from csv files


-- Creating a query between two databases
SELECT cities.city_name, country.country_name 	-- Selects the two tables where the data exists
FROM cities LEFT JOIN country 				-- States that we want the joining od data to be inner
ON cities.country_id = country.country_id 		-- States the fields that share a common piece of information.
WHERE cities.country_id = "US";				-- In this case we only want the country ID to be UK

-- Why may the above query not have returned any cities?

SELECT * 
FROM cities LEFT JOIN country
ON cities.country_id = country.country_id
WHERE cities.city_id = "UK";

-- Identifies duplicates
SELECT city_name FROM world.cities GROUP BY city_name HAVING COUNT(*) >1;

SELECT cities.city_name FROM cities
UNION
SELECT city.city_name FROM city;

-- How to delete duplicates
-- c1 and c2 are alises basically creating two tables to review.
DELETE c1 FROM cities c1
INNER JOIN cities c2		-- 
WHERE 
c1.city_name = c2.city_name;








