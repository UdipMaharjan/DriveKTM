<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Admin Login | DriveKTM</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;600&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<style>
:root {
    --gold: #C9A96E;
    --gold-light: #E8C98A;
    --dark: #0A0A0A;
    --dark-2: #111111;
    --dark-3: #1A1A1A;
    --text: #F0EDE8;
    --text-muted: #888880;
    --white: #FDFCFA;
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
    min-height: 100vh;
}

/* Admin Login Section */
.admin-login-wrapper {
    min-height: 100vh;
    padding-top: 72px;
    display: flex;
    align-items: center;
    justify-content: center;
    background:
        linear-gradient(rgba(10,10,10,0.82), rgba(10,10,10,0.92)),
        radial-gradient(circle at top left, rgba(201,169,110,0.18), transparent 35%),
        radial-gradient(circle at bottom right, rgba(201,169,110,0.10), transparent 35%);
}

.admin-login-box {
    width: 420px;
    background: rgba(17,17,17,0.92);
    border: 1px solid rgba(201,169,110,0.22);
    padding: 42px 38px;
    box-shadow: 0 25px 80px rgba(0,0,0,0.55);
    backdrop-filter: blur(18px);
}
.admin-nav {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 100;

    height: 72px;
    display: flex;
    align-items: center;
    justify-content: center;

    background: rgba(10,10,10,0.85);
    backdrop-filter: blur(20px);
    border-bottom: 1px solid rgba(201,169,110,0.12);
}

.admin-nav .nav-logo {
    font-family: 'Cormorant Garamond', serif;
    font-size: 24px;
    font-weight: 600;
    letter-spacing: 0.08em;
    color: var(--white);
    text-decoration: none;
}

.admin-nav .nav-logo span {
    color: var(--gold);
}

.admin-label {
    font-size: 11px;
    letter-spacing: 0.22em;
    text-transform: uppercase;
    color: var(--gold);
    margin-bottom: 14px;
    text-align: center;
}

.admin-login-box h1 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 42px;
    font-weight: 300;
    text-align: center;
    color: var(--white);
    margin-bottom: 10px;
}

.admin-login-box h1 span {
    color: var(--gold);
}

.admin-subtitle {
    text-align: center;
    color: var(--text-muted);
    font-size: 14px;
    line-height: 1.6;
    margin-bottom: 34px;
}

.form-group {
    margin-bottom: 18px;
}

.form-group label {
    display: block;
    font-size: 11px;
    letter-spacing: 0.14em;
    text-transform: uppercase;
    color: var(--text-muted);
    margin-bottom: 8px;
}

.form-group input {
    width: 100%;
    padding: 14px 15px;
    background: rgba(255,255,255,0.04);
    border: 1px solid rgba(201,169,110,0.22);
    color: var(--text);
    font-family: 'DM Sans', sans-serif;
    font-size: 14px;
    outline: none;
    transition: 0.25s;
}

.form-group input:focus {
    border-color: var(--gold);
    background: rgba(255,255,255,0.07);
}

.admin-btn {
    width: 100%;
    margin-top: 10px;
    padding: 14px;
    border: none;
    background: linear-gradient(135deg, var(--gold), var(--gold-light));
    color: var(--dark);
    font-family: 'DM Sans', sans-serif;
    font-size: 12px;
    font-weight: 600;
    letter-spacing: 0.16em;
    text-transform: uppercase;
    cursor: pointer;
    transition: 0.3s;
}

.admin-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 30px rgba(201,169,110,0.25);
}

.error-message {
    background: rgba(255, 70, 70, 0.08);
    border: 1px solid rgba(255, 70, 70, 0.25);
    color: #ff9b9b;
    font-size: 13px;
    padding: 12px;
    text-align: center;
    margin-bottom: 20px;
}

.back-home {
    display: block;
    text-align: center;
    margin-top: 24px;
    color: var(--text-muted);
    font-size: 13px;
    text-decoration: none;
    transition: 0.25s;
}

.back-home:hover {
    color: var(--gold);
}

@media (max-width: 520px) {
    nav {
        padding: 0 22px;
    }

    .nav-links {
        display: none;
    }

    .admin-login-box {
        width: 90%;
        padding: 34px 26px;
    }

    .admin-login-box h1 {
        font-size: 36px;
    }
}
</style>
</head>

<body>

<nav>
    <nav class="admin-nav">
    <a href="${pageContext.request.contextPath}/home" class="nav-logo">
        Drive<span>KTM</span>
    </a>
</nav>


    <a href="${pageContext.request.contextPath}/login.jsp" class="btn-outline">User Login</a>
</nav>

<section class="admin-login-wrapper">
    <div class="admin-login-box">

        <div class="admin-label">Secure Access</div>

        <h1>Admin <span>Portal</span></h1>

        <p class="admin-subtitle">
            Login to manage vehicles, bookings, users and DriveKTM dashboard records.
        </p>

        <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                Invalid username or password.
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/admin" method="post">
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" placeholder="Enter admin email" required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter admin password" required>
            </div>

            <button type="submit" class="admin-btn">Login as Admin</button>
        </form>

        <a href="${pageContext.request.contextPath}/home" class="back-home">
            ← Back to DriveKTM Home
        </a>

    </div>
</section>

</body>
</html>