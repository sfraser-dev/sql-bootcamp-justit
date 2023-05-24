DROP DATABASE IF EXISTS car_breakdown_company;
CREATE DATABASE car_breakdown_company;
USE car_breakdown_company;

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