<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String adminEmail = (String) session.getAttribute("adminEmail");
    if (adminEmail == null) {
        response.sendRedirect(request.getContextPath() + "/admin");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Vehicle | DriveKTM</title>

<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">

<style>
:root {
    --gold: #C9A96E;
    --dark: #0A0A0A;
    --dark2: #111111;
    --text: #F0EDE8;
    --muted: #999;
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

.form-box {
    background: var(--dark2);
    border: 1px solid rgba(201,169,110,0.18);
    padding: 30px;
    max-width: 850px;
    box-shadow: 0 15px 45px rgba(0,0,0,0.35);
}

.form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

.form-group {
    margin-bottom: 18px;
}

.form-group label {
    display: block;
    color: var(--gold);
    font-size: 13px;
    margin-bottom: 8px;
}

.form-group input,
.form-group select {
    width: 100%;
    padding: 13px;
    background: rgba(255,255,255,0.04);
    border: 1px solid rgba(201,169,110,0.22);
    color: var(--text);
    outline: none;
    font-family: 'DM Sans', sans-serif;
}

.form-group select option {
    background: #111;
    color: white;
}

.form-group input:focus,
.form-group select:focus {
    border-color: var(--gold);
}

.btn-row {
    margin-top: 20px;
}

.save-btn {
    padding: 13px 22px;
    background: var(--gold);
    color: var(--dark);
    border: none;
    cursor: pointer;
    font-weight: 600;
    margin-right: 10px;
}

.cancel-btn {
    padding: 13px 22px;
    background: transparent;
    color: var(--gold);
    border: 1px solid var(--gold);
    text-decoration: none;
}

.message {
    padding: 13px 16px;
    margin-bottom: 20px;
    border: 1px solid rgba(255,80,80,0.35);
    background: rgba(255,80,80,0.08);
    color: #ff9b9b;
}
</style>
</head>

<body>

<div class="admin-layout">

    <aside class="sidebar">
        <div class="logo">Drive<span>KTM</span></div>

        <div class="menu">
            <a href="${pageContext.request.contextPath}/admin-dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin-vehicles" class="active">Manage Vehicles</a>
            <a href="#">Manage Bookings</a>
            <a href="${pageContext.request.contextPath}/admin-users">Manage Users</a>
            <a href="#">Reports</a>
            <a href="#" class="logout">Logout</a>
        </div>
    </aside>

    <main class="main">

        <div class="topbar">
            <h1>Add Vehicle</h1>
            <div class="admin-email">Admin: <%= adminEmail %></div>
        </div>

        <div class="content">

            <div class="page-header">
                <h2>Add <span>Vehicle</span></h2>
                <p style="color:#999; margin-top:8px;">Add a new vehicle to the DriveKTM frontend vehicles page.</p>
            </div>

            <% if (request.getParameter("error") != null) { %>
                <div class="message">Something went wrong. Please check the details and try again.</div>
            <% } %>

            <div class="form-box">
                <form action="${pageContext.request.contextPath}/add-vehicle" method="post">

                    <div class="form-grid">

                        <div class="form-group">
                            <label>Vehicle Name</label>
                            <input type="text" name="vehicleName" placeholder="Toyota Fortuner" required>
                        </div>

                        <div class="form-group">
                            <label>Category</label>
                            <select name="category" required>
                                <option value="Cars">Cars</option>
                                <option value="Bikes">Bikes</option>
                                <option value="Scooters">Scooters</option>
                                <option value="Bicycles">Bicycles</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Tag</label>
                            <input type="text" name="tag" placeholder="Premium SUV">
                        </div>

                        <div class="form-group">
                            <label>Vehicle Type</label>
                            <input type="text" name="vehicleType" placeholder="7 Seater SUV">
                        </div>

                        <div class="form-group">
                            <label>Price Per Day</label>
                            <input type="number" name="pricePerDay" placeholder="4500" required>
                        </div>

                        <div class="form-group">
                            <label>Fuel</label>
                            <input type="text" name="fuel" placeholder="Petrol / Diesel / Electric">
                        </div>

                        <div class="form-group">
                            <label>Seats</label>
                            <input type="text" name="seats" placeholder="5 Seats">
                        </div>

                        <div class="form-group">
                            <label>Feature</label>
                            <input type="text" name="feature" placeholder="AC / City / Off-road">
                        </div>

                        <div class="form-group">
                            <label>Image Name</label>
                            <input type="text" name="imageName" placeholder="ToyotaFortuner.png">
                        </div>

                        <div class="form-group">
                            <label>Status</label>
                            <select name="status">
                                <option value="Available">Available</option>
                                <option value="Unavailable">Unavailable</option>
                            </select>
                        </div>

                    </div>

                    <div class="btn-row">
                        <button type="submit" class="save-btn">Add Vehicle</button>
                        <a href="${pageContext.request.contextPath}/admin-vehicles" class="cancel-btn">Cancel</a>
                    </div>

                </form>
            </div>

        </div>

    </main>

</div>

</body>
</html>