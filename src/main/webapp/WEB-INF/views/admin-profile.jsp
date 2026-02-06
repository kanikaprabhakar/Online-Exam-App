<!-- filepath: src/main/webapp/WEB-INF/views/admin-profile.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Profile - Evalora</title>
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

        .profile-container {
            max-width: 700px;
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

        .header h1 {
            color: #fff;
            font-weight: 700;
            font-size: 1.8rem;
        }

        .header p {
            color: #aaa;
            margin-top: 10px;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 22px;
            animation: fadeIn 0.6s ease backwards;
        }

        .form-group:nth-of-type(1) { animation-delay: 0.1s; }
        .form-group:nth-of-type(2) { animation-delay: 0.12s; }
        .form-group:nth-of-type(3) { animation-delay: 0.14s; }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #aaa;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.5px;
        }

        input[type="text"], input[type="email"], input[type="password"] {
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

        input:focus {
            outline: none;
            border-color: #666;
            background-color: #1f1f1f;
            box-shadow: 0 0 0 2px rgba(100, 100, 100, 0.2);
        }

        input::placeholder {
            color: #888;
        }

        .btn {
            padding: 12px 28px;
            background-color: #444;
            color: white;
            border: 1px solid #666;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            margin-right: 12px;
            margin-top: 20px;
            font-family: 'Aileron', sans-serif;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            display: inline-block;
        }

        .btn:hover {
            background-color: #555;
            border-color: #888;
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
        }

        .btn-secondary {
            background-color: #555;
            border-color: #777;
        }

        .btn-secondary:hover {
            background-color: #666;
            border-color: #999;
        }

        .error {
            color: #ff8888;
            background-color: rgba(90, 56, 66, 0.4);
            padding: 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 3px solid #ff8888;
            animation: fadeIn 0.5s ease;
        }

        .success {
            color: #88ff88;
            background-color: rgba(34, 58, 34, 0.4);
            padding: 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 3px solid #88ff88;
            animation: fadeIn 0.5s ease;
        }

        .info-box {
            background: linear-gradient(135deg, #1f1f1f 0%, #1a1a1a 100%);
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            border: 1px solid #444;
            color: #bbb;
            animation: slideDown 0.5s ease 0.05s backwards;
        }

        .info-box strong {
            color: #fff;
        }

        .password-note {
            font-size: 12px;
            color: #888;
            margin-top: 8px;
            font-style: italic;
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
    <div class="profile-container">
        <div class="header">
            <h1>My Profile</h1>
            <p>Update your admin account information</p>
        </div>

        <div class="info-box">
            <strong>Current Account:</strong> ${currentAdmin.name} (${currentAdmin.email})
        </div>

        <c:if test="${error != null}">
            <div class="error">${error}</div>
        </c:if>
        
        <c:if test="${success != null}">
            <div class="success">${success}</div>
        </c:if>

        <form action="/admin/update-profile" method="post">
            <div class="form-group">
                <label for="name">Full Name:</label>
                <input type="text" id="name" name="name" value="${currentAdmin.name}" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${currentAdmin.email}" required>
            </div>
            
            <div class="form-group">
                <label for="password">New Password:</label>
                <input type="password" id="password" name="password" placeholder="Leave blank to keep current password">
                <div class="password-note">Only enter a new password if you want to change it</div>
            </div>
            
            <div style="text-align: center; margin-top: 30px;">
                <button type="submit" class="btn">Update Profile</button>
                <a href="/admin" class="btn btn-secondary">Back to Dashboard</a>
            </div>
        </form>
    </div>
</body>
</html>