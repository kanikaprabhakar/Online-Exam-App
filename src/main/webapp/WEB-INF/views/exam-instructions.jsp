<!-- filepath: src/main/webapp/WEB-INF/views/exam-instructions.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Instructions - ${config.examTitle}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .header { text-align: center; margin-bottom: 30px; }
        .student-info { background: #e7f3ff; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .instructions { background: #fff3cd; border: 1px solid #ffeaa7; padding: 20px; border-radius: 5px; margin-bottom: 30px; }
        .instructions h3 { color: #856404; margin-top: 0; }
        .instructions ul { margin-left: 20px; }
        .instructions li { margin-bottom: 10px; }
        .exam-details { background: #d4edda; border: 1px solid #c3e6cb; padding: 20px; border-radius: 5px; margin-bottom: 30px; }
        .btn { padding: 15px 30px; border: none; border-radius: 5px; cursor: pointer; font-size: 18px; text-decoration: none; display: inline-block; text-align: center; }
        .btn-success { background: #28a745; color: white; }
        .btn-secondary { background: #6c757d; color: white; }
        .warning { color: #dc3545; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📝 ${config.examTitle}</h1>
            <p>Welcome to the Online Examination System</p>
        </div>

        <div class="student-info">
            <h3>👤 Student Information</h3>
            <p><strong>Name:</strong> ${student.name}</p>
            <p><strong>Email:</strong> ${student.email}</p>
            <p><strong>Roll Number:</strong> ${student.rollNumber}</p>
        </div>

        <div class="exam-details">
            <h3>📋 Exam Details</h3>
            <p><strong>Exam Title:</strong> ${config.examTitle}</p>
            <p><strong>Number of Questions:</strong> ${config.questionCount}</p>
            <p><strong>Time Duration:</strong> ${config.examDurationMinutes} minutes</p>
            <p><strong>Question Type:</strong> Multiple Choice Questions (MCQ)</p>
        </div>

        <div class="instructions">
            <h3>⚠️ Important Instructions</h3>
            <ul>
                <li><strong>Time Limit:</strong> You have ${config.examDurationMinutes} minutes to complete the exam</li>
                <li><strong>Questions:</strong> There are ${config.questionCount} questions in total</li>
                <li><strong>Navigation:</strong> You can move forward through questions, but cannot go back</li>
                <li><strong>Selection:</strong> Choose one option for each question</li>
                <li><strong>Submission:</strong> Your exam will be auto-submitted when time expires</li>
                <li><strong>Browser:</strong> Do not refresh the page or close the browser during exam</li>
                <li class="warning">⚠️ Once you start, you cannot restart the exam</li>
            </ul>
        </div>

        <div style="text-align: center;">
            <p class="warning">Are you ready to begin the exam?</p>
            <a href="/exam/question" class="btn btn-success">🚀 Start Exam</a>
            <a href="/student-dashboard" class="btn btn-secondary">🔙 Back to Dashboard</a>
        </div>
    </div>
</body>
</html>