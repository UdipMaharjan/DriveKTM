<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String adminEmail = (String) session.getAttribute("adminEmail");
    if (adminEmail == null) {
        response.sendRedirect(request.getContextPath() + "/admin");
        return;
    }

    Integer totalUsers = (Integer) request.getAttribute("totalUsers");
    if (totalUsers == null) {
        totalUsers = 0;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard | DriveKTM</title>

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

.welcome {
    background:
        linear-gradient(rgba(17,17,17,0.92), rgba(17,17,17,0.92)),
        radial-gradient(circle at right, rgba(201,169,110,0.20), transparent 35%);
    border: 1px solid rgba(201,169,110,0.18);
    padding: 30px;
    margin-bottom: 28px;
}

.welcome h2 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 38px;
    font-weight: 400;
    margin-bottom: 8px;
}

.welcome h2 span {
    color: var(--gold);
}

.welcome p {
    color: var(--muted);
    line-height: 1.7;
}

.cards {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 22px;
    margin-bottom: 30px;
}

.card {
    background: var(--dark2);
    border: 1px solid rgba(201,169,110,0.18);
    padding: 26px;
    box-shadow: 0 15px 45px rgba(0,0,0,0.35);
}

.card h3 {
    font-size: 14px;
    color: var(--muted);
    margin-bottom: 14px;
    font-weight: 500;
}

.card .number {
    font-size: 36px;
    font-weight: 600;
    color: var(--white);
}

.card .note {
    margin-top: 10px;
    font-size: 13px;
    color: var(--gold);
}

.dashboard-grid {
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 24px;
}

.panel {
    background: var(--dark2);
    border: 1px solid rgba(201,169,110,0.18);
    padding: 28px;
}

.panel h2 {
    font-size: 21px;
    margin-bottom: 20px;
    border-bottom: 1px solid var(--gold);
    padding-bottom: 12px;
}

.quick-actions a {
    display: inline-block;
    margin: 8px 10px 8px 0;
    padding: 12px 18px;
    background: transparent;
    border: 1px solid var(--gold);
    color: var(--gold);
    text-decoration: none;
    font-size: 13px;
    transition: 0.25s;
}

.quick-actions a:hover {
    background: var(--gold);
    color: var(--dark);
}

.activity p {
    padding: 13px 0;
    border-bottom: 1px solid rgba(255,255,255,0.08);
    color: var(--muted);
}

.logout {
    color: #ff8888 !important;
}

@media(max-width: 1000px) {
    .cards {
        grid-template-columns: repeat(2, 1fr);
    }

    .dashboard-grid {
        grid-template-columns: 1fr;
    }
}
</style>
</head>

<body>

<div class="admin-layout">

    <aside class="sidebar">
        <div class="logo">Drive<span>KTM</span></div>

        <div class="menu">
            <a href="${pageContext.request.contextPath}/admin-dashboard" class="active">Dashboard</a>
             <a href="${pageContext.request.contextPath}/admin-vehicles">Manage Vehicles</a>
            <a href="#">Manage Bookings</a>
            <a href="${pageContext.request.contextPath}/admin-users">Manage Users</a>
            <a href="#">Reports</a>
            <a href="${pageContext.request.contextPath}/admin-logout" class="logout">Logout</a>
        </div>
    </aside>

    <main class="main">

        <div class="topbar">
            <h1>Admin Dashboard</h1>
            <div class="admin-email">Welcome, <%= adminEmail %></div>
        </div>

        <div class="content">

            <section class="welcome">
                <h2>Welcome to <span>DriveKTM</span> Admin</h2>
                <p>Manage users, vehicles, bookings and reports from one dashboard.</p>
            </section>

            <section class="cards">
                <div class="card">
                    <h3>Total Users</h3>
                    <div class="number"><%= totalUsers %></div>
                    <div class="note">Registered customers</div>
                </div>

                <div class="card">
                    <h3>Total Vehicles</h3>
                    <div class="number">0</div>
                    <div class="note">Coming next</div>
                </div>

                <div class="card">
                    <h3>Total Bookings</h3>
                    <div class="number">0</div>
                    <div class="note">Coming next</div>
                </div>

                <div class="card">
                    <h3>Pending Bookings</h3>
                    <div class="number">0</div>
                    <div class="note">Coming next</div>
                </div>
            </section>

            <section class="dashboard-grid">

                <div class="panel">
                    <h2>Quick Actions</h2>

                    <div class="quick-actions">
                        <a href="${pageContext.request.contextPath}/admin-users">Manage Users</a>
                        <a href="${pageContext.request.contextPath}/admin-vehicles">Manage Vehicles</a>
                        <a href="#">View Bookings</a>
                        <a href="#">View Reports</a>
                    </div>
                </div>

                <div class="panel activity">
                    <h2>System Status</h2>
                    <p>User management connected</p>
                    <p>Vehicle management pending</p>
                    <p>Booking management pending</p>
                    <p>Report section pending</p>
                </div>

            </section>

        </div>

    </main>

</div>

</body>
</html>