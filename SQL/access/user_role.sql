CREATE ROLE manager;

GRANT create table, create view TO manager;

--Grant a role to users

GRANT manager TO SAM, STARK;
--Grant succeeded.

REVOKE create table FROM manager;
--Drop a Role :

DROP ROLE manager;

> mysql -u root -p  
Enter password: *********  
mysql> use mysql;  
Database changed  
mysql> SELECT user FROM user;  

Select user from mysql.user;  

--To get the selected information like as hostname, password 
--expiration status, and account locking, execute the query as 
--below:

mysql> SELECT user, host, account_locked, password_expired 
FROM user;  

CREATE USER 'username'@'host' IDENTIFIED WITH 
authentication_plugin 
BY 'password';

ALTER USER 'sammy'@'localhost' 
IDENTIFIED WITH mysql_native_password BY 'password';

CREATE USER 'sammy'@'localhost' 
IDENTIFIED WITH mysql_native_password BY 'password';

--Note: If your root MySQL user is configured to 
--authenticate with a password, you will need to use a 
--different command to access the MySQL shell. 
--The following will run your MySQL client with 
--regular user privileges, and you will only gain 
--administrator privileges within the database by 
--authenticating with the correct password:

mysql -u root -p

GRANT PRIVILEGE ON database.table 
TO 'username'@'host';

GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, 
SELECT, REFERENCES, RELOAD on *.* TO 
'sammy'@'localhost' 
WITH GRANT OPTION;

--Warning: Some users may want to grant their MySQL 
--user the ALL PRIVILEGES privilege, which will provide 
--them with broad superuser privileges akin to the 
--root user’s privileges, like so:

GRANT ALL PRIVILEGES ON *.* TO 'sammy'@'localhost' 
WITH GRANT OPTION;
--Such broad privileges should not be granted lightly, 
--as anyone with access to this MySQL user will have 
--complete control over every database on the server.

--https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql


--Flush privileges. mysql> FLUSH PRIVILEGES; 
--when we grant some
 --privileges for a user, running the command 
 --flush privileges 
-- will reloads the grant tables in the mysql 
--database enabling
-- the changes to take effect 
--without reloading or restarting mysql service. Flush TABLES
--To tell the server to reload the grant tables, perform a 
--flush-privileges operation. This can be done by issuing a 
--FLUSH PRIVILEGES statement or by executing.
mysql> CREATE DATABASE test_company;
Query OK, 1 row affected (0.23 sec)

mysql> CREATE USER 'test_user'@'localhost' 
IDENTIFIED BY 'PASSWORD';
Query OK, 0 rows affected (0.26 sec)

mysql> GRANT ALL PRIVILEGES 
ON test_company.* TO 'test_user'@'localhost';
Query OK, 0 rows affected (0.08 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.04 sec)

mysql> CREATE USER 'Sunita'@'localhost' 
IDENTIFIED BY 'sun123';
Query OK, 0 rows affected (0.24 sec)

mysql> SELECT USER FROM MySQl.user;
+------------------+
| USER             |
+------------------+
| Sunita           |
| mysql.infoschema |
| mysql.session    |
| mysql.sys        |
| root             |
| test_user        |
+------------------+
6 rows in set (0.00 sec)

mysql> GRANT ALL PRIVILEGES ON * . * 
TO 'Sunita'@'localhost';
Query OK, 0 rows affected (0.12 sec)

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u Sunita -p
Enter password: ******
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 12
Server version: 8.0.30 MySQL Community Server - GPL

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>

GRANT UPDATE, DELETE, SELECT on .* 
TO 'sammy'@'localhost' WITH GRANT OPTION;


mysql> GRANT CREATE, ALTER, DROP ON 
company.department TO 'Sunita'@'localhost';
Query OK, 0 rows affected (0.04 sec)
--****************************************--
revoke all privileges on *.* from 'Sunita'@'localhost';

grant CREATE, ALTER, DROP, INSERT, UPDATE, 
DELETE, REFERENCES on company.department 
TO 'Sunita'@'localhost';
Query OK, 0 rows affected (0.04 sec)

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u Sunita -p
Enter password: ******

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| company            |
| information_schema |
| performance_schema |
+--------------------+
3 rows in set (0.00 sec)

mysql> use company;
Database changed
mysql> show tables;
+-------------------+
| Tables_in_company |
+-------------------+
| department        |
+-------------------+
1 row in set (0.00 sec)

mysql> select * from department;
ERROR 1142 (42000): SELECT command denied to user 
'Sunita'@'localhost' for table 'department'



********************************************************************

CREATE ROLE 'student_ReadOnly';
GRANT SELECT ON * . * TO 'student_ReadOnly';
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';


GRANT 'student_ReadOnly' TO 'newuser'@'localhost';

CREATE ROLE samplerole@localhost;
CREATE ROLE IF NOT EXISTS 'testrole@localhost';

--to view exixiting users
SELECT user, host FROM user;
SELECT user, host FROM mysql.user;
 --To see current logged-in user:
SELECT USER();
--To see all privileges of a specific user:
SHOW GRANTS FOR 'username'@'host'; 
--To see all privileges of a specific user:
--drop wrong user which we created
DROP USER IF EXISTS 'student_Readonly'@'%';
--or
DROP USER 'student_ReadOnly'@'%';
DROP USER 'student_ReadOnly'@'localhost';
