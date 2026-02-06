<!-- filepath: src/main/webapp/WEB-INF/views/questions.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Questions Management - Admin - Evalora</title>
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
        .container { max-width: 1400px; margin: 0 auto; }
        .header {
            text-align: center;
            margin-bottom: 35px;
            animation: slideDown 0.5s ease;
        }
        .header h1 { color: #fff; font-weight: 700; font-size: 2rem; }
        .header p { color: #aaa; margin-top: 10px; font-size: 14px; }
        h2 {
            color: #fff;
            margin: 35px 0 20px 0;
            font-weight: 700;
            font-size: 1.3rem;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
            background-color: #252525;
            border-radius: 0 0 12px 12px;
            overflow: hidden;
            border: 1px solid #333;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.6s ease 0.35s backwards;
        }
        th {
            padding: 16px;
            text-align: left;
            background-color: #2a2a2a;
            color: #fff;
            font-weight: 700;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #444;
        }
        td { padding: 16px; color: #bbb; border-bottom: 1px solid #333; }
        tr:hover td { background-color: #1f1f1f; color: #ddd; }
        tr:last-child td { border-bottom: none; }
        form {
            margin: 20px 0;
            padding: 30px;
            border: 1px solid #333;
            border-radius: 12px;
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            animation: fadeIn 0.6s ease backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }
        form:nth-of-type(2) { animation-delay: 0.2s; }
        input, textarea, select {
            padding: 12px 16px;
            margin: 8px 8px 8px 0;
            border: 1px solid #444;
            border-radius: 6px;
            font-family: 'Aileron', sans-serif;
            background-color: #1a1a1a;
            color: #ddd;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: #666;
            background-color: #1f1f1f;
            box-shadow: 0 0 0 2px rgba(100, 100, 100, 0.2);
        }
        textarea { width: 100%; height: 80px; resize: vertical; }
        .btn {
            padding: 12px 28px;
            border: 1px solid #666;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            font-weight: 600;
            margin: 8px 8px 8px 0;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-family: 'Aileron', sans-serif;
        }
        .btn-primary { background-color: #444; color: white; }
        .btn-primary:hover { background-color: #555; border-color: #888; transform: translateY(-2px); box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4); }
        .btn-danger { background-color: #5a3842; color: white; border-color: #8b5a63; }
        .btn-danger:hover { background-color: #6d4a54; border-color: #a87080; transform: translateY(-2px); box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4); }
        .btn-edit { background-color: #444; color: white; }
        .btn-edit:hover { background-color: #555; border-color: #888; transform: translateY(-2px); box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4); }
        .question-text { max-width: 400px; word-wrap: break-word; }
        .options { font-size: 14px; line-height: 1.6; }
        .correct-answer { background: #223a22; padding: 8px 12px; border-radius: 6px; font-weight: 600; color: #88ff88; }
        .navigation {
            text-align: center;
            margin-top: 40px;
            padding: 30px;
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            border-radius: 12px;
            border: 1px solid #333;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.6s ease 0.4s backwards;
        }
        .navigation a { margin: 0 12px; }
        label { color: #aaa; font-weight: 600; text-transform: uppercase; font-size: 12px; letter-spacing: 0.5px; }
        small { color: #888; font-size: 12px; }
        .alert-success { background: rgba(34, 58, 34, 0.4); color: #88ff88; padding: 16px; border-radius: 8px; margin-bottom: 20px; border-left: 3px solid #88ff88; animation: fadeIn 0.5s ease; }
        .alert-error { background: rgba(90, 56, 66, 0.4); color: #ff8888; padding: 16px; border-radius: 8px; margin-bottom: 20px; border-left: 3px solid #ff8888; animation: fadeIn 0.5s ease; }
        @keyframes slideDown { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Questions Management</h1>
            <p>Manage exam questions for students</p>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty param.success}">
            <div class="alert-success">
                ${param.success}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert-error">
                ${error}
            </div>
        </c:if>

        <!-- Add Question Form -->
        <h2>Add New Question</h2>
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
            
            <button type="submit" class="btn btn-primary">Add Question</button>
        </form>

        <!-- Questions List -->
        <h2>All Questions (${questions.size()} total)</h2>
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
                            <!-- Use admin URLs -->
                            <a href="/admin/questions/edit/${q.id}" class="btn btn-edit">Edit</a>
                            <a href="/admin/questions/delete/${q.id}" 
                               onclick="return confirm('Are you sure you want to delete this question?\n\nQuestion: ${q.question}\n\nThis action cannot be undone!');"
                               class="btn btn-danger">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty questions}">
                    <tr>
                        <td colspan="5" style="text-align: center; color: #888; font-style: italic; padding: 30px;">
                            No questions found. Add your first question above
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <!-- Quick Stats -->
        <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px; margin: 30px 0;">
            <div style="background: #22333a; padding: 20px; border-radius: 8px; text-align: center; border: 1px solid #446677;">
                <h3 style="margin: 0; color: #88ccee;">Total Questions</h3>
                <p style="font-size: 24px; font-weight: bold; margin: 10px 0; color: #88ccee;">${questions.size()}</p>
            </div>
            <div style="background: #3a2a3a; padding: 20px; border-radius: 8px; text-align: center; border: 1px solid #664466;">
                <h3 style="margin: 0; color: #cc88cc;">Per Exam</h3>
                <p style="font-size: 24px; font-weight: bold; margin: 10px 0; color: #cc88cc;">${examConfig.questionCount != null ? examConfig.questionCount : '20'}</p>
            </div>
            <div style="background: #223a22; padding: 20px; border-radius: 8px; text-align: center; border: 1px solid #446644;">
                <h3 style="margin: 0; color: #88ee88;">Status</h3>
                <p style="font-size: 18px; font-weight: bold; margin: 10px 0; color: #88ee88;">
                    ${questions.size() >= 10 ? 'Ready' : 'Need More'}
                </p>
            </div>
        </div>

        <!-- Navigation -->
        <div class="navigation">
            <a href="/admin" class="btn btn-primary">Admin Dashboard</a>
            <a href="/admin/exam-config" class="btn btn-edit">Exam Config</a>
            <a href="/admin/students" class="btn btn-edit">Students</a>
            <a href="/admin/exam-attempts" class="btn btn-edit">Exam Results</a>
        </div>
    </div>
</body>
</html>