use Company;

DELIMITER $$
CREATE TRIGGER trg_MinSalary
BEFORE INSERT ON Employee
FOR EACH ROW
BEGIN
    IF NEW.Salary < 20000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Salary must be at least 20000!";
    END IF;
END$$
DELIMITER ;

desc `EMPLOYEE`;

insert into `EMPLOYEE` VALUES 
('foo', 'b', 'baz', 'abcdefghi', '2025-01-01', 'akjshdkajs', 'M', 10, 'jklmnopqr', 2);