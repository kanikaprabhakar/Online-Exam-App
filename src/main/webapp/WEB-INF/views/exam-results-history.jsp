<!-- filepath: src/main/webapp/WEB-INF/views/exam-results-history.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Results History - Evalora</title>
    <link rel="icon" type="image/png" href="/document-file.png">
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
        
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin: 30px 0 40px;
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
        .stat-card:nth-child(1) { animation-delay: 0.15s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:hover { border-color: #555; transform: translateY(-6px); }
        .stat-number { font-size: 28px; font-weight: 700; color: #88ff88; }
        .stat-label { color: #aaa; margin-top: 10px; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px; }
        
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
        
        .results-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #252525;
            border-radius: 0 0 12px 12px;
            overflow: hidden;
            border: 1px solid #333;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }
        .results-table th {
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
        .results-table td { padding: 16px; color: #bbb; border-bottom: 1px solid #333; }
        .results-table tr:hover td { background-color: #1f1f1f; color: #ddd; }
        .results-table tr:last-child td { border-bottom: none; }
        .score-good { color: #88ff88; font-weight: 700; }
        .score-bad { color: #ff8888; font-weight: 700; }
        
        .no-attempts {
            text-align: center;
            padding: 60px 20px;
            border-radius: 12px;
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            border: 1px solid #333;
            animation: slideDown 0.5s ease 0.1s backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }
        .no-attempts h3 { color: #fff; font-size: 1.3rem; margin-bottom: 15px; }
        .no-attempts p { color: #888; margin-bottom: 25px; }
        
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
        .btn-secondary { background-color: #555; border-color: #777; }
        .btn-secondary:hover { background-color: #666; border-color: #999; }
        
        .button-group { text-align: center; margin-top: 40px; display: flex; justify-content: center; gap: 15px; flex-wrap: wrap; }
        @keyframes slideDown { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Exam Results History</h1>
            <a href="/student-dashboard" class="btn btn-secondary">Back to Dashboard</a>
        </div>

        <div class="student-info">
            <h3>Student Information</h3>
            <p><strong>Name:</strong> ${student.name}</p>
            <p><strong>Email:</strong> ${student.email}</p>
            <p><strong>Roll Number:</strong> ${student.rollNumber}</p>
        </div>

        <c:choose>
            <c:when test="${empty attemptsByExam or totalAttempts == 0}">
                <div class="no-attempts">
                    <h3>No Exam Attempts Found</h3>
                    <p>You haven't taken any exams yet.</p>
                    <a href="/student-dashboard" class="btn">Go to Dashboard</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="stats">
                    <div class="stat-card">
                        <div class="stat-number">${totalAttempts}</div>
                        <div class="stat-label">Total Attempts</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${attemptsByExam.size()}</div>
                        <div class="stat-label">Exams Taken</div>
                    </div>
                </div>

                <!-- Results grouped by exam -->
                <c:forEach var="examEntry" items="${attemptsByExam}">
                    <div class="exam-section">
                        <div class="exam-header">
                            <div class="exam-title">${examEntry.key}</div>
                            <div class="exam-count">${examEntry.value.size()} attempt(s)</div>
                        </div>
                        
                        <table class="results-table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Date & Time</th>
                                    <th>Score</th>
                                    <th>Total Questions</th>
                                    <th>Percentage</th>
                                    <th>Result</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="attempt" items="${examEntry.value}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>
                                            <c:set var="attemptTimeStr" value="${attempt.attemptTime.toString()}" />
                                            <c:set var="dateOnly" value="${attemptTimeStr.substring(0, 10)}" />
                                            <c:set var="timeOnly" value="${attemptTimeStr.substring(11, 19)}" />
                                            
                                            <div style="font-weight: bold;">${dateOnly}</div>
                                            <div style="color: #666; font-size: 12px;">${timeOnly}</div>
                                        </td>
                                        <td>${attempt.score}</td>
                                        <td>${attempt.totalQuestions}</td>
                                        <td>
                                            <span class="${attempt.percentage >= 60 ? 'score-good' : 'score-bad'}">
                                                <fmt:formatNumber value="${attempt.percentage}" maxFractionDigits="1"/>%
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${attempt.percentage >= 60}">
                                                    <span class="score-good">PASSED</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="score-bad">FAILED</span>
                                                </c:otherwise>
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

        <div class="button-group">
            <a href="/student-dashboard" class="btn">Back to Dashboard</a>
            <a href="/exam/practice" class="btn btn-secondary">Practice Mode</a>
        </div>
    </div>
</body>
</html>