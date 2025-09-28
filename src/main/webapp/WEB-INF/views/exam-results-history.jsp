<!-- filepath: src/main/webapp/WEB-INF/views/exam-results-history.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Results History</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .header { text-align: center; margin-bottom: 30px; }
        .student-info { background: #e7f3ff; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .results-table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        .results-table th, .results-table td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        .results-table th { background-color: #f8f9fa; font-weight: bold; }
        .results-table tr:hover { background-color: #f8f9fa; }
        .score-good { color: #28a745; font-weight: bold; }
        .score-bad { color: #dc3545; font-weight: bold; }
        .no-attempts { text-align: center; padding: 40px; color: #6c757d; }
        .btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; }
        .btn-primary { background: #007bff; color: white; }
        .btn-secondary { background: #6c757d; color: white; }
        .stats { display: flex; justify-content: space-between; margin-bottom: 20px; }
        .stat-card { background: #f8f9fa; padding: 15px; border-radius: 5px; text-align: center; flex: 1; margin: 0 10px; }
        .stat-number { font-size: 24px; font-weight: bold; color: #007bff; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 Exam Results History</h1>
        </div>

        <div class="student-info">
            <h3>👤 Student Information</h3>
            <p><strong>Name:</strong> ${student.name}</p>
            <p><strong>Email:</strong> ${student.email}</p>
            <p><strong>Roll Number:</strong> ${student.rollNumber}</p>
        </div>

        <c:choose>
            <c:when test="${empty attempts}">
                <div class="no-attempts">
                    <h3>📝 No Exam Attempts Found</h3>
                    <p>You haven't taken any exams yet.</p>
                    <a href="/student-dashboard" class="btn btn-primary">Go to Dashboard</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="stats">
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
                        <div>Passed</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">
                            <c:set var="maxScore" value="0"/>
                            <c:forEach var="attempt" items="${attempts}">
                                <c:if test="${attempt.percentage > maxScore}">
                                    <c:set var="maxScore" value="${attempt.percentage}"/>
                                </c:if>
                            </c:forEach>
                            <fmt:formatNumber value="${maxScore}" maxFractionDigits="1"/>%
                        </div>
                        <div>Best Score</div>
                    </div>
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
                        <c:forEach var="attempt" items="${attempts}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <!-- ✅ FIX: Use toString() instead of fmt:formatDate for LocalDateTime -->
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
                                            <span class="score-good">✅ PASSED</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="score-bad">❌ FAILED</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>

        <div style="text-align: center; margin-top: 30px;">
            <a href="/student-dashboard" class="btn btn-primary">🏠 Back to Dashboard</a>
            <a href="/exam/start" class="btn btn-secondary">📝 Take New Exam</a>
        </div>
    </div>
</body>
</html>