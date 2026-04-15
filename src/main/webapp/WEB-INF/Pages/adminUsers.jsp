<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String adminEmail = (String) session.getAttribute("adminEmail");
    if (adminEmail == null) {
        response.sendRedirect(request.getContextPath() + "/admin");
        return;
    }

    ArrayList<HashMap<String, String>> users =
        (ArrayList<HashMap<String, String>>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Users | DriveKTM</title>

<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">

<style>
:root {
    --gold: #C9A96E;
    --dark: #0A0A0A;
    --dark2: #111111;
    --text: #F0EDE8;
    --muted: #999;
    --white: #fff;
    --red: #d9534f;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'DM Sans', sans-serif;
    background: var(--dark);
    color: var(--text);
}

.admin-layout {
    display: flex;
    min-height: 100vh;
}

.sidebar {
    width: 250px;
    background: rgba(17,17,17,0.96);
    border-right: 1px solid rgba(201,169,110,0.15);
    position: fixed;
    top: 0;
    bottom: 0;
    left: 0;
}

.logo {
    height: 80px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Cormorant Garamond', serif;
    font-size: 28px;
    font-weight: 600;
    letter-spacing: 0.08em;
    border-bottom: 1px solid rgba(201,169,110,0.15);
}

.logo span {
    color: var(--gold);
}

.menu {
    padding-top: 25px;
}

.menu a {
    display: block;
    padding: 17px 30px;
    color: var(--text);
    text-decoration: none;
    font-size: 15px;
    transition: 0.25s;
    border-left: 4px solid transparent;
}

.menu a:hover,
.menu a.active {
    background: rgba(201,169,110,0.12);
    color: var(--gold);
    border-left-color: var(--gold);
}

.logout {
    color: #ff8888 !important;
}

.main {
    margin-left: 250px;
    width: calc(100% - 250px);
}

.topbar {
    height: 80px;
    background: rgba(17,17,17,0.92);
    border-bottom: 1px solid rgba(201,169,110,0.12);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 38px;
}

.topbar h1 {
    font-size: 24px;
    font-weight: 500;
}

.admin-email {
    color: var(--gold);
    font-size: 14px;
}

.content {
    padding: 35px;
}

.page-header {
    margin-bottom: 25px;
}

.page-header h2 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 38px;
    font-weight: 400;
}

.page-header h2 span {
    color: var(--gold);
}

.page-header p {
    color: var(--muted);
    margin-top: 8px;
}

.message {
    padding: 13px 16px;
    margin-bottom: 20px;
    border: 1px solid rgba(201,169,110,0.25);
    background: rgba(201,169,110,0.08);
    color: var(--gold);
}

.error {
    border-color: rgba(217,83,79,0.35);
    background: rgba(217,83,79,0.10);
    color: #ff9b9b;
}

.table-box {
    background: var(--dark2);
    border: 1px solid rgba(201,169,110,0.18);
    padding: 25px;
    box-shadow: 0 15px 45px rgba(0,0,0,0.35);
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th {
    text-align: left;
    color: var(--gold);
    font-size: 13px;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    padding: 15px 12px;
    border-bottom: 1px solid rgba(201,169,110,0.35);
}

td {
    padding: 16px 12px;
    border-bottom: 1px solid rgba(255,255,255,0.08);
    color: var(--text);
    font-size: 14px;
}

tr:hover {
    background: rgba(255,255,255,0.03);
}

.delete-btn {
    padding: 8px 14px;
    border: none;
    background: rgba(217,83,79,0.90);
    color: white;
    cursor: pointer;
    font-family: 'DM Sans', sans-serif;
    font-size: 13px;
    transition: 0.25s;
}

.delete-btn:hover {
    background: #c9302c;
}

.empty {
    text-align: center;
    color: var(--muted);
    padding: 35px;
}
</style>
</head>

<body>

<div class="admin-layout">

    <aside class="sidebar">
        <div class="logo">Drive<span>KTM</span></div>

        <div class="menu">
            <a href="${pageContext.request.contextPath}/admin-dashboard">Dashboard</a>
            <a href="#">Manage Vehicles</a>
            <a href="#">Manage Bookings</a>
            <a href="${pageContext.request.contextPath}/admin-users" class="active">Manage Users</a>
            <a href="#">Reports</a>
            <a href="#" class="logout">Logout</a>
        </div>
    </aside>

    <main class="main">

        <div class="topbar">
            <h1>Manage Users</h1>
            <div class="admin-email">Admin: <%= adminEmail %></div>
        </div>

        <div class="content">

            <div class="page-header">
                <h2>User <span>Management</span></h2>
                <p>View registered users and delete user accounts from the system.</p>
            </div>

            <% if ("deleted".equals(request.getParameter("success"))) { %>
                <div class="message">User deleted successfully.</div>
            <% } %>

            <% if (request.getParameter("error") != null) { %>
                <div class="message error">Something went wrong. Please try again.</div>
            <% } %>

            <div class="table-box">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>License</th>
                            <th>Joined Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>
                    <% if (users != null && !users.isEmpty()) { %>

                        <% for (HashMap<String, String> user : users) { %>
                            <tr>
                                <td><%= user.get("id") %></td>
                                <td><%= user.get("firstName") %> <%= user.get("lastName") %></td>
                                <td><%= user.get("email") %></td>
                                <td><%= user.get("phone") %></td>
                                <td><%= user.get("licenseType") %></td>
                                <td><%= user.get("createdAt") %></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin-users" method="post"
                                          onsubmit="return confirm('Are you sure you want to delete this user?');">
                                        <input type="hidden" name="userId" value="<%= user.get("id") %>">
                                        <button type="submit" class="delete-btn">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>

                    <% } else { %>
                        <tr>
                            <td colspan="7" class="empty">No registered users found.</td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

        </div>

    </main>

</div>

</body>
</html>