<!-- filepath: src/main/webapp/WEB-INF/views/exam-instructions.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Instructions</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
        .container { max-width: 800px; margin: 0 auto; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 20px rgba(0,0,0,0.1); }
        .header { text-align: center; margin-bottom: 30px; color: #4CAF50; }
        .instructions { margin-bottom: 30px; }
        .instruction-item { margin-bottom: 15px; padding: 10px; background-color: #f9f9f9; border-radius: 5px; }
        .exam-details { background-color: #e8f5e9; padding: 20px; border-radius: 5px; margin-bottom: 20px; }
        .btn { padding: 15px 30px; font-size: 16px; text-decoration: none; border-radius: 5px; border: none; cursor: pointer; margin: 10px; }
        .btn-primary { background-color: #4CAF50; color: white; }
        .btn-secondary { background-color: #2196F3; color: white; }
        .btn:hover { opacity: 0.8; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📋 Exam Instructions</h1>
            <h2>${config.examTitle}</h2>
        </div>

        <div class="exam-details">
            <h3>📊 Exam Details</h3>
            <p><strong>📝 Total Questions:</strong> ${config.questionCount}</p>
            <p><strong>⏱️ Duration:</strong> ${config.examDuration} minutes</p>
            <p><strong>📋 Total Marks:</strong> ${config.totalMarks}</p>
            <p><strong>✅ Passing Marks:</strong> ${config.passingMarks}</p>
            <p><strong>❌ Negative Marking:</strong> ${config.negativeMarking ? 'Yes' : 'No'}</p>
        </div>

        <div class="instructions">
            <h3>📜 Important Instructions</h3>
            <div class="instruction-item">
                <strong>1.</strong> Read each question carefully before answering.
            </div>
            <div class="instruction-item">
                <strong>2.</strong> You have ${config.examDuration} minutes to complete the exam.
            </div>
            <div class="instruction-item">
                <strong>3.</strong> Once you start the exam, you cannot pause it.
            </div>
            <div class="instruction-item">
                <strong>4.</strong> Make sure you have a stable internet connection.
            </div>
            <div class="instruction-item">
                <strong>5.</strong> Click "Submit" when you're done or when time runs out.
            </div>
            <c:if test="${config.negativeMarking}">
                <div class="instruction-item" style="background-color: #ffebee; color: #c62828;">
                    <strong>⚠️ Warning:</strong> Negative marking is enabled. Wrong answers will deduct marks.
                </div>
            </c:if>
        </div>

        <div style="text-align: center;">
            <a href="/student-dashboard" class="btn btn-secondary">🏠 Back to Dashboard</a>
            <a href="/exam/question" class="btn btn-primary">🚀 Start Exam Now</a>
        </div>
    </div>
</body>
</html>