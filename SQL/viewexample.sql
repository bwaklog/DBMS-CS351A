use company

SELECT * FROM employee;

create view emp_sal60K as 
(select * from employee where salary>60000);

select * from emp_sal60k;

insert into emp_sal60k values("neelam","L","S","111333444","1988-07-18","green garden layout",'F',67000,"888665555",1);
select * from emp_sal60k;
select * from employee;

update emp_sal60K set salary=40000 where ssn="111333444";
select * from emp_sal60k;
select * from employee;

Delete from emp_sal60K where ssn="111333444"; 
/*it will not delete through view as this data is not present 
in view. so no changes is done to base table as well*/
select * from emp_sal60k;
select * from employee;
/*data is deleted through view as its part of view aswell as base 
table*/
delete from employee where ssn="111111888";
select * from emp_sal60k;
select * from employee;


CREATE VIEW above80k AS
    SELECT * FROM employee
    WHERE(salary> 80000) WITH CASCADED CHECK OPTION;
select * from above80k;
select * from employee;

insert into above80k values("neelam","L","S","111333445","1988-07-18","green garden layout",'F',87000,"888665555",1);
select * from above80k;
select * from employee;

update emp_sal60K set salary=47000 where ssn="111333445";
select * from above80k;
select * from employee;
/*with check option, update to less salary is possible 
but in view that row will be removed similar to create view without
check option*/

insert into above80k values("neelam","L","S","111333446","1988-07-18","green garden layout",'F',44000,"888665555",1);
select * from above80k;
select * from employee;
/*12:06:43	insert into above80k values("neelam","L","S",
"111333446","1988-07-18","green garden layout",'F',44000,
"888665555",1)	Error Code: 1369. CHECK OPTION failed 
'company.above80k'	0.000 sec
Due to check option insert failed as salary is not more than 80K*/

