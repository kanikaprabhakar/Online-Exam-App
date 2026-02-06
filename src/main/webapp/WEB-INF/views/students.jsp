<!-- filepath: src/main/webapp/WEB-INF/views/students.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Students Management</title>
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
        .field-error { color: #b60000; font-size: 0.85rem; margin: 2px 5px 8px 5px; display: none; }
        .input-error { border-color: #b60000 !important; }
    </style>
</head>
<body>
    <h1>Students Management</h1>

    <!-- Registration Form -->
    <h2>Register New Student</h2>
    <form action="/students/register" method="post" data-validate>
        <input type="text" name="name" placeholder="Name" required data-validate="required">
        <input type="email" name="email" placeholder="Email" required data-validate="email">
        <input type="text" name="rollNumber" placeholder="Roll Number" required data-validate="roll">
        <input type="text" name="phone" placeholder="Phone" required data-validate="phone">
        <input type="text" name="address" placeholder="Address" required data-validate="required">
        <button type="submit">Register Student</button>
    </form>

    <!-- Edit Form (shows only when editing) -->
    <c:if test="${student.studentId != null}">
        <h2>Edit Student</h2>
        <form action="/students/update" method="post" class="edit-form" data-validate>
            <input type="hidden" name="studentId" value="${student.studentId}">
            <input type="text" name="name" value="${student.name}" placeholder="Name" required data-validate="required">
            <input type="email" name="email" value="${student.email}" placeholder="Email" required data-validate="email">
            <input type="text" name="rollNumber" value="${student.rollNumber}" placeholder="Roll Number" required data-validate="roll">
            <input type="text" name="phone" value="${student.phone}" placeholder="Phone" required data-validate="phone">
            <input type="text" name="address" value="${student.address}" placeholder="Address" required data-validate="required">
            <button type="submit">Update Student</button>
            <a href="/students"><button type="button">Cancel</button></a>
        </form>
    </c:if>

    <!-- Students List -->
    <h2>All Students</h2>
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
    <a href="/">Home</a> | 
    <a href="/admin">Admin Dashboard</a> | 
    <a href="/questions">Questions</a> | 
    <a href="/exam-attempts">Exam Attempts</a>
    <script src="/js/validation.js"></script>
</body>
</html>