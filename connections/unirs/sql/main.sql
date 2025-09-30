use unidb;

create table students (
    student_id int AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100),
    department VARCHAR(50)
);

create table subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100)
);

create table marks (
    mark_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- insert tables

-- INSERT INTO unidb.students (name, department) VALUES 
--     ('Alice Johnson', 'CSE'),
--     ('Bob Smith', 'ECE'),
--     ('Charlie Lee', 'ME'),
--     ('Diana Patel', 'CSE');

-- INSERT INTO unidb.subjects (name) VALUES 
--     ('Mathematics'),
--     ('Data Structures'),
--     ('Digital Electronics'),
--     ('Thermodynamics');

-- INSERT INTO unidb.marks (student_id, subject_id, marks) VALUES 
--     (1, 1, 85), 
--     (1, 2, 90), 
--     (2, 1, 78), 
--     (2, 3, 88), 
--     (3, 1, 65), 
--     (3, 4, 70),
--     (4, 2, 95), 
--     (4, 3, 89);

select * from unidb.students;
select * from unidb.subjects;
select * from unidb.marks;