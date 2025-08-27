-- Project Title: Library Management System Database
-- Author: Chebet Caroline
-- Description:
--  This SQL script creates a relational database schema for a 
--  Library Management System. It includes tables for Authors,
--  Users, Books, Categories, Borrow Records, and Fines.

--  Create fresh database
CREATE DATABASE library_db;
USE library_db;

--  Authors Table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(100)
);

--  Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    membership_date DATE NOT NULL
);

--  Books Table
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    published_year INT,
    copies_available INT DEFAULT 1,
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

--  Categories Table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) UNIQUE NOT NULL
);

--  Book-Categories (Many-to-Many)
CREATE TABLE BookCategories (
    book_id INT,
    category_id INT,
    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);

--  Borrow Records
CREATE TABLE BorrowRecords (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    book_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    status ENUM('Borrowed','Returned','Overdue') DEFAULT 'Borrowed',
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

--  Fines Table
CREATE TABLE Fines (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    borrow_id INT,
    amount DECIMAL(10,2) NOT NULL,
    paid BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (borrow_id) REFERENCES BorrowRecords(borrow_id) ON DELETE CASCADE
);

--  Insert Sample Data

-- Authors
INSERT INTO Authors (name, country) VALUES
('Chinua Achebe', 'Nigeria'),
('Ngugi wa Thiong\'o', 'Kenya'),
('J.K. Rowling', 'United Kingdom'),
('George Orwell', 'United Kingdom'),
('Jane Austen', 'United Kingdom'),
('Mark Twain', 'USA');

-- Users
INSERT INTO Users (name, email, membership_date) VALUES
('Alice Johnson', 'alice@example.com', '2023-01-10'),
('Bob Smith', 'bob@example.com', '2023-02-15'),
('Charlie Brown', 'charlie@example.com', '2023-03-20'),
('Diana Prince', 'diana@example.com', '2023-04-05'),
('Ethan Hunt', 'ethan@example.com', '2023-05-12'),
('Fiona Green', 'fiona@example.com', '2023-06-18');

-- Books
INSERT INTO Books (title, isbn, published_year, copies_available, author_id) VALUES
('Things Fall Apart', 'ISBN001', 1958, 5, 1),
('The River Between', 'ISBN002', 1965, 3, 2),
('Harry Potter and the Sorcerer\'s Stone', 'ISBN003', 1997, 10, 3),
('1984', 'ISBN004', 1949, 4, 4),
('Pride and Prejudice', 'ISBN005', 1813, 6, 5),
('Adventures of Huckleberry Finn', 'ISBN006', 1884, 2, 6);

-- Categories
INSERT INTO Categories (category_name) VALUES
('Fiction'),
('Non-Fiction'),
('Fantasy'),
('Science Fiction'),
('Classic');

-- BookCategories
INSERT INTO BookCategories (book_id, category_id) VALUES
(1, 1),
(2, 1),
(3, 3),
(4, 4),
(5, 5),
(6, 5);

-- BorrowRecords
INSERT INTO BorrowRecords (user_id, book_id, borrow_date, status) VALUES
(1, 1, '2025-08-20', 'Returned'),
(2, 2, '2025-08-21', 'Borrowed'),
(3, 3, '2025-08-22', 'Borrowed'),
(4, 4, '2025-08-23', 'Overdue'),
(5, 5, '2025-08-24', 'Returned'),
(6, 6, '2025-08-25', 'Borrowed');

-- Fines
INSERT INTO Fines (borrow_id, amount, paid) VALUES
(4, 50.00, FALSE),
(6, 20.00, TRUE);