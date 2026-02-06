<!-- filepath: src/main/webapp/WEB-INF/views/exam-result.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Exam Results - Evalora</title>
    <link rel="icon" type="image/png" href="/static/document-file.png">
    <link href="https://fonts.googleapis.com/css2?family=Aileron:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Aileron', sans-serif; background: #1a1a1a; color: #ddd; padding: 20px; line-height: 1.6; }
        .container { max-width: 800px; margin: 0 auto; background-color: #252525; padding: 40px; border-radius: 8px; border: 1px solid #333; }
        .header { text-align: center; margin-bottom: 30px; padding-bottom: 20px; border-bottom: 1px solid #444; }
        .header h1 { color: #fff; font-weight: 700; }
        .header p { color: #aaa; margin-top: 10px; }
        .result-card { background: #223a22; color: #88ff88; padding: 30px; border-radius: 8px; text-align: center; margin: 20px 0; border: 2px solid #446b44; }
        .result-card.failed { background: #3a2223; color: #ff8888; border-color: #6b4444; }
        .score-circle { width: 120px; height: 120px; border-radius: 50%; background-color: rgba(255, 255, 255, 0.1); display: flex; align-items: center; justify-content: center; margin: 20px auto; border: 3px solid currentColor; }
        .score-text { font-size: 24px; font-weight: bold; }
        .details-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin: 30px 0; }
        .detail-card { background-color: #1f1f1f; padding: 20px; border-radius: 8px; border: 1px solid #444; }
        .detail-label { font-weight: 600; color: #aaa; margin-bottom: 5px; }
        .detail-value { font-size: 18px; color: #fff; }
        .btn { padding: 12px 25px; border: 1px solid #666; border-radius: 4px; cursor: pointer; font-size: 14px; font-weight: 600; text-decoration: none; display: inline-block; margin: 10px; font-family: 'Aileron', sans-serif; transition: all 0.3s ease; }
        .btn-primary { background-color: #444; color: white; }
        .btn-primary:hover { background-color: #555; border-color: #888; }
        .btn-secondary { background-color: #444; color: white; }
        .btn-secondary:hover { background-color: #555; border-color: #888; }
        .performance-indicator { text-align: center; margin: 20px 0; }
        .performance-indicator h3 { margin-bottom: 10px; }
        .performance-indicator p { color: #aaa; }
        .excellent { color: #88ff88; }
        .good { color: #ffcc88; }
        .needs-improvement { color: #ff8888; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>${isPractice ? 'Practice Completed' : 'Exam Completed'}</h1>
            <p>
                <c:choose>
                    <c:when test="${isPractice}">
                        ${student.name}, you have completed the practice session. This score will not be recorded.
                    </c:when>
                    <c:otherwise>
                        Congratulations ${student.name}, you have successfully completed the exam.
                    </c:otherwise>
                </c:choose>
            </p>
        </div>

        <div class="result-card ${passed ? '' : 'failed'}">
            <h2>Your Score</h2>
            <div class="score-circle">
                <div class="score-text">
                    <fmt:formatNumber value="${percentage}" maxFractionDigits="1"/>%
                </div>
            </div>
            <h3>${correctAnswers} out of ${totalQuestions} correct</h3>
        </div>

        <div class="performance-indicator">
            <c:choose>
                <c:when test="${percentage >= 80}">
                    <h3 class="excellent">Excellent Performance</h3>
                    <p>Outstanding work! You have demonstrated a strong understanding of the subject.</p>
                </c:when>
                <c:when test="${percentage >= 60}">
                    <h3 class="good">Good Performance</h3>
                    <p>Well done! You have a good grasp of the material with room for improvement.</p>
                </c:when>
                <c:otherwise>
                    <h3 class="needs-improvement">Keep Learning</h3>
                    <p>Don't worry! Review the material and try again. Practice makes perfect!</p>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="details-grid">
            <div class="detail-card">
                <div class="detail-label">Student Name</div>
                <div class="detail-value">${student.name}</div>
            </div>
            
            <div class="detail-card">
                <div class="detail-label">Roll Number</div>
                <div class="detail-value">${student.rollNumber}</div>
            </div>
            
            <div class="detail-card">
                <div class="detail-label">Total Questions</div>
                <div class="detail-value">${totalQuestions}</div>
            </div>
            
            <div class="detail-card">
                <div class="detail-label">Correct Answers</div>
                <div class="detail-value">${correctAnswers}</div>
            </div>
            
            <div class="detail-card">
                <div class="detail-label">Wrong Answers</div>
                <div class="detail-value">${totalQuestions - correctAnswers}</div>
            </div>
            
            <div class="detail-card">
                <div class="detail-label">Score Percentage</div>
                <div class="detail-value">
                    <fmt:formatNumber value="${percentage}" maxFractionDigits="1"/>%
                </div>
            </div>
            
            <div class="detail-card">
                <div class="detail-label">Result Status</div>
                <div class="detail-value">
                    <c:choose>
                        <c:when test="${passed}">
                            <span style="color: #88ff88; font-weight: bold;">PASSED</span>
                        </c:when>
                        <c:otherwise>
                            <span style="color: #ff8888; font-weight: bold;">FAILED</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <div class="detail-card">
                <div class="detail-label">Passing Score</div>
                <div class="detail-value">60%</div>
            </div>
        </div>

        <div style="text-align: center; margin-top: 30px;">
            <c:if test="${isPractice}">
                <a href="/exam/practice" class="btn btn-secondary">Practice Again</a>
            </c:if>
            <a href="/exam/results" class="btn btn-secondary">View All Results</a>
            <a href="/student-dashboard" class="btn btn-primary">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>