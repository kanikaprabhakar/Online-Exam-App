<!-- filepath: src/main/webapp/WEB-INF/views/admin-signup.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Sign Up - Evalora</title>
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
            background: #1a1a1a;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .signup-container {
            background-color: #252525;
            padding: 40px;
            border-radius: 4px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
            width: 100%;
            max-width: 500px;
            border: 1px solid #333;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #ddd;
            font-size: 0.95rem;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #444;
            border-radius: 4px;
            box-sizing: border-box;
            font-family: 'Aileron', sans-serif;
            font-size: 1rem;
            background: #1a1a1a;
            color: #ddd;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #777;
            background: #202020;
        }

        .btn {
            width: 100%;
            padding: 13px 20px;
            background: #444;
            color: white;
            border: 1px solid #666;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            font-family: 'Aileron', sans-serif;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .btn:hover {
            background: #555;
            border-color: #888;
        }

        .error {
            background-color: #3a2223;
            color: #ff8888;
            padding: 12px 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            border-left: 3px solid #6b4444;
            font-size: 0.95rem;
        }

        h2 {
            text-align: center;
            margin-bottom: 10px;
            color: #fff;
            font-size: 1.8rem;
            font-weight: 700;
        }

        .subtitle {
            text-align: center;
            color: #999;
            margin-bottom: 30px;
            font-size: 0.95rem;
        }

        .warning {
            background-color: #3a3a23;
            border: 1px solid #666644;
            color: #ccc880;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 25px;
            text-align: center;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .admin-code-note {
            background-color: #223a3a;
            border: 1px solid #446666;
            color: #88cccc;
            padding: 12px;
            border-radius: 4px;
            font-size: 0.85rem;
            margin-bottom: 15px;
            font-weight: 500;
        }

        .login-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid #333;
            color: #aaa;
            font-size: 0.95rem;
        }

        .login-link a {
            color: #999;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .login-link a:hover {
            color: #ddd;
        }

        .back-link {
            text-align: center;
            margin-top: 15px;
        }

        .back-link a {
            color: #999;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .back-link a:hover {
            color: #ddd;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <h2>Admin Registration</h2>
        <p class="subtitle">Authorized personnel only</p>
        
        <div class="warning">
            This page is restricted to authorized administrators only. You will need a valid admin registration code to proceed.
        </div>
        
        <c:if test="${error != null}">
            <div class="error">${error}</div>
        </c:if>

        <form action="/admin-signup" method="post">
            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <label for="adminCode">Admin Registration Code</label>
                <div class="admin-code-note">
                    Enter the secret admin registration code provided by your organization administrator.
                </div>
                <input type="password" id="adminCode" name="adminCode" required>
            </div>
            
            <button type="submit" class="btn">Register as Admin</button>
        </form>
        
        <div class="login-link">
            Already registered? <a href="/login">Sign in</a>
        </div>
        
        <div class="back-link">
            <a href="/">Back to Home</a>
        </div>
    </div>
</body>
</html>