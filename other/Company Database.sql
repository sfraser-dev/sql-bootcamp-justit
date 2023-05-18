
-- Author: Zak PARDIS
-- Host: localhost
-------------- Creating Company Database --------------

CREATE DATABASE IF NOT EXISTS Company;

--
-- ------------ Now Select the Company Database ----------
USE company; 

-- --------------------------------------------------------

-- 
-- Creating Department table
CREATE TABLE IF NOT EXISTS Department (
  DNAME varchar(20) NOT NULL,
  DNUMBER int NOT NULL,
  MGRSSN int(9) default NULL,
  MGRSTARTDATE date default NULL,
  PRIMARY KEY  (DNUMBER));
-- -----------------------------------------------------------------------------

--
-- Inserting multiple values into the Department table ------------------------------------------
INSERT INTO Department (DNAME, DNUMBER, MGRSSN, MGRSTARTDATE) VALUES 
('Headquarters', 1, 888665555, '1981-06-19'),
('Administration', 4, 987654321, '1995-01-01'),
('Research', 5, 333445555, '1988-05-22');

-- --------------------------------------------------------

--
-- Creating Dependent table  ---------------------------------------
CREATE TABLE IF NOT EXISTS Dependent (
  ESSN int(9) NOT NULL,
  DEPENDENT_NAME varchar(15) default NULL,
  SEX enum('M','F') default NULL,
  BDATE date default NULL,
  RELATIONSHIP enum('DAUTHER','SON','SPOUSE') default NULL);

-- ---------------------------------------------------------------------------

--
-- Inserting multiple values into the Dependent table ------------------------------------------
INSERT INTO Dependent (ESSN, DEPENDENT_NAME, SEX, BDATE, RELATIONSHIP) VALUES 
(333445555, 'Alice', 'F', '1986-04-05', NULL),
(333445555, 'Theodore', 'M', '1983-10-25', 'SON'),
(333445555, 'Joy', 'F', '1958-05-03', 'SPOUSE'),
(987654321, 'Abner', 'M', '1942-02-28', 'SPOUSE'),
(123456789, 'Michael', 'M', '1988-01-04', 'SON'),
(123456789, 'Alice', 'F', '1988-12-30', NULL),
(123456789, 'Elizabeth', 'F', '1967-05-05', 'SPOUSE'),
(20120, 'Ab. Rahman', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Creating Dept_locations table --------------------------
CREATE TABLE IF NOT EXISTS Dept_Locations (
  DNUMBER int NOT NULL,
  DLOCATION varchar(20) NOT NULL,
  PRIMARY KEY  (DNUMBER, DLOCATION));
-- ----------------------------------------------------------------

--
-- Inserting multiple values into the Dept_locations table ------------------------------------------
INSERT INTO Dept_locations (DNUMBER, DLOCATION) VALUES 
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Houston'),
(5, 'Sugarland');

-- --------------------------------------------------------

--
-- Creating the Employee Table -------------------------
CREATE TABLE IF NOT EXISTS Employee (
  FNAME varchar(10) NOT NULL,
  LNAME varchar(10) NOT NULL,
  SSN int(9) NOT NULL,
  BDATE date default NULL,
  ADDRESS varchar(30) default NULL,
  SEX enum('M','F') default NULL,
  SALARY double(7,2) unsigned default NULL,
  SUPERSSN int(9) default NULL,
  DNO int default NULL,
  PRIMARY KEY  (SSN));
-- ------------------------------------------------------------------------

--
-- Inserting multiple values into the Employee table ------------------------------------------
INSERT INTO Employee (FNAME,  LNAME, SSN, BDATE, ADDRESS, SEX, SALARY, SUPERSSN, DNO) VALUES 
('Ab. Rahman', 'Sherzad', 20120, NULL, NULL, NULL, NULL, NULL, NULL),
('John', 'Smith', 123456789, '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000.00, 333445555, 5),
('Franklin', 'Wong', 333445555, '1955-12-08', '638 Voss, Houston, TX', 'M', 40000.00, 888665555, 5),
('Joyce', 'English', 453453453, '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000.00, 333445555, 5),
('Ramesh',  'Narayan', 666884444, '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000.00, 333445555, 5),
('James', 'Borg', 888665555, '1937-11-10', '450 Stone, Houston, TX', 'M', 55000.00, NULL, 1),
('Jennifer',  'Wallace', 987654321, '1941-06-20', '291 Berry, Bellaire, TX', 'F', 43000.00, 888665555, 4),
('Ahmad', 'Jabbar', 987987987, '1969-03-29', '980 Dallas, Houston, TX', 'M', 25000.00, 987654321, 4),
('Alicia',  'Zelaya', 999887777, '1968-07-19', '3321 Castle, Spring, TX', 'F', 25000.00, 987654321, 4);

-- ----------------------------------------------------------------------

--
-- Creating the Project Table ----------------------------------
CREATE TABLE IF NOT EXISTS Project (
  PNAME varchar(20) default NULL,
  PNUMBER int(11) NOT NULL,
  PLOCATION varchar(20) default NULL,
  DNUM int default NULL,
  PRIMARY KEY  (PNUMBER));
-- -----------------------------------------------------------------------------

--
-- Inserting multiple values into the Project table ------------------------------------------
INSERT INTO Project (PNAME, PNUMBER, PLOCATION, DNUM) VALUES 
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1),
('Newbenefits', 30, 'Stafford', 4);

-- ---------------------------------------------------------------------------

--
-- Creating Works_On table-------------------------------------
CREATE TABLE IF NOT EXISTS Works_On (
  ESSN int(9) NOT NULL,
  PNO int(11) NOT NULL,
  HOURS double(3,1) default NULL,
  PRIMARY KEY  (ESSN,PNO));
-- ----------------------------------------------------------------------------

--
-- Inserting multiple values into the Works_On table ------------------------------------------
INSERT INTO Works_On (ESSN, PNO, HOURS) VALUES 
(123456789, 1, 32.5),
(123456789, 2, 7.5),
(333445555, 2, 10.0),
(333445555, 3, 10.0),
(333445555, 10, 10.0),
(333445555, 20, 10.0),
(453453453, 1, 20.0),
(453453453, 2, 20.0),
(666884444, 3, 40.0),
(888665555, 20, NULL),
(987654321, 20, 15.0),
(987654321, 30, 20.0),
(987987987, 10, 35.0),
(987987987, 30, 5.0),
(999887777, 10, 10.0),
(999887777, 30, 30.0);

-- ----------------------------------------------


-- Making the MGRSSN of Department table as Foreign KEY which references to SSN of Employee table-------------------------------------
ALTER TABLE Department ADD  FOREIGN KEY (MGRSSN) REFERENCES Employee (SSN);

-- Making the ESSN of Dependent table as Foreign KEY which references to SSN of Employee table-------------------------------------
ALTER TABLE Dependent ADD FOREIGN KEY (ESSN) REFERENCES Employee (SSN);

-- 
-- Making the DNUMBER of Dept_Locations table as Foreign KEY which references to DNUMBER of Department table-------------------------------------
ALTER TABLE Dept_Locations ADD FOREIGN KEY (DNUMBER) REFERENCES Department (DNUMBER);

-- 
-- Making the DNO of Employee table as Foreign KEY which references to DNUMBER of Department table-------------------------------------
ALTER TABLE Employee ADD FOREIGN KEY (DNO) REFERENCES Department (DNUMBER);

-- Making the SUPERSSN of Employee table as Foreign KEY which references to SSN of the same table (Employee table)-------------------------------------
ALTER TABLE Employee ADD  FOREIGN KEY (SUPERSSN) REFERENCES Employee (SSN);

-- 
-- Making the DNUM of Project table as Foreign KEY which references to DNUMBER of Department table-------------------------------------
ALTER TABLE Project ADD FOREIGN KEY (DNUM) REFERENCES Department (DNUMBER);

-- 
-- Making the ESSN of Works_On table as Foreign KEY which references to SSN of Employee table-------------------------------------
ALTER TABLE Works_On ADD  FOREIGN KEY (ESSN) REFERENCES Employee (SSN);

-- 
-- Making the PNO of Works_On table as Foreign KEY which references to PNUMBER of Project table-------------------------------------
ALTER TABLE Works_On  ADD FOREIGN KEY (PNO) REFERENCES Project (PNUMBER);


SELECT * FROM Department;