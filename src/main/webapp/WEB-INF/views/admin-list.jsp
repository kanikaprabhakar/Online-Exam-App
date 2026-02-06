<!-- filepath: src/main/webapp/WEB-INF/views/admin-list.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Admins - Evalora</title>
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

        .page-container {
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
            gap: 8px;
        }

        .btn:hover {
            background-color: #555;
            border-color: #888;
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
        }

        .btn-back {
            background-color: #555;
            border-color: #777;
        }

        .btn-back:hover {
            background-color: #666;
            border-color: #999;
        }

        .btn-logout {
            background-color: #5a3842;
            border-color: #8b5a63;
        }

        .btn-logout:hover {
            background-color: #6d4a54;
            border-color: #a87080;
        }

        .content-wrapper {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 30px;
            margin-bottom: 40px;
        }

        .form-section {
            background-color: #252525;
            padding: 30px;
            border-radius: 12px;
            border: 1px solid #333;
            animation: fadeIn 0.6s ease 0.1s backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }

        .form-section h2 {
            color: #fff;
            margin-bottom: 25px;
            font-weight: 700;
            font-size: 1.4rem;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #aaa;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 16px;
            background-color: #1a1a1a;
            color: #ddd;
            border: 1px solid #444;
            border-radius: 6px;
            font-family: 'Aileron', sans-serif;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: #666;
            background-color: #1f1f1f;
            box-shadow: 0 0 12px rgba(102, 102, 102, 0.2);
        }

        .form-section button {
            width: 100%;
            padding: 14px;
            background-color: #444;
            color: white;
            border: 1px solid #666;
            border-radius: 6px;
            cursor: pointer;
            font-family: 'Aileron', sans-serif;
            font-weight: 700;
            font-size: 14px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-section button:hover {
            background-color: #555;
            border-color: #888;
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
        }

        .admin-list-section {
            animation: fadeIn 0.6s ease 0.2s backwards;
        }

        .admin-list-header {
            background-color: #252525;
            padding: 30px;
            border-radius: 12px 12px 0 0;
            border: 1px solid #333;
            border-bottom: none;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }

        .admin-list-header h2 {
            color: #fff;
            font-weight: 700;
            font-size: 1.4rem;
            margin: 0;
        }

        .admin-list-table {
            background-color: #252525;
            border-radius: 0 0 12px 12px;
            border: 1px solid #333;
            border-top: none;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background-color: #2a2a2a;
            padding: 16px 20px;
            text-align: left;
            color: #fff;
            font-weight: 700;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #444;
        }

        td {
            padding: 16px 20px;
            color: #bbb;
            border-bottom: 1px solid #333;
            transition: all 0.3s ease;
        }

        tr:hover td {
            background-color: #1f1f1f;
            color: #ddd;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .admin-name {
            color: #fff;
            font-weight: 600;
        }

        .label-you {
            color: #88ff88;
            font-weight: 600;
            margin-left: 8px;
            font-size: 12px;
            background-color: rgba(136, 255, 136, 0.15);
            padding: 3px 8px;
            border-radius: 3px;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn-small {
            padding: 8px 16px;
            font-size: 12px;
            border-radius: 4px;
            border: 1px solid #666;
            background-color: #444;
            color: white;
            text-decoration: none;
            cursor: pointer;
            font-family: 'Aileron', sans-serif;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-small:hover {
            background-color: #555;
            border-color: #888;
            transform: translateY(-1px);
        }

        .btn-small-delete {
            background-color: #5a3842;
            border-color: #8b5a63;
        }

        .btn-small-delete:hover {
            background-color: #6d4a54;
            border-color: #a87080;
        }

        .error-msg {
            color: #ff8888;
            background-color: #3a2223;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #6b4444;
            animation: slideDown 0.4s ease;
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #888;
        }

        .empty-state p {
            margin: 0;
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

        @media (max-width: 1024px) {
            .content-wrapper {
                grid-template-columns: 1fr;
            }
        }

        .edit-admin-section {
            background-color: #252525;
            padding: 30px;
            border-radius: 12px;
            border: 1px solid #333;
            animation: fadeIn 0.6s ease 0.2s backwards;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            margin-bottom: 30px;
        }

        .edit-admin-section h2 {
            color: #fff;
            margin-bottom: 25px;
            font-weight: 700;
            font-size: 1.4rem;
        }

        .form-buttons {
            display: flex;
            gap: 12px;
        }

        .form-buttons button,
        .form-buttons .btn {
            flex: 1;
        }

        .form-buttons .btn-cancel {
            background-color: #555;
            border-color: #777;
        }

        .form-buttons .btn-cancel:hover {
            background-color: #666;
            border-color: #999;
        }
    </style>
</head>
<body>
    <div class="page-container">
        <div class="header">
            <h1>Manage Admins</h1>
            <div class="header-actions">
                <a href="/admin" class="btn btn-back">Back to Dashboard</a>
                <a href="/logout" class="btn btn-logout">Logout</a>
            </div>
        </div>

        <!-- Error Message -->
        <c:if test="${param.error == 'cannot-delete-self'}">
            <div class="error-msg">
                You cannot delete your own admin account
            </div>
        </c:if>

        <div class="content-wrapper">
            <!-- Register Admin Form -->
            <div class="form-section">
                <h2>Register New Admin</h2>
                <form action="/admin/register" method="post">
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" placeholder="John Doe" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" placeholder="admin@evalora.com" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" placeholder="••••••••" required>
                    </div>
                    <button type="submit">Register Admin</button>
                </form>
            </div>

            <!-- Edit Admin Form (shows only when editing) -->
            <c:if test="${user.id != null}">
                <div class="edit-admin-section">
                    <h2>Edit Admin Account</h2>
                    <form action="/admin/update-admin" method="post">
                        <div class="form-group">
                            <label for="edit-name">Full Name</label>
                            <input type="hidden" name="id" value="${user.id}">
                            <input type="text" id="edit-name" name="name" value="${user.name}" placeholder="John Doe" required>
                        </div>
                        <div class="form-group">
                            <label for="edit-email">Email Address</label>
                            <input type="email" id="edit-email" name="email" value="${user.email}" placeholder="admin@evalora.com" required>
                        </div>
                        <div class="form-group">
                            <label for="edit-password">New Password <span style="color: #888;">(leave blank to keep current)</span></label>
                            <input type="password" id="edit-password" name="password" placeholder="••••••••">
                        </div>
                        <div class="form-buttons">
                            <button type="submit">Update Admin</button>
                            <a href="/admin/admins" class="btn btn-cancel">Cancel</a>
                        </div>
                    </form>
                </div>
            </c:if>
        </div>

        <!-- Admins List -->
        <div class="admin-list-section">
            <div class="admin-list-header">
                <h2>All Admin Accounts (${admins.size()} total)</h2>
            </div>
            <div class="admin-list-table">
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="a" items="${admins}">
                            <tr>
                                <td>
                                    <span class="admin-name">${a.name}</span>
                                    <c:if test="${a.email == currentAdmin.email}">
                                        <span class="label-you">You</span>
                                    </c:if>
                                </td>
                                <td>${a.email}</td>
                                <td>${a.role}</td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="/admin/edit-admin/${a.id}" class="btn-small">Edit</a>
                                        <c:if test="${a.email != currentAdmin.email}">
                                            <a href="/admin/delete-admin/${a.id}" 
                                               onclick="return confirm('Delete this admin account? This action cannot be undone.');" 
                                               class="btn-small btn-small-delete">Delete</a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <c:if test="${empty admins}">
                    <div class="empty-state">
                        <p>No admin accounts found</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>
