<!-- filepath: src/main/webapp/WEB-INF/views/index.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Online Exam System</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 50px; text-align: center; }
        .nav-button { 
            display: inline-block; 
            margin: 10px; 
            padding: 15px 25px; 
            background-color: #4CAF50; 
            color: white; 
            text-decoration: none; 
            border-radius: 5px; 
        }
        .nav-button:hover { background-color: #45a049; }
    </style>
</head>
<body>
    <h1>Online Exam System</h1>
    <h2>Welcome to the MVC Version</h2>
    
    <div>
        <a href="/admin" class="nav-button">Admin Dashboard</a>
        <a href="/students" class="nav-button">Students Management</a>
        <a href="/questions" class="nav-button">Questions Management</a>
        <a href="/exam-attempts" class="nav-button">Exam Attempts</a>
    </div>
</body>
</html>