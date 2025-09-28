# Online Exam App - Microservices Architecture

A **Spring Boot microservices application** for managing and taking online exams, with role-based access for admins and students. Built with **Spring Cloud** and **Eureka Service Discovery**.

## Architecture

This application follows a **microservices architecture** pattern:

- **API Gateway**: Routes requests and handles authentication
- **Service Discovery**: Eureka Server for service registration and discovery
- **Authentication Service**: JWT-based authentication with role management
- **Exam Service**: Core exam functionality (questions, attempts, scoring)
- **User Management Service**: Admin and student registration/management

## Features

- **User Registration & Login**: JWT-based authentication with admin and student roles
- **Service Discovery**: Eureka-based microservices with automatic service registration
- **API Gateway**: Centralized routing and authentication
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

## Microservices Components

### 1. Eureka Service Registry
- **Purpose**: Service discovery and registration
- **Default Port**: 8761
- **URL**: http://localhost:8761

### 2. API Gateway (Main Application)
- **Purpose**: Routes requests, handles authentication, serves web UI
- **Port**: 8080
- **Service Name**: `ONLINE-EXAM-GATEWAY`
- **Features**:
  - JWT authentication filter
  - Role-based access control
  - JSP web frontend
  - API routing

## Getting Started

### Prerequisites

- Java 8+
- Maven
- MySQL
- Eureka Server (for service discovery)

### Setup

1. **Start Eureka Server**
   ```bash
   # Start Eureka Server on port 8761
   # (You should have a separate Eureka server project)
   ```

2. **Clone the repository**  
   ```bash
   git clone https://github.com/kanikaprabhakar/Online-Exam-App.git
   ```

3. **Configure MySQL**  
   - Create a database named `EXAM_APP`
   - Update credentials in `src/main/resources/application.properties`:
   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/EXAM_APP
   spring.datasource.username=your_username
   spring.datasource.password=your_password
   ```

4. **Configure Eureka**  
   ```properties
   eureka.client.service-url.defaultZone=http://localhost:8761/eureka/
   spring.application.name=online-exam-gateway
   ```

5. **Build the project**  
   ```bash
   mvn clean install
   ```

6. **Run the application**  
   ```bash
   mvn spring-boot:run
   # or
   java -jar target/OnlineExamApp2-0.0.1-SNAPSHOT.war
   ```

7. **Verify Service Registration**
   - Check Eureka Dashboard: http://localhost:8761
   - Should see `ONLINE-EXAM-GATEWAY` registered

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

## Microservices Configuration

### Application Properties
```properties
# Application name for Eureka
spring.application.name=online-exam-gateway

# Eureka configuration
eureka.client.service-url.defaultZone=http://localhost:8761/eureka/
eureka.instance.prefer-ip-address=true

# Server configuration  
server.port=8080

# Database configuration
spring.datasource.url=jdbc:mysql://localhost:3306/EXAM_APP
spring.jpa.hibernate.ddl-auto=update

# JWT configuration
jwt.secret=your-secret-key
jwt.expiration=86400000
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


