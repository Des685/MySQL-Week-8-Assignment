-- Database: Library Management System

-- -----------------------------------------------------
-- Table structure for table `Books`
-- -----------------------------------------------------
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    PublicationYear INT,
    AuthorID INT,
    CategoryID INT,
    TotalCopies INT NOT NULL,
    AvailableCopies INT NOT NULL,
    CHECK (TotalCopies >= 0),
    CHECK (AvailableCopies >= 0 AND AvailableCopies <= TotalCopies)
);

-- -----------------------------------------------------
-- Table structure for table `Authors`
-- -----------------------------------------------------
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Biography TEXT
);

-- -----------------------------------------------------
-- Table structure for table `Categories`
-- -----------------------------------------------------
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE
);

-- -----------------------------------------------------
-- Table structure for table `Members`
-- -----------------------------------------------------
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(20) UNIQUE,
    Email VARCHAR(100) UNIQUE NOT NULL,
    DateOfBirth DATE NOT NULL
);

-- -----------------------------------------------------
-- Table structure for table `Loans`
-- -----------------------------------------------------
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    BookID INT,
    LoanDate DATE NOT NULL,
    ReturnDate DATE,
    Status ENUM('Loaned', 'Returned', 'Overdue') NOT NULL,
    CHECK (LoanDate <= ReturnDate)
);

-- -----------------------------------------------------
-- Table structure for table `Reservations`
-- -----------------------------------------------------
CREATE TABLE Reservations (
    ReservationID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    BookID INT,
    ReservationDate DATE NOT NULL,
    Status ENUM('Pending', 'Active', 'Cancelled') NOT NULL
);

-- -----------------------------------------------------
-- Add foreign key constraints
-- -----------------------------------------------------
ALTER TABLE Books
ADD CONSTRAINT fk_author_id
FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID);

ALTER TABLE Books
ADD CONSTRAINT fk_category_id
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

ALTER TABLE Loans
ADD CONSTRAINT fk_member_id_loans
FOREIGN KEY (MemberID) REFERENCES Members(MemberID);

ALTER TABLE Loans
ADD CONSTRAINT fk_book_id_loans
FOREIGN KEY (BookID) REFERENCES Books(BookID);

ALTER TABLE Reservations
ADD CONSTRAINT fk_member_id_reservations
FOREIGN KEY (MemberID) REFERENCES Members(MemberID);

ALTER TABLE Reservations
ADD CONSTRAINT fk_book_id_reservations
FOREIGN KEY (BookID) REFERENCES Books(BookID);
