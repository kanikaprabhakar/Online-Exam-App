<!-- filepath: src/main/webapp/WEB-INF/views/student-results.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Exam Results - Evalora</title>
    <link href="https://fonts.googleapis.com/css2?family=Aileron:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Aileron', sans-serif;
            background: linear-gradient(135deg, #1a1a1a 0%, #0f0f0f 100%);
            color: #ddd;
            padding: 20px;
            line-height: 1.6;
            min-height: 100vh;
        }
        .container {
            max-width: 1200px;
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
        .student-info {
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            border: 1px solid #333;
            animation: slideDown 0.5s ease 0.1s backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }
        .student-info h3 { color: #fff; margin-bottom: 12px; font-size: 1.1rem; }
        .student-info p { color: #bbb; margin-bottom: 6px; }
        .student-info strong { color: #ddd; }
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
            background-color: #252525;
            border-radius: 0 0 12px 12px;
            overflow: hidden;
            border: 1px solid #333;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }
        th {
            background-color: #2a2a2a;
            color: #fff;
            padding: 16px;
            text-align: left;
            font-weight: 700;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #444;
        }
        td {
            padding: 16px;
            color: #bbb;
            border-bottom: 1px solid #333;
        }
        tr:hover td { background-color: #1f1f1f; color: #ddd; }
        tr:last-child td { border-bottom: none; }
        .score-excellent { background-color: rgba(136, 255, 136, 0.15); color: #88ff88; font-weight: 700; }
        .score-good { background-color: rgba(255, 204, 136, 0.15); color: #ffcc88; font-weight: 700; }
        .score-needs-improvement { background-color: rgba(255, 136, 136, 0.15); color: #ff8888; font-weight: 700; }
        .btn {
            padding: 12px 28px;
            background-color: #444;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            border: 1px solid #666;
            cursor: pointer;
            font-family: 'Aileron', sans-serif;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: inline-block;
        }
        .btn:hover {
            background-color: #555;
            border-color: #888;
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
        }
        .btn-secondary {
            background-color: #555;
            border-color: #777;
        }
        .btn-secondary:hover {
            background-color: #666;
            border-color: #999;
        }
        .no-results {
            text-align: center;
            padding: 60px 20px;
            border-radius: 12px;
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            border: 1px solid #333;
            animation: slideDown 0.5s ease 0.1s backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }
        .no-results h3 { color: #fff; font-size: 1.3rem; margin-bottom: 15px; }
        .no-results p { color: #888; margin-bottom: 25px; }
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        .stat-card {
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            padding: 25px;
            border-radius: 12px;
            text-align: center;
            border: 1px solid #333;
            animation: fadeIn 0.6s ease backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
        }
        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.15s; }
        .stat-card:nth-child(3) { animation-delay: 0.2s; }
        .stat-card:nth-child(4) { animation-delay: 0.25s; }
        .stat-card:hover {
            border-color: #555;
            transform: translateY(-6px);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.4);
        }
        .stat-number { font-size: 28px; font-weight: 700; color: #88ff88; }
        .stat-label { color: #aaa; margin-top: 10px; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px; }
        .button-group { text-align: center; margin-top: 40px; display: flex; justify-content: center; gap: 15px; flex-wrap: wrap; }
        h2 { color: #fff; margin: 30px 0 20px 0; font-weight: 700; font-size: 1.4rem; }
        @keyframes slideDown { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>My Exam Results</h1>
            <a href="/student-dashboard" class="btn btn-secondary">Back to Dashboard</a>
        </div>

        <div class="student-info">
            <h3>${student.name} (${student.rollNumber})</h3>
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
                                            <span style="color: #88ff88; font-weight: bold;">PASSED</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #ff8888; font-weight: bold;">FAILED</span>
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
                    <h3>No Exam Attempts Yet</h3>
                    <p>You haven't taken any exams yet. Ready to start your first exam?</p>
                    <a href="/exam/start" class="btn">Take Your First Exam</a>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="button-group">
            <a href="/exam/start" class="btn">Take New Exam</a>
            <a href="/student-dashboard" class="btn btn-secondary">Dashboard</a>
        </div>
    </div>
</body>
</html>