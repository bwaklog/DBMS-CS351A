-- CREATE TABLE `tbldepartment` (
--   `Dname` varchar(15) NOT NULL,
--   `Dnumber` int NOT NULL,
--   `Mgr_ssn` char(9) DEFAULT NULL,
--   `Mgr_start_date` date DEFAULT NULL,
--   PRIMARY KEY (`Dnumber`),
--   UNIQUE KEY `Dname` (`Dname`)
-- );

CREATE TABLE `tblemployee` (
  `fname` varchar(20) NOT NULL,
  `minit` varchar(1) DEFAULT NULL,
  `lname` varchar(15) NOT NULL,
  `ssn` char(9) NOT NULL,
  `bdate` date DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `superssn` char(9) DEFAULT NULL,
  `dno` int DEFAULT NULL,
  PRIMARY KEY (`ssn`),
  KEY `fk_employee_department` (`dno`),
  CONSTRAINT `fk_employee_department` FOREIGN KEY (`dno`) REFERENCES `tbldepartment` (`Dnumber`) ON DELETE SET NULL ON UPDATE CASCADE
)

describe tblemployee;

-- alter table tblemployee
-- add column doj date after ssn;

-- alter table tbldepartment
-- change column mgr_ssn manage_id char(9);

-- select * from tbldepartment;
