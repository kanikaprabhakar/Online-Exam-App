<!-- filepath: src/main/webapp/WEB-INF/views/exam-instructions.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Instructions - Evalora</title>
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
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            padding: 40px;
            border-radius: 12px;
            border: 1px solid #333;
            animation: slideDown 0.5s ease;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }
        .header {
            text-align: center;
            margin-bottom: 35px;
            padding-bottom: 25px;
            border-bottom: 1px solid #444;
        }
        .header h1 { color: #fff; font-weight: 700; font-size: 1.8rem; }
        .header h2 { color: #ddd; margin-top: 12px; font-weight: 600; font-size: 1.2rem; }
        .instructions { margin-bottom: 30px; }
        .instruction-item {
            margin-bottom: 12px;
            padding: 16px;
            background: linear-gradient(135deg, #1f1f1f 0%, #1a1a1a 100%);
            border-radius: 8px;
            border: 1px solid #444;
            color: #bbb;
            animation: fadeIn 0.6s ease backwards;
            transition: all 0.3s ease;
        }
        .instruction-item:nth-child(1) { animation-delay: 0.25s; }
        .instruction-item:nth-child(2) { animation-delay: 0.27s; }
        .instruction-item:nth-child(3) { animation-delay: 0.29s; }
        .instruction-item:nth-child(4) { animation-delay: 0.31s; }
        .instruction-item:nth-child(5) { animation-delay: 0.33s; }
        .instruction-item:nth-child(6) { animation-delay: 0.35s; }
        .instruction-item:nth-child(7) { animation-delay: 0.37s; }
        .instruction-item:hover { border-color: #555; background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%); transform: translateX(4px); }
        .exam-details {
            background: linear-gradient(135deg, #1f1f1f 0%, #1a1a1a 100%);
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 25px;
            border: 1px solid #444;
            animation: slideDown 0.5s ease 0.1s backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }
        .exam-details h3 { color: #fff; margin-bottom: 15px; font-weight: 700; }
        .exam-details p { color: #bbb; margin-bottom: 10px; }
        .exam-details strong { color: #ddd; }
        .btn {
            padding: 12px 28px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            border-radius: 6px;
            border: 1px solid #666;
            cursor: pointer;
            margin: 12px 12px 12px 0;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: inline-block;
            font-family: 'Aileron', sans-serif;
        }
        .btn-primary { background-color: #444; color: white; }
        .btn-primary:hover { background-color: #555; border-color: #888; transform: translateY(-2px); box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4); }
        .btn-secondary { background-color: #555; color: white; border-color: #777; }
        .btn-secondary:hover { background-color: #666; border-color: #999; transform: translateY(-2px); box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4); }
        .warning-box {
            background: linear-gradient(135deg, rgba(90, 56, 66, 0.3) 0%, rgba(107, 68, 68, 0.2) 100%);
            color: #ff8888;
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 25px;
            border: 2px solid #ff8888;
            text-align: center;
            animation: slideDown 0.5s ease 0.2s backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }
        .warning-box h3 {
            margin-top: 0;
            margin-bottom: 15px;
            font-size: 1.2rem;
            color: #ffaaaa;
            font-weight: 700;
            letter-spacing: 0.5px;
        }
        .warning-box p { font-size: 14px; margin: 10px 0; line-height: 1.6; }
        .practice-box {
            background: linear-gradient(135deg, rgba(34, 51, 58, 0.3) 0%, rgba(68, 102, 119, 0.2) 100%);
            color: #88ccee;
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 25px;
            border: 2px solid #88ccee;
            text-align: center;
            animation: slideDown 0.5s ease 0.15s backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }
        .practice-box h3 {
            margin-top: 0;
            margin-bottom: 15px;
            color: #aaddee;
            font-weight: 700;
            font-size: 1.1rem;
            letter-spacing: 0.5px;
        }
        .practice-box p { font-size: 14px; margin: 10px 0; line-height: 1.6; }
        .warning-item { background: linear-gradient(135deg, rgba(90, 56, 66, 0.3) 0%, rgba(107, 68, 68, 0.2) 100%) !important; color: #ffaaaa !important; border: 1px solid #ff8888 !important; font-weight: 600; }
        .warning-item strong { color: #ffbb99 !important; }
        div[style*="text-align: center"] { animation: fadeIn 0.6s ease 0.4s backwards; }
        @keyframes slideDown { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Exam Instructions</h1>
            <h2>${config.examTitle}</h2>
        </div>

        <div class="exam-details">
            <h3>Exam Details</h3>
            <p><strong>Total Questions:</strong> ${config.questionCount}</p>
            <p><strong>Duration:</strong> ${config.examDuration} minutes</p>
            <p><strong>Total Marks:</strong> ${config.totalMarks}</p>
            <p><strong>Passing Marks:</strong> ${config.passingMarks}</p>
            <p><strong>Negative Marking:</strong> ${config.negativeMarking ? 'Yes' : 'No'}</p>
        </div>
        
        <c:if test="${not isPractice}">
            <div class="warning-box">
                <h3>ONE ATTEMPT ONLY</h3>
                <p>
                    <strong>This is a REAL EXAM. You can only take it ONCE.</strong><br>
                    Make sure you are ready before clicking "Start Exam Now".<br>
                    For practice, please use Practice Mode from the dashboard.
                </p>
            </div>
        </c:if>
        
        <c:if test="${isPractice}">
            <div class="practice-box">
                <h3>Practice Mode</h3>
                <p>
                    This is a practice session. You can take it as many times as you want.<br>
                    Your score will <strong>NOT</strong> be recorded.
                </p>
            </div>
        </c:if>

        <div class="instructions">
            <h3>Important Instructions</h3>
            <c:if test="${not isPractice}">
                <div class="instruction-item warning-item">
                    <strong>IMPORTANT:</strong> You can take this exam ONLY ONCE. There are NO retakes.
                </div>
            </c:if>
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
                <div class="instruction-item warning-item">
                    <strong>Warning:</strong> Negative marking is enabled. Wrong answers will deduct marks.
                </div>
            </c:if>
        </div>

        <div style="text-align: center;">
            <a href="/student-dashboard" class="btn btn-secondary">Back to Dashboard</a>
            <a href="/exam/question" class="btn btn-primary">Start Exam Now</a>
        </div>
    </div>
</body>
</html>