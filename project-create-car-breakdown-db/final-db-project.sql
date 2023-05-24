DROP DATABASE IF EXISTS CarBreakdownCompany;
CREATE DATABASE CarBreakdownCompany;
USE CarBreakdownCompany;

/*****************
***** TASK 1 ***** 
*****************/
 
-- Create tables for the database.
CREATE TABLE Members (
  MemberID varchar(10) NOT NULL,
  MFName varchar(20) NOT NULL,
  MLName varchar(20) NOT NULL,
  MLoc varchar(20) NOT NULL,

  PRIMARY KEY (MemberID)
);

CREATE TABLE Vehicle (
  VehReg varchar(10) NOT NULL,
  VehMake varchar(10) NOT NULL,
  VehModel varchar(10) NOT NULL,
  MemberID varchar(10) NOT NULL,

  PRIMARY KEY (VehReg),
  FOREIGN KEY (MemberID) REFERENCES Members (MemberID)
);

CREATE TABLE Engineer (
  EngID int NOT NULL,
  EFName varchar(20) NOT NULL,
  ELName varchar(20) NOT NULL,

  PRIMARY KEY (EngID)
);

CREATE TABLE EngVan (
  VanReg varchar(10) NOT NULL,
  VanMake varchar(10) NOT NULL,
  VanModel varchar(10) NOT NULL,
  EngID int NOT NULL,
  VMileage int NOT NULL,

  PRIMARY KEY (VanReg),
  FOREIGN KEY (EngID) REFERENCES Engineer (EngID)
);

CREATE TABLE Breakdown (
  BDID int NOT NULL,
  VehReg varchar(10) NOT NULL,
  VanReg varchar(10) NOT NULL,
  BDDATE date NOT NULL,
  BDTIME time NOT NULL,
  BDLoc varchar(20) NOT NULL,

  PRIMARY KEY (BDID),
  FOREIGN KEY (VehReg) REFERENCES Vehicle (VehReg),
  FOREIGN KEY (VanReg) REFERENCES EngVan (VanReg)
);

-- Set the foreign keys via the ALTER command.
ALTER TABLE Vehicle
ADD CONSTRAINT FK_Vehicle_MemberID
FOREIGN KEY (MemberID) REFERENCES Members (MemberID);

ALTER TABLE EngVan
ADD CONSTRAINT FK_EngVan_EngID
FOREIGN KEY (EngID) REFERENCES Engineer (EngID);

ALTER TABLE Breakdown
ADD CONSTRAINT FK_Breakdown_VehReg
FOREIGN KEY (VehReg) REFERENCES Vehicle (VehReg);

ALTER TABLE Breakdown
ADD CONSTRAINT FK_Breakdown_VanReg
FOREIGN KEY (VanReg) REFERENCES EngVan (VanReg);

/*****************
***** TASK 2 ***** 
*****************/

-- Add data to the tables.
INSERT INTO Members (MemberID, MFName, MLName, MLoc) VALUES
('1', 'John', 'Doe', 'New York'),
('2', 'Jane', 'Smith', 'Los Angeles'),
('3', 'Michael', 'Brown', 'Chicago'),
('4', 'Susan', 'Jones', 'Dallas'),
('5', 'Peter', 'Williams', 'Miami');

INSERT INTO Vehicle (VehReg, VehMake, VehModel, MemberID) VALUES
('ABC123', 'Honda', 'Civic', '1'),
('DEF456', 'Toyota', 'Camry', '2'),
('GHI789', 'Ford', 'F-150', '3'),
('JKL012', 'Chevy', 'Silverado', '4'),
('MNO345', 'Dodge', 'Ram', '5');

INSERT INTO Engineer (EngID, EFName, ELName) VALUES
('1', 'John', 'Doe'),
('2', 'Jane', 'Smith'),
('3', 'Michael', 'Brown');

INSERT INTO EngVan (VanReg, VanMake, VanModel, EngID, VMileage) VALUES
('RST321', 'Honda', 'Civic', '1', 10000),
('UVW654', 'Toyota', 'Camry', '2', 20000),
('XYZ987', 'Ford', 'F-150', '3', 30000);

INSERT INTO Breakdown (BDID, VehReg, VanReg, BDDATE, BDTIME, BDLoc) VALUES
(1, 'ABC123', 'RST321', '2023-05-20', '09:45', 'New York'),
(2, 'DEF456', 'UVW654', '2023-05-24', '17:45', 'Los Angeles'),
(3, 'GHI789', 'XYZ987', '2023-05-24', '18:15', 'Chicago'),
(4, 'ABC123', 'RST321', '2023-06-01', '18:00', 'Dallas'),
(5, 'MNO345', 'XYZ987', '2023-06-12', '18:45', 'Miami'),
(6, 'ABC123', 'RST321', '2023-06-23', '09:00', 'New York'),
(7, 'DEF456', 'UVW654', '2023-06-28', '09:30', 'Los Angeles'),
(8, 'JKL012', 'XYZ987', '2023-07-03', '22:30', 'Chicago'),
(9, 'MNO345', 'RST321', '2023-07-18', '08:45', 'Dallas'),
(10, 'JKL012', 'UVW654', '2023-08-012', '17:30', 'Miami');

/*****************
***** TASK 3 ***** 
*****************/

-- 3.1 Names of members who live in NY.
SELECT MFName, MLName FROM Members WHERE MLoc = 'New York';

-- 3.2 All vehicles registered to the company.
SELECT VehReg, VehMake, VehModel FROM Vehicle;

-- 3.3 The number of engineers that work for the company.
SELECT COUNT(*) AS 'number of engineers' FROM Engineer;

-- 3.4 The number of members registered.
SELECT COUNT(*) AS 'number of members' FROM Members;

-- 3.5 All the breakdowns after June.
SELECT * FROM breakdown WHERE BDDATE >= '2023-07-01';

-- 3.6 All the breakdowns between June 1st and June 30th inclusive.
SELECT * FROM breakdown WHERE BDDate BETWEEN '2023-06-01' AND '2023-06-30';

-- 3.7 The number of times member vehicle with registration 'DEF456' has broken down.
SELECT COUNT(*) AS 'number of times vehicle "DEF456" has broken down' FROM breakdown WHERE VehReg = 'DEF456'; 

-- 3.8 The number of vehicles that have broken down more than once.
-- List the number of times each vehicle has broken down.
SELECT VehReg, COUNT(*) AS 'number of breakdowns' FROM breakdown GROUP BY VehReg;
-- Return only the vehicles that have broken down more than once.
SELECT VehReg, COUNT(*) AS 'number of breakdowns' FROM breakdown GROUP BY VehReg HAVING COUNT(*) >= 2;

/*****************
***** TASK 4 ***** 
*****************/

-- Create membership type table.
CREATE TABLE MshipType (
  MTID INT NOT NULL AUTO_INCREMENT,
  Type VARCHAR(6) NOT NULL,
  MPrice DECIMAL(4, 2) NOT NULL,
  PRIMARY KEY (MTID)
);

-- Populate membership type table.
INSERT INTO MshipType (Type, MPrice) VALUES
('Gold', 99.99),
('Silver', 59.99),
('Bronze', 39.99);

/*****************
***** TASK 5 ***** 
*****************/
-- Add MTID column to members, allow null and set it to FK.
ALTER TABLE Members ADD MTID INT NULL;
ALTER TABLE Members ADD CONSTRAINT Members_MTID_FKmembers FOREIGN KEY (MTID) REFERENCES MshipType (MTID);
-- Assign values to the foreign keys in Members. 
UPDATE Members SET MTID=3 WHERE MemberID=1;
UPDATE Members SET MTID=1 WHERE MemberID=2;
UPDATE Members SET MTID=2 WHERE MemberID=3;
UPDATE Members SET MTID=2 WHERE MemberID=4;
UPDATE Members SET MTID=3 WHERE MemberID=5;