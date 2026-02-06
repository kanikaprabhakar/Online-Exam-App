<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Exams - Evalora Admin</title>
    <link rel="icon" type="image/png" href="/document-file.png">
    <link href="https://fonts.googleapis.com/css2?family=Aileron:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Aileron', sans-serif;
            background: linear-gradient(135deg, #1a1a1a 0%, #0f0f0f 100%);
            color: #ddd;
            min-height: 100vh;
            padding: 40px 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            animation: slideDown 0.5s ease;
        }

        .header h1 {
            color: #fff;
            font-weight: 700;
            font-size: 2.2rem;
        }

        .header-actions {
            display: flex;
            gap: 15px;
        }

        .btn {
            padding: 12px 28px;
            background: linear-gradient(135deg, #444 0%, #333 100%);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            border: 1px solid #666;
            font-weight: 600;
            transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            display: inline-block;
            font-size: 0.95rem;
        }

        .btn:hover {
            background: linear-gradient(135deg, #555 0%, #444 100%);
            border-color: #888;
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
        }

        .btn-primary {
            background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%);
            border-color: #5a9fe9;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #5a9fe9 0%, #4682d4 100%);
            border-color: #6aaff0;
        }

        .btn-danger {
            background: linear-gradient(135deg, #e24a4a 0%, #bd3535 100%);
            border-color: #e95a5a;
            padding: 8px 20px;
            font-size: 0.85rem;
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #e95a5a 0%, #d44646 100%);
            border-color: #f06a6a;
        }

        .alert {
            padding: 16px 24px;
            border-radius: 8px;
            margin-bottom: 30px;
            animation: slideDown 0.4s ease;
            font-weight: 600;
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

        .exams-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 25px;
        }

        .exam-card {
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            padding: 30px;
            border-radius: 12px;
            border: 1px solid #333;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
            animation: fadeIn 0.6s ease backwards;
        }

        .exam-card:nth-child(1) { animation-delay: 0.1s; }
        .exam-card:nth-child(2) { animation-delay: 0.15s; }
        .exam-card:nth-child(3) { animation-delay: 0.2s; }
        .exam-card:nth-child(4) { animation-delay: 0.25s; }
        .exam-card:nth-child(5) { animation-delay: 0.3s; }
        .exam-card:nth-child(6) { animation-delay: 0.35s; }

        .exam-card:hover {
            border-color: #444;
            transform: translateY(-5px);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
        }

        .exam-header {
            border-bottom: 1px solid #333;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }

        .exam-title {
            color: #fff;
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-enabled {
            background-color: #223a22;
            color: #88dd88;
        }

        .status-disabled {
            background-color: #3a2222;
            color: #dd8888;
        }

        .exam-details {
            margin-bottom: 20px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #2a2a2a;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            color: #888;
            font-size: 0.9rem;
        }

        .detail-value {
            color: #ddd;
            font-weight: 600;
        }

        .exam-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .exam-actions .btn {
            flex: 1;
            text-align: center;
            padding: 10px;
            font-size: 0.9rem;
        }

        .btn-edit {
            background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%);
            border-color: #5a9fe9;
        }

        .btn-edit:hover {
            background: linear-gradient(135deg, #5a9fe9 0%, #4682d4 100%);
            border-color: #6aaff0;
        }

        .no-exams {
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            padding: 60px 40px;
            border-radius: 12px;
            text-align: center;
            border: 1px solid #333;
            animation: fadeIn 0.6s ease;
        }

        .no-exams p {
            color: #888;
            font-size: 1.2rem;
            margin-bottom: 15px;
        }

        .no-exams .btn {
            margin-top: 20px;
        }

        .back-link {
            display: inline-block;
            color: #888;
            text-decoration: none;
            margin-bottom: 20px;
            transition: color 0.3s;
        }

        .back-link:hover {
            color: #ddd;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="/admin" class="back-link">← Back to Dashboard</a>

        <div class="header">
            <h1>Manage Exams</h1>
            <div class="header-actions">
                <a href="/admin/exams/create" class="btn btn-primary">+ Create New Exam</a>
            </div>
        </div>

        <c:if test="${param.success != null}">
            <div class="alert alert-success">
                ${param.success}
            </div>
        </c:if>

        <c:if test="${param.error != null}">
            <div class="alert alert-error">
                ${param.error}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty exams}">
                <div class="no-exams">
                    <p>No exams created yet</p>
                    <p style="color: #666; font-size: 0.95rem;">Create your first exam to get started</p>
                    <a href="/admin/exams/create" class="btn btn-primary">Create Your First Exam</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="exams-grid">
                    <c:forEach var="exam" items="${exams}">
                        <div class="exam-card">
                            <div class="exam-header">
                                <h2 class="exam-title">${exam.examTitle}</h2>
                                <span class="status-badge ${exam.examEnabled ? 'status-enabled' : 'status-disabled'}">
                                    ${exam.examEnabled ? 'Enabled' : 'Disabled'}
                                </span>
                            </div>

                            <div class="exam-details">
                                <div class="detail-row">
                                    <span class="detail-label">Duration:</span>
                                    <span class="detail-value">${exam.examDuration} minutes</span>
                                </div>
                                <div class="detail-row">
                                    <span class="detail-label">Questions:</span>
                                    <span class="detail-value">${exam.questionCount}</span>
                                </div>
                                <div class="detail-row">
                                    <span class="detail-label">Total Marks:</span>
                                    <span class="detail-value">${exam.totalMarks}</span>
                                </div>
                                <div class="detail-row">
                                    <span class="detail-label">Passing Marks:</span>
                                    <span class="detail-value">${exam.passingMarks}</span>
                                </div>
                                <div class="detail-row">
                                    <span class="detail-label">Negative Marking:</span>
                                    <span class="detail-value">${exam.negativeMarking ? 'Yes' : 'No'}</span>
                                </div>
                            </div>

                            <div class="exam-actions">
                                <a href="/admin/exams/edit/${exam.id}" class="btn btn-edit">Edit</a>
                                <a href="/admin/exams/delete/${exam.id}" 
                                   class="btn btn-danger" 
                                   onclick="return confirm('Are you sure you want to delete this exam? All associated attempts will also be deleted.');">
                                   Delete
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
