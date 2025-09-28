<!-- filepath: src/main/webapp/WEB-INF/views/student-results.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                            <c:set var="totalPercentage" value="0"/>
                            <c:forEach var="attempt" items="${attempts}">
                                <c:set var="totalPercentage" value="${totalPercentage + attempt.percentage}"/>
                            </c:forEach>
                            <fmt:formatNumber value="${totalPercentage / attempts.size()}" maxFractionDigits="1"/>%
                        </div>
                        <div class="stat-label">Average Score</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">
                            <c:set var="bestScore" value="0"/>
                            <c:forEach var="attempt" items="${attempts}">
                                <c:if test="${attempt.percentage > bestScore}">
                                    <c:set var="bestScore" value="${attempt.percentage}"/>
                                </c:if>
                            </c:forEach>
                            <fmt:formatNumber value="${bestScore}" maxFractionDigits="1"/>%
                        </div>
                        <div class="stat-label">Best Score</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">
                            <c:set var="passedCount" value="0"/>
                            <c:forEach var="attempt" items="${attempts}">
                                <c:if test="${attempt.percentage >= 60}">
                                    <c:set var="passedCount" value="${passedCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${passedCount}
                        </div>
                        <div class="stat-label">Passed Attempts</div>
                    </div>
                </div>

                <!-- Results Table -->
                <h2>Exam History</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Attempt #</th>
                            <th>Date & Time</th>
                            <th>Total Questions</th>
                            <th>Score</th>
                            <th>Percentage</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="attempt" items="${attempts}" varStatus="status">
                            <tr>
                                <td><strong>#${status.index + 1}</strong></td>
                                <td>
                                    <fmt:formatDate value="${attempt.attemptTime}" pattern="MMM dd, yyyy"/>
                                    <br>
                                    <small style="color: #666;">
                                        <fmt:formatDate value="${attempt.attemptTime}" pattern="hh:mm a"/>
                                    </small>
                                </td>
                                <td>${attempt.totalQuestions}</td>
                                <td>${attempt.score}</td>
                                <td class="<c:choose>
                                    <c:when test='${attempt.percentage >= 80}'>score-excellent</c:when>
                                    <c:when test='${attempt.percentage >= 60}'>score-good</c:when>
                                    <c:otherwise>score-needs-improvement</c:otherwise>
                                </c:choose>">
                                    <fmt:formatNumber value="${attempt.percentage}" maxFractionDigits="1"/>%
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${attempt.percentage >= 60}">
                                            <span style="color: #4CAF50; font-weight: bold;">✅ PASSED</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #f44336; font-weight: bold;">❌ FAILED</span>
                                        </c:otherwise>
                                    </c:choose>
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