-- Numbering.
-- W.X where W is a "lesson" and X is a sequentially increasing lesson "section".
-- Some "lessons" had one "section" and other "lessons" had multiple "sections".
-- Thus the "section" numbers should constantly increase in proper sequence (1, 2, 3, 4..., end).
-- As well as each lesson possibly being split into sections, lessons were also split into various tasks and challenges. 
-- Task W.X.Y.Z would be lessonW.sectionX.taskIntegerY.taskDecimalZ.
-- Challenge W.X.Y.Z would be lessonW.sectionX.challengeIntegerY.challengeDecimalZ.

-- For testing all code at once.
DROP DATABASE IF EXISTS class;

-- ----------------------------------------------------------- 
-- LESSON 1.1 - Create then destroy a database as a test.
-- -----------------------------------------------------------
-- (Task 1.1.1) Create a table in the DB.
CREATE DATABASE class;
USE class;
DROP DATABASE IF EXISTS class;

-- Create the database again and use it.
CREATE DATABASE class;
USE class;

-- ----------------------------------------------------------- 
-- LESSON 1.2 - Create tables and alter tables.
-- ----------------------------------------------------------- 
-- (Task 1.2.1) Create a table in the DB.
CREATE TABLE trainer(
  trainer_id INT PRIMARY KEY,
  trainer_name VARCHAR(15),
  trainer_dob DATE,
  salary DECIMAL(20,5));
-- View the structure / format of this table.
DESCRIBE trainer;

-- (Task 1.2.2) Create another table (with a check) in the DB.
CREATE TABLE students(
  student_id INT PRIMARY KEY AUTO_INCREMENT,
  student_name VARCHAR(30),
  student_age INT NOT NULL,
  CHECK(student_age >= 18 AND student_age < 100));

-- (Task 1.2.3) A subject table using an enum.
CREATE TABLE subjects(
  subject_id INT PRIMARY KEY AUTO_INCREMENT,
  trainer_id INT NOT NULL,
  subject_name ENUM('DB','WebDev', 'SwDev') DEFAULT ('DB'),
  start_date DATE NOT NULL,
  -- Foreign key constraint.
  CONSTRAINT trainer_id FOREIGN KEY(trainer_id) REFERENCES trainer(trainer_id));
  
-- (Challenge 1.2.1) Add columns.
ALTER TABLE students ADD COLUMN passport INT;
ALTER TABLE students ADD COLUMN first_name VARCHAR(30);
ALTER TABLE students ADD COLUMN last_name VARCHAR(30); 

-- (Challenge 1.2.2) Drop / remove a column.
ALTER TABLE students DROP COLUMN student_name; 

-- (Challenge 1.2.3) Rename a table.
ALTER TABLE trainer RENAME TO teachers;

-- (Challenge 1.2.4) Two step process to remove primary key from students.
-- First change datatype then remove the primary key.
ALTER TABLE students MODIFY COLUMN student_id INT;
ALTER TABLE students DROP PRIMARY KEY;

-- (Challenge 1.2.5) Simple renaming of column.
ALTER TABLE students RENAME COLUMN student_id TO student_number;

-- (Challenge 1.2.6) Two step process to add primary key to students.
-- First add the primary key then change the datatype.
ALTER TABLE students ADD PRIMARY KEY(student_number);
ALTER TABLE students MODIFY COLUMN student_number INT AUTO_INCREMENT;

-- (Challenge 1.2.7) Rename of column with a default value.
ALTER TABLE teachers MODIFY COLUMN salary DECIMAL(18,5) DEFAULT 30000.10;

-- ----------------------------------------------------------- 
-- Lesson 2.3 - Inserting data into tables.
-- ----------------------------------------------------------- 
-- (Tasks 2.3.1, 2.3.2, 2.3.3) Adding data to a table.
INSERT INTO teachers(trainer_id, trainer_name, trainer_dob, salary) VALUES(1, "Zak", '1996-09-20',20000.3);
INSERT INTO teachers(trainer_id, trainer_name, trainer_dob, salary) VALUES(2, 'Tim','1994-01-01',15000.2);
INSERT INTO teachers(trainer_id, trainer_name, trainer_dob, salary) VALUES(3, 'Christain','1993-01-01',35900.3);
INSERT INTO teachers(trainer_id, trainer_name, trainer_dob, salary)
  VALUES(4, 'Richard', '1969-01-01', 100900.3), (5, 'Waqas', '1922-01-01', 50000.2);
DESCRIBE teachers;
SELECT * FROM teachers;

-- (Challenge 2.3.1)  
INSERT INTO students(student_age, passport, first_name, last_name) VALUES(18, 105405239, 'Harry', 'Biker');
DESCRIBE students;
SELECT * FROM students;

-- (Challenge 2.3.2)
INSERT INTO subjects(trainer_id, subject_name, start_date) VALUES(2, 'WebDev', '2023-06-20');

-- (Challenge 2.3.3)
INSERT INTO subjects(trainer_id, subject_name, start_date) VALUES(1, 'WebDev', '2023-06-05');
INSERT INTO subjects(trainer_id, subject_name, start_date) VALUES(3, 'DB', '2023-06-05');
INSERT INTO subjects(trainer_id, subject_name, start_date) VALUES(4, 'SwDev', '2023-07-01');
DESCRIBE subjects;
SELECT * FROM subjects;

-- (Challenge 2.3.4)
-- (NB: not putting column names will still input the data to the columns IF in correct format).
INSERT INTO teachers VALUES(6, 'Narayan', '1982-01-01', 100500.1);
DESCRIBE teachers;
SELECT * FROM teachers;
INSERT INTO students VALUES(4, 22, 400034983, 'Bart', 'Simpson'); -- NB: student_id (PK) is auto increment
INSERT INTO students VALUES(2, 52, 400344894, 'Homer', 'Simpson'); 
INSERT INTO students(student_age, passport, first_name, last_name) VALUES(24, 400034982, 'Lisa', 'Simpson'); -- student_id's are now 1 2 4 5
DESCRIBE students;
SELECT * FROM students;
INSERT INTO subjects VALUES (10, 3, 'DB', '2022-08-03'); -- NB: subject_id (PK) is auto increment
INSERT INTO subjects (trainer_id, subject_name, start_date) VALUES (3, 'DB', '2022-08-03'); -- subject_id's are now 1 2 3 4 10 11
DESCRIBE subjects;
SELECT * FROM subjects;

-- -----------------------------------------------------------
-- Lesson 2.4 - Update and delete data.
-- ----------------------------------------------------------- 
-- (Task 2.4.1.1, 2.4.1.2) Give the teachers a pay rise.
UPDATE teachers SET salary = 30000.1 WHERE salary < 25000.0; 
UPDATE teachers SET salary = 80000 WHERE trainer_name = 'Richard';
SELECT * FROM teachers;

-- (Task 2.4.1.3) Update all student ages by 1.
UPDATE students SET student_age = student_age + 1;
SELECT * FROM students;

-- (Challenge 2.4.1.1) Waqas is teaching all WebDev courses now.
UPDATE subjects SET trainer_id=5 WHERE subject_name='WebDev';
SELECT * FROM subjects;

-- (Challenge 2.4.1.2) All teachers get 2% pay rise.
UPDATE teachers SET salary = salary * 1.02;
SELECT * FROM teachers;

-- (Challenge 2.4.1.3)
UPDATE subjects SET start_date='2023-07-10' WHERE subject_id=3;
SELECT * FROM subjects;

-- (Task 2.4.2.1) Tim is leaving.
DELETE FROM teachers WHERE trainer_name='Tim';
SELECT * FROM teachers;

-- (Task 2.4.2.2) Remove duplicate entry for WebDev using aliases (COPIED FROM ANSWER).
DELETE s1 FROM subjects s1
  INNER JOIN subjects s2
  WHERE s1.subject_name=s2.subject_name AND s1.subject_id < s2.subject_id;
SELECT * FROM subjects;

-- (Challenge 2.4.2.1) Remove Waqas from teachers respecting constraints.
UPDATE subjects SET trainer_id=6 WHERE trainer_id=5; -- Waqas has trainer_id 5
DELETE FROM teachers WHERE trainer_name='Waqas';
SELECT * FROM subjects;
SELECT * FROM teachers;

-- (Challenge 2.4.2.2) Zak no longer teaching and needs to removed from the teachers
-- table. This cannot be done as Zak is referenced in the subjects table. This would
-- not have had happened if we had used ON CASCADE DELETE when creating the subjects table.
ALTER TABLE subjects DROP FOREIGN KEY trainer_id;
ALTER TABLE subjects ADD FOREIGN KEY(trainer_id) REFERENCES teachers(trainer_id) ON DELETE CASCADE;
DELETE FROM teachers WHERE trainer_name='Zak';
SELECT * FROM subjects;
SELECT * FROM teachers;

-- -----------------------------------------------------------
-- Lesson 3.5 - Selecting data.
-- ----------------------------------------------------------- 
-- (Tasks 3.5.1.1, 3.5.1.2, 3.5.1.3) Simple queries.
SELECT * FROM students;
SELECT student_number, last_name FROM students;
SELECT * FROM teachers WHERE trainer_name='Richard'; 

-- (Task 3.5.1.4) Add two new teacher rows.
INSERT INTO teachers(trainer_id, trainer_name, trainer_dob, salary)
  VALUES(7, 'Richard', '2000-06-01', 90000), (8, 'Zak', '2001-05-01', 89000);
SELECT * FROM teachers;

-- (Task 3.5.1.5) Bring up only the newly added teachers Zak and Richard.
SELECT * FROM teachers WHERE trainer_name='Zak' OR trainer_name='Richard' AND salary > 82000;

-- (Task 3.5.2.1) Testing import of tiny Mockaroo.com generated csv file
-- ---------- a tiny test csv file from Mockaroo.com ----------
-- id,first_name
-- 1,Karoline
-- 2,Nicol
-- 3,Maybelle
-- 4,Welbie
-- 5,Alberto
-- ---------- tiny test csv file end ----------
-- Create a table to hold csv data.
CREATE TABLE my_wee_table (
  id INT PRIMARY KEY,
  name VARCHAR(15)
);
-- Load the data from the csv file into the table created to hold this data.
-- MySQL has a specific folder to use for holding files that being read or it'll
-- generate an error (C:\ProgramData\MySQL\MySQL Server 8.0\Uploads).
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\MOCK_DATA_2cols_5rows.csv'
INTO TABLE my_wee_table
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; -- Ignore the title row.
-- Print the table filled from the csv file. 
SELECT * FROM my_wee_table;
-- ---------- a bigger test csv file from Mockaroo.com 6 cols 200 rows ----------
CREATE TABLE my_medium_table (
  id INT PRIMARY KEY,
  first_name VARCHAR(25),
  last_name VARCHAR(25),
  email VARCHAR(40),
  gender VARCHAR(25),
  ip_address VARCHAR(25)
);
-- Load the data from the csv file into the table created to hold this data.
-- MySQL has a specific folder to use for holding files that being read or it'll
-- generate an error (C:\ProgramData\MySQL\MySQL Server 8.0\Uploads).
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\MOCK_DATA_6cols_200rows.csv'
INTO TABLE my_medium_table
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; -- Ignore the title row.
-- Print the table filled from the csv file. 
SELECT * FROM my_medium_table;
-- Count how many people share a first name using an alias (COPIED FROM ANSWER).
SELECT first_name, COUNT(first_name) AS count_of_names
FROM my_medium_table
GROUP BY first_name
HAVING COUNT(*) > 1;

-- (Task 3.5.2.2) Born after 2000?
SELECT trainer_name, trainer_dob FROM teachers WHERE YEAR(trainer_dob) > 2000;

-- (Task 3.5.2.3) Sum the wages of all the teachers using an alias.
SELECT COUNT(salary) AS count_salary FROM teachers; -- this basically counts how many rows there are
SELECT SUM(salary) AS total_salary FROM teachers; -- replace the count function with a sum function

-- (Challenge 3.5.1) Capitalise names and order by salary.
SELECT UPPER(trainer_name), salary FROM teachers ORDER BY salary DESC;

-- (Challenge 3.5.2) Count subject_names. Group and order by the subject_name too.
SELECT COUNT(subject_name) AS count, subject_name FROM subjects GROUP BY subject_name ORDER BY subject_name;

-- -----------------------------------------------------------
-- Lesson 4.6 - Combining data with union.
-- -----------------------------------------------------------
-- (Task 4.6.1.1) Create a new table.
CREATE TABLE admin_staff(staff_id INT PRIMARY KEY, staff_name VARCHAR(15),
  staff_dob DATE, salary DECIMAL(20,5));
INSERT INTO admin_staff VALUES (1, 'Shamira','1991-01-01', 15000.3);
INSERT INTO admin_staff VALUES (2, 'Karl','1991-01-01', 15000.3);
SELECT * FROM admin_staff;
-- (Task 4.6.1.2) The tables have exactky the same columns so can use union on them all.
SELECT * FROM teachers UNION SELECT * FROM admin_staff;
-- (Task 4.6.1.3) Only those born after 1990.
SELECT * FROM teachers WHERE YEAR(trainer_dob) > 1990
  UNION SELECT * FROM admin_staff WHERE YEAR(staff_dob) > 1990;
-- (Challenge 4.4.1) 
SELECT * FROM teachers WHERE salary < 40000 UNION SELECT * FROM admin_staff WHERE salary < 35000;
-- (Challenge 4.4.2) Use aliases to give better column names (as trainers are also staff members).
SELECT trainer_id AS staff_id, trainer_name AS staff_name, trainer_dob AS dob, salary FROM teachers WHERE salary < 40000 GROUP BY trainer_id
  UNION SELECT * FROM admin_staff WHERE salary < 35000 GROUP BY staff_id;
-- (Challenge 4.4.3) From the previous query, show what giving the teachers a 10% bonus and staff a 20% bonus looks like.
SELECT trainer_id AS staff_id, trainer_name AS staff_name, trainer_dob AS dob, salary, salary*0.1 AS bonus FROM teachers WHERE salary < 40000 GROUP BY trainer_id
  UNION SELECT staff_id, staff_name, staff_dob AS dob, salary, salary*0.2 AS bonus FROM admin_staff WHERE salary < 35000;

-- -----------------------------------------------------------
-- Lesson 5 - There was no lesson 5.
-- -----------------------------------------------------------

-- -----------------------------------------------------------
-- Lesson 6.7 - Inner join.
-- -----------------------------------------------------------
-- (Task 6.7.1.1) Inner join teachers and subjects tables.
SELECT teachers.trainer_id, teachers.trainer_name, subjects.subject_name FROM teachers	 
  INNER JOIN subjects 
  ON teachers.trainer_id = subjects.trainer_id;

-- (Task 6.7.1.2) Can you explain what impact the removal of the ON clause has on the results?
-- "Without an ON clause the query will take every field from the left and right,
-- attempting to pair them up regardless of PK and FK relationships.
-- This will result in records being duplicated and incorrect results."

-- (Task 6.7.1.3) Create a query to SELECT all fields from subjects and teachers. Subjects should be the left table and teachers
-- should be the right. The ON clause should be on trainer_id from both tables. Include a WHERE trainer_name = ‘Christain’.
SELECT * FROM subjects
  INNER JOIN teachers
  ON subjects.trainer_id = teachers.trainer_id
  WHERE teachers.trainer_name='Christain'; 

-- (Challenge 6.7.1.1) We can DELETE data from one table using an INNER JOIN. Work out how to achieve this.
DELETE subjects FROM subjects
  INNER JOIN teachers
  ON subjects.trainer_id = teachers.trainer_id
  WHERE teachers.trainer_name='Christain';
SELECT * FROM subjects;  -- Subject row that made the inner join is removed.
SELECT * FROM teachers;  -- Teachers table unaffected.