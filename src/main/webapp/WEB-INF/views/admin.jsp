<!-- filepath: src/main/webapp/WEB-INF/views/admin.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard</title>
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
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #2196F3;
        }
        .admin-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .nav-buttons {
            margin: 20px 0;
            text-align: center;
        }
        .nav-btn {
            display: inline-block;
            margin: 10px;
            padding: 15px 25px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
        }
        .nav-btn:hover {
            background-color: #45a049;
        }
        .profile-btn {
            background-color: #2196F3;
        }
        .profile-btn:hover {
            background-color: #0b7dda;
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
        .btn-logout {
            background-color: #f44336;
        }
        .btn-logout:hover {
            background-color: #da190b;
        }
        .edit-form {
            background-color: #f9f9f9;
        }
        .error-msg {
            color: red;
            background-color: #ffe6e6;
            padding: 10px;
            border-radius: 3px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="header">
            <h1>Admin Dashboard</h1>
            <a href="/logout" class="btn btn-logout">Logout</a>
        </div>

        <!-- Current Admin Info -->
        <div class="current-admin">
            <div class="admin-info">
                <div>
                    <h3>👨‍💼 Logged in as: ${currentAdmin.name}</h3>
                    <p><strong>Email:</strong> ${currentAdmin.email}</p>
                    <p><strong>Role:</strong> ${currentAdmin.role}</p>
                </div>
                <a href="/admin/profile" class="btn profile-btn">Update My Profile</a>
            </div>
        </div>

        <!-- Error Message -->
        <c:if test="${param.error == 'cannot-delete-self'}">
            <div class="error-msg">
                ⚠️ You cannot delete your own admin account!
            </div>
        </c:if>

        <div class="nav-buttons">
            <a href="/admin/students" class="nav-btn">Manage Students</a>
            <a href="/questions" class="nav-btn">Manage Questions</a>
            <a href="/admin/exam-attempts" class="nav-btn">View All Exam Attempts</a>
        </div>

        <!-- Register Admin Form -->
        <h2>Register New Admin</h2>
        <form action="/admin/register" method="post">
            <input type="text" name="name" placeholder="Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Register Admin</button>
        </form>

        <!-- Edit Admin Form (shows only when editing) -->
        <c:if test="${user.id != null}">
            <h2>Edit Admin</h2>
            <form action="/admin/update-admin" method="post" class="edit-form">
                <input type="hidden" name="id" value="${user.id}">
                <input type="text" name="name" value="${user.name}" placeholder="Name" required>
                <input type="email" name="email" value="${user.email}" placeholder="Email" required>
                <input type="password" name="password" placeholder="New Password (leave blank to keep current)">
                <button type="submit">Update Admin</button>
                <a href="/admin"><button type="button">Cancel</button></a>
            </form>
        </c:if>

        <!-- Admins List -->
        <h2>All Admins</h2>
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="a" items="${admins}">
                    <tr>
                        <td>
                            ${a.name}
                            <c:if test="${a.email == currentAdmin.email}">
                                <span style="color: #4CAF50; font-weight: bold;">(You)</span>
                            </c:if>
                        </td>
                        <td>${a.email}</td>
                        <td>${a.role}</td>
                        <td>
                            <a href="/admin/edit-admin/${a.id}" class="btn">Edit</a>
                            <c:if test="${a.email != currentAdmin.email}">
                                <a href="/admin/delete-admin/${a.id}" 
                                   onclick="return confirm('Delete this admin?');" 
                                   class="btn btn-danger">Delete</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>