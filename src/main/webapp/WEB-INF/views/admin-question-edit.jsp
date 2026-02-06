<!-- filepath: c:\Users\DELL\eclipse-workspace\OnlineExamApp2\src\main\webapp\WEB-INF\views\admin-question-edit.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Question - Admin</title>
    <link rel="icon" type="image/png" href="/static/document-file.png">
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .header { text-align: center; margin-bottom: 30px; color: #333; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #333; }
        input[type="text"], textarea { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        textarea { height: 80px; resize: vertical; }
        .options-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 20px; }
        .btn { padding: 12px 24px; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; font-size: 16px; margin: 10px 5px; }
        .btn-primary { background: #28a745; color: white; }
        .btn-secondary { background: #6c757d; color: white; }
        .btn:hover { opacity: 0.8; }
        .alert { padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-danger { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .question-preview { background: #f8f9fa; padding: 20px; border-radius: 5px; margin-bottom: 20px; border-left: 4px solid #007bff; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>✏️ Edit Question</h1>
            <p>Modify the question details below</p>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">✅ ${success}</div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">❌ ${error}</div>
        </c:if>

        <!-- Current Question Preview -->
        <div class="question-preview">
            <h3>📋 Current Question (ID: ${question.id})</h3>
            <p><strong>Question:</strong> ${question.question}</p>
            <p><strong>Options:</strong></p>
            <ul>
                <li><strong>A.</strong> ${question.option1}</li>
                <li><strong>B.</strong> ${question.option2}</li>
                <li><strong>C.</strong> ${question.option3}</li>
                <li><strong>D.</strong> ${question.option4}</li>
            </ul>
            <p><strong>Correct Answer:</strong> <span style="background: #e8f5e9; padding: 3px 8px; border-radius: 3px;">${question.correctAnswer}</span></p>
        </div>

        <!-- Edit Form -->
        <form action="/admin/questions/update" method="POST">
            <input type="hidden" name="id" value="${question.id}"/>
            
            <div class="form-group">
                <label for="question">Question Text:</label>
                <textarea name="question" id="question" required placeholder="Enter your question here...">${question.question}</textarea>
            </div>
            
            <div class="options-grid">
                <div class="form-group">
                    <label for="option1">Option A:</label>
                    <input type="text" name="option1" id="option1" value="${question.option1}" required placeholder="Option A"/>
                </div>
                <div class="form-group">
                    <label for="option2">Option B:</label>
                    <input type="text" name="option2" id="option2" value="${question.option2}" required placeholder="Option B"/>
                </div>
                <div class="form-group">
                    <label for="option3">Option C:</label>
                    <input type="text" name="option3" id="option3" value="${question.option3}" required placeholder="Option C"/>
                </div>
                <div class="form-group">
                    <label for="option4">Option D:</label>
                    <input type="text" name="option4" id="option4" value="${question.option4}" required placeholder="Option D"/>
                </div>
            </div>
            
            <div class="form-group">
                <label for="correctAnswer">Correct Answer (exact text):</label>
                <input type="text" name="correctAnswer" id="correctAnswer" value="${question.correctAnswer}" required placeholder="Enter the exact correct answer text"/>
                <small style="color: #666; display: block; margin-top: 5px;">⚠️ Enter the exact text that matches one of your options above</small>
            </div>
            
            <div style="text-align: center; margin-top: 30px; padding: 20px; background: #f8f9fa; border-radius: 5px;">
                <button type="submit" class="btn btn-primary">💾 Update Question</button>
                <a href="/admin/questions" class="btn btn-secondary">❌ Cancel</a>
            </div>
        </form>

        <!-- Navigation -->
        <div style="text-align: center; margin-top: 30px; padding: 20px; background: #f0f0f0; border-radius: 5px;">
            <a href="/admin/questions" class="btn btn-secondary">📋 Back to Questions</a>
            <a href="/admin" class="btn btn-secondary">🏠 Admin Dashboard</a>
        </div>
    </div>
</body>
</html>