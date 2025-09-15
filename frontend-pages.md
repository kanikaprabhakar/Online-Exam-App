# Online Exam App Frontend Pages

Below are the available web frontend pages for this project. All are located in `src/main/resources/static/` and can be accessed directly when the Spring Boot server is running:

| Page                | Purpose / Features                                      | URL (when running locally)           |
|---------------------|--------------------------------------------------------|--------------------------------------|
| admin.html          | Admin dashboard: manage admins, students, and questions| http://localhost:8080/admin.html     |
| students.html       | Student registration and management                    | http://localhost:8080/students.html  |
| questions.html      | Questions dashboard: add, edit, delete, download JSON  | http://localhost:8080/questions.html |
| exam_attempts.html  | View exam attempts (admin/student)                     | http://localhost:8080/exam_attempts.html |
| question_limit.html | Set and view question limit (admin)                    | http://localhost:8080/question_limit.html |

All pages use a shared `style.css` for consistent styling.

## How to Access
- Start the Spring Boot server.
- Open any of the above URLs in your browser.
- Use the dashboards to manage users, questions, exam attempts, and settings.

---
For more details on API endpoints and backend features, see the rest of this README.
