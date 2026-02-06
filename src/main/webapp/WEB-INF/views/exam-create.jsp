<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create New Exam - Admin - Evalora</title>
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
        .back-link {
            display: inline-block;
            color: #888;
            text-decoration: none;
            margin-bottom: 20px;
            transition: color 0.3s;
        }
        .back-link:hover { color: #ddd; }
        .header {
            text-align: center;
            margin-bottom: 35px;
            padding-bottom: 25px;
            border-bottom: 1px solid #444;
        }
        .header h1 { color: #fff; font-weight: 700; font-size: 1.8rem; }
        .header p { color: #aaa; margin-top: 10px; font-size: 14px; }
        .form-group {
            margin-bottom: 22px;
            animation: fadeIn 0.6s ease backwards;
        }
        .form-group:nth-of-type(1) { animation-delay: 0.15s; }
        .form-group:nth-of-type(2) { animation-delay: 0.17s; }
        .form-group:nth-of-type(3) { animation-delay: 0.19s; }
        .form-group:nth-of-type(4) { animation-delay: 0.21s; }
        .form-group:nth-of-type(5) { animation-delay: 0.23s; }
        .form-group:nth-of-type(6) { animation-delay: 0.25s; }
        .form-group:nth-of-type(7) { animation-delay: 0.27s; }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #aaa;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.5px;
        }
        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #444;
            border-radius: 6px;
            background-color: #1a1a1a;
            color: #ddd;
            font-family: 'Aileron', sans-serif;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #666;
            background-color: #1f1f1f;
            box-shadow: 0 0 0 2px rgba(100, 100, 100, 0.2);
        }
        input::placeholder { color: #888; }
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px;
            background: #1a1a1a;
            border-radius: 6px;
            border: 1px solid #444;
        }
        .checkbox-group input[type="checkbox"] {
            width: auto;
            cursor: pointer;
        }
        .checkbox-group label {
            margin: 0;
            text-transform: none;
            font-size: 14px;
            letter-spacing: normal;
        }
        .btn {
            padding: 12px 28px;
            border: 1px solid #666;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            font-family: 'Aileron', sans-serif;
            transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .btn-submit {
            background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%);
            color: white;
            border-color: #5a9fe9;
        }
        .btn-submit:hover {
            background: linear-gradient(135deg, #5a9fe9 0%, #4682d4 100%);
            border-color: #6aaff0;
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(74, 144, 226, 0.3);
        }
        .btn-cancel {
            background: linear-gradient(135deg, #444 0%, #333 100%);
            color: white;
            border-color: #666;
            text-decoration: none;
            display: inline-block;
        }
        .btn-cancel:hover {
            background: linear-gradient(135deg, #555 0%, #444 100%);
            border-color: #888;
            transform: translateY(-2px);
        }
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            animation: fadeIn 0.6s ease 0.29s backwards;
        }
        .alert {
            padding: 16px 24px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-weight: 600;
            animation: slideDown 0.4s ease;
        }
        .alert-success {
            background-color: #2a3a2a;
            color: #88dd88;
            border: 1px solid #446644;
        }
        .alert-error {
            background-color: #3a2222;
            color: #dd8888;
            border: 1px solid #664444;
        }
        .info-box {
            background: linear-gradient(135deg, #2a2f3a 0%, #1f242d 100%);
            border: 1px solid #3a4a5a;
            padding: 16px;
            border-radius: 8px;
            margin-bottom: 25px;
            color: #88aadd;
            animation: fadeIn 0.6s ease 0.1s backwards;
        }
        .info-box p { font-size: 13px; margin-bottom: 8px; }
        .info-box p:last-child { margin-bottom: 0; }
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <a href="/admin/exams" class="back-link">← Back to Exams List</a>
    <div class="container">
        <div class="header">
            <h1>Create New Exam</h1>
            <p>Set up a new exam configuration for students</p>
        </div>

        <c:if test="${error != null}">
            <div class="alert alert-error">
                ${error}
            </div>
        </c:if>

        <div class="info-box">
            <p><strong>Total Questions Available:</strong> ${totalQuestions}</p>
            <p>Make sure the question count doesn't exceed available questions in the database.</p>
        </div>

        <form action="/admin/exams/create" method="post">
            <div class="form-group">
                <label for="examTitle">Exam Title</label>
                <input type="text" id="examTitle" name="examTitle" placeholder="e.g., Java Programming Exam" required>
            </div>

            <div class="form-group">
                <label for="examDuration">Duration (minutes)</label>
                <input type="number" id="examDuration" name="examDuration" min="1" placeholder="e.g., 60" required>
            </div>

            <div class="form-group">
                <label for="questionCount">Number of Questions</label>
                <input type="number" id="questionCount" name="questionCount" min="1" max="${totalQuestions}" placeholder="e.g., 20" required>
            </div>

            <div class="form-group">
                <label for="totalMarks">Total Marks</label>
                <input type="number" id="totalMarks" name="totalMarks" min="1" placeholder="e.g., 100" required>
            </div>

            <div class="form-group">
                <label for="passingMarks">Passing Marks</label>
                <input type="number" id="passingMarks" name="passingMarks" min="0" placeholder="e.g., 60" required>
            </div>

            <div class="form-group">
                <label>Negative Marking</label>
                <div class="checkbox-group">
                    <input type="checkbox" id="negativeMarking" name="negativeMarking" value="true">
                    <label for="negativeMarking">Enable negative marking for incorrect answers</label>
                </div>
            </div>

            <div class="form-group">
                <label>Exam Status</label>
                <div class="checkbox-group">
                    <input type="checkbox" id="examEnabled" name="examEnabled" value="true" checked>
                    <label for="examEnabled">Enable this exam (students can take it)</label>
                </div>
            </div>

            <div class="button-group">
                <button type="submit" class="btn btn-submit">Create Exam</button>
                <a href="/admin/exams" class="btn btn-cancel">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
