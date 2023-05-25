-- -----------------------------------------------------------
-- Lesson 7.8 - Left and right joins.
-- -----------------------------------------------------------
-- (Task 7.8.1.1) Create new enrollment table.
CREATE TABLE enrollments (
  enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
  subject_id INT,
  student_id INT,
  CONSTRAINT subject_id FOREIGN KEY(subject_id) REFERENCES subjects(subject_id),
  CONSTRAINT student_id FOREIGN KEY(student_id) REFERENCES students(student_number)
);

-- Add more rows / records to the students and subjects tables. Studens now has 8 rows and subjects has 7 rows.
INSERT INTO students VALUES (3, 48, 400034987, 'Marge', 'Simpson'); 
INSERT INTO students VALUES (6, 48, 400034988, 'Maggie', 'Simpson');
INSERT INTO students VALUES (7, 35, 400074601, 'Barney', 'Gumble'); 
INSERT INTO students VALUES (8, 35, 400054345, 'Krusty', 'Clown'); 
INSERT INTO subjects VALUES (1, 6, 'DB', '2022-08-03'); 
INSERT INTO subjects VALUES (3, 7, 'WebDev', '2022-08-03'); 
INSERT INTO subjects VALUES (5, 8, 'SwDev', '2022-05-28'); 
INSERT INTO subjects VALUES (6, 3, 'SwDev', '2022-06-21'); 
INSERT INTO subjects VALUES (7, 7, 'DB', '2022-07-15'); 
SELECT * FROM subjects;
SELECT * FROM students;
-- (Task 7.8.1.2) Add data to the foreign key columns.
INSERT INTO enrollments (subject_id, student_id) VALUES (2, 1), (4, 5), (1, 2), (3, 3), (7, 4), (5, 6), (6, 7);
SELECT * FROM enrollments;
-- (Task 7.8.1.3) Left join. Query returns eight rows (8th row of subjects is null).
SELECT * FROM students LEFT JOIN enrollments ON student_number = student_id;

-- (Task 7.8.1.4) Right join. Query return seven rows (8th row of students isn't included).
SELECT * FROM students RIGHT JOIN enrollments ON student_number = student_id;

-- (Task 7.8.1.5) Left join using subjects and enrollements.
SELECT * FROM subjects LEFT JOIN enrollments ON subjects.subject_id = enrollments.subject_id;

-- Challenge (7.8.1) Join the tables. Delete rows in enrollments where the condition is met in the joined table.
-- The enrollement table is changed. 
DELETE enrollments FROM enrollments LEFT JOIN subjects ON enrollments.subject_id=subjects.subject_id WHERE trainer_id=6;

-- Challenge (7.8.2) Combining multiple tables using multiple joins.
-- A single left join of enrollments and students (LJES, left join enrollment students).
SELECT enrollments.enrollment_id, students.student_number
  FROM enrollments LEFT JOIN students ON enrollments.student_id = students.student_number;
-- Now left join LJES with the subjects table.
SELECT enrollments.enrollment_id, students.student_number, subjects.subject_name
  FROM enrollments LEFT JOIN students ON enrollments.student_id = students.student_number
  LEFT JOIN subjects ON enrollments.subject_id = subjects.subject_id;
 
-- -----------------------------------------------------------
-- Lesson 8.9 - Case / when / then / end statement.
-- -----------------------------------------------------------
-- (Task 8.9.1.1) Calculate teacher salary with bonus (it will show up in the CASE column of retuned 
-- table, it will not affect the teacher table).
SELECT trainer_name, trainer_dob, salary,
  CASE 
	WHEN salary <= 40000 THEN salary + 2000
  END
FROM teachers;

-- (Task 8.9.1.2) Calculate teacher salary with bonus more parameters.
SELECT trainer_name, trainer_dob, salary,
  CASE
  	WHEN salary <= 40000 THEN salary + 2000
    WHEN salary BETWEEN 40001 AND 85000 THEN salary + 3000
  END
FROM teachers;

-- (Task 8.9.1.3) Calculate teacher salary with bonus more parameters.
SELECT trainer_name, trainer_dob, salary,
  CASE
  	WHEN salary <= 40000 THEN salary + 2000
    WHEN salary BETWEEN 40001 AND 58000 THEN salary + 3000
    WHEN salary >= 58001 THEN salary + 4000
  END
FROM teachers;

-- (Task 8.9.1.3) Calculate teacher salary with bonus nicer column title.
SELECT trainer_name, trainer_dob, salary,
  CASE
  	WHEN salary <= 40000 THEN salary + 2000
    WHEN salary BETWEEN 40001 AND 58000 THEN salary + 3000
    WHEN salary >= 58001 THEN salary + 4000
  END AS 'salary with bonus'
FROM teachers;

-- (Challenge 8.9.1.1) Only return for Zak and Christian.
SELECT trainer_name, trainer_dob, salary,
  CASE
  	WHEN salary <= 40000 THEN salary + 2000
    WHEN salary BETWEEN 40001 AND 58000 THEN salary + 3000
    WHEN salary >= 58001 THEN salary + 4000
  END AS 'salary with bonus'
FROM teachers WHERE trainer_name='Zak' OR trainer_name='Christian';

-- (Challenge 8.9.1.2) Up until now, we've been using SELECT to *display* the
-- data, now let's actually update the table permanently using UPDATE and SET.
UPDATE teachers SET salary =
  CASE
  	WHEN salary <= 40000 THEN salary + 2000
    WHEN salary BETWEEN 40001 AND 58000 THEN salary + 3000
    WHEN salary >= 58001 THEN salary + 4000
  END;
  SELECT * FROM teachers;
  
  -- -----------------------------------------------------------
-- Lesson 9.10 - Multiple joins.
-- -----------------------------------------------------------
-- (Task 9.10.1.1) Create a three table join (a multi-table join).
SELECT *
FROM enrollments
-- Gives a enrollments-students view by joining enrollments into students
RIGHT JOIN students ON enrollments.student_id = students.student_number 
-- Gives an enrollments-students-subjects view by joining enrollments-students into subjects.
RIGHT JOIN subjects ON subjects.subject_id = enrollments.subject_id;    

-- (Task 9.10.1.2) Use a left join for the second join.
SELECT *
FROM enrollments
-- Gives a enrollments-students view by joining enrollments into students
RIGHT JOIN students ON enrollments.student_id = students.student_number
-- Gives an enrollments-students-subjects view by joining subjects into enrollments-students.
LEFT JOIN subjects ON subjects.subject_id = enrollments.subject_id;