-- create schema bank;
-- use bank;

-- /* -- Table name: customer -*/  
-- CREATE TABLE employee (  
--     Employee_ID INT AUTO_INCREMENT PRIMARY KEY,  
--     employee_name VARCHAR(55),  
--     employee_salary int
-- );    
-- drop table department;
-- CREATE TABLE Department (  
-- 	DepartmentID INT AUTO_INCREMENT PRIMARY KEY,  
--     Department_name VARCHAR(55),  
--     Employee_ID int
-- ); 
--  drop table loan; 
-- /* -- Table name: balance -*/  
-- CREATE TABLE loan (  
--     loan_id INT AUTO_INCREMENT PRIMARY KEY,  
--     branch varchar(50),
--     amount int
-- ); 
-- drop table Borrower;
-- CREATE TABLE Borrower (  
--     CustID INT AUTO_INCREMENT PRIMARY KEY,  
--     CustName varchar(50),
--     loan_id int
-- );  

-- /* -- Data for customer table -*/  
-- INSERT INTO employee(employee_name,employee_salary)  
-- values
-- ('Arun Tiwari	',50000),
-- ('Sachin Rathi	',64000),
-- ('Harshal Pathak',	48000),
-- ('Arjun Kuwar	',46000),
-- ('Sarthak Gada	',62000),
-- ('Saurabh Sheik	',53000),
-- ('Shubham Singh	',29000),
-- ('Shivam Dixit	',54000),
-- ('Vicky Gujral	',39000),
-- ('Vijay Bose	',  28000);
--   
-- INSERT INTO Department(Department_Name,	Employee_ID)  
-- values
-- ('Production	',1),
-- ('Sales	        ',3),
-- ('Marketing	    ',4),
-- ('Accounts	    ',5),
-- ('Development	',7),
-- ('HR	        ',9),
-- ('Sales	        ',10);

-- INSERT INTO loan(branch,	amount)  
-- values
-- ('B1',	15000),
-- ('B2',	10000),
-- ('B3',	20000),
-- ('B4',	100000),
-- ('B5',	150000),
-- ('B6',	50000),
-- ('B7',	35000),
-- ('B8',	85000);

-- INSERT INTO Borrower(CustName,	loan_id)  
-- values
--   ('Sonakshi Dixit',	1),
--     ('Shital Garg	   ', 4),
--     ('Swara Joshi	   ', 5),
--     ('Isha Deshmukh',	2),
--     ('Swati Bose	   ', 7),
--     ('Asha Kapoor	    ',10),
--     ('Nandini Shah',	9);
--     
-- CREATE TABLE cust_info (  
--     CustID int,  
--     mobile VARCHAR(15),  
--     address VARCHAR(65)  
-- );  
-- INSERT INTO cust_info(CustID, mobile, address)  
-- VALUES(1, '598675498654', '777 Brockton Avenue, Abington MA 251'),   
--     (2, '698853747888', '337 Russell St, Hadley MA 103'),   
--     (3, '234456977555', '20 Soojian Dr, Leicester MA 154'),   
--     (4, '987656789666', '780 Lynnway, Lynn MA 19'),   
--     (5, '756489372222', '700 Oak Street, Brockton MA 23');  
--     
select * from employee ; 
select * from department;
select * from loan;
select * from Borrower;  

SELECT employee_name, employee_salary,Department_name  
FROM employee   
NATURAL JOIN Department;  

SELECT CustName, CustID, amount, mobile ,address  
FROM Borrower  
NATURAL JOIN loan  
NATURAL JOIN cust_info ;  

SELECT e.Employee_ID, e.Employee_Name, e.Employee_Salary, d.DepartmentID, d.Department_Name 
FROM employee e INNER JOIN department d ON e.Employee_ID = d.Employee_ID;  


SELECT l.Loan_ID, l.Branch, l.Amount, b.CustID, b.CustName 
FROM Loan l  JOIN Borrower b ON l.Loan_ID = b.Loan_ID;  

SELECT e.Employee_ID, e.Employee_Name, e.Employee_Salary, d.DepartmentID, d.Department_Name 
FROM employee e RIGHT OUTER JOIN department d ON e.Employee_ID = d.Employee_ID; 

 SELECT l.Loan_ID, l.Branch, l.Amount, b.CustID, b.CustName 
 FROM Loan l RIGHT OUTER JOIN Borrower b ON l.Loan_ID = b.Loan_ID; 
 
 SELECT e.Employee_ID, e.Employee_Name, e.Employee_Salary, d.DepartmentID, d.Department_Name 
 FROM department d LEFT OUTER JOIN employee e ON e.Employee_ID = d.Employee_ID 
 UNION SELECT e.Employee_ID, e.Employee_Name, e.Employee_Salary, d.DepartmentID, d.Department_Name 
 FROM department d RIGHT OUTER JOIN employee e ON e.Employee_ID = d.Employee_ID;  

SELECT l.Loan_ID, l.Branch, l.Amount, b.CustID, b.CustName 
FROM Loan l LEFT OUTER JOIN Borrower b ON l.Loan_ID = b.Loan_ID 
UNION SELECT l.Loan_ID, l.Branch, l.Amount, b.CustID, b.CustName 
FROM Loan l RIGHT OUTER JOIN Borrower b ON l.Loan_ID = b.Loan_ID;  

SELECT employee_name, employee_salary,Department_name  FROM employee   NATURAL JOIN Department; 
select * from cust_info;
