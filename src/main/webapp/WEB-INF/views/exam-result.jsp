<!-- filepath: src/main/webapp/WEB-INF/views/exam-result.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Exam Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #4CAF50;
        }
        .result-card {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            margin: 20px 0;
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
        }
        .result-card.failed {
            background: linear-gradient(135deg, #f44336 0%, #da190b 100%);
            box-shadow: 0 4px 15px rgba(244, 67, 54, 0.3);
        }
        .score-circle {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 20px auto;
            border: 3px solid white;
        }
        .score-text {
            font-size: 24px;
            font-weight: bold;
        }
        .details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        .detail-card {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #4CAF50;
        }
        .detail-label {
            font-weight: bold;
            color: #666;
            margin-bottom: 5px;
        }
        .detail-value {
            font-size: 18px;
            color: #333;
        }
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            margin: 10px;
        }
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        .btn-primary:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #2196F3;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #0b7dda;
        }
        .performance-indicator {
            text-align: center;
            margin: 20px 0;
        }
        .excellent { color: #4CAF50; }
        .good { color: #ff9800; }
        .needs-improvement { color: #f44336; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>${isPractice ? '📝 Practice Completed!' : '🎉 Exam Completed!'}</h1>
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
                    <h3 class="excellent">🌟 Excellent Performance!</h3>
                    <p>Outstanding work! You have demonstrated a strong understanding of the subject.</p>
                </c:when>
                <c:when test="${percentage >= 60}">
                    <h3 class="good">👍 Good Performance!</h3>
                    <p>Well done! You have a good grasp of the material with room for improvement.</p>
                </c:when>
                <c:otherwise>
                    <h3 class="needs-improvement">📚 Keep Learning!</h3>
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
                            <span style="color: #4CAF50; font-weight: bold;">✅ PASSED</span>
                        </c:when>
                        <c:otherwise>
                            <span style="color: #f44336; font-weight: bold;">❌ FAILED</span>
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
                <a href="/exam/practice" class="btn btn-secondary">🔄 Practice Again</a>
            </c:if>
            <a href="/exam/results" class="btn btn-secondary">📊 View All Results</a>
            <a href="/student-dashboard" class="btn btn-primary">🏠 Back to Dashboard</a>
        </div>
    </div>
</body>
</html>