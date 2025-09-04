use Company;

SELECT fname, lname
from `Company`.`EMPLOYEE`
where salary > (
    select MAX(salary)
    from `Company`.`EMPLOYEE`
    WHERE dno = 5
);

select e.fname, e.lname
from `Company`.`EMPLOYEE` as e
where e.ssn in (
    select d.essn
    from `Company`.`DEPENDENT` as d
    where e.ssn = d.essn and e.fname = d.dependent_name and e.sex = d.sex
)

select e.fname, e.lname
from `Company`.`EMPLOYEE` as e 
where EXISTS (
    select d.essn
    from `Company`.`DEPENDENT` as d
    where e.ssn = d.essn and e.fname = d.dependent_name and e.sex = d.sex
)

SELECT count(*) from `Company`.`EMPLOYEE`

select e.fname, e.lname
from `Company`.`EMPLOYEE` as e
where NOT EXISTS (
    select d.essn
    from `Company`.`DEPENDENT` as d
    where e.ssn = d.essn
)

select *
from `Company`.`DEPENDENT`
where essn = 123456789;

select * 
FROM `Company`.`EMPLOYEE`
where ssn = 123456789;

select e.fname, e.lname
from `Company`.`EMPLOYEE` as e
where EXISTS (
    select *
    from `Company`.`DEPARTMENT`
    where e.ssn = `Mgr_ssn`
) and EXISTS (
    select essn
    from `Company`.`DEPENDENT`
    where e.ssn = essn
)



-- select *
-- from `Company`.`PROJECT` as p inner join `Company`.`WORKS_ON` as w
-- on p.pnumber = w.pno
-- where p.dnum = 4

select e.ssn
from `Company`.`EMPLOYEE` as e
where (
    select w.pno
    from `Company`.`WORKS_ON` as w
    where w.essn = e.ssn
)

select pnumber
from `Company`.`PROJECT`
where dnum=4;

select pno
from `Company`.`WORKS_ON`
where essn = ssn

select *
from (
    select dno, AVG(salary)
    from `Company`.`EMPLOYEE`
    GROUP BY dno
) as dept_avg(dno, avg_salary)
where avg_salary > 32000

select *
from (
    select dno, SUM(salary)
    from `Company`.`EMPLOYEE`
    group by dno
) as dep_sal(dno, total_sal)
ORDER BY total_sal DESC
LIMIT 1

WITH max_work(max_hours) AS
(select MAX(hours) from `Company`.`WORKS_ON`)
select essn, pno, max_hours
from `Company`.`WORKS_ON`, max_work
where hours = max_hours