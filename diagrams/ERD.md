## University ERD

```mermaid
erDiagram
  PROFESSORS ||--o{ COURSES : teaches
  STUDENTS ||--o{ ENROLLMENTS : enrolls
  COURSES ||--o{ ENROLLMENTS : has

  PROFESSORS {
    int ProfessorID PK
    string FirstName
    string LastName
    string Email UNIQUE
  }
  STUDENTS {
    int StudentID PK
    string FirstName
    string LastName
    string Email UNIQUE
    int EnrollmentYear
  }
  COURSES {
    int CourseID PK
    string Code UNIQUE
    string Title
    int Credits
    int ProfessorID FK
  }
  ENROLLMENTS {
    int StudentID PK, FK
    int CourseID PK, FK
    date EnrolledAt
    string Grade
  }
```


## Library ERD

```mermaid
erDiagram
  MEMBERS ||--o{ LOANS : borrows
  BOOKS ||--o{ LOANS : is_loaned

  MEMBERS {
    int MemberID PK
    string FirstName
    string LastName
    string Email UNIQUE
    date JoinedAt
    string Status
  }
  BOOKS {
    int BookID PK
    string Title
    string ISBN UNIQUE
    int PublishedYear
    int CopiesTotal
  }
  LOANS {
    int LoanID PK
    int MemberID FK
    int BookID FK
    date LoanedAt
    date DueAt
    date ReturnedAt
  }
```
