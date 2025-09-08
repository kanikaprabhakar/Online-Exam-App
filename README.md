# Online Exam App

A Spring Boot REST API for managing and taking online exams, with role-based access for admins and students.

## Features

- **User Registration & Login**: Supports both admin and student roles.
- **Admin Dashboard**:
  - Add objective questions (with 4 options and correct answer) via REST API.
  - Enable/disable exam and set number of questions.
  - View all student exam attempts.
- **Student Dashboard**:
  - Take objective exams (random questions, score calculation).
  - View own exam attempt history.
- **Persistence**: Uses MySQL with JPA/Hibernate ORM for all data storage.
- **Spring Boot**: RESTful API, dependency injection, and transaction management.

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
   - Update credentials in `src/main/resources/application.properties`.

3. **Build the project**  
   `mvn clean install`

4. **Run the application**  
   `mvn spring-boot:run`  
   or  
   `mvn exec:java -Dexec.mainClass=orm.ormfirst.OnlineExamApp`

## Usage

- Use a REST client (Postman, curl, etc.) to interact with the API endpoints.
- Register as admin or student.
- Admins can add questions, enable/disable exams, set question count, and view all attempts.
- Students can take exams and view their own attempt history.

## API Endpoints

**Student Endpoints**

- `GET /api/students` — List all students

**Question Endpoints**

- `GET /api/questions` — List all questions
- `POST /api/questions` — Add a new question
- `PUT /api/questions/{id}` — Update a question by ID
- `DELETE /api/questions/{id}` — Delete a question by ID

**Exam Attempt Endpoints**

- `GET /api/exam-attempts` — List all exam attempts
- `GET /api/exam-attempts/{email}` — List exam attempts for a specific student email

**Other Endpoints**

- `GET /api/all-students` — List all students (admin view)

## Project Structure

- `src/main/java/entity/` — JPA entities (User, Question, Exam, ExamAttempt, etc.)
- `src/main/java/orm/ormfirst/repository/` — Spring Data JPA repositories
- `src/main/java/orm/ormfirst/controller/` — REST controllers
- `src/main/java/Service/` — Service layer
- `src/main/java/orm/ormfirst/App.java` — Legacy console UI (not used in REST API)
- `src/main/resources/application.properties` — Spring Boot configuration

## Customization

- Change exam settings, question formats, or add new features by editing the relevant classes.
- For a web frontend, consider integrating with React or another framework.

## License

MIT



