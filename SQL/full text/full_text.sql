create DATABASE social;

use social;

CREATE TABLE posts (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200),
    postbody TEXT,
    FULLTEXT (title, postbody)   -- Full-text index for searching
) ;

INSERT INTO posts (title, postbody) VALUES
    ('MySQL Tutorial', 'DBMS stands for DataBase ...'),
    ('How To Use MySQL Well', 'After you went through a ...'),
    ('Optimizing MySQL', 'In this tutorial, we show ...'),
    ('1001 MySQL Tricks', '1. Never run mysqld as root. 2. ...'),
    ('MySQL vs. YourSQL', 'In the following database comparison ...'),
    ('MySQL Security', 'When configured properly, MySQL ...');



--Search for a single word

SELECT * FROM posts
WHERE MATCH(title, postbody) AGAINST('tutorial');

use social;

select id, title, postbody,
    match(title, postbody) against ('database') as relevance
from posts
where match(title, postbody) against ('database')
order by relevance desc;

--Search for multiple words (ranked by relevance):
SELECT * FROM posts
WHERE MATCH(title, postbody) AGAINST('mysql tutorial');


--Phrase search (exact match):
SELECT * FROM posts
WHERE MATCH(title, postbody) AGAINST('"MySQL Tutorial"' 
IN BOOLEAN MODE);


--boolean MODE

use social;

select * from posts ;

SELECT id, title, postbody
FROM posts
WHERE MATCH(title, postbody)
      AGAINST('optim*' IN BOOLEAN MODE);

/*Explanation
optim* means find any word starting with "optim".
This matches:
Optimizing
Optimization
Optimal
etc.*/

-- try with "MyS*" also:This will return all rows 
--since every title has "MySQL" in it.
SELECT id, title
FROM posts
WHERE MATCH(title, postbody)
      AGAINST('mys*' IN BOOLEAN MODE);

--example 2

CREATE TABLE articles (
    article_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT,
    FULLTEXT (title, content)
);

INSERT INTO articles (title, content) VALUES
('Introduction to Databases', 
 'Databases are organized collections of data. MySQL is a popular open-source database.'),

('MySQL Optimization Techniques', 
 'Learn indexing, query plans, and caching to speed up MySQL queries.'),

('Oracle vs MySQL', 
 'Comparison of Oracle and MySQL databases based on performance and cost.'),

('PostgreSQL Guide', 
 'PostgreSQL is an advanced open-source RDBMS.'),

('Data Science and SQL', 
 'SQL plays a key role in data science workflows.'),

('MySQL Tutorial for Beginners', 
 'This MySQL tutorial covers basic to intermediate topics for new developers.'),

('Cooking for Beginners', 
 'This guide is about basic cooking techniques and not related to databases.');

-- find article that contains MySQL with natural language
select * from social.articles
where match(title, content) against('MySQL');

-- get relavence score for the term MySql
select title, content,
    match(title, content) against ('MySQL') as relevance
from social.articles
where match(title, content) against ('MySQL')
order by relevance desc;

-- find articles that MUST include MySQL but must not include Oracle
select * from social.articles
where match(title, content) against('+MySQL -Oracle' IN BOOLEAN MODE);

-- find articles that contain "tutorial" or "guide"
select * from social.articles
where match(title, content) against ('tutorial guide' in boolean mode);

-- find articles that must contain "data"la and any word that starts with "scien"  like science, scientist etc

select article_id, title, content,
    from social.articles
where match(title, content) against ('+data scien*' in boolean mode);


-- simple query expansion
select article_id, title,
    match(title, content) against('MySQL' with QUERY EXPANSION) as relevance
from social.articles
where match(title, content) against('MySQL' with QUERY EXPANSION)
order by relevance desc;

select article_id, title,
    match(title, content) against('MySQL' with QUERY EXPANSION) as relevance
from social.articles
order by relevance desc;

--example3
CREATE TABLE Authors (
    Author_ID   VARCHAR(10) PRIMARY KEY,
    Name        VARCHAR(100) NOT NULL,
    Age         INT CHECK (Age > 0),
    Email       VARCHAR(100) UNIQUE NOT NULL,
    Bio         VARCHAR(255),
    Password    VARCHAR(50) NOT NULL
);

ALTER TABLE Authors ADD FULLTEXT(name, email, bio);

INSERT INTO Authors (Author_ID, Name, Age, Email, Bio, Password) VALUES
('A001', 'Alice Johnson', 40, 'alice.johnson@example.com', 'Expert in AI and ML', 'password123'),
('A002', 'Bob Smith', 40, 'bob.smith@example.com', 'Data Scientist', 'password456'),
('A003', 'Carol White', 28, 'carol.white@example.com', 'Researcher in NLP', 'password789'),
('A004', 'David Brown', 50, 'david.brown@example.com', 'Professor in Quantum Computing', 'password321'),
('A005', 'Eve Davis', 32, 'eve.davis@example.com', 'Cloud Computing Specialist', 'password654'),
('A006', 'Frank Martin', 45, 'frank.martin@example.com', 'Expert in Computer Vision', 'password987'),
('A007', 'Grace Lee', 30, 'grace.lee@example.com', 'Cryptography Enthusiast', 'password147'),
('A008', 'Henry Wilson', 27, 'henry.wilson@example.com', 'Cybersecurity Analyst', 'password258'),
('A010', 'John Wick', 52, 'john.wick@example.com', 'Expert in Pencils', 'password567');

--1. content of authors table

select *from authors;
--2.First, create a FULLTEXT index on the columns:


--3.Search for authors related to "Computing"

SELECT * FROM Authors where match(name,email,bio) 
against('+Computing');

--4.Search for "Computer Vision" with related terms expansion

select *from authors WHERE MATCH(Name, Email, Bio) 
AGAINST('Computer Vision' WITH QUERY EXPANSION);

--5.Search authors who have "Expert" but not "Cloud"

select *from authors WHERE MATCH(Name, Email, Bio) 
AGAINST('Expert -Cloud' IN BOOLEAN MODE);

--6. Relevance score for Data Scientist
SELECT *, MATCH(Name, Email, Bio) 
AGAINST('Data Scientist') AS RelevanceScore 
FROM Authors WHERE MATCH(Name, Email, Bio) 
AGAINST('Data Scientist') ORDER BY RelevanceScore DESC;