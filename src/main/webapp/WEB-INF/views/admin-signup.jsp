<!-- filepath: src/main/webapp/WEB-INF/views/admin-signup.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Registration - Online Exam System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
            box-sizing: border-box;
        }
        .signup-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
            border-left: 5px solid #f44336;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .btn {
            width: 100%;
            padding: 12px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #da190b;
        }
        .error {
            color: red;
            margin-bottom: 15px;
        }
        .login-link {
            text-align: center;
            margin-top: 15px;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #f44336;
        }
        .warning {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        .admin-code-note {
            background-color: #e7f3ff;
            border: 1px solid #b8daff;
            color: #0c5460;
            padding: 10px;
            border-radius: 3px;
            font-size: 12px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <h2>🔐 Admin Registration</h2>
        
        <div class="warning">
            <strong>⚠️ Admin Registration</strong><br>
            This page is for authorized administrators only. You need a valid admin registration code to proceed.
        </div>
        
        <c:if test="${error != null}">
            <div class="error">${error}</div>
        </c:if>

        <form action="/auth/admin-signup" method="post">
            <div class="form-group">
                <label for="name">Full Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <label for="adminCode">Admin Registration Code:</label>
                <div class="admin-code-note">
                    Enter the secret admin registration code provided by your organization.
                </div>
                <input type="password" id="adminCode" name="adminCode" placeholder="Enter admin code" required>
            </div>
            
            <button type="submit" class="btn">Register as Admin</button>
        </form>
        
        <div class="login-link">
            Already have an account? <a href="/auth/login">Login here</a>
        </div>
        
        <div class="login-link">
            <a href="/">Back to Home</a>
        </div>
        
        <div class="login-link">
            <small>Student? <a href="/auth/signup">Register as Student</a></small>
        </div>
    </div>
</body>
</html>