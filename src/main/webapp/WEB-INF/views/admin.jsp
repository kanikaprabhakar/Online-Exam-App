<!-- filepath: src/main/webapp/WEB-INF/views/admin.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { border-collapse: collapse; width: 100%; margin: 20px 0; }
        table, th, td { border: 1px solid #ddd; }
        th, td { padding: 12px; text-align: left; }
        th { background-color: #f2f2f2; }
        form { margin: 20px 0; padding: 20px; border: 1px solid #ddd; }
        input, button { padding: 8px; margin: 5px; }
        button { background-color: #4CAF50; color: white; border: none; cursor: pointer; }
        button:hover { background-color: #45a049; }
        .edit-form { background-color: #f9f9f9; }
        hr { margin: 30px 0; }
    </style>
</head>
<body>
    <h1>Admin Dashboard</h1>

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
            <input type="password" name="password" value="${user.password}" placeholder="Password" required>
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
                    <td>${a.name}</td>
                    <td>${a.email}</td>
                    <td>${a.role}</td>
                    <td>
                        <a href="/admin/edit-admin/${a.id}">
                            <button type="button">Edit</button>
                        </a>
                        <a href="/admin/delete-admin/${a.id}" 
                           onclick="return confirm('Delete this admin?');">
                            <button type="button" style="background-color: #f44336;">Delete</button>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <hr>

    <!-- Students Management Section -->
    <h2>Students Management</h2>
    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Roll Number</th>
                <th>Phone</th>
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
                    <td>
                        <a href="/students/edit/${s.studentId}">
                            <button type="button">Edit</button>
                        </a>
                        <a href="/students/delete/${s.studentId}" 
                           onclick="return confirm('Delete this student?');">
                            <button type="button" style="background-color: #f44336;">Delete</button>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <hr>
    <a href="/students">Students Page</a> | 
    <a href="/questions">Questions</a> | 
    <a href="/exam-attempts">Exam Attempts</a>
</body>
</html>