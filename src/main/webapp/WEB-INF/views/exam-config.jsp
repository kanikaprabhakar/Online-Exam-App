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