<!-- filepath: src/main/webapp/WEB-INF/views/admin.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard - Evalora</title>
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
            background: #1a1a1a;
            color: #ddd;
            padding: 20px;
            line-height: 1.6;
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

        .header-actions {
            display: flex;
            gap: 12px;
        }

        .current-admin {
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 40px;
            border: 1px solid #333;
            animation: slideDown 0.5s ease 0.1s backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }

        .admin-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .admin-details h3 {
            color: #fff;
            margin-bottom: 8px;
            font-size: 1.2rem;
        }

        .admin-details p {
            color: #aaa;
            margin-bottom: 4px;
            font-size: 14px;
        }

        .admin-details p strong {
            color: #ddd;
        }

        .nav-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .nav-btn {
            display: block;
            padding: 25px;
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            border: 1px solid #333;
            font-size: 14px;
            font-weight: 700;
            text-align: center;
            transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
            animation: fadeIn 0.6s ease backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            cursor: pointer;
        }

        .nav-btn:nth-child(1) { animation-delay: 0.1s; }
        .nav-btn:nth-child(2) { animation-delay: 0.15s; }
        .nav-btn:nth-child(3) { animation-delay: 0.2s; }
        .nav-btn:nth-child(4) { animation-delay: 0.25s; }
        .nav-btn:nth-child(5) { animation-delay: 0.3s; }

        .nav-btn:hover {
            background: linear-gradient(135deg, #2a2a2a 0%, #252525 100%);
            border-color: #555;
            transform: translateY(-8px);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
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
            display: inline-flex;
            align-items: center;
            gap: 6px;
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

        .profile-btn {
            background-color: #444;
            border-color: #666;
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
            <h1>Admin Dashboard</h1>
            <div class="header-actions">
                <a href="/logout" class="btn btn-logout">Logout</a>
            </div>
        </div>

        <!-- Current Admin Info -->
        <div class="current-admin">
            <div class="admin-info">
                <div class="admin-details">
                    <h3>Logged in as ${currentAdmin.name}</h3>
                    <p><strong>Email:</strong> ${currentAdmin.email}</p>
                    <p><strong>Role:</strong> ${currentAdmin.role}</p>
                </div>
                <a href="/admin/profile" class="btn profile-btn">Update My Profile</a>
            </div>
        </div>

        <!-- Main Navigation -->
        <div class="nav-buttons">
            <a href="/admin/students" class="nav-btn">Manage Students</a>
            <a href="/admin/questions" class="nav-btn">Manage Questions</a>
            <a href="/admin/exam-attempts" class="nav-btn">View Exam Attempts</a>
            <a href="/admin/exam-config" class="nav-btn">Configure Exam</a>
            <a href="/admin/exams" class="nav-btn">Manage Exams</a>
            <a href="/admin/admins" class="nav-btn">Manage Admins</a>
        </div>
    </div>
</body>
</html>