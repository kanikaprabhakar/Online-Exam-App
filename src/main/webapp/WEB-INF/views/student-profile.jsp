<!-- filepath: src/main/webapp/WEB-INF/views/student-profile.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .profile-container {
            max-width: 600px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #4CAF50;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }
        .btn {
            padding: 12px 25px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .error {
            color: red;
            background-color: #ffe6e6;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        .success {
            color: green;
            background-color: #e6ffe6;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        .info-box {
            background-color: #e8f5e8;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #4CAF50;
        }
        .password-note {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <div class="header">
            <h1>👨‍🎓 My Profile</h1>
            <p>Update your student account information</p>
        </div>

        <div class="info-box">
            <strong>Current Account:</strong> ${student.name} (${student.email})
        </div>

        <c:if test="${error != null}">
            <div class="error">${error}</div>
        </c:if>
        
        <c:if test="${success != null}">
            <div class="success">${success}</div>
        </c:if>

        <form action="/student-dashboard/profile/update" method="post">
            <div class="form-group">
                <label for="name">Full Name:</label>
                <input type="text" id="name" name="name" value="${student.name}" disabled readonly style="background-color: #e9ecef; cursor: not-allowed;">
                <div class="password-note">Cannot be changed</div>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${student.email}" disabled readonly style="background-color: #e9ecef; cursor: not-allowed;">
                <div class="password-note">Cannot be changed</div>
            </div>
            
            <div class="form-group">
                <label for="rollNumber">Roll Number:</label>
                <input type="text" id="rollNumber" name="rollNumber" value="${student.rollNumber}" disabled readonly style="background-color: #e9ecef; cursor: not-allowed;">
                <div class="password-note">Cannot be changed</div>
            </div>
            
            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" value="${student.phone}" required>
            </div>
            
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" value="${student.address}" required>
            </div>
            
            <div style="text-align: center; margin-top: 30px;">
                <button type="submit" class="btn">Update Profile</button>
                <a href="/student-dashboard" class="btn btn-secondary">Back to Dashboard</a>
            </div>
        </form>
    </div>
</body>
</html>