<!-- filepath: src/main/webapp/WEB-INF/views/exam-attempts.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Exam Attempts</title>
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
        .search-form { background-color: #f9f9f9; }
    </style>
</head>
<body>
    <h1>Exam Attempts Management</h1>

    <!-- Search by Email Form -->
    <h2>Search Exam Attempts by Email</h2>
    <form action="/exam-attempts" method="get" class="search-form">
        <input type="email" name="email" value="${searchEmail}" placeholder="Student Email">
        <button type="submit">Search</button>
        <a href="/exam-attempts"><button type="button">Show All</button></a>
    </form>

    <!-- Add Exam Attempt Form -->
    <h2>Add Exam Attempt</h2>
    <form action="/exam-attempts/add" method="post">
        <input type="email" name="studentEmail" placeholder="Student Email" required>
        <input type="number" name="score" placeholder="Score" required>
        <input type="number" name="totalQuestions" placeholder="Total Questions" required>
        <input type="datetime-local" name="attemptTime" placeholder="Attempt Time" required>
        <button type="submit">Add Attempt</button>
    </form>

    <!-- Exam Attempts List -->
    <h2>
        <c:choose>
            <c:when test="${searchEmail != null}">
                Exam Attempts for: ${searchEmail}
            </c:when>
            <c:otherwise>
                All Exam Attempts
            </c:otherwise>
        </c:choose>
    </h2>
    
    <table>
        <thead>
            <tr>
                <th>Student Email</th>
                <th>Score</th>
                <th>Total Questions</th>
                <th>Attempt Time</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="attempt" items="${examAttempts}">
                <tr>
                    <td>${attempt.studentEmail}</td>
                    <td>${attempt.score}</td>
                    <td>${attempt.totalQuestions}</td>
                    <td>${attempt.attemptTime}</td>
                    <td>
                        <a href="/exam-attempts/delete/${attempt.id}" 
                           onclick="return confirm('Delete this attempt?');">
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
    <a href="/students">Students</a> | 
    <a href="/questions">Questions</a>
</body>
</html>