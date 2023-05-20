-- Numbering.
-- X.Y where X is the "day" and Y is a sequential lesson count.
-- Some "days" had multiple lessons.

-- For testing all code at once.
DROP DATABASE IF EXISTS class;

-- 
-- LESSON 1.1 - Create then destroy a database as a test.
--

CREATE DATABASE class;
USE class;
DROP DATABASE IF EXISTS class;

-- Create the database again and use it.
CREATE DATABASE class;
USE class;

-- 
-- LESSON 1.2 - Create tables and alter tables.
-- 

-- (Task 1) Create a table in the DB.
CREATE TABLE trainer(
  trainer_id INT PRIMARY KEY,
  trainer_name VARCHAR(15),
  trainer_dob DATE,
  salary DECIMAL(20,5));
-- View the structure / format of this table.
DESCRIBE trainer;

-- (Task 2) Create another table (with a check) in the DB.
CREATE TABLE students(
  student_id INT PRIMARY KEY AUTO_INCREMENT,
  student_name VARCHAR(30),
  student_age INT NOT NULL,
  CHECK(student_age >= 18 AND student_age < 100));

-- (Task 3) A subject table using an enum.
CREATE TABLE subjects(
  subject_id INT PRIMARY KEY AUTO_INCREMENT,
  trainer_id INT NOT NULL,
  subject_name ENUM('DB','WebDev', 'SwDev') DEFAULT ('DB'),
  start_date DATE NOT NULL,
  -- Foreign key constraint.
  CONSTRAINT trainer_id FOREIGN KEY(trainer_id) REFERENCES trainer(trainer_id));
  
-- Challenge 1: add columns.
ALTER TABLE students ADD COLUMN passport INT;
ALTER TABLE students ADD COLUMN first_name VARCHAR(30);
ALTER TABLE students ADD COLUMN last_name VARCHAR(30); 

-- Challenge 2: drop / remove a column.
ALTER TABLE students DROP COLUMN student_name; 

-- Challenge 3: rename a table.
ALTER TABLE trainer RENAME TO teachers;

-- Challenge 4: two step process to remove primary key from students.
-- First change datatype then remove the primary key.
ALTER TABLE students MODIFY COLUMN student_id INT;
ALTER TABLE students DROP PRIMARY KEY;

-- Challenge 5: Simple renaming of column.
ALTER TABLE students RENAME COLUMN student_id TO student_number;

-- Challenge 6: two step process to add primary key to students.
-- First add the primary key then change the datatype.
ALTER TABLE students ADD PRIMARY KEY(student_number);
ALTER TABLE students MODIFY COLUMN student_number INT AUTO_INCREMENT;

-- Challenge 7: Rename of column with a default value.
ALTER TABLE teachers MODIFY COLUMN salary DECIMAL(18,5) DEFAULT 30000.10;

-- 
-- Lesson 2.3 - Inserting data into tables.
-- 

INSERT INTO teachers(trainer_id, trainer_name, trainer_dob, salary) VALUES(1, "Zak", '1996-09-20',20000.3);
INSERT INTO teachers(trainer_id, trainer_name, trainer_dob, salary) VALUES(2, 'Tim','1994-01-01',15000.2);
INSERT INTO teachers(trainer_id, trainer_name, trainer_dob, salary) VALUES(3, 'Christain','1993-01-01',35900.3);
INSERT INTO teachers(trainer_id, trainer_name, trainer_dob, salary)
  VALUES(4, 'Christain','1993-01-01',35900.3), (5, 'Waqas', '1922-01-01', 50000.2);
DESCRIBE teachers;
SELECT * FROM teachers;

-- Challenge 1: 
INSERT INTO students(student_age, passport, first_name, last_name) VALUES(18, 10540523, 'Harry', 'Biker');
DESCRIBE students;
SELECT * FROM students;

-- Challenge 2:
INSERT INTO subjects(trainer_id, subject_name, start_date) VALUES(2, 'WebDev', '2023-06-20');

-- Challenge 3:
INSERT INTO subjects(trainer_id, subject_name, start_date) VALUES(1, 'WebDev', '2023-06-05');
INSERT INTO subjects(trainer_id, subject_name, start_date) VALUES(3, 'DB', '2023-06-05');
INSERT INTO subjects(trainer_id, subject_name, start_date) VALUES(4, 'SwDev', '2023-07-01');
DESCRIBE subjects;
SELECT * FROM subjects;

-- Challenge 4: (not putting column names will still input the data to the columns IF in correct format).
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

