DROP DATABASE IF EXISTS car_breakdown_company;
CREATE DATABASE car_breakdown_company;
USE car_breakdown_company;

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
(1, 'ABC123', 'RST321', '2023-05-24', '10:00', 'New York'),
(2, 'DEF456', 'UVW654', '2023-05-24', '11:00', 'Los Angeles'),
(3, 'GHI789', 'XYZ987', '2023-05-24', '12:00', 'Chicago'),
(4, 'JKL012', 'RST321', '2023-06-01', '10:00', 'Dallas'),
(5, 'MNO345', 'XYZ987', '2023-06-01', '11:00', 'Miami'),
(6, 'ABC123', 'RST321', '2023-06-01', '12:00', 'New York'),
(7, 'DEF456', 'UVW654', '2023-06-01', '10:00', 'Los Angeles'),
(8, 'GHI789', 'XYZ987', '2023-06-01', '11:00', 'Chicago'),
(9, 'JKL012', 'RST321', '2023-06-01', '12:00', 'Dallas'),
(10, 'MNO345', 'UVW654', '2023-06-01', '10:00', 'Miami');
