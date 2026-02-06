<!-- filepath: src/main/webapp/WEB-INF/views/student-dashboard.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student Dashboard - Evalora</title>
    <link rel="icon" type="image/png" href="/static/document-file.png">
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
            padding: 20px;
            line-height: 1.6;
            min-height: 100vh;
        }

        .dashboard-container {
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
            margin: 0;
        }

        .welcome {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .welcome span {
            color: #888;
            font-size: 14px;
        }

        .user-info {
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 40px;
            border: 1px solid #333;
            animation: slideDown 0.5s ease 0.1s backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }

        .user-info h3 {
            color: #fff;
            margin-bottom: 20px;
            font-weight: 700;
            font-size: 1.2rem;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            padding-bottom: 12px;
            border-bottom: 1px solid #333;
        }

        .info-row:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .label {
            font-weight: 600;
            color: #aaa;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .value {
            color: #ddd;
            font-weight: 600;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin: 40px 0;
        }

        .feature-card {
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            padding: 30px;
            border-radius: 12px;
            text-align: center;
            border: 1px solid #333;
            transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
            animation: fadeIn 0.6s ease backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            cursor: pointer;
        }

        .feature-card:nth-child(1) { animation-delay: 0.1s; }
        .feature-card:nth-child(2) { animation-delay: 0.15s; }
        .feature-card:nth-child(3) { animation-delay: 0.2s; }
        .feature-card:nth-child(4) { animation-delay: 0.25s; }

        .feature-card:hover {
            border-color: #555;
            transform: translateY(-8px);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
        }

        .feature-card h3 {
            color: #fff;
            margin-bottom: 12px;
            font-size: 1.1rem;
            font-weight: 700;
        }

        .feature-card p {
            color: #999;
            font-size: 0.9rem;
            margin-bottom: 20px;
            line-height: 1.5;
        }

        .btn {
            padding: 12px 28px;
            background-color: #444;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            border: 1px solid #666;
            cursor: pointer;
            font-family: 'Aileron', sans-serif;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: inline-block;
        }

        .btn:hover {
            background-color: #555;
            border-color: #888;
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
        }

        .btn-logout {
            background-color: #5a3842;
            border-color: #8b5a63;
        }

        .btn-logout:hover {
            background-color: #6d4a54;
            border-color: #a87080;
        }

        .btn-profile {
            background-color: #444;
            border-color: #666;
        }

        .btn:disabled {
            background-color: #2a2a2a !important;
            border-color: #444 !important;
            cursor: not-allowed !important;
            opacity: 0.5;
            transform: none !important;
        }

        .exam-status {
            margin-top: 40px;
            padding: 30px;
            border-radius: 12px;
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            border: 1px solid #333;
            animation: fadeIn 0.6s ease 0.3s backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }

        .exam-status h3 {
            color: #fff;
            margin-bottom: 20px;
            font-weight: 700;
            font-size: 1.2rem;
        }

        .status-enabled {
            color: #aaa;
        }

        .status-enabled p {
            margin: 10px 0;
            color: #bbb;
        }

        .status-disabled {
            color: #ff8888;
        }

        .alert-success {
            background-color: #223a22;
            color: #88ff88;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 3px solid #446b44;
            animation: slideDown 0.4s ease;
        }

        .alert-error {
            background-color: #3a2223;
            color: #ff8888;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 3px solid #6b4444;
            animation: slideDown 0.4s ease;
        }

        .alert-warning {
            background-color: #3a3a23;
            color: #ccc880;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #666644;
            text-align: center;
            animation: slideDown 0.4s ease;
        }

        .alert-warning h3 {
            margin-top: 0;
            color: #e6e088;
            font-size: 1.1rem;
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
    <div class="dashboard-container">
        <div class="header">
            <div class="welcome">
                <h1>Welcome, ${student.name}</h1>
                <span>Let's get you exam-ready!</span>
            </div>
            <a href="/logout" class="btn btn-logout">Logout</a>
        </div>
        
        <c:if test="${success != null}">
            <div class="alert-success">
                ${success}
            </div>
        </c:if>
        
        <c:if test="${error != null}">
            <div class="alert-error">
                ${error}
            </div>
        </c:if>

        <div class="user-info">
            <h3>Your Information</h3>
            <div class="info-row">
                <span class="label">Name:</span>
                <span>${student.name}</span>
            </div>
            <div class="info-row">
                <span class="label">Email:</span>
                <span>${student.email}</span>
            </div>
            <div class="info-row">
                <span class="label">Roll Number:</span>
                <span>${student.rollNumber}</span>
            </div>
            <div class="info-row">
                <span class="label">Phone:</span>
                <span>${student.phone}</span>
            </div>
            <div class="info-row">
                <span class="label">Address:</span>
                <span>${student.address}</span>
            </div>
        </div>

        <div class="features">
            <div class="feature-card">
                <h3>View Results</h3>
                <p>Check your exam results</p>
                <a href="/exam/results" class="btn">View Results</a>
            </div>
            
            <div class="feature-card">
                <h3>Practice Mode</h3>
                <p>Unlimited attempts</p>
                <a href="/exam/practice" class="btn">Practice</a>
            </div>
            
            <div class="feature-card">
                <h3>My Profile</h3>
                <p>Update personal information</p>
                <a href="/student-dashboard/profile" class="btn btn-profile">Update Profile</a>
            </div>
        </div>

        <!-- Multi-Exam List -->
        <div class="exams-section" style="animation: fadeIn 0.6s ease 0.3s backwards;">
            <h2 style="color: #fff; margin-bottom: 25px; font-weight: 700; font-size: 1.8rem;">Available Exams</h2>
            
            <c:choose>
                <c:when test="${empty examStatusList}">
                    <div class="no-exams" style="background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%); padding: 40px; border-radius: 12px; text-align: center; border: 1px solid #333;">
                        <p style="color: #888; font-size: 1.1rem;">No exams available at the moment.</p>
                        <p style="color: #666; font-size: 0.9rem; margin-top: 10px;">Please check back later or contact your administrator.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="exams-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 20px;">
                        <c:forEach var="examStatus" items="${examStatusList}" varStatus="status">
                            <div class="exam-card" style="background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%); padding: 25px; border-radius: 12px; border: 1px solid #333; box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3); transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1); animation: fadeIn 0.6s ease ${0.1 * status.index}s backwards;">
                                <div class="exam-header" style="border-bottom: 1px solid #333; padding-bottom: 15px; margin-bottom: 15px;">
                                    <h3 style="color: #fff; font-weight: 700; font-size: 1.2rem; margin-bottom: 8px;">${examStatus.exam.examTitle}</h3>
                                    <c:choose>
                                        <c:when test="${examStatus.hasTaken}">
                                            <span class="status-badge" style="display: inline-block; padding: 4px 12px; background-color: #444; color: #888; border-radius: 12px; font-size: 0.75rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Completed</span>
                                        </c:when>
                                        <c:when test="${!examStatus.exam.examEnabled}">
                                            <span class="status-badge" style="display: inline-block; padding: 4px 12px; background-color: #3a2222; color: #dd8888; border-radius: 12px; font-size: 0.75rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Disabled</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge" style="display: inline-block; padding: 4px 12px; background-color: #223a22; color: #88dd88; border-radius: 12px; font-size: 0.75rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Available</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="exam-details" style="margin-bottom: 20px;">
                                    <div class="detail-row" style="display: flex; justify-content: space-between; margin-bottom: 8px;">
                                        <span style="color: #888; font-size: 0.9rem;">Duration:</span>
                                        <span style="color: #ddd; font-weight: 600;">${examStatus.exam.examDuration} mins</span>
                                    </div>
                                    <div class="detail-row" style="display: flex; justify-content: space-between; margin-bottom: 8px;">
                                        <span style="color: #888; font-size: 0.9rem;">Questions:</span>
                                        <span style="color: #ddd; font-weight: 600;">${examStatus.exam.questionCount}</span>
                                    </div>
                                    <div class="detail-row" style="display: flex; justify-content: space-between; margin-bottom: 8px;">
                                        <span style="color: #888; font-size: 0.9rem;">Total Marks:</span>
                                        <span style="color: #ddd; font-weight: 600;">${examStatus.exam.totalMarks}</span>
                                    </div>
                                    <div class="detail-row" style="display: flex; justify-content: space-between;">
                                        <span style="color: #888; font-size: 0.9rem;">Passing Marks:</span>
                                        <span style="color: #ddd; font-weight: 600;">${examStatus.exam.passingMarks}</span>
                                    </div>
                                </div>
                                
                                <div class="exam-actions">
                                    <c:choose>
                                        <c:when test="${examStatus.hasTaken}">
                                            <button class="btn" disabled style="width: 100%; opacity: 0.5; cursor: not-allowed; background-color: #333; border-color: #444;">Already Taken</button>
                                            <p style="color: #888; font-size: 0.8rem; margin-top: 8px; text-align: center;">You can only take each exam once</p>
                                        </c:when>
                                        <c:when test="${!examStatus.exam.examEnabled}">
                                            <button class="btn" disabled style="width: 100%; opacity: 0.5; cursor: not-allowed; background-color: #333; border-color: #444;">Exam Disabled</button>
                                            <p style="color: #888; font-size: 0.8rem; margin-top: 8px; text-align: center;">Contact administrator for details</p>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/exam/start?examId=${examStatus.exam.id}" class="btn" style="width: 100%; display: block; text-align: center; text-decoration: none;">Start Exam</a>
                                            <p style="color: #ff8888; font-size: 0.8rem; margin-top: 8px; text-align: center; font-weight: 600;">One attempt only</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>