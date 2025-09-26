<!-- filepath: src/main/webapp/WEB-INF/views/questions.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Questions Management</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { border-collapse: collapse; width: 100%; margin: 20px 0; }
        table, th, td { border: 1px solid #ddd; }
        th, td { padding: 12px; text-align: left; }
        th { background-color: #f2f2f2; }
        form { margin: 20px 0; padding: 20px; border: 1px solid #ddd; }
        input, textarea, button { padding: 8px; margin: 5px; }
        textarea { width: 300px; height: 60px; }
        button { background-color: #4CAF50; color: white; border: none; cursor: pointer; }
        button:hover { background-color: #45a049; }
        .edit-form { background-color: #f9f9f9; }
        .question-text { max-width: 300px; word-wrap: break-word; }
    </style>
</head>
<body>
    <h1>Questions Management</h1>

    <!-- Add Question Form -->
    <h2>Add New Question</h2>
    <form action="/questions/add" method="post">
        <textarea name="question" placeholder="Question Text" required></textarea><br>
        <input type="text" name="option1" placeholder="Option 1" required>
        <input type="text" name="option2" placeholder="Option 2" required><br>
        <input type="text" name="option3" placeholder="Option 3" required>
        <input type="text" name="option4" placeholder="Option 4" required><br>
        <input type="number" name="correctAnswer" placeholder="Correct Answer (1-4)" min="1" max="4" required>
        <button type="submit">Add Question</button>
    </form>

    <!-- Edit Question Form (shows only when editing) -->
    <c:if test="${question.id != null}">
        <h2>Edit Question</h2>
        <form action="/questions/update" method="post" class="edit-form">
            <input type="hidden" name="id" value="${question.id}">
            <textarea name="question" required>${question.question}</textarea><br>
            <input type="text" name="option1" value="${question.option1}" placeholder="Option 1" required>
            <input type="text" name="option2" value="${question.option2}" placeholder="Option 2" required><br>
            <input type="text" name="option3" value="${question.option3}" placeholder="Option 3" required>
            <input type="text" name="option4" value="${question.option4}" placeholder="Option 4" required><br>
            <input type="number" name="correctAnswer" value="${question.correctAnswer}" placeholder="Correct Answer (1-4)" min="1" max="4" required>
            <button type="submit">Update Question</button>
            <a href="/questions"><button type="button">Cancel</button></a>
        </form>
    </c:if>

    <!-- Questions List -->
    <h2>All Questions</h2>
    <table>
        <thead>
            <tr>
                <th>Question</th>
                <th>Options</th>
                <th>Correct Answer</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="q" items="${questions}">
                <tr>
                    <td class="question-text">${q.question}</td>
                    <td>
                        1. ${q.option1}<br>
                        2. ${q.option2}<br>
                        3. ${q.option3}<br>
                        4. ${q.option4}
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${q.correctAnswer == 1}">${q.option1}</c:when>
                            <c:when test="${q.correctAnswer == 2}">${q.option2}</c:when>
                            <c:when test="${q.correctAnswer == 3}">${q.option3}</c:when>
                            <c:when test="${q.correctAnswer == 4}">${q.option4}</c:when>
                        </c:choose>
                    </td>
                    <td>
                        <a href="/questions/edit/${q.id}">
                            <button type="button">Edit</button>
                        </a>
                        <a href="/questions/delete/${q.id}" 
                           onclick="return confirm('Delete this question?');">
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
    <a href="/exam-attempts">Exam Attempts</a>
</body>
</html>