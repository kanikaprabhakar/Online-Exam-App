<!-- filepath: src/main/webapp/WEB-INF/views/admin-students.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin - Students Management - Evalora</title>
    <link rel="icon" type="image/png" href="/static/document-file.png">
    <link href="https://fonts.googleapis.com/css2?family=Aileron:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Aileron', sans-serif;
            background: linear-gradient(135deg, #1a1a1a 0%, #0f0f0f 100%);
            color: #ddd;
            padding: 20px;
            line-height: 1.6;
            min-height: 100vh;
        }

        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            animation: slideDown 0.5s ease;
        }

        .header h1 {
            color: #fff;
            font-weight: 700;
            font-size: 2.2rem;
        }

        .current-admin {
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            border: 1px solid #333;
            color: #bbb;
            animation: slideDown 0.5s ease 0.1s backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }

        .current-admin strong {
            color: #ddd;
        }

        h2 {
            color: #fff;
            margin: 35px 0 20px 0;
            font-weight: 700;
            font-size: 1.3rem;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
            background-color: #252525;
            border-radius: 0 0 12px 12px;
            overflow: hidden;
            border: 1px solid #333;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.6s ease 0.35s backwards;
        }

        table th {
            padding: 16px;
            text-align: left;
            background-color: #2a2a2a;
            color: #fff;
            font-weight: 700;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #444;
        }

        table td {
            padding: 16px;
            color: #bbb;
            border-bottom: 1px solid #333;
        }

        table tr:hover td {
            background-color: #1f1f1f;
            color: #ddd;
        }

        table tr:last-child td {
            border-bottom: none;
        }

        form {
            margin: 20px 0;
            padding: 30px;
            border: 1px solid #333;
            border-radius: 12px;
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            animation: fadeIn 0.6s ease backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }

        form:nth-of-type(2) { animation-delay: 0.2s; }
        form:nth-of-type(3) { animation-delay: 0.25s; }
        form:nth-of-type(4) { animation-delay: 0.3s; }

        input {
            padding: 12px 16px;
            margin: 8px 8px 8px 0;
            font-family: 'Aileron', sans-serif;
            background-color: #1a1a1a;
            color: #ddd;
            border: 1px solid #444;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s ease;
            display: inline-block;
            width: calc(50% - 8px);
        }

        input:focus {
            outline: none;
            border-color: #666;
            background-color: #1f1f1f;
            box-shadow: 0 0 0 2px rgba(100, 100, 100, 0.2);
        }

        input::placeholder {
            color: #888;
        }

        button, .btn {
            padding: 12px 28px;
            background-color: #444;
            color: white;
            border: 1px solid #666;
            cursor: pointer;
            border-radius: 6px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            display: inline-block;
            margin: 8px 8px 8px 0;
            font-family: 'Aileron', sans-serif;
        }

        button:hover, .btn:hover {
            background-color: #555;
            border-color: #888;
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
        }

        .btn-danger {
            background-color: #5a3842;
            border-color: #8b5a63;
        }

        .btn-danger:hover {
            background-color: #6d4a54;
            border-color: #a87080;
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
        }

        .back-btn {
            background-color: #555;
            border-color: #777;
        }

        .back-btn:hover {
            background-color: #666;
            border-color: #999;
        }

        .edit-form {
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
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
            <strong>Logged in as:</strong> ${currentAdmin.name} (${currentAdmin.email})
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