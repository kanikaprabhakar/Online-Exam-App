<!-- filepath: src/main/webapp/WEB-INF/views/student-dashboard.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .dashboard-container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #4CAF50;
        }
        .user-info {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
            position: relative;
        }
        .info-row {
            margin-bottom: 10px;
        }
        .label {
            font-weight: bold;
            display: inline-block;
            width: 150px;
        }
        .btn {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-logout {
            background-color: #f44336;
        }
        .btn-logout:hover {
            background-color: #da190b;
        }
        .btn-profile {
            background-color: #2196F3;
            position: absolute;
            top: 15px;
            right: 15px;
        }
        .btn-profile:hover {
            background-color: #0b7dda;
        }
        .welcome {
            color: #4CAF50;
        }
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .feature-card {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            text-align: center;
        }
        .exam-status {
            margin-top: 30px;
            padding: 20px;
            border-radius: 5px;
            background-color: #e8f5e9;
        }
        .status-enabled {
            color: #2e7d32;
        }
        .status-disabled {
            color: #c62828;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="header">
            <h1 class="welcome">Welcome, ${student.name}!</h1>
            <a href="/logout" class="btn btn-logout">Logout</a>
        </div>

        <div class="user-info">
            <a href="/student-profile" class="btn btn-profile">Update Profile</a>
            <h3>Your Information</h3>
            <div class="info-row">
                <span class="label">Name:</span>
                <span>${student.name}</span>
            </div>
            <div class="info-row">
                <span class="label">Email:</span>
                <span>${student.email}</span>
            </div>
            <div class="info-row">
                <span class="label">Roll Number:</span>
                <span>${student.rollNumber}</span>
            </div>
            <div class="info-row">
                <span class="label">Phone:</span>
                <span>${student.phone}</span>
            </div>
            <div class="info-row">
                <span class="label">Address:</span>
                <span>${student.address}</span>
            </div>
        </div>

        <div class="features">
            <div class="feature-card">
                <h3>Take Exam</h3>
                <p>Start your online examination</p>
                <a href="/exam/start" class="btn">Start Exam</a>
            </div>
            
            <div class="feature-card">
                <h3>View Results</h3>
                <p>Check your previous exam results</p>
                <a href="/exam/results" class="btn">View Results</a>
            </div>
            
            <div class="feature-card">
                <h3>Practice Mode</h3>
                <p>Practice with sample questions</p>
                <a href="/exam/start" class="btn">Practice</a>
            </div>
            
            <div class="feature-card">
                <h3>My Profile</h3>
                <p>Update your personal information</p>
                <a href="/student-profile" class="btn btn-profile">Update Profile</a>
            </div>
        </div>

        <!-- Add this section to show exam status -->
        <div class="exam-status">
            <h3>📝 Exam Status</h3>
            <c:choose>
                <c:when test="${config.examEnabled}">
                    <div class="status-enabled">
                        <p>✅ <strong>${config.examTitle}</strong> is AVAILABLE</p>
                        <p>📊 Questions: ${config.questionCount} (randomized)</p>
                        <p>⏱️ Duration: ${config.examDurationMinutes} minutes</p>
                        <a href="/exam/start" class="btn btn-primary">🚀 Start Exam</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="status-disabled">
                        <p>❌ Exam is currently <strong>DISABLED</strong></p>
                        <p>Please contact your administrator</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>