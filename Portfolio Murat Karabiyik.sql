/*******************************************************************************
   MURAT COLLINS - COMPLETE SQL MASTERY PORTFOLIO
   Target Environment: MySQL 8.0+
   Last Updated: 2026-01-20
********************************************************************************/

DROP DATABASE IF EXISTS Murat_Professional_Portfolio;
CREATE DATABASE Murat_Professional_Portfolio;
USE Murat_Professional_Portfolio;

-- ======================================================
-- SECTION 1: RETAIL & LIBRARY MODULE (DDL)
-- ======================================================

CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL
);

CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    AuthorID INT,
    CONSTRAINT fk_book_author FOREIGN KEY (AuthorID) 
        REFERENCES Authors(AuthorID) ON DELETE CASCADE
);

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) DEFAULT 0.00
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT DEFAULT 1,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- ======================================================
-- SECTION 2: UNIVERSITY MODULE - REVERSE ENGINEERED (DDL)
-- ======================================================

-- Admin Table (Top Level)
CREATE TABLE Admin (
    admin_id INT PRIMARY KEY,
    admin_name VARCHAR(100),
    email VARCHAR(100),
    role VARCHAR(50)
);

-- Department Table
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    office_location VARCHAR(100),
    admin_id INT,
    FOREIGN KEY (admin_id) REFERENCES Admin(admin_id)
);

-- Student Table
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    department_id INT,
    admin_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id),
    FOREIGN KEY (admin_id) REFERENCES Admin(admin_id)
);

-- Course Table
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT,
    department_id INT,
    admin_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id),
    FOREIGN KEY (admin_id) REFERENCES Admin(admin_id)
);

-- Enrollment Junction Table (Many-to-Many Relationship)
CREATE TABLE Enrollment (
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- ======================================================
-- SECTION 3: DATA POPULATION (DML)
-- ======================================================

-- Retail/Library Data
INSERT INTO Authors (AuthorName) VALUES ('George Orwell'), ('J.K. Rowling'), ('Murat Collins');
INSERT INTO Books (Title, AuthorID) VALUES ('1984', 1), ('Harry Potter', 2), ('SQL Mastery', 3);
INSERT INTO Customers (CustomerName, Email) VALUES ('John Smith', 'john@example.com');
INSERT INTO Products (ProductName, Price) VALUES ('Smartphone', 699.99), ('Laptop', 1200.00);
INSERT INTO Orders (CustomerID, ProductID, OrderDate, Quantity) VALUES (1, 1, '2026-01-10', 1);

-- University Data
INSERT INTO Admin VALUES (1, 'Director Sarah', 'sarah@uni.edu', 'Head of Faculty');
INSERT INTO Department VALUES (10, 'Computer Science', 'Building A', 1);
INSERT INTO Student VALUES (1001, 'Loki', 'Odinson', 'loki@asgard.edu', 10, 1);
INSERT INTO Student VALUES (1002, 'Tony', 'Stark', 'tony@stark.edu', 10, 1);
INSERT INTO Course VALUES (501, 'Database Systems', 4, 10, 1);
INSERT INTO Enrollment VALUES (1001, 501, '2026-01-15'), (1002, 501, '2026-01-15');

-- ======================================================
-- SECTION 4: QUERIES & REPORTS (DQL)
-- ======================================================

-- Report: See which students are enrolled in which courses
SELECT 
    Student.first_name, 
    Student.last_name, 
    Course.course_name, 
    Enrollment.enrollment_date
FROM Enrollment
JOIN Student ON Enrollment.student_id = Student.student_id
JOIN Course ON Enrollment.course_id = Course.course_id;

-- Final Verification
SHOW TABLES;