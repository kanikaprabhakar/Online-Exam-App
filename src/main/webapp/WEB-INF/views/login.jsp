<!-- filepath: src/main/webapp/WEB-INF/views/login.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Evalora</title>
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

        .login-container {
            background-color: #252525;
            padding: 40px;
            border-radius: 4px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
            width: 100%;
            max-width: 450px;
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

        .success {
            background-color: #223a22;
            color: #88ff88;
            padding: 12px 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            border-left: 3px solid #446b44;
            font-size: 0.95rem;
        }

        h2 {
            text-align: center;
            margin-bottom: 10px;
            color: #fff;
            font-size: 2rem;
            font-weight: 700;
        }

        .subtitle {
            text-align: center;
            color: #999;
            margin-bottom: 30px;
            font-size: 0.95rem;
        }

        .signup-links {
            text-align: center;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid #333;
        }

        .signup-links p {
            color: #aaa;
            margin-bottom: 15px;
            font-size: 0.95rem;
        }

        .signup-links-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .signup-links a {
            flex: 1;
            min-width: 140px;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            border: 1px solid #555;
        }

        .student-link {
            background-color: #5a3d2a;
            color: white;
            border-color: #8b5a3c;
        }

        .student-link:hover {
            background-color: #6d4a35;
            border-color: #a86d49;
        }

        .admin-link {
            background-color: #5a3842;
            color: white;
            border-color: #8b5a63;
        }

        .admin-link:hover {
            background-color: #6d4a54;
            border-color: #a87080;
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
    <div class="login-container">
        <h2>Evalora</h2>
        <p class="subtitle">Sign in to your account</p>
        
        <c:if test="${error != null}">
            <div class="error">${error}</div>
        </c:if>
        
        <c:if test="${success != null}">
            <div class="success">${success}</div>
        </c:if>

        <form action="/login" method="POST">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="your@email.com" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn">Sign In</button>
        </form>
        
        <div class="signup-links">
            <p>Don't have an account?</p>
            <div class="signup-links-buttons">
                <a href="/signup" class="student-link">Student Sign Up</a>
                <a href="/admin-signup" class="admin-link">Admin Sign Up</a>
            </div>
        </div>
        
        <div class="back-link">
            <a href="/">Back to Home</a>
        </div>
    </div>
</body>
</html>