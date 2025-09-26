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
            <h1>🎉 Exam Completed!</h1>
            <p>Congratulations ${student.name}, you have successfully completed the exam.</p>
        </div>

        <div class="result-card">
            <h2>Your Score</h2>
            <div class="score-circle">
                <div class="score-text">
                    <fmt:formatNumber value="${attempt.score}" maxFractionDigits="1"/>%
                </div>
            </div>
            <h3>${attempt.correctAnswers} out of ${attempt.totalQuestions} correct</h3>
        </div>

        <div class="performance-indicator">
            <c:choose>
                <c:when test="${attempt.score >= 80}">
                    <h3 class="excellent">🌟 Excellent Performance!</h3>
                    <p>Outstanding work! You have demonstrated a strong understanding of the subject.</p>
                </c:when>
                <c:when test="${attempt.score >= 60}">
                    <h3 class="good">👍 Good Performance!</h3>
                    <p>Well done! You have a good grasp of the material with room for improvement.</p>
                </c:when>
                <c:otherwise>
                    <h3 class="needs-improvement">📚 Keep Learning!</h3>
                    <p>Don't worry! Review the material and try again. Practice makes perfect!</p>
                </c:otherwise>
            </c:choose>
            
            <c:if test="${unansweredQuestions > 0}">
                <div style="background-color: #fff3cd; padding: 10px; border-radius: 5px; margin: 10px 0; border-left: 4px solid #ffc107;">
                    <strong>Note:</strong> You left ${unansweredQuestions} question(s) unanswered. 
                    Make sure to answer all questions in future attempts for better results.
                </div>
            </c:if>
        </div>

        <div class="details-grid">
            <div class="detail-card">
                <div class="detail-label">Student Name</div>
                <div class="detail-value">${attempt.studentName}</div>
            </div>
            
            <div class="detail-card">
                <div class="detail-label">Roll Number</div>
                <div class="detail-value">${student.rollNumber}</div>
            </div>
            
            <div class="detail-card">
                <div class="detail-label">Total Questions</div>
                <div class="detail-value">${attempt.totalQuestions}</div>
            </div>
            
            <div class="detail-card">
                <div class="detail-label">Correct Answers</div>
                <div class="detail-value">${attempt.correctAnswers}</div>
            </div>
            
            <div class="detail-card">
                <div class="detail-label">Wrong Answers</div>
                <div class="detail-value">${attempt.totalQuestions - attempt.correctAnswers}</div>
            </div>
            
            <div class="detail-card">
                <div class="detail-label">Time Taken</div>
                <div class="detail-value">${attempt.timeTaken} minutes</div>
            </div>
            
            <div class="detail-card">
                <div class="detail-label">Start Time</div>
                <div class="detail-value">
                    ${attempt.startTime.toLocalDate()}<br>
                    <small>${attempt.startTime.toLocalTime()}</small>
                </div>
            </div>
            
            <div class="detail-card">
                <div class="detail-label">Completion Time</div>
                <div class="detail-value">
                    ${attempt.endTime.toLocalDate()}<br>
                    <small>${attempt.endTime.toLocalTime()}</small>
                </div>
            </div>

            <div class="detail-card">
                <div class="detail-label">Answered Questions</div>
                <div class="detail-value">${answeredQuestions} out of ${attempt.totalQuestions}</div>
            </div>

            <div class="detail-card">
                <div class="detail-label">Unanswered Questions</div>
                <div class="detail-value">${unansweredQuestions}</div>
            </div>
        </div>

        <div style="text-align: center; margin-top: 30px;">
            <a href="/exam/results" class="btn btn-secondary">📊 View All Results</a>
            <a href="/student-dashboard" class="btn btn-primary">🏠 Back to Dashboard</a>
        </div>
    </div>
</body>
</html>