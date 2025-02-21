create table Authors(
authorId int not null,
firstName varchar(50),
LastName varchar(50)
);


ALTER TABLE Authors
ADD CONSTRAINT author_id PRIMARY KEY (authorId);

ALTER TABLE Authors
ALTER COLUMN firstName VARCHAR(50) NOT NULL;

ALTER TABLE Authors
ALTER COLUMN lastName VARCHAR(50) NOT NULL;


/*books table */
create table books1(
bookId int not null,
title varchar(50),
authorId int,
publishedYear int

);

ALTER TABLE books1
ADD CONSTRAINT book_id PRIMARY KEY (bookId);

ALTER TABLE books1
ALTER COLUMN title VARCHAR(50) NOT NULL;

ALTER TABLE books1
ADD CONSTRAINT FK_AuthorId
FOREIGN KEY (authorId) REFERENCES Authors(authorId);

ALTER TABLE books1
ADD CONSTRAINT CHK_PublishedYear
CHECK (publishedYear BETWEEN 1500 AND YEAR(GETDATE()));


create table Members(
memberId int,
firstName varchar(50),
lastName varchar(50),
email varchar(30)
);
ALTER TABLE Members
alter column memberId int not null; 

ALTER TABLE Members
ADD CONSTRAINT member_id PRIMARY KEY (memberId);


ALTER TABLE Members
ALTER COLUMN firstName VARCHAR(50) NOT NULL;

ALTER TABLE Members
ALTER COLUMN lastName VARCHAR(50) NOT NULL;

ALTER TABLE Members
ALTER COLUMN email VARCHAR(50) NOT NULL ;

ALTER TABLE Members
ADD CONSTRAINT UQ_Email UNIQUE (email);


create table Loan(
loanId int not null,
bookId int,
memberId int,
loanDate date,
returnDate date
);

ALTER TABLE Loan
ADD CONSTRAINT loan_id PRIMARY KEY (loanId);


ALTER TABLE Loan
ADD CONSTRAINT FK_bookId
FOREIGN KEY (bookId) REFERENCES books1(bookId);

ALTER TABLE Loan
ADD CONSTRAINT FK_memberId
FOREIGN KEY (memberId) REFERENCES Members(memberId);

ALTER TABLE Loan
ALTER COLUMN loanDate Date NOT NULL;

ALTER TABLE Loan
ADD CONSTRAINT CHK_returnDate
CHECK (returnDate > loanDate OR returnDate IS NULL);


