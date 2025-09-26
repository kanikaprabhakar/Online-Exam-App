<!-- filepath: src/main/webapp/WEB-INF/views/student-results.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Exam Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .container {
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
        .student-info {
            background-color: #e8f5e8;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
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
        .btn-secondary {
            background-color: #2196F3;
        }
        .btn-secondary:hover {
            background-color: #0b7dda;
        }
        .no-results {
            text-align: center;
            padding: 40px;
            color: #666;
        }
        .stats-cards {
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
            <h1>📊 My Exam Results</h1>
            <a href="/student-dashboard" class="btn btn-secondary">🏠 Back to Dashboard</a>
        </div>

        <div class="student-info">
            <h3>👨‍🎓 ${student.name} (${student.rollNumber})</h3>
            <p><strong>Email:</strong> ${student.email}</p>
        </div>

        <c:choose>
            <c:when test="${not empty attempts}">
                <!-- Statistics Cards -->
                <div class="stats-cards">
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
                            <c:set var="avgScore" value="${totalScore / attempts.size()}"/>
                            <c:choose>
                                <c:when test="${avgScore == avgScore.intValue()}">
                                    ${avgScore.intValue()}%
                                </c:when>
                                <c:otherwise>
                                    ${String.format("%.1f", avgScore)}%
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="stat-label">Average Score</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">
                            <c:set var="bestScore" value="0"/>
                            <c:forEach var="attempt" items="${attempts}">
                                <c:if test="${attempt.score > bestScore}">
                                    <c:set var="bestScore" value="${attempt.score}"/>
                                </c:if>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${bestScore == bestScore.intValue()}">
                                    ${bestScore.intValue()}%
                                </c:when>
                                <c:otherwise>
                                    ${String.format("%.1f", bestScore)}%
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="stat-label">Best Score</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">
                            <c:set var="totalTime" value="0"/>
                            <c:forEach var="attempt" items="${attempts}">
                                <c:set var="totalTime" value="${totalTime + attempt.timeTaken}"/>
                            </c:forEach>
                            ${totalTime / attempts.size()}
                        </div>
                        <div class="stat-label">Avg. Time (min)</div>
                    </div>
                </div>

                <!-- Results Table -->
                <h2>Exam History</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Attempt #</th>
                            <th>Date & Time</th>
                            <th>Questions</th>
                            <th>Correct</th>
                            <th>Score</th>
                            <th>Time Taken</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="attempt" items="${attempts}" varStatus="status">
                            <tr>
                                <td><strong>#${status.index + 1}</strong></td>
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
                                    <c:choose>
                                        <c:when test="${attempt.score == attempt.score.intValue()}">
                                            ${attempt.score.intValue()}%
                                        </c:when>
                                        <c:otherwise>
                                            ${String.format("%.1f", attempt.score)}%
                                        </c:otherwise>
                                    </c:choose>
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
                <div class="no-results">
                    <h3>📝 No Exam Attempts Yet</h3>
                    <p>You haven't taken any exams yet. Ready to start your first exam?</p>
                    <a href="/exam/start" class="btn">🚀 Take Your First Exam</a>
                </div>
            </c:otherwise>
        </c:choose>

        <div style="text-align: center; margin-top: 30px;">
            <a href="/exam/start" class="btn">📝 Take New Exam</a>
            <a href="/student-dashboard" class="btn btn-secondary">🏠 Dashboard</a>
        </div>
    </div>
</body>
</html>