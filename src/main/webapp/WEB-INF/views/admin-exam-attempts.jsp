<!-- filepath: src/main/webapp/WEB-INF/views/admin-exam-attempts.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Exam Attempts - Admin Dashboard</title>
    <link rel="icon" type="image/png" href="/static/document-file.png">
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
        .container { max-width: 1400px; margin: 0 auto; }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            animation: slideDown 0.5s ease;
        }
        .header h1 { color: #fff; font-weight: 700; font-size: 2.2rem; }
        .header-actions { display: flex; gap: 15px; }
        
        .btn {
            padding: 12px 28px;
            background: linear-gradient(135deg, #444 0%, #333 100%);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            border: 1px solid #666;
            font-weight: 600;
            transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            display: inline-block;
            font-size: 0.95rem;
        }
        .btn:hover {
            background: linear-gradient(135deg, #555 0%, #444 100%);
            border-color: #888;
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
        }
        .btn-primary {
            background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%);
            border-color: #5a9fe9;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #5a9fe9 0%, #4682d4 100%);
            border-color: #6aaff0;
        }
        
        .alert {
            padding: 16px 24px;
            border-radius: 8px;
            margin-bottom: 30px;
            animation: slideDown 0.4s ease;
            font-weight: 600;
        }
        .alert-error {
            background-color: #3a2222;
            color: #dd8888;
            border: 1px solid #664444;
        }
        
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
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
        .stat-card:hover { border-color: #555; transform: translateY(-6px); }
        .stat-number { font-size: 32px; font-weight: 700; color: #88ff88; margin-bottom: 10px; }
        .stat-label { color: #aaa; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px; }
        
        .exam-section {
            margin-bottom: 40px;
            animation: fadeIn 0.6s ease backwards;
        }
        .exam-section:nth-child(1) { animation-delay: 0.25s; }
        .exam-section:nth-child(2) { animation-delay: 0.3s; }
        .exam-section:nth-child(3) { animation-delay: 0.35s; }
        
        .exam-header {
            background: linear-gradient(135deg, #2a2a2a 0%, #252525 100%);
            padding: 20px 25px;
            border-radius: 12px 12px 0 0;
            border: 1px solid #444;
            border-bottom: none;
        }
        .exam-title { color: #fff; font-size: 1.4rem; font-weight: 700; margin-bottom: 8px; }
        .exam-count { color: #888; font-size: 0.9rem; }
        
        .attempts-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #252525;
            border-radius: 0 0 12px 12px;
            overflow: hidden;
            border: 1px solid #333;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }
        .attempts-table th {
            background-color: #2a2a2a;
            color: #fff;
            padding: 16px;
            text-align: left;
            font-weight: 700;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #444;
        }
        .attempts-table td { padding: 16px; color: #bbb; border-bottom: 1px solid #333; }
        .attempts-table tr:hover td { background-color: #1f1f1f; color: #ddd; }
        .attempts-table tr:last-child td { border-bottom: none; }
        
        .score-good { color: #88ff88; font-weight: 700; }
        .score-bad { color: #ff8888; font-weight: 700; }
        
        .no-attempts {
            text-align: center;
            padding: 60px 20px;
            border-radius: 12px;
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            border: 1px solid #333;
            animation: fadeIn 0.6s ease;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }
        .no-attempts h3 { color: #fff; font-size: 1.3rem; margin-bottom: 15px; }
        .no-attempts p { color: #888; margin-bottom: 25px; }
        
        .navigation { text-align: center; margin-top: 40px; display: flex; justify-content: center; gap: 15px; flex-wrap: wrap; }
        
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>All Exam Attempts</h1>
            <div class="header-actions">
                <a href="/admin" class="btn btn-primary">Dashboard</a>
                <a href="/admin/students" class="btn">Students</a>
            </div>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <strong>Error:</strong> ${error}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty attemptsByExam or totalAttempts == 0}">
                <div class="no-attempts">
                    <h3>No Exam Attempts Found</h3>
                    <p>No students have taken any exams yet.</p>
                    <a href="/admin/exam-config" class="btn btn-primary">Configure Exam</a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Statistics Cards -->
                <div class="stats-cards">
                    <div class="stat-card">
                        <div class="stat-number">${totalAttempts}</div>
                        <div class="stat-label">Total Attempts</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${attemptsByExam.size()}</div>
                        <div class="stat-label">Different Exams</div>
                    </div>
                </div>

                <!-- Attempts grouped by exam -->
                <c:forEach var="examEntry" items="${attemptsByExam}">
                    <div class="exam-section">
                        <div class="exam-header">
                            <div class="exam-title">${examEntry.key}</div>
                            <div class="exam-count">${examEntry.value.size()} attempt(s)</div>
                        </div>
                        
                        <table class="attempts-table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Student Email</th>
                                    <th>Attempt Date & Time</th>
                                    <th>Score</th>
                                    <th>Total Questions</th>
                                    <th>Percentage</th>
                                    <th>Result</th>
                                    <th>Grade</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="attempt" items="${examEntry.value}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td><strong>${attempt.studentEmail}</strong></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty attempt.attemptTime}">
                                                    ${attempt.attemptTime}
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: #666;">No date available</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><strong>${attempt.score}</strong></td>
                                        <td>${attempt.totalQuestions}</td>
                                        <td>
                                            <span class="${attempt.percentage >= 60 ? 'score-good' : 'score-bad'}">
                                                <fmt:formatNumber value="${attempt.percentage}" maxFractionDigits="1"/>%
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${attempt.percentage >= 80}">
                                                    <span class="score-good">EXCELLENT</span>
                                                </c:when>
                                                <c:when test="${attempt.percentage >= 60}">
                                                    <span class="score-good">PASSED</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="score-bad">FAILED</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${attempt.percentage >= 90}">A+</c:when>
                                                <c:when test="${attempt.percentage >= 80}">A</c:when>
                                                <c:when test="${attempt.percentage >= 70}">B</c:when>
                                                <c:when test="${attempt.percentage >= 60}">C</c:when>
                                                <c:when test="${attempt.percentage >= 50}">D</c:when>
                                                <c:otherwise>F</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <!-- Navigation -->
        <div class="navigation">
            <a href="/admin" class="btn btn-primary">Admin Dashboard</a>
            <a href="/admin/students" class="btn">Manage Students</a>
            <a href="/admin/questions" class="btn">Manage Questions</a>
            <a href="/admin/exam-config" class="btn">Exam Configuration</a>
        </div>
    </div>
</body>
</html>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 All Exam Attempts</h1>
            <div>
                <a href="/admin" class="btn btn-primary">🏠 Dashboard</a>
                <a href="/admin/students" class="btn btn-secondary">👥 Students</a>
            </div>
        </div>

        <!-- ✅ ADD: Error handling -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <strong>⚠️ Error:</strong> ${error}
            </div>
        </c:if>

        <!-- ✅ FIX: Check if attempts exists and is not null -->
        <c:choose>
            <c:when test="${empty attempts or attempts.size() == 0}">
                <div class="no-attempts">
                    <h3>📝 No Exam Attempts Found</h3>
                    <p>No students have taken any exams yet.</p>
                    <p><a href="/admin/exam-config" class="btn btn-primary">⚙️ Configure Exam</a></p>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Statistics Cards -->
                <div class="stats-cards">
                    <div class="stat-card">
                        <div class="stat-number">${attempts.size()}</div>
                        <div>Total Attempts</div>
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
                        <div>Passed (≥60%)</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">
                            ${attempts.size() - passedCount}
                        </div>
                        <div>Failed (<60%)</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">
                            <c:set var="totalPercentage" value="0"/>
                            <c:forEach var="attempt" items="${attempts}">
                                <c:set var="totalPercentage" value="${totalPercentage + attempt.percentage}"/>
                            </c:forEach>
                            <fmt:formatNumber value="${totalPercentage / attempts.size()}" maxFractionDigits="1"/>%
                        </div>
                        <div>Average Score</div>
                    </div>
                </div>

                <!-- Attempts Table -->
                <table class="attempts-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Student Email</th>
                            <th>Attempt Date & Time</th>
                            <th>Score</th>
                            <th>Total Questions</th>
                            <th>Percentage</th>
                            <th>Result</th>
                            <th>Grade</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="attempt" items="${attempts}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <strong>${attempt.studentEmail}</strong>
                                </td>
                                <td>
                                    <!-- ✅ FIX: Display LocalDateTime directly without fmt:formatDate -->
                                    <c:choose>
                                        <c:when test="${not empty attempt.attemptTime}">
                                            <div style="font-weight: bold; font-size: 12px; word-break: break-word;">
                                                ${attempt.attemptTime}
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div style="color: #999;">No date available</div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td><strong>${attempt.score}</strong></td>
                                <td>${attempt.totalQuestions}</td>
                                <td>
                                    <span class="${attempt.percentage >= 60 ? 'score-good' : 'score-bad'}">
                                        <fmt:formatNumber value="${attempt.percentage}" maxFractionDigits="1"/>%
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${attempt.percentage >= 80}">
                                            <span class="score-good">🏆 EXCELLENT</span>
                                        </c:when>
                                        <c:when test="${attempt.percentage >= 60}">
                                            <span class="score-good">✅ PASSED</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="score-bad">❌ FAILED</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${attempt.percentage >= 90}">A+</c:when>
                                        <c:when test="${attempt.percentage >= 80}">A</c:when>
                                        <c:when test="${attempt.percentage >= 70}">B</c:when>
                                        <c:when test="${attempt.percentage >= 60}">C</c:when>
                                        <c:when test="${attempt.percentage >= 50}">D</c:when>
                                        <c:otherwise>F</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>

        <!-- Navigation -->
        <div style="text-align: center; margin-top: 30px; padding: 20px; background: #f8f9fa; border-radius: 5px;">
            <a href="/admin" class="btn btn-primary">🏠 Admin Dashboard</a>
            <a href="/admin/students" class="btn btn-secondary">👥 Manage Students</a>
            <a href="/admin/questions" class="btn btn-secondary">📝 Manage Questions</a>
            <a href="/admin/exam-config" class="btn btn-secondary">⚙️ Exam Configuration</a>
        </div>
    </div>
</body>
</html>