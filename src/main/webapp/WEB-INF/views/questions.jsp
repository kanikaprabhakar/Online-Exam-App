<!-- filepath: src/main/webapp/WEB-INF/views/questions.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Questions Management - Admin</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .header { text-align: center; margin-bottom: 30px; color: #333; }
        table { border-collapse: collapse; width: 100%; margin: 20px 0; }
        table, th, td { border: 1px solid #ddd; }
        th, td { padding: 12px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        form { margin: 20px 0; padding: 20px; border: 1px solid #ddd; border-radius: 5px; background: #f9f9f9; }
        input, textarea, button, select { padding: 10px; margin: 5px; border: 1px solid #ddd; border-radius: 5px; }
        textarea { width: 300px; height: 60px; resize: vertical; }
        .btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; font-size: 14px; margin: 2px; }
        .btn-primary { background-color: #4CAF50; color: white; }
        .btn-danger { background-color: #f44336; color: white; }
        .btn-edit { background-color: #2196F3; color: white; }
        .btn:hover { opacity: 0.8; }
        .question-text { max-width: 400px; word-wrap: break-word; }
        .options { font-size: 14px; line-height: 1.6; }
        .correct-answer { background: #e8f5e9; padding: 5px; border-radius: 3px; font-weight: bold; }
        .navigation { text-align: center; margin-top: 30px; padding: 20px; background: #f0f0f0; border-radius: 5px; }
        .navigation a { margin: 0 10px; text-decoration: none; color: #007bff; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 Questions Management</h1>
            <p>Manage exam questions for students</p>
        </div>

        <!-- ✅ ADD: Success/Error Messages -->
        <c:if test="${not empty param.success}">
            <div style="background: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin-bottom: 20px; border: 1px solid #c3e6cb;">
                ✅ ${param.success}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div style="background: #f8d7da; color: #721c24; padding: 15px; border-radius: 5px; margin-bottom: 20px; border: 1px solid #f5c6cb;">
                ❌ ${error}
            </div>
        </c:if>

        <!-- Add Question Form -->
        <h2>➕ Add New Question</h2>
        <form action="/admin/questions/add" method="POST">
            <div style="margin-bottom: 15px;">
                <label><strong>Question:</strong></label><br>
                <textarea name="question" placeholder="Enter your question here..." required style="width: 100%; height: 80px;"></textarea>
            </div>
            
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 15px;">
                <div>
                    <label><strong>Option 1:</strong></label>
                    <input type="text" name="option1" placeholder="Option A" required style="width: 90%;">
                </div>
                <div>
                    <label><strong>Option 2:</strong></label>
                    <input type="text" name="option2" placeholder="Option B" required style="width: 90%;">
                </div>
                <div>
                    <label><strong>Option 3:</strong></label>
                    <input type="text" name="option3" placeholder="Option C" required style="width: 90%;">
                </div>
                <div>
                    <label><strong>Option 4:</strong></label>
                    <input type="text" name="option4" placeholder="Option D" required style="width: 90%;">
                </div>
            </div>
            
            <div style="margin-bottom: 15px;">
                <label><strong>Correct Answer (exact text):</strong></label>
                <input type="text" name="correctAnswer" placeholder="Enter the correct answer text" required style="width: 100%;">
                <small style="color: #666;">Enter the exact text of the correct answer</small>
            </div>
            
            <button type="submit" class="btn btn-primary">✅ Add Question</button>
        </form>

        <!-- Questions List -->
        <h2>📋 All Questions (${questions.size()} total)</h2>
        <table>
            <thead>
                <tr>
                    <th style="width: 5%;">ID</th>
                    <th style="width: 40%;">Question</th>
                    <th style="width: 30%;">Options</th>
                    <th style="width: 15%;">Correct Answer</th>
                    <th style="width: 10%;">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="q" items="${questions}">
                    <tr>
                        <td>${q.id}</td>
                        <td class="question-text">${q.question}</td>
                        <td class="options">
                            <strong>A.</strong> ${q.option1}<br>
                            <strong>B.</strong> ${q.option2}<br>
                            <strong>C.</strong> ${q.option3}<br>
                            <strong>D.</strong> ${q.option4}
                        </td>
                        <td>
                            <span class="correct-answer">${q.correctAnswer}</span>
                        </td>
                        <td>
                            <!-- ✅ FIX: Use admin URLs -->
                            <a href="/admin/questions/edit/${q.id}" class="btn btn-edit">✏️ Edit</a>
                            <a href="/admin/questions/delete/${q.id}" 
                               onclick="return confirm('⚠️ Are you sure you want to delete this question?\\n\\nQuestion: ${q.question}\\n\\nThis action cannot be undone!');"
                               class="btn btn-danger">🗑️ Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty questions}">
                    <tr>
                        <td colspan="5" style="text-align: center; color: #666; font-style: italic; padding: 30px;">
                            📭 No questions found. Add your first question above!
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <!-- Quick Stats -->
        <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px; margin: 30px 0;">
            <div style="background: #e3f2fd; padding: 20px; border-radius: 5px; text-align: center;">
                <h3 style="margin: 0; color: #1976d2;">📊 Total Questions</h3>
                <p style="font-size: 24px; font-weight: bold; margin: 10px 0; color: #1976d2;">${questions.size()}</p>
            </div>
            <div style="background: #f3e5f5; padding: 20px; border-radius: 5px; text-align: center;">
                <h3 style="margin: 0; color: #7b1fa2;">🎯 Per Exam</h3>
                <p style="font-size: 24px; font-weight: bold; margin: 10px 0; color: #7b1fa2;">${examConfig.questionCount != null ? examConfig.questionCount : '20'}</p>
            </div>
            <div style="background: #e8f5e9; padding: 20px; border-radius: 5px; text-align: center;">
                <h3 style="margin: 0; color: #388e3c;">✅ Status</h3>
                <p style="font-size: 18px; font-weight: bold; margin: 10px 0; color: #388e3c;">
                    ${questions.size() >= 10 ? 'Ready!' : 'Need More'}
                </p>
            </div>
        </div>

        <!-- Navigation -->
        <div class="navigation">
            <a href="/admin" class="btn btn-primary">🏠 Admin Dashboard</a>
            <a href="/admin/exam-config" class="btn btn-edit">⚙️ Exam Config</a>
            <a href="/admin/students" class="btn btn-edit">👥 Students</a>
            <a href="/admin/exam-attempts" class="btn btn-edit">📊 Exam Results</a>
        </div>
    </div>
</body>
</html>