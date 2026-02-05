# Online Exam App

A **Spring Boot application** for managing and taking online exams, with role-based access for admins and students. Features JWT-based authentication, a responsive web interface, and MySQL database.

## Architecture

This application is a monolithic Spring Boot application with:

- **Authentication Service**: JWT-based authentication with role management
- **Exam Management**: Core exam functionality (questions, attempts, scoring)
- **User Management**: Admin and student registration/management
- **REST API**: Full API for all operations
- **Web Frontend**: JSP-based UI for all features

## Features

- **User Registration & Login**: JWT-based authentication with admin and student roles
- **REST API**: Full RESTful API for programmatic access
- **Web Frontend**: Complete web interface via JSP pages
- **Admin Dashboard**:
  - Add objective questions (with 4 options and correct answer **as answer text**, e.g., "jk") via REST API or web UI
  - Enable/disable exam and set number of questions
  - View all student exam attempts
  - Manage students and other admins
- **Student Dashboard**:
  - Take objective exams (random questions, score calculation)
  - View own exam attempt history
  - Update profile information
- **Persistence**: Uses MySQL with JPA/Hibernate ORM for all data storage
- **Spring Boot**: RESTful API, dependency injection, and transaction management
- **JSP Web Frontend**: All main features available via JSP pages under `/WEB-INF/views/`
- **Security**: JWT tokens with HTTP-only cookies, role-based authorization

## Application Components

### Main Application
- **Purpose**: Handles authentication, exam management, and serves web UI
- **Port**: 8080
- **Features**:
  - JWT authentication with HTTP-only cookies
  - Role-based access control (Admin/Student)
  - JSP web frontend with responsive design
  - RESTful API endpoints
  - MySQL database integration

## Getting Started

### Prerequisites

- Java 8 or higher
- MySQL 5.7 or higher
- Maven 3.6+ (included in this project)

### Setup

1. **Clone the repository**  
   ```bash
   git clone https://github.com/kanikaprabhakar/Online-Exam-App.git
   cd Online-Exam-App
   ```

2. **Configure MySQL**  
   - Create a database named `EXAM_APP`
   - Update credentials in `src/main/resources/application.properties`:
   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/EXAM_APP
   spring.datasource.username=root
   spring.datasource.password=root
   ```

3. **Build the project**  
   ```bash
   # Windows
   .\apache-maven-3.9.11\bin\mvn.cmd clean install
   
   # Linux/Mac
   ./apache-maven-3.9.11/bin/mvn clean install
   ```

4. **Run the application**  
   ```bash
   # Windows
   .\apache-maven-3.9.11\bin\mvn.cmd spring-boot:run
   
   # Linux/Mac
   ./apache-maven-3.9.11/bin/mvn spring-boot:run
   
   # Or use system Maven if installed
   mvn spring-boot:run
   ```

5. **Access the application**
   - Open browser and go to: http://localhost:8080
   - Login page: http://localhost:8080/login

## Usage

### Authentication Flow
1. **Register**: Use `/signup` (students) or `/admin-signup` (admins with code: `ADMIN2024`)
2. **Login**: Use `/login` - receives JWT token in HTTP-only cookie
3. **Access**: Protected endpoints automatically validate JWT token
4. **Logout**: Use `/logout` - clears authentication cookie

### Web Interface
- **Home**: http://localhost:8080/
- **Login**: http://localhost:8080/login
- **Student Signup**: http://localhost:8080/signup  
- **Admin Signup**: http://localhost:8080/admin-signup (requires code: `ADMIN2024`)
- **Admin Dashboard**: http://localhost:8080/admin
- **Student Dashboard**: http://localhost:8080/student-dashboard
- **Questions Management**: http://localhost:8080/questions

## API Endpoints & Example Request Bodies

### Authentication Endpoints
- `GET /login` — Login page
- `POST /login` — Authenticate user (returns JWT in cookie)
- `GET /logout` — Logout (clears JWT cookie)
- `GET /signup` — Student registration page
- `POST /signup` — Register student
- `GET /admin-signup` — Admin registration page  
- `POST /admin-signup` — Register admin (requires secret code)

### Student Registration

- `POST /api/students/register-student`
  - Example body:
    ```json
    {
      "name": "John Doe",
      "email": "john@example.com",
      "password": "yourPassword",
      "role": "student",
      "rollNumber": "STU1001", 
      "phone": "9876543210",
      "address": "123 Main Street, City"
    }
    ```

### Admin Registration  

- `POST /api/admin/users/register-admin`
  - Example body:
    ```json
    {
      "name": "Admin User",
      "email": "admin@example.com", 
      "password": "adminPassword",
      "role": "admin"
    }
    ```

### Question Endpoints
- `GET /api/questions` — List all questions
- `POST /api/questions` — Add a new question  
  - **Note:** `correctAnswer` should be the actual answer text (e.g., `"jk"`), not an option number.
- `PUT /api/questions/{id}` — Update a question by ID
- `DELETE /api/questions/{id}` — Delete a question by ID
- `GET /api/questions/{id}` — Get a question by ID
- `GET /api/questions/student` — Get random questions for student (limit applied)

#### Example Question Body
```json
{
  "question": "What is the code for option B?",
  "option1": "kp",
  "option2": "jk", 
  "option3": "lp",
  "option4": "uy",
  "correctAnswer": "jk"
}
```

### Exam Management
- `POST /api/admin/question-limit` — Set question limit for exams
  ```json
  { "limit": 5 }
  ```
- `GET /api/admin/question-limit` — Get current question limit

### Exam Taking
- `GET /exam/start` — Start exam (student)
- `GET /exam/question` — Get current question
- `POST /exam/answer` — Submit answer for current question
- `GET /exam/submit` — Submit entire exam
- `GET /exam/results` — View exam results

## Configuration

### Application Properties
Edit `src/main/resources/application.properties` to configure:

```properties
# Server configuration  
server.port=8080

# Database configuration
spring.datasource.url=jdbc:mysql://localhost:3306/EXAM_APP
spring.datasource.username=root
spring.datasource.password=root
spring.jpa.hibernate.ddl-auto=update

# JWT configuration
jwt.secret=mySecretKey12345678901234567890123456789012345678901234567890
jwt.expiration=86400000

# Logging (to reduce noise during startup)
logging.level.root=WARN
logging.level.orm.ormfirst=INFO
logging.level.org.springframework.boot=INFO
```

## Project Structure

```
src/main/java/
├── orm/ormfirst/
│   ├── OnlineExamApp.java           # Main Spring Boot application
│   ├── controller/                  # REST and MVC controllers
│   │   ├── AuthController.java      # Authentication endpoints
│   │   ├── AdminMvcController.java  # Admin web pages
│   │   ├── StudentController.java   # Student API
│   │   ├── QuestionController.java  # Question API  
│   │   └── ExamController.java      # Exam functionality
│   ├── repository/                  # Spring Data JPA repositories
│   ├── security/                    # JWT and security configuration
│   │   ├── JwtUtil.java            # JWT token utilities
│   │   ├── JwtAuthenticationFilter.java # JWT filter
│   │   └── SecurityConfig.java      # Spring Security config
│   └── config/                      # Configuration classes
├── entity/                          # JPA entities
│   ├── User.java                   # Admin users
│   ├── Student.java                # Student users  
│   ├── Question.java               # Exam questions
│   └── ExamAttempt.java            # Exam attempts
└── Service/                        # Service layer

src/main/webapp/WEB-INF/views/      # JSP web frontend
├── login.jsp                       # Login page
├── signup.jsp                      # Student registration
├── admin-signup.jsp      # Admin registration (requires secret code)
├── admin.jsp                       # Admin dashboard
├── student-dashboard.jsp           # Student dashboard
├── questions.jsp                   # Question management
└── ...
```

## Security Features

- **JWT Authentication**: Secure token-based authentication
- **HTTP-only Cookies**: Prevents XSS attacks on auth tokens
- **Role-based Authorization**: Separate access for ADMIN and STUDENT roles
- **Password Encryption**: BCrypt hashing for all passwords
- **CSRF Protection**: Disabled for API endpoints, enabled for forms

## Web Frontend Pages (JSP)

| Page                  | Purpose / Features                                      | URL                                   |
|-----------------------|--------------------------------------------------------|---------------------------------------|
| login.jsp             | Login page with error handling                         | http://localhost:8080/login           |
| signup.jsp            | Student registration                                   | http://localhost:8080/signup          |
| admin-signup.jsp      | Admin registration (requires secret code)             | http://localhost:8080/admin-signup    |
| admin.jsp             | Admin dashboard: manage admins, students, questions    | http://localhost:8080/admin           |
| student-dashboard.jsp | Student dashboard: take exam, view results             | http://localhost:8080/student-dashboard |
| questions.jsp         | Questions dashboard: add, edit, delete                 | http://localhost:8080/questions       |
| exam-instructions.jsp | Exam start page with instructions                      | http://localhost:8080/exam/start      |
| exam-question.jsp     | Individual exam questions                              | http://localhost:8080/exam/question   |
| exam-result.jsp       | View exam results and score                           | http://localhost:8080/exam/results    |

## Future Enhancements

- **Additional Microservices**: Split into separate Question Service, User Service, Exam Service
- **API Gateway**: Implement Spring Cloud Gateway for advanced routing
- **Configuration Server**: Centralized configuration management
- **Circuit Breaker**: Hystrix or Resilience4j for fault tolerance
- **Distributed Tracing**: Sleuth and Zipkin for request tracing
- **Container Deployment**: Docker containers with Kubernetes orchestration

## Troubleshooting

### Common Issues

1. **Service not registering with Eureka**:
   - Ensure Eureka server is running on port 8761
   - Check `eureka.client.service-url.defaultZone` property

2. **JWT token issues**:
   - Check cookie settings (HTTP-only, path, domain)
   - Verify JWT secret key configuration

3. **Database connection issues**:
   - Verify MySQL is running and database exists
   - Check connection credentials in `application.properties`

## License

MIT

---

**This Online Exam App demonstrates modern Spring Boot microservices architecture with service discovery, JWT authentication, and full web frontend capabilities.**


