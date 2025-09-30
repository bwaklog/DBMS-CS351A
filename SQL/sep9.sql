use Company;

with dept5 as (
    SELECT dno, COUNT(*) as no_emps
    from `EMPLOYEE`
    GROUP BY dno
    HAVING COUNT(*) > 5
) select e.fname, e.lname, e.salary
from `EMPLOYEE` as e, dept5 as d
where e.dno = d.dno and e.salary > 40000;

with empavg as (
    select AVG(salary) as avg_sal
    from `EMPLOYEE`
) select e.fname, e.lname, e.salary
from `EMPLOYEE` as e, empavg as a
where salary > avg_sal;

-- with emp40k as (
--     select fname, dno
--     from `EMPLOYEE`
--     where salary > 40000
-- ), with dept as (
--     SELECT `Dnumber`, `Dname`
--     from `DEPARTMENT`
-- ) SELECT e.fname, d.`Dnumber`, 

with recursive countdown(n) as
    (
        SELECT 5
        UNION ALL
        SELECT n - 1
        from countdown
        where n > 1
    )
    SELECT n from countdown;

with recursive hierarchy_cte as
(
    select *, lev as 1
    from `EMPLOYEE`
    where superssn is null
    union all
    select *, lev + 1
    from `EMPLOYEE` as e, hierarchy_cte as h
    where h.ssn = e.superssn
)
SELECT * from hierarchy_cte;

with RECURSIVE hierarchy_cte as (
    select ssn, fname, superssn, 1 as level
    from `EMPLOYEE`
    where superssn is null
    union all
    select e.ssn, e.fname, e.superssn, level + 1
    from `EMPLOYEE` as e, hierarchy_cte as h
    where h.ssn = e.superssn
)
select *
from hierarchy_cte;