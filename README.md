# Online Exam App

A console-based Java application for managing and taking online exams, with role-based access for admins and students.

## Features

- **User Registration & Login**: Supports both admin and student roles.
- **Admin Dashboard**:
  - Add objective questions (with 4 options and correct answer).
  - Enable/disable exam and set number of questions.
  - View all student exam attempts.
- **Student Dashboard**:
  - Take objective exams (random questions, score calculation).
  - View own exam attempt history.
- **Persistence**: Uses MySQL with Hibernate ORM for all data storage.
- **Spring Framework**: Dependency injection and transaction management.

## Getting Started

### Prerequisites

- Java 8+
- Maven
- MySQL

### Setup

1. **Clone the repository**  
   `git clone https://github.com/kanikaprabhakar/Online-Exam-App.git`

2. **Configure MySQL**  
   - Create a database named `EXAM_APP`.
   - Update credentials in `applicationContext.xml` if needed.

3. **Build the project**  
   `mvn clean install`

4. **Run the application**  
   `mvn exec:java "-Dexec.mainClass=orm.ormfirst.App"`

### Usage

- Register as admin or student.
- Admins can add questions, enable/disable exams, set question count, and view all attempts.
- Students can take exams and view their own attempt history.

## Project Structure

- `src/main/java/Entity/` — JPA entities (User, Question, Exam, ExamAttempt, etc.)
- `src/main/java/Dao/` — Data access objects (DAOs)
- `src/main/java/Service/` — Service layer
- `src/main/java/orm/ormfirst/App.java` — Main console UI
- `src/main/resources/applicationContext.xml` — Spring configuration

## Customization

- Change exam settings, question formats, or add new features by editing the relevant classes.
- For a web frontend, consider integrating with Spring Boot or React.

## License

MIT



