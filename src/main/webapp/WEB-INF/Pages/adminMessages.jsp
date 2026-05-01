<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Messages | DriveKTM</title>

<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">

<style>
:root {
    --gold: #C9A96E;
    --dark: #0A0A0A;
    --dark2: #111111;
    --dark3: #1A1A1A;
    --text: #F0EDE8;
    --muted: #999;
    --white: #fff;
    --border: rgba(201,169,110,0.18);
    --danger: #D94F4F;
    --success: #4CAF70;
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

/* SIDEBAR - SAME AS ADMIN DASHBOARD */
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

/* MAIN - SAME SIZE AS ADMIN DASHBOARD */
.main {
    margin-left: 250px;
    width: calc(100% - 250px);
    min-height: 100vh;
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

/* PAGE TITLE */
.page-title {
    margin-bottom: 28px;
}

.page-title h2 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 42px;
    font-weight: 400;
    color: var(--text);
}

.page-title h2 span {
    color: var(--gold);
}

.page-title p {
    color: var(--muted);
    margin-top: 8px;
    font-size: 16px;
}

/* ALERTS */
.alert {
    padding: 14px 18px;
    margin-bottom: 24px;
    font-size: 14px;
    border: 1px solid;
}

.alert.success {
    background: rgba(76,175,112,0.08);
    border-color: rgba(76,175,112,0.4);
    color: #8ee0aa;
}

.alert.error {
    background: rgba(217,79,79,0.08);
    border-color: rgba(217,79,79,0.4);
    color: #ff9b9b;
}

/* TABLE */
.table-box {
    background: var(--dark2);
    border: 1px solid rgba(201,169,110,0.18);
    padding: 28px 30px;
    box-shadow: 0 15px 45px rgba(0,0,0,0.35);
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
}

thead th {
    color: var(--gold);
    text-align: left;
    font-size: 13px;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    padding: 16px 14px;
    border-bottom: 1px solid rgba(201,169,110,0.35);
    white-space: nowrap;
}

tbody td {
    padding: 18px 14px;
    border-bottom: 1px solid rgba(255,255,255,0.06);
    font-size: 14px;
    vertical-align: top;
}

tbody tr:nth-child(even) {
    background: rgba(255,255,255,0.025);
}

.message-text {
    max-width: 340px;
    line-height: 1.6;
    color: var(--muted);
}

.status {
    display: inline-block;
    padding: 6px 12px;
    font-size: 12px;
    border: 1px solid;
    white-space: nowrap;
}

.status.unread {
    color: var(--gold);
    border-color: rgba(201,169,110,0.45);
    background: rgba(201,169,110,0.08);
}

.status.read {
    color: #8ee0aa;
    border-color: rgba(76,175,112,0.45);
    background: rgba(76,175,112,0.08);
}

.action-row {
    display: flex;
    gap: 8px;
}

.btn {
    border: none;
    padding: 10px 14px;
    color: #fff;
    cursor: pointer;
    font-family: 'DM Sans', sans-serif;
    font-size: 13px;
    transition: 0.2s;
    white-space: nowrap;
}

.btn-read {
    background: var(--gold);
    color: var(--dark);
}

.btn-delete {
    background: var(--danger);
}

.btn:hover {
    opacity: 0.85;
}

.empty-box {
    text-align: center;
    padding: 60px 20px;
    color: var(--muted);
}

.empty-box h3 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 30px;
    color: var(--gold);
    margin-bottom: 8px;
}

@media(max-width: 1000px) {
    table {
        min-width: 1100px;
    }
}
</style>
</head>

<body>

<div class="admin-layout">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <div class="logo">Drive<span>KTM</span></div>

        <div class="menu">
            <a href="${pageContext.request.contextPath}/admin-dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin-vehicles">Manage Vehicles</a>
            <a href="${pageContext.request.contextPath}/admin-bookings">Manage Bookings</a>
            <a href="${pageContext.request.contextPath}/admin-users">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin-messages" class="active">Messages</a>
            <a href="${pageContext.request.contextPath}/admin-logout" class="logout">Logout</a>
        </div>
    </aside>

    <!-- MAIN -->
    <main class="main">

        <div class="topbar">
            <h1>Messages</h1>
            <div class="admin-email">Admin: ${sessionScope.adminEmail}</div>
        </div>

        <div class="content">

            <div class="page-title">
                <h2>Customer <span>Messages</span></h2>
                <p>View messages submitted from the contact form.</p>
            </div>

            <c:if test="${param.success == 'deleted'}">
                <div class="alert success">Message deleted successfully.</div>
            </c:if>

            <c:if test="${param.success == 'read'}">
                <div class="alert success">Message marked as read.</div>
            </c:if>

            <c:if test="${param.error == 'invalid'}">
                <div class="alert error">Invalid message request.</div>
            </c:if>

            <c:if test="${param.error == 'server'}">
                <div class="alert error">Something went wrong. Please try again.</div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="alert error">${errorMessage}</div>
            </c:if>

            <div class="table-box">

                <c:choose>
                    <c:when test="${empty messages}">
                        <div class="empty-box">
                            <h3>No Messages Found</h3>
                            <p>Messages submitted from the contact page will appear here.</p>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Full Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Topic</th>
                                    <th>Message</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach var="msg" items="${messages}">
                                    <tr>
                                        <td>${msg.id}</td>
                                        <td>${msg.fullName}</td>
                                        <td>${msg.email}</td>
                                        <td>${msg.phone}</td>
                                        <td>${msg.topic}</td>

                                        <td>
                                            <div class="message-text">
                                                ${msg.message}
                                            </div>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${msg.status == 'Unread'}">
                                                    <span class="status unread">Unread</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status read">Read</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>${msg.createdAt}</td>

                                        <td>
                                            <div class="action-row">
                                                <form action="${pageContext.request.contextPath}/admin-messages" method="post">
                                                    <input type="hidden" name="id" value="${msg.id}">
                                                    <input type="hidden" name="action" value="read">
                                                    <button type="submit" class="btn btn-read">Read</button>
                                                </form>

                                                <form action="${pageContext.request.contextPath}/admin-messages" method="post"
                                                      onsubmit="return confirm('Are you sure you want to delete this message?');">
                                                    <input type="hidden" name="id" value="${msg.id}">
                                                    <input type="hidden" name="action" value="delete">
                                                    <button type="submit" class="btn btn-delete">Delete</button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>

            </div>

        </div>

    </main>

</div>

</body>
</html>