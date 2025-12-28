-- Library Database Schema
-- Tables: Members, Books, Loans (loan connects member to book)

CREATE TABLE Members (
    MemberID  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName  VARCHAR(100) NOT NULL,
    Email     VARCHAR(255) NOT NULL UNIQUE,
    JoinedAt  DATE NOT NULL DEFAULT CURRENT_DATE,
    Status    VARCHAR(20) NOT NULL DEFAULT 'ACTIVE' CHECK (Status IN ('ACTIVE','SUSPENDED'))
);

CREATE TABLE Books (
    BookID    INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Title     VARCHAR(255) NOT NULL,
    ISBN      VARCHAR(20) NOT NULL UNIQUE,
    PublishedYear INT NULL CHECK (PublishedYear IS NULL OR PublishedYear >= 1450),
    CopiesTotal INT NOT NULL DEFAULT 1 CHECK (CopiesTotal >= 1)
);

CREATE TABLE Loans (
    LoanID    INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    MemberID  INT NOT NULL,
    BookID    INT NOT NULL,
    LoanedAt  DATE NOT NULL DEFAULT CURRENT_DATE,
    DueAt     DATE NOT NULL,
    ReturnedAt DATE NULL,
    CONSTRAINT FK_Loans_Member
        FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
        ON DELETE CASCADE,
    CONSTRAINT FK_Loans_Book
        FOREIGN KEY (BookID) REFERENCES Books(BookID)
        ON DELETE RESTRICT,
    CONSTRAINT CK_Loans_Dates
        CHECK (DueAt >= LoanedAt AND (ReturnedAt IS NULL OR ReturnedAt >= LoanedAt))
);

-- Optional: prevent "double active loan" for same member+book (partial unique indexes differ by DB)
-- If PostgreSQL:
-- CREATE UNIQUE INDEX UX_Loans_ActiveLoan
-- ON Loans(MemberID, BookID)
-- WHERE ReturnedAt IS NULL;
