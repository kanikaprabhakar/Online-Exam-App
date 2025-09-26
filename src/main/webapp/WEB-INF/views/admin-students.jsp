<!-- filepath: src/main/webapp/WEB-INF/views/admin-students.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin - Students Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .dashboard-container {
            max-width: 1200px;
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
        .current-admin {
            background-color: #e7f3ff;
            padding: 10px 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 14px;
            border-left: 4px solid #2196F3;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        form {
            margin: 20px 0;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        input, button {
            padding: 8px;
            margin: 5px;
        }
        button, .btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            padding: 8px 15px;
            border-radius: 3px;
            text-decoration: none;
            display: inline-block;
        }
        button:hover, .btn:hover {
            background-color: #45a049;
        }
        .btn-danger {
            background-color: #f44336;
        }
        .btn-danger:hover {
            background-color: #da190b;
        }
        .back-btn {
            background-color: #2196F3;
        }
        .back-btn:hover {
            background-color: #0b7dda;
        }
        .edit-form {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="header">
            <h1>Students Management</h1>
            <a href="/admin" class="btn back-btn">Back to Admin Dashboard</a>
        </div>

        <!-- Current Admin Info -->
        <div class="current-admin">
            👨‍💼 <strong>Logged in as:</strong> ${currentAdmin.name} (${currentAdmin.email})
        </div>

        <!-- Add Student Form -->
        <h2>Add New Student</h2>
        <form action="/admin/students/add" method="post">
            <input type="text" name="name" placeholder="Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="text" name="rollNumber" placeholder="Roll Number" required>
            <input type="text" name="phone" placeholder="Phone" required>
            <input type="text" name="address" placeholder="Address" required>
            <button type="submit">Add Student</button>
        </form>

        <!-- Edit Student Form (shows only when editing) -->
        <c:if test="${student.studentId != null}">
            <h2>Edit Student</h2>
            <form action="/admin/students/update" method="post" class="edit-form">
                <input type="hidden" name="studentId" value="${student.studentId}">
                <input type="text" name="name" value="${student.name}" placeholder="Name" required>
                <input type="email" name="email" value="${student.email}" placeholder="Email" required>
                <input type="password" name="password" placeholder="New Password (leave blank to keep current)">
                <input type="text" name="rollNumber" value="${student.rollNumber}" placeholder="Roll Number" required>
                <input type="text" name="phone" value="${student.phone}" placeholder="Phone" required>
                <input type="text" name="address" value="${student.address}" placeholder="Address" required>
                <button type="submit">Update Student</button>
                <a href="/admin/students"><button type="button">Cancel</button></a>
            </form>
        </c:if>

        <!-- Students List -->
        <h2>All Students (${students.size()} total)</h2>
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Roll Number</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="s" items="${students}">
                    <tr>
                        <td>${s.name}</td>
                        <td>${s.email}</td>
                        <td>${s.rollNumber}</td>
                        <td>${s.phone}</td>
                        <td>${s.address}</td>
                        <td>
                            <a href="/admin/students/edit/${s.studentId}" class="btn">Edit</a>
                            <a href="/admin/students/delete/${s.studentId}" 
                               onclick="return confirm('Delete this student?');" 
                               class="btn btn-danger">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>