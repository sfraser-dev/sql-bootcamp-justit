DROP DATABASE IF EXISTS car_breakdown_company;
CREATE DATABASE car_breakdown_company;
USE car_breakdown_company;

/*******************************************************************
****************************** TASK 1 ****************************** 
*******************************************************************/
 
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

  PRIMARY KEY (VehReg)
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

  PRIMARY KEY (VanReg)
);

CREATE TABLE Breakdown (
  BDID int NOT NULL,
  VehReg varchar(10) NOT NULL,
  VanReg varchar(10) NOT NULL,
  BDDATE date NOT NULL,
  BDTIME time NOT NULL,
  BDLoc varchar(20) NOT NULL,

  PRIMARY KEY (BDID)
);

-- Set the foreign keys after table creation using the ALTER command.
ALTER TABLE Vehicle
ADD CONSTRAINT FK_Vehicle_MemberID FOREIGN KEY (MemberID) REFERENCES Members (MemberID);

ALTER TABLE EngVan
ADD CONSTRAINT FK_EngVan_EngID FOREIGN KEY (EngID) REFERENCES Engineer (EngID);

ALTER TABLE Breakdown
ADD CONSTRAINT FK_Breakdown_VehReg FOREIGN KEY (VehReg) REFERENCES Vehicle (VehReg);

ALTER TABLE Breakdown
ADD CONSTRAINT FK_Breakdown_VanReg FOREIGN KEY (VanReg) REFERENCES EngVan (VanReg);


/*******************************************************************
****************************** TASK 2 ****************************** 
*******************************************************************/

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
('JKL123', 'Chevy', 'Silverado', '4'),
('MNO345', 'Kia', 'Sportage', '5'),
('PQR678', 'Ferrari', 'F40', '3'),
('STU901', 'BMW', 'i5', '2'),
('VWX234', 'Porsche', '911', '3');

INSERT INTO Engineer (EngID, EFName, ELName) VALUES
('1', 'Tim', 'Spanner'),
('2', 'Freddy', 'Wrench'),
('3', 'Joyce', 'Hammer');

INSERT INTO EngVan (VanReg, VanMake, VanModel, EngID, VMileage) VALUES
('LMN654', 'Honda', 'Hilux', '1', 10000),
('OPQ987', 'Jeep', 'Wrangler', '2', 10000),
('RST321', 'Honda', 'Civic', '3', 10000),
('UVW654', 'Toyota', 'Camry', '2', 20000),
('XYZ987', 'Ford', 'F-150', '1', 30000);

INSERT INTO Breakdown (BDID, VehReg, VanReg, BDDATE, BDTIME, BDLoc) VALUES
(1, 'ABC123', 'RST321', '2023-02-20', '09:45', 'New York'),
(2, 'DEF456', 'UVW654', '2023-02-24', '17:45', 'Los Angeles'),
(3, 'GHI789', 'XYZ987', '2023-02-24', '18:15', 'Chicago'),
(4, 'ABC123', 'RST321', '2023-03-01', '18:00', 'New York'),
(5, 'MNO345', 'XYZ987', '2023-03-12', '18:45', 'Miami'),
(6, 'VWX234', 'OPQ987', '2023-03-23', '09:00', 'Chicago'),
(7, 'DEF456', 'UVW654', '2023-04-28', '09:30', 'Los Angeles'),
(8, 'JKL123', 'XYZ987', '2023-04-03', '22:30', 'Dallas'),
(9, 'MNO345', 'RST321', '2023-04-18', '08:45', 'Miami'),
(10, 'ABC123', 'LMN654', '2023-04-27', '23:30', 'Boston'),
(11, 'PQR678', 'RST321', '2023-05-10', '17:15', 'Chicago'),
(12, 'GHI789', 'OPQ987', '2023-05-20', '07:45', 'New York');
-- NB: 'STU901' is the only vehicle without a breakdown recorded.

/*******************************************************************
****************************** TASK 3 ****************************** 
*******************************************************************/

-- 3.1 Names of members who live in NY.
SELECT MFName AS 'first name', MLName AS 'last name' FROM Members WHERE MLoc = 'New York';

-- 3.2 All vehicles registered to the company.
SELECT VehReg AS 'vehicle registration', VehMake AS 'vehicle make', VehModel AS 'vehicle model' FROM Vehicle;

-- 3.3 The number of engineers that work for the company.
SELECT COUNT(*) AS 'number of engineers in the company' FROM Engineer;

-- 3.4 The number of members registered.
SELECT COUNT(*) AS 'number of registered members' FROM Members;

-- 3.5 All the breakdowns after March.
SELECT BDID AS 'breakdown ID', VehReg AS 'vehicle reg', VanReg AS 'van registration',
BDDATE AS 'breakdown date', BDTIME AS 'breakdown time', BDLoc AS 'breakdown location'
FROM Breakdown WHERE BDDATE >= '2023-04-01';

-- 3.6 All the breakdowns between March 1st and March 31st inclusive.
SELECT BDID AS 'breakdown ID', VehReg AS 'vehicle reg', VanReg AS 'van registration',
BDDATE AS 'breakdown date', BDTIME AS 'breakdown time', BDLoc AS 'breakdown location'
FROM Breakdown WHERE BDDate BETWEEN '2023-03-01' AND '2023-03-31';

-- 3.7 The number of times member vehicle with registration 'DEF456' has broken down.
SELECT COUNT(*) AS 'number of times vehicle "DEF456" has broken down' FROM Breakdown WHERE VehReg = 'DEF456'; 

-- 3.8 The number of vehicles that have broken down more than once.
-- List the number of times each vehicle has broken down.
SELECT VehReg AS 'vehicle registration', COUNT(*) AS 'number of breakdowns' FROM Breakdown GROUP BY VehReg;
-- List only the vehicles that have broken down more than once.
SELECT VehReg AS 'vehicle registration', COUNT(*) AS 'number of breakdowns' FROM Breakdown GROUP BY VehReg HAVING COUNT(*) >= 2;

/*******************************************************************
****************************** TASK 4 ****************************** 
*******************************************************************/

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

/*******************************************************************
****************************** TASK 5 ****************************** 
*******************************************************************/

-- Add MTID column to members, allow null and set it to FK.
ALTER TABLE Members ADD MTID INT NULL;
ALTER TABLE Members ADD CONSTRAINT Members_MTID_FKmembers FOREIGN KEY (MTID) REFERENCES MshipType (MTID);

-- Assign values to the foreign keys in Members. 
UPDATE Members SET MTID=3 WHERE MemberID=1;
UPDATE Members SET MTID=1 WHERE MemberID=2;
UPDATE Members SET MTID=2 WHERE MemberID=3;
UPDATE Members SET MTID=2 WHERE MemberID=4;
UPDATE Members SET MTID=3 WHERE MemberID=5;
UPDATE Members SET MTID=1 WHERE MemberID=6;
UPDATE Members SET MTID=2 WHERE MemberID=7;
UPDATE Members SET MTID=2 WHERE MemberID=8;

/*******************************************************************
****************************** TASK 6 ****************************** 
*******************************************************************/

-- 6.1 Show all the vehicles that each member owns.
SELECT Members.MemberID AS 'member ID', Members.MFName AS 'member first name', Members.MLName AS 'member last name',
Vehicle.VehMake AS 'vehicle make', Vehicle.VehModel AS 'vehicle model'
FROM Members
INNER JOIN Vehicle ON Members.MemberID = Vehicle.MemberID
ORDER BY Members.MemberID;

-- 6.2 Show how many vehicles each member owns in descending order.
SELECT COUNT(Vehicle.VehReg) AS 'vehicles owned', Members.MFName AS 'member first name',
Members.MLName AS 'member last name', Members.MemberID AS 'member ID'
FROM Members
INNER JOIN Vehicle ON Members.MemberID = Vehicle.MemberID
GROUP BY Members.MemberID, Members.MFName, Members.MLName
ORDER BY COUNT(Vehicle.VehReg) DESC;

-- 6.3 The number of vans driven by a particular engineer.
SELECT COUNT(*) AS 'number of vans driven', Engineer.EFName AS 'engineer first name',
Engineer.ELname AS 'engineer last name', EngVan.EngID AS 'engineer ID'
FROM EngVan
INNER JOIN Engineer ON Engineer.EngID = EngVan.EngID
GROUP BY EngVan.EngID, Engineer.EFName, Engineer.ELName;

-- 6.4 All vehicles that have broken down in a particular location along with member details.
SELECT Breakdown.BDLoc AS 'breakdown location', Breakdown.BDDATE AS 'breakdown date',
Breakdown.VehReg AS 'vehicle registration',
Members.MFName AS 'member first name', Members.MLName AS 'member last name'
FROM Breakdown 
INNER JOIN Vehicle ON Breakdown.VehReg = Vehicle.VehReg
INNER JOIN Members ON Vehicle.MemberID = Members.MemberID
ORDER BY Breakdown.BDLoc;

-- 6.5 List of all vehicles that broke down with member details and the engineer who attended.
SELECT Breakdown.BDID AS 'breakdown ID', Breakdown.BDDATE AS 'breakdown date', Breakdown.VehReg AS 'broken down vehicle',
Members.MFName AS 'member first name', Members.MLName AS 'member last name',
Vehicle.VehMake AS 'vehicle make' , Vehicle.VehModel AS 'vehicle model',
Engineer.EFName AS 'attending engineer first name', Engineer.ELName AS 'attending engineer last name'
FROM Breakdown
LEFT JOIN EngVan ON Breakdown.VanReg = EngVan.VanReg
LEFT JOIN Vehicle ON Breakdown.VehReg = Vehicle.VehReg
LEFT JOIN Members ON Vehicle.MemberID = Members.MemberID
LEFT JOIN Engineer ON EngVan.EngID = Engineer.EngID;

-- 6.6 List of all breakdowns with member and engineer details between March 20th and April 20th.
SELECT Breakdown.BDDate AS 'breakdown date', Breakdown.BDID AS 'breakdown ID',
Members.MFName AS 'member first name', Members.MLName AS 'member last name',
Engineer.EFName AS 'attending engineer first name', Engineer.ELName AS 'attending engineer last name'
FROM Breakdown 
LEFT JOIN EngVan ON Breakdown.VanReg = EngVan.VanReg
LEFT JOIN Vehicle ON Breakdown.VehReg = Vehicle.VehReg
LEFT JOIN Members ON Vehicle.MemberID = Members.MemberID
LEFT JOIN Engineer ON EngVan.EngID = Engineer.EngID
WHERE Breakdown.BDDate BETWEEN '2023-03-20' AND '2023-04-20';

-- 6.7.1 Show the breakdown dates and locations attended by each engineer.
SELECT Engineer.EFname AS 'engineer first name', Engineer.ELName AS 'engineer last name',
Breakdown.BDDATE AS 'breakdown date', Breakdown.BDLoc AS 'breakdown location'
FROM Breakdown 
LEFT JOIN EngVan ON Breakdown.VanReg = EngVan.VanReg
LEFT JOIN Engineer ON EngVan.EngID = Engineer.EngID
ORDER BY Engineer.EFName;

-- 6.7.2 List of all breakdowns with member and engineer details that occurred in the afternoon.
SELECT Breakdown.BDDate AS 'breakdown date', Breakdown.BDTIME AS 'breakdown time',
Breakdown.BDID AS 'breakdown ID', Members.MFName AS 'member first name', Members.MLName AS 'member last name',
Engineer.EFName AS 'attending engineer first name', Engineer.ELName AS 'attending engineer last name'
FROM Breakdown
LEFT JOIN EngVan ON Breakdown.VanReg = EngVan.VanReg
LEFT JOIN Vehicle ON Breakdown.VehReg = Vehicle.VehReg
LEFT JOIN Members ON Vehicle.MemberID = Members.MemberID
LEFT JOIN Engineer ON EngVan.EngID = Engineer.EngID
WHERE Breakdown.BDTIME BETWEEN '12:00:00' AND '23:59:59'
ORDER BY Breakdown.BDTIME;

-- 6.7.3 List the engineers that attended breakdowns in New York.
SELECT Engineer.EFname AS 'engineer first name', Engineer.ELName AS 'engineer last name',
Breakdown.BDID AS 'breakdown ID', Breakdown.BDDATE AS 'breakdown date', 
Breakdown.BDLoc AS 'breakdown location'
FROM Breakdown
LEFT JOIN EngVan ON Breakdown.VanReg = EngVan.VanReg
LEFT JOIN Engineer ON EngVan.EngID = Engineer.EngID
WHERE Breakdown.BDLoc = 'New York';

/*******************************************************************
****************************** TASK 7 ****************************** 
*******************************************************************/

-- Create a new database.
DROP DATABASE IF EXISTS humans;
CREATE DATABASE humans;
USE humans;

-- Create a new table in the database.
CREATE TABLE People (
  FirstName varchar(20) NOT NULL,
  LastName varchar(20) NOT NULL,
  HeightInCM FLOAT(5,2) NOT NULL,
  Age INT NOT NULL
);  

-- Populate the new database.
INSERT INTO People VALUES
('Alice', 'Aitken', 150.15, 32),
('Bob', 'Butler', 195.22, 38),
('Charles', 'Cooper', 165.45, 55),
('Diana', 'Drapper', 160.87, 27),
('Edgar', 'Ellison', 175.38, 42);

-- Average function: find the average value of the records in a particular table's field. 
SELECT ROUND(AVG(People.HeightInCM),2) AS 'average height' FROM People;

-- Max function: find the maximum record value in a particular table's field. 
SELECT MAX(People.Age) AS 'maximum age' FROM People;

-- Min function: find the minimum record value in a particular table's field. 
SELECT MIN(People.Age) AS 'minimum age' FROM People;

-- Sum function: find the sum of all records in a particular table's field. 
SELECT SUM(People.Age) AS 'sum of all ages' FROM People;

/*******************************************************************
****************************** TASK 8 ****************************** 
*******************************************************************/

-- Switch back to the car breakdown company database.
USE car_breakdown_company;

-- 8.1 Reporting policy type in a temporary field using an if statement to deduce if it's a single-car or multi-car policy. 
SELECT
COUNT(Vehicle.VehReg) AS 'vehicles owned',
Members.MFName AS 'member first name',
Members.MLName AS 'member last name', Members.MemberID AS 'member ID',
IF (COUNT(Vehicle.VehReg) > 1, 'Multi-Car', 'Single-Car') AS 'policy type'
FROM Members
INNER JOIN Vehicle ON Members.MemberID = Vehicle.MemberID
GROUP BY Members.MemberID, Members.MFName, Members.MLName
ORDER BY COUNT(Vehicle.VehReg) DESC;

-- 8.2 Display adjustment to next premium in a temporary field for each vehicle based on the number of times that vehicle
-- has broken down. Left join into vehicle table so vehicle registrations that haven't had a breakdown are still present.
SELECT
Vehicle.VehReg AS 'vehicle registration',
COUNT(Breakdown.VehReg) AS 'number of breakdowns',
CASE
  WHEN COUNT(Breakdown.VehReg) > 2 THEN '+10%'
  WHEN COUNT(Breakdown.VehReg) = 2 THEN '+5%'
  WHEN COUNT(Breakdown.VehReg) = 1 THEN '--'
  WHEN COUNT(Breakdown.VehReg) = 0 THEN '-10%'
END AS 'adjustment to next premium'
FROM Vehicle
LEFT JOIN Breakdown ON Vehicle.VehReg = Breakdown.VehReg
GROUP BY Vehicle.VehReg
ORDER BY COUNT(Breakdown.VehReg) DESC;
