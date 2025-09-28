<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Configuration - Admin</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .header { text-align: center; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], input[type="number"], select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; }
        .checkbox-group { display: flex; align-items: center; gap: 10px; }
        .checkbox-group input[type="checkbox"] { width: auto; }
        .btn { padding: 12px 30px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
        .btn-primary { background: #007bff; color: white; }
        .btn-secondary { background: #6c757d; color: white; }
        .alert { padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-danger { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .status-indicator { display: inline-block; padding: 5px 15px; border-radius: 20px; font-size: 14px; font-weight: bold; }
        .status-enabled { background: #28a745; color: white; }
        .status-disabled { background: #dc3545; color: white; }
        .info-box { background: #e7f3ff; border: 1px solid #b8daff; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🎯 Exam Configuration</h1>
            <p>Configure exam settings for students</p>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="info-box">
            <h3>📊 Current Status</h3>
            <p><strong>Exam Status:</strong> 
                <span class="status-indicator ${config.examEnabled ? 'status-enabled' : 'status-disabled'}">
                    ${config.examEnabled ? 'ENABLED' : 'DISABLED'}
                </span>
            </p>
            <p><strong>Questions in Database:</strong> ${totalQuestions}</p>
            <p><strong>Questions per Exam:</strong> ${config.questionCount}</p>
            <p><strong>Exam Duration:</strong> ${config.examDurationMinutes} minutes</p>
        </div>

        <form action="/admin/exam-config" method="POST">
            <div class="form-group">
                <label for="examTitle">Exam Title:</label>
                <input type="text" id="examTitle" name="examTitle" value="${config.examTitle}" required>
            </div>

            <div class="form-group">
                <div class="checkbox-group">
                    <input type="checkbox" id="examEnabled" name="examEnabled" ${config.examEnabled ? 'checked' : ''}>
                    <label for="examEnabled">Enable Exam (Students can take exam)</label>
                </div>
            </div>

            <div class="form-group">
                <label for="questionCount">Number of Questions per Exam:</label>
                <input type="number" id="questionCount" name="questionCount" value="${config.questionCount}" 
                       min="1" max="${totalQuestions}" required>
                <small>Maximum available: ${totalQuestions} questions</small>
            </div>

            <div class="form-group">
                <label for="examDurationMinutes">Exam Duration (minutes):</label>
                <input type="number" id="examDurationMinutes" name="examDurationMinutes" 
                       value="${config.examDurationMinutes}" min="5" max="180" required>
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-primary">💾 Update Configuration</button>
                <a href="/admin" class="btn btn-secondary">🔙 Back to Admin Dashboard</a>
            </div>
        </form>
    </div>
</body>
</html>