-- For testing all code at once.
DROP DATABASE IF EXISTS class;

-- Create then destroy a database as a test.
CREATE DATABASE class;
USE class;
DROP DATABASE IF EXISTS class;

-- Create the database again and use it.
CREATE DATABASE class;
USE class;

-- (1) Create a table in the DB.
CREATE TABLE trainer(
  trainer_id INT PRIMARY KEY,
  trainer_name VARCHAR(15),
  trainer_dob DATE,
  salary DECIMAL(20,5));
-- View this table.
DESCRIBE trainer;

-- (2) Create another table (with a check) in the DB.
CREATE TABLE students(
  student_id INT PRIMARY KEY AUTO_INCREMENT,
  student_name VARCHAR(30),
  student_age INT NOT NULL,
  CHECK(student_age >= 18 AND student_age < 100));

-- (3) A subject table using an enum.
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
