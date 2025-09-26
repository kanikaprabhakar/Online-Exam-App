<!-- filepath: src/main/webapp/WEB-INF/views/admin-exam-attempts.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin - All Exam Attempts</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .container {
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
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .score-excellent { 
            background-color: #d4edda; 
            color: #155724; 
            font-weight: bold; 
        }
        .score-good { 
            background-color: #fff3cd; 
            color: #856404; 
            font-weight: bold; 
        }
        .score-needs-improvement { 
            background-color: #f8d7da; 
            color: #721c24; 
            font-weight: bold; 
        }
        .btn {
            padding: 10px 20px;
            background-color: #2196F3;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0b7dda;
        }
        .no-attempts {
            text-align: center;
            padding: 40px;
            color: #666;
        }
        .stats-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        .stat-card {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            border-left: 4px solid #4CAF50;
        }
        .stat-number {
            font-size: 24px;
            font-weight: bold;
            color: #4CAF50;
        }
        .stat-label {
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 All Exam Attempts</h1>
            <a href="/admin" class="btn">🏠 Back to Admin Dashboard</a>
        </div>

        <!-- Current Admin Info -->
        <div class="current-admin">
            👨‍💼 <strong>Logged in as:</strong> ${currentAdmin.name} (${currentAdmin.email})
        </div>

        <c:choose>
            <c:when test="${not empty attempts}">
                <!-- Statistics Summary -->
                <div class="stats-summary">
                    <div class="stat-card">
                        <div class="stat-number">${attempts.size()}</div>
                        <div class="stat-label">Total Attempts</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">
                            <c:set var="totalScore" value="0"/>
                            <c:forEach var="attempt" items="${attempts}">
                                <c:set var="totalScore" value="${totalScore + attempt.score}"/>
                            </c:forEach>
                            <fmt:formatNumber value="${totalScore / attempts.size()}" maxFractionDigits="1"/>%
                        </div>
                        <div class="stat-label">Average Score</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">
                            <c:set var="uniqueStudents" value="0"/>
                            <c:set var="processedEmails" value=""/>
                            <c:forEach var="attempt" items="${attempts}">
                                <c:if test="${!processedEmails.contains(attempt.studentEmail)}">
                                    <c:set var="uniqueStudents" value="${uniqueStudents + 1}"/>
                                    <c:set var="processedEmails" value="${processedEmails},${attempt.studentEmail}"/>
                                </c:if>
                            </c:forEach>
                            ${uniqueStudents}
                        </div>
                        <div class="stat-label">Students Participated</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">
                            <c:set var="totalTime" value="0"/>
                            <c:forEach var="attempt" items="${attempts}">
                                <c:set var="totalTime" value="${totalTime + attempt.timeTaken}"/>
                            </c:forEach>
                            <fmt:formatNumber value="${totalTime / attempts.size()}" maxFractionDigits="0"/>
                        </div>
                        <div class="stat-label">Avg. Time (min)</div>
                    </div>
                </div>

                <!-- Attempts Table -->
                <h2>All Exam Attempts (${attempts.size()} records)</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Student Name</th>
                            <th>Email</th>
                            <th>Date & Time</th>
                            <th>Questions</th>
                            <th>Correct</th>
                            <th>Score</th>
                            <th>Time Taken</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="attempt" items="${attempts}">
                            <tr>
                                <td><strong>${attempt.studentName}</strong></td>
                                <td>${attempt.studentEmail}</td>
                                <td>
                                    ${attempt.startTime.toLocalDate()}
                                    <br>
                                    <small style="color: #666;">
                                        ${attempt.startTime.toLocalTime()} - ${attempt.endTime.toLocalTime()}
                                    </small>
                                </td>
                                <td>${attempt.totalQuestions}</td>
                                <td>
                                    ${attempt.correctAnswers}
                                    <small style="color: #666;">
                                        (${attempt.totalQuestions - attempt.correctAnswers} wrong)
                                    </small>
                                </td>
                                <td class="<c:choose>
                                    <c:when test='${attempt.score >= 80}'>score-excellent</c:when>
                                    <c:when test='${attempt.score >= 60}'>score-good</c:when>
                                    <c:otherwise>score-needs-improvement</c:otherwise>
                                </c:choose>">
                                    <fmt:formatNumber value="${attempt.score}" maxFractionDigits="1"/>%
                                </td>
                                <td>${attempt.timeTaken} min</td>
                                <td>
                                    <span style="color: #4CAF50; font-weight: bold;">
                                        ${attempt.status}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-attempts">
                    <h3>📝 No Exam Attempts Yet</h3>
                    <p>No students have taken any exams yet. Exam attempts will appear here once students start taking exams.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div style="text-align: center; margin-top: 30px;">
            <a href="/admin" class="btn">🏠 Back to Admin Dashboard</a>
            <a href="/admin/students" class="btn">👨‍🎓 Manage Students</a>
        </div>
    </div>
</body>
</html>