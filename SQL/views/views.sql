-- Authors Table
CREATE TABLE Authors (
    Author_ID VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Age INT,
    Email VARCHAR(50) UNIQUE,
    Bio TEXT,
    Password VARCHAR(50) NOT NULL
);

-- Insert values into Authors table
INSERT INTO Authors (Author_ID, Name, Age, Email, Bio, Password) VALUES
('A001', 'Alice Johnson', 35, 'alice.johnson@example.com', 'Expert in AI and ML', 'password123'),
('A002', 'Bob Smith', 40, 'bob.smith@example.com', 'Data Scientist', 'password456'),
('A003', 'Carol White', 28, 'carol.white@example.com', 'Researcher in NLP', 'password789'),
('A004', 'David Brown', 50, 'david.brown@example.com', 'Professor in Quantum Computing', 'password321'),
('A005', 'Eve Davis', 32, 'eve.davis@example.com', 'Cloud Computing Specialist', 'password654'),
('A006', 'Frank Martin', 45, 'frank.martin@example.com', 'Expert in Computer Vision', 'password987'),
('A007', 'Grace Lee', 30, 'grace.lee@example.com', 'Cryptography Enthusiast', 'password147'),
('A008', 'Henry Wilson', 27, 'henry.wilson@example.com', 'Cybersecurity Analyst', 'password258'),
('A009', 'Ivy Scott', 34, 'ivy.scott@example.com', 'Data Engineering Expert', 'password369');

show tables;
desc authors;
select * from authors;

-- View to get Experienced Authors(Age>=30 and Bio has the word "Expert")
create view experienced_authors as 
select * from authors 
where age>=30 and Bio like '%Expert%';

select * from experienced_authors;

-- Inserting a new experienced author
insert into experienced_authors (Author_ID, Name, Age, Email, Bio, Password) 
values ("A010", "John Wick", 52, "john.wick@example.com", "Expert in Pencils", "password567");

-- Updating Alice's Age to 40 from 35
update experienced_authors set Age=40 where Author_ID='A001';

-- Updated Table with changes
select * from experienced_authors;

-- Deleting Ivy Scott (A009) from the view 
delete from experienced_authors where Author_ID="A009" and Name="Ivy Scott";
select * from experienced_authors;

-- All the crud operations are reflected on the original table as well
select * from authors;


show full tables
where table_type like 'VIEW';

create view above35 as 
select * from authors
where (age > 35) with CASCADED check option;

select * from above35;

insert into above35 (Author_ID, Name, Age, Email, Bio, Password) 
values ("A232", "Ben Dover", 20, "ben.dover@example.com", "expert in ur mom", "urmom");


