<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Configuration - Admin - Evalora</title>
    <link rel="icon" type="image/png" href="/static/document-file.png">
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
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
            margin-right: 12px;
        }
        .btn-primary { background: #444; color: white; }
        .btn-primary:hover { background: #555; border-color: #888; transform: translateY(-2px); box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4); }
        .btn-secondary { background: #555; color: white; border-color: #777; }
        .btn-secondary:hover { background: #666; border-color: #999; transform: translateY(-2px); box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4); }
        .alert {
            padding: 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            animation: fadeIn 0.5s ease;
        }
        .alert-success { background: rgba(34, 58, 34, 0.4); color: #88ff88; border-left: 3px solid #88ff88; }
        .alert-danger { background: rgba(90, 56, 66, 0.4); color: #ff8888; border-left: 3px solid #ff8888; }
        .status-indicator {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .status-enabled { background: rgba(34, 58, 34, 0.5); color: #88ff88; border: 1px solid #88ff88; }
        .status-disabled { background: rgba(90, 56, 66, 0.5); color: #ff8888; border: 1px solid #ff8888; }
        .info-box {
            background: linear-gradient(135deg, #1f1f1f 0%, #1a1a1a 100%);
            border: 1px solid #444;
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 25px;
            animation: slideDown 0.5s ease 0.05s backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }
        .info-box h3 { color: #fff; margin-bottom: 15px; font-weight: 700; }
        .info-box p { color: #bbb; margin-bottom: 10px; }
        .info-box strong { color: #ddd; }
        @keyframes slideDown { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Exam Configuration</h1>
            <p>Configure exam settings for students</p>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="info-box">
            <h3>Current Status</h3>
            <p><strong>Exam Status:</strong> 
                <span class="status-indicator ${examConfig.examEnabled ? 'status-enabled' : 'status-disabled'}">
                    ${examConfig.examEnabled ? 'ENABLED' : 'DISABLED'}
                </span>
            </p>
            <p><strong>Questions in Database:</strong> ${totalQuestions}</p>
            <p><strong>Questions per Exam:</strong> ${examConfig.questionCount}</p>
            <p><strong>Exam Duration:</strong> ${examConfig.examDuration} minutes</p>
        </div>

        <form action="/admin/exam-config/update" method="post">
            <input type="hidden" name="id" value="${examConfig.id}"/>
            
            <div class="form-group">
                <label>Exam Title:</label>
                <input type="text" name="examTitle" value="${examConfig.examTitle}" class="form-control"/>
            </div>
            
            <div class="form-group">
                <label>Duration (minutes):</label>
                <input type="number" name="examDuration" value="${examConfig.examDuration}" class="form-control"/>
            </div>
            
            <div class="form-group">
                <label>Total Questions:</label>
                <input type="number" name="questionCount" value="${examConfig.questionCount}" class="form-control"/>
            </div>
            
            <div class="form-group">
                <label>Total Marks:</label>
                <input type="number" name="totalMarks" value="${examConfig.totalMarks}" class="form-control"/>
            </div>
            
            <div class="form-group">
                <label>Passing Marks:</label>
                <input type="number" name="passingMarks" value="${examConfig.passingMarks}" class="form-control"/>
            </div>
            
            <div class="form-group checkbox-group">
                <input type="checkbox" name="negativeMarking" value="true" ${examConfig.negativeMarking ? 'checked' : ''} id="negativeMarking"/>
                <label for="negativeMarking">Enable Negative Marking</label>
                <input type="hidden" name="negativeMarking" value="false"/>
            </div>
            
            <div class="form-group checkbox-group">
                <input type="checkbox" name="examEnabled" value="true" ${examConfig.examEnabled ? 'checked' : ''} id="examEnabled"/>
                <label for="examEnabled">Enable Exam</label>
                <input type="hidden" name="examEnabled" value="false"/>
            </div>
            
            <div style="text-align: center; margin-top: 30px;">
                <button type="submit" class="btn btn-primary">Update Configuration</button>
                <a href="/admin" class="btn btn-secondary">Back to Dashboard</a>
            </div>
        </form>
    </div>
</body>
</html>