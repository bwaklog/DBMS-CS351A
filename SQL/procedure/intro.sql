use company;

DELIMITER $$

create PROCEDURE inform_supervisor111(
    IN superssnl char(9),
    IN sal decimal(10, 2)
)
BEGIN
    DECLARE empsal DECIMAL(10, 2);
    DECLARE supersal DECIMAL(10, 2);
    set empsal=sal;
    set supersal = (SELECT salary from employee where ssn=superssn);

    IF empsal > supersal then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'employee salary cannot be more than supervisor';
    end if;
END$$

DELIMITER ;

select * from `EMPLOYEE`

delimiter $$
create trigger salary_violation11
before insert
on employee
for each row
    begin
        if (new.salary > (
            select salary from employee
            where ssn=new.superssn
        )) then
            call inform_supervisor111(new.superssn, new.salary);
        end if;
    end $$

DELIMITER ;

CALL inform_supervisor111();