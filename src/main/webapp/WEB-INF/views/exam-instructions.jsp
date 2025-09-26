<!-- filepath: src/main/webapp/WEB-INF/views/exam-instructions.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Exam Instructions</title>
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
        .instructions {
            background-color: #fff3cd;
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
            border-left: 4px solid #ffc107;
        }
        .student-info {
            background-color: #e8f5e8;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .btn {
            padding: 15px 30px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        ul {
            text-align: left;
            margin: 20px 0;
        }
        li {
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📝 Online Examination</h1>
            <h3>Instructions & Guidelines</h3>
        </div>

        <div class="student-info">
            <h3>Student Information</h3>
            <p><strong>Name:</strong> ${student.name}</p>
            <p><strong>Roll Number:</strong> ${student.rollNumber}</p>
            <p><strong>Total Questions:</strong> ${totalQuestions}</p>
        </div>

        <div class="instructions">
            <h3>⚠️ Important Instructions</h3>
            <ul>
                <li><strong>Time Management:</strong> There is no time limit, but your time will be recorded</li>
                <li><strong>Navigation:</strong> Use "Previous" and "Next" buttons to navigate between questions</li>
                <li><strong>Answering:</strong> Select one option for each multiple-choice question</li>
                <li><strong>Review:</strong> You can review and change your answers before final submission</li>
                <li><strong>Submission:</strong> Once submitted, you cannot change your answers</li>
                <li><strong>Technical Issues:</strong> If you face any technical problems, contact your administrator</li>
                <li><strong>Fair Play:</strong> This exam is monitored. Please maintain academic integrity</li>
            </ul>
        </div>

        <div class="instructions">
            <h3>📋 Exam Guidelines</h3>
            <ul>
                <li>Read each question carefully before selecting your answer</li>
                <li>Make sure you have answered all questions before submitting</li>
                <li>Your results will be available immediately after submission</li>
                <li>Your exam attempt will be recorded for future reference</li>
            </ul>
        </div>

        <div style="text-align: center; margin-top: 30px;">
            <p><strong>Ready to begin your examination?</strong></p>
            <a href="/exam/question" class="btn">🚀 Start Exam</a>
            <a href="/student-dashboard" class="btn btn-secondary">Cancel</a>
        </div>
    </div>
</body>
</html>