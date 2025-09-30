CREATE ROLE 'student_ReadOnly' @ 'localhost';
GRANT SELECT ON * . * TO 'student_ReadOnly'@'localhost';
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
GRANT 'student_ReadOnly'@ 'localhost' TO 'newuser'@'localhost';

CREATE ROLE 'manager'@ 'localhost';
GRANT create table, create view TO 'manager'@ 'localhost';
--Grant a role to users
GRANT 'manager'@ 'localhost' 
TO 'SAM'@ 'localhost', 'SUNITA'@ 'localhost';
--Grant succeeded.
REVOKE create table FROM 'manager'@ 'localhost';
--Drop a Role :
DROP ROLE manager;

-- use windows command prompt to acess mysql
--using  cd C:\Program Files\MySQL\MySQL Server 9.3\bin
--above change command works if you have set path variable

--type following
mysql -u root -p
--enter password for root USER
-- to check existing users in system 
Select user from mysql.user;  

--To get the selected information like as hostname, password 
--expiration status, and account locking, execute the query as 
--below:

SELECT user, host, account_locked, password_expired 
FROM user; 

GRANT ALL PRIVILEGES 
ON companydb.department TO 'newuser'@'localhost';

GRANT CREATE, ALTER, DROP ON 
company.department TO 'newuser'@'localhost';

GRANT UPDATE, DELETE, SELECT on *.* 
TO 'newuser'@'localhost' WITH GRANT OPTION;

revoke all privileges on *.* from 'newuser'@'localhost';

grant CREATE, ALTER, DROP, INSERT, UPDATE, 
DELETE, REFERENCES on company.Employee 
TO 'newuser'@'localhost';

-- to check if granted privileges workd
--login to different cmd prompt using following user
mysql -u newuser -p
--enter password
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| companydb          |
| information_schema |
| performance_schema |
+--------------------+
3 rows in set (0.013 sec)

mysql> use companydb;
Database changed
mysql> show tables;
+---------------------+
| Tables_in_companydb |
+---------------------+
| department          |
+---------------------+
1 row in set (0.389 sec)

mysql> select * from department;
ERROR 1142 (42000): SELECT command denied to user 
'newuser'@'localhost' for table 'department'

--in root user change PRIVILEGES 
GRANT CREATE, ALTER, DROP ON
    -> *.* TO 'newuser'@'localhost';
	
-- check in newuser login
--now you can acess all dbs and tables in newuser
use companydb;
Database changed
mysql> show tables;
+---------------------+
| Tables_in_companydb |
+---------------------+
| department          |
| dependent           |
| dept_locations      |
| employee            |
| project             |
| works_on            |
+---------------------+
6 rows in set (0.027 sec)

mysql> create table test(id int, name varchar(20),primary key(id));
Query OK, 0 rows affected (1.068 sec)
	
	

