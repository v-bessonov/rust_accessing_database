CREATE SCHEMA MYSCHEMA;

CREATE TABLE MYSCHEMA.EMPLOYEES (
                                    EmployeeID INT NOT NULL AUTO_INCREMENT
    ,Name VARCHAR(50) NOT NULL
    ,Salary DOUBLE NOT NULL
    ,Region VARCHAR(50) NOT NULL
    ,PRIMARY KEY (EmployeeID)
);

CREATE TABLE MYSCHEMA.EMPLOYEES2 (
                                     EmployeeID INT NOT NULL AUTO_INCREMENT
    ,Name VARCHAR(50) NOT NULL
    ,Salary DOUBLE NOT NULL
    ,Region VARCHAR(50) NOT NULL
    ,Photo BLOB(16)
    ,PRIMARY KEY (EmployeeID)
);

CREATE TABLE MYSCHEMA.SKILLS (
                                 SkillID INT NOT NULL AUTO_INCREMENT
    ,EmployeeID INT NOT NULL
    ,Description VARCHAR(50) NOT NULL
    ,LEVEL INT DEFAULT 5
    ,PRIMARY KEY (SkillID)
    ,CONSTRAINT EmployeeFK FOREIGN KEY (EmployeeID) REFERENCES MYSCHEMA.EMPLOYEES(EmployeeID)
);

CREATE TABLE MYSCHEMA.CONTRACTS (
                                    EmployeeID INT NOT NULL
    ,StartDate DATE NOT NULL
    ,StartSalary DOUBLE NOT NULL
    ,PRIMARY KEY (EmployeeID)
    ,CONSTRAINT EmployeeContractFK FOREIGN KEY (EmployeeID) REFERENCES MYSCHEMA.EMPLOYEES(EmployeeID)
);

CREATE TABLE MYSCHEMA.PERSONS (
                                  PersonID INT NOT NULL AUTO_INCREMENT
    ,FirstName VARCHAR(50) NOT NULL
    ,LastName VARCHAR(50) NOT NULL
    ,Address1 VARCHAR(50) NOT NULL
    ,Address2 VARCHAR(50) NOT NULL
    ,Address3 VARCHAR(50) NOT NULL
    ,PRIMARY KEY (PersonID)
);

CREATE TABLE MYSCHEMA.DEPARTMENTS (
                                      DepartmentID INT NOT NULL AUTO_INCREMENT
    ,RegulatoryName VARCHAR(50)
    ,CommonName VARCHAR(50)
    ,PRIMARY KEY (DepartmentID)
);

-- Populate tables.
USE MYSCHEMA;

INSERT INTO MYSCHEMA.EMPLOYEES (Name, Salary, Region)
VALUES ('Andy', 25000.0, 'South Wales'), ('Mary', 42000.0, 'London');

INSERT INTO MYSCHEMA.EMPLOYEES2 (Name, Salary, Region)
VALUES ('Andy', 25000.0, 'South Wales'), ('Mary', 42000.0, 'London');

INSERT INTO MYSCHEMA.SKILLS (EmployeeID, Description, LEVEL)
VALUES (1, 'Football', 5), (1, 'Running', 3), (2, 'Sales', 4), (2, 'Math', 2);

INSERT INTO MYSCHEMA.CONTRACTS (EmployeeID, StartDate, StartSalary)
VALUES (1, '2008-1-1', 10000), (2, '2009-1-1', 20000);

INSERT INTO MYSCHEMA.PERSONS (FirstName, LastName, Address1, Address2, Address3)
VALUES ('John', 'Smith', '1 Main St', 'Weston', 'Bath')
     , ('Jane', 'Evans', '2 High St', 'Newton', 'Neath');

INSERT INTO MYSCHEMA.DEPARTMENTS (RegulatoryName, CommonName)
VALUES ('MKT', 'Markets'), ('HR', NULL);