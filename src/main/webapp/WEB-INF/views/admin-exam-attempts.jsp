<!-- filepath: src/main/webapp/WEB-INF/views/admin-exam-attempts.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Exam Attempts - Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 1400px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .attempts-table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        .attempts-table th, .attempts-table td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        .attempts-table th { background-color: #f8f9fa; font-weight: bold; }
        .attempts-table tr:hover { background-color: #f8f9fa; }
        .score-good { color: #28a745; font-weight: bold; }
        .score-bad { color: #dc3545; font-weight: bold; }
        .btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; }
        .btn-primary { background: #007bff; color: white; }
        .no-attempts { text-align: center; padding: 40px; color: #6c757d; }
        .stats-cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: #f8f9fa; padding: 20px; border-radius: 8px; text-align: center; border-left: 4px solid #007bff; }
        .stat-number { font-size: 24px; font-weight: bold; color: #007bff; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 All Exam Attempts</h1>
            <!-- ✅ FIX: Correct dashboard URL -->
            <a href="/admin" class="btn btn-primary">🏠 Back to Dashboard</a>
        </div>

        <c:choose>
            <c:when test="${empty attempts}">
                <div class="no-attempts">
                    <h3>📝 No Exam Attempts Found</h3>
                    <p>No students have taken any exams yet.</p>
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
                        <div>Passed</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">
                            <c:set var="failedCount" value="${attempts.size() - passedCount}"/>
                            ${failedCount}
                        </div>
                        <div>Failed</div>
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
                            <th>Sr. No.</th>
                            <th>Student Email</th>
                            <th>Attempt Date/Time</th>
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
                                <td>${attempt.studentEmail}</td>
                                <td>
                                    <!-- ✅ FIX: Handle LocalDateTime properly -->
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
    </div>
</body>
</html>