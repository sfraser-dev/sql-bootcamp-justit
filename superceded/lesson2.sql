-- Numbering.
-- W.X where W is the "day" and X is a sequential lesson count.
-- Some "days" had multiple lessons.
-- Task W.X.Y.Z would be day.lesson.taskInteger.taskDecimal
-- Challenge W.X.Y.Z would be day.lesson.challengeInteger.challengeDecimal

-- For testing all code at once.
DROP DATABASE IF EXISTS class;

-- 
-- LESSON 1.1 - Create then destroy a database as a test.
--
-- (Task 1.1.1) Create a table in the DB.
CREATE DATABASE class;
USE class;
DROP DATABASE IF EXISTS class;

-- Create the database again and use it.
CREATE DATABASE class;
USE class;

-- 
-- LESSON 1.2 - Create tables and alter tables.
-- 
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

-- 
-- Lesson 2.3 - Inserting data into tables.
-- 
-- (Tasks 2.3.1, 2.3.2, 2.3.3) Adding data to a table.
INSERT INTO teachers(trainer_id, trainer_name, trainer_dob, salary) VALUES(1, "Zak", '1996-09-20',20000.3);
INSERT INTO teachers(trainer_id, trainer_name, trainer_dob, salary) VALUES(2, 'Tim','1994-01-01',15000.2);
INSERT INTO teachers(trainer_id, trainer_name, trainer_dob, salary) VALUES(3, 'Christain','1993-01-01',35900.3);
INSERT INTO teachers(trainer_id, trainer_name, trainer_dob, salary)
  VALUES(4, 'Richard', '1969-01-01', 100900.3), (5, 'Waqas', '1922-01-01', 50000.2);
DESCRIBE teachers;
SELECT * FROM teachers;

-- (Challenge 2.3.1)  
INSERT INTO students(student_age, passport, first_name, last_name) VALUES(18, 10540523, 'Harry', 'Biker');
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
INSERT INTO students(student_age, passport, first_name, last_name) VALUES(24, 400034983, 'Lisa', 'Simpson'); -- student_id's are now 1 2 4 5
DESCRIBE students;
SELECT * FROM students;
INSERT INTO subjects VALUES (10, 3, 'DB', '2022-08-03'); -- NB: subject_id (PK) is auto increment
INSERT INTO subjects (trainer_id, subject_name, start_date) VALUES (3, 'DB', '2022-08-03'); -- subject_id's are now 1 2 3 4 10 11
DESCRIBE subjects;
SELECT * FROM subjects;

-- 
-- Lesson 2.4 - Update and delete data.
-- 
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

-- (Task 2.4.2.2) Remove duplicate entry for WebDev using aliases.
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