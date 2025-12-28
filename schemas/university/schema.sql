-- University Database Schema
-- Tables: Students, Professors, Courses, Enrollments (Many-to-Many)

CREATE TABLE Professors (
    ProfessorID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    FirstName   VARCHAR(100) NOT NULL,
    LastName    VARCHAR(100) NOT NULL,
    Email       VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Students (
    StudentID   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    FirstName   VARCHAR(100) NOT NULL,
    LastName    VARCHAR(100) NOT NULL,
    Email       VARCHAR(255) NOT NULL UNIQUE,
    EnrollmentYear INT NOT NULL CHECK (EnrollmentYear >= 1950)
);

CREATE TABLE Courses (
    CourseID    INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Code        VARCHAR(20) NOT NULL UNIQUE,     -- e.g., CS101
    Title       VARCHAR(255) NOT NULL,
    Credits     INT NOT NULL CHECK (Credits BETWEEN 1 AND 10),
    ProfessorID INT NOT NULL,
    CONSTRAINT FK_Courses_Professor
        FOREIGN KEY (ProfessorID) REFERENCES Professors(ProfessorID)
        ON DELETE RESTRICT
);

-- Join table: Students <-> Courses
CREATE TABLE Enrollments (
    StudentID INT NOT NULL,
    CourseID  INT NOT NULL,
    EnrolledAt DATE NOT NULL DEFAULT CURRENT_DATE,
    Grade     VARCHAR(2) NULL CHECK (Grade IN ('AA','BA','BB','CB','CC','DC','DD','FD','FF')),
    PRIMARY KEY (StudentID, CourseID),
    CONSTRAINT FK_Enrollments_Student
        FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
        ON DELETE CASCADE,
    CONSTRAINT FK_Enrollments_Course
        FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
        ON DELETE CASCADE
);
