<!-- filepath: src/main/webapp/WEB-INF/views/index.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Online Exam System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 50px;
            text-align: center;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 50px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .nav-button {
            display: inline-block;
            margin: 10px;
            padding: 15px 25px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
        }
        .nav-button:hover {
            background-color: #45a049;
        }
        .auth-buttons {
            margin-top: 30px;
        }
        .btn-login {
            background-color: #2196F3;
        }
        .btn-login:hover {
            background-color: #0b7dda;
        }
        .btn-signup {
            background-color: #ff9800;
        }
        .btn-signup:hover {
            background-color: #e68900;
        }
        .btn-admin {
            background-color: #f44336;
        }
        .btn-admin:hover {
            background-color: #da190b;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        h2 {
            color: #666;
            margin-bottom: 40px;
        }
        .role-section {
            margin: 30px 0;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Online Exam System</h1>
        <h2>Secure MVC Version with JWT Authentication</h2>
        
        <div class="auth-buttons">
            <a href="/auth/login" class="nav-button btn-login">🔑 Login</a>
        </div>
        
        <div class="role-section">
            <h3>👨‍🎓 Student Registration</h3>
            <p>New student? Create your account to access exams and view results.</p>
            <a href="/auth/signup" class="nav-button btn-signup">Sign Up as Student</a>
        </div>
        
        <div class="role-section">
            <h3>👨‍💼 Admin Registration</h3>
            <p>Authorized administrators can register with a valid admin code.</p>
            <a href="/auth/admin-signup" class="nav-button btn-admin">Register as Admin</a>
        </div>
        
        <hr style="margin: 40px 0;">
        
        <div style="background-color: #e7f3ff; padding: 20px; border-radius: 5px;">
            <h4>🔐 Access Levels:</h4>
            <p><strong>Students:</strong> Access student dashboard, take exams, view results</p>
            <p><strong>Admins:</strong> Manage students, questions, view all exam attempts</p>
        </div>
    </div>
</body>
</html>