-- -----------------------------------------------------------
-- Lesson 7.8 - Left and right joins.
-- -----------------------------------------------------------
-- (Task 7.8.1.1) Create new table.

CREATE TABLE enrollments (
  enrolment_id INT AUTO_INCREMENT PRIMARY KEY,
  subject_id INT, student_id INT,
  CONSTRAINT subject_id FOREIGN KEY(subject_id) REFERENCES subjects(subject_id),
  CONSTRAINT student_id FOREIGN KEY(student_id) REFERENCES students(student_number)
);
INSERT INTO enrollments (subject_id, student_id) VALUES (2, 1), (4, 5);
SELECT * FROM enrollments;
SELECT * FROM subjects;
SELECT * FROM students;
SELECT * FROM teachers;

INSERT INTO students VALUES(3, 48, 400034987, 'Marge', 'Simpson'); -- NB: student_id (PK) is auto increment
INSERT INTO subjects VALUES (1, 6, 'DB', '2022-08-03'); -- NB: subject_id (PK) is auto increment
INSERT INTO subjects VALUES (3, 7, 'WebDev', '2022-08-03'); -- NB: subject_id (PK) is auto increment
INSERT INTO subjects VALUES (5, 8, 'SwDev', '2022-05-28'); -- NB: subject_id (PK) is auto increment
INSERT INTO subjects VALUES (6, 3, 'SwDev', '2022-06-21'); -- NB: subject_id (PK) is auto increment
INSERT INTO subjects VALUES (7, 7, 'DB', '2022-07-15'); -- NB: subject_id (PK) is auto increment