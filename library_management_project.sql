-- I'm here created database named library.
CREATE DATABASE library;

USE library;

-- Table: Branch
CREATE TABLE Branch (
  Branch_no INT PRIMARY KEY,
  Manager_Id INT,
  Branch_address VARCHAR(200),
  Contact_no VARCHAR(15)
);

-- Table: Employee
CREATE TABLE Employee (
  Emp_Id INT PRIMARY KEY,
  Emp_name VARCHAR(20),
  Position VARCHAR(20),
  Salary DECIMAL(10, 2)
);

-- Table: Customer
CREATE TABLE Customer (
  Customer_Id INT PRIMARY KEY,
  Customer_name VARCHAR(20),
  Customer_address VARCHAR(200),
  Reg_date DATE
);

-- Table: IssueStatus
CREATE TABLE IssueStatus (
  Issue_Id INT PRIMARY KEY,
  Issued_cust INT,
  Issued_book_name VARCHAR(20),
  Issue_date DATE,
  Isbn_book VARCHAR(20),
  FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

-- Table: ReturnStatus
CREATE TABLE ReturnStatus (
  Return_Id INT PRIMARY KEY,
  Return_cust INT,
  Return_book_name VARCHAR(20),
  Return_date DATE,
  Isbn_book2 VARCHAR(20),
  FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

-- Table: Books
CREATE TABLE Books (
  ISBN VARCHAR(20) PRIMARY KEY,
  Book_title VARCHAR(20),
  Category VARCHAR(20),
  Rental_Price DECIMAL(10, 2),
  Status ENUM('yes', 'no'),
  Author VARCHAR(20),
  Publisher VARCHAR(20)
);

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
    (1, 101, 'Branch 1 Address', '1234567890'),
    (2, 102, 'Branch 2 Address', '9876543210'),
    (3, 103, 'Branch 3 Address', '5555555555'),
    (4, 104, 'Branch 4 Address', '9999999999'),
    (5, 105, 'Branch 5 Address', '1111111111');

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary)
VALUES
(101, 'Virat Kohili', 'Manager', 50000.00),
(102, 'Suresh Raina', 'Librarian', 30000.00),
(103, 'M S Dhoni', 'Assistant Manager', 25000.00),
(104, 'Ravi Jadeja', 'Assistant Manager', 25000.00),
(105, 'Jazzim', 'Branch Manager', 30000.00);

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
(1001, 'Anushka', '123 ABC Street', '2023-01-01'),
(1002, 'Sara', '456 XYZ Street', '2023-02-15'),
(1003, 'Sachin', '789 PQR Street', '2023-03-30'),
(1004, 'Aparna', '987 MNO Street', '2023-04-10'),
(1005, 'Kiran', '654 JKL Street', '2023-05-20');

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
(1, 1001, 'Book A', '2023-04-01', 'ISBN-001'),
(2, 1002, 'Book B', '2023-04-02', 'ISBN-002'),
(3, 1003, 'Book C', '2023-04-03', 'ISBN-003'),
(4, 1004, 'Book D', '2023-04-04', 'ISBN-004'),
(5, 1005, 'Book E', '2023-04-05', 'ISBN-005');

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
(1, 1001, 'Book A', '2023-04-10', 'ISBN-001'),
(2, 1002, 'Book B', '2023-04-12', 'ISBN-002'),
(3, 1003, 'Book C', '2023-04-15', 'ISBN-003'),
(4, 1004, 'Book D', '2023-04-20', 'ISBN-004'),
(5, 1005, 'Book E', '2023-04-25', 'ISBN-005');

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
('ISBN-001', 'Book A', 'Fiction', 10.00, 'Yes', 'Author A', 'Publisher X'),
('ISBN-002', 'Book B', 'Non-Fiction', 12.50, 'Yes', 'Author B', 'Publisher Y'),
('ISBN-003', 'Book C', 'Mystery', 8.00, 'No', 'Author C', 'Publisher Z'),
('ISBN-004', 'Book D', 'Fiction', 9.99, 'Yes', 'Author D', 'Publisher W'),
('ISBN-005', 'Book E', 'Thriller', 11.25, 'No', 'Author E', 'Publisher V');

-- Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'Yes';

-- List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- Retrieve the book titles and the corresponding customers who have issued those books.
SELECT b.Book_title, c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

-- Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Count
FROM Books
GROUP BY Category;

-- Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
  AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- Display the branch numbers and the total count of employees in each branch.
SELECT b.Branch_no, COUNT(*) AS Total_Count
FROM Branch b
JOIN Employee e ON b.Manager_Id = e.Emp_Id
GROUP BY b.Branch_no;

-- Display the names of customers who have issued books in the month of June 2023.
SELECT c.Customer_name
FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE EXTRACT(YEAR_MONTH FROM i.Issue_date) = '202306';

-- Retrieve book_title from the book table containing history.
SELECT Book_title
FROM Books
WHERE Category = 'History';

-- Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT b.Branch_no, COUNT(*) AS Employee_Count
FROM Branch b
JOIN Employee e ON b.Branch_no = e.Branch_no
GROUP BY b.Branch_no
HAVING Employee_Count > 5;



