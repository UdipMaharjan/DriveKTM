<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DriveKTM — Book Your Ride</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
  :root {
    --gold: #C9A96E;
    --gold-light: #E8C98A;
    --gold-dim: rgba(201,169,110,0.15);
    --dark: #0A0A0A;
    --dark-2: #111111;
    --dark-3: #1A1A1A;
    --dark-4: #222222;
    --text: #F0EDE8;
    --text-muted: #AAA39A;
    --text-faint: #666055;
    --white: #FDFCFA;
    --danger: #ff7a7a;
    --success: #87d7a3;
  }

  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  html {
    scroll-behavior: smooth;
  }

  body {
    font-family: 'DM Sans', sans-serif;
    background: var(--dark);
    color: var(--text);
    overflow-x: hidden;
  }

  a {
    text-decoration: none;
  }

  ::-webkit-scrollbar { width: 4px; }
  ::-webkit-scrollbar-track { background: var(--dark-2); }
  ::-webkit-scrollbar-thumb { background: var(--gold); border-radius: 2px; }

 /* ── NAV ── */
  nav {
    position: fixed; top: 0; left: 0; right: 0; z-index: 100;
    display: flex; align-items: center; justify-content: space-between;
    padding: 0 48px; height: 72px;
    background: rgba(10,10,10,0.85);
    backdrop-filter: blur(20px);
    border-bottom: 1px solid rgba(201,169,110,0.12);
    transition: background 0.4s;
  }
  .nav-logo {
    font-family: 'Cormorant Garamond', serif;
    font-size: 22px; font-weight: 600; letter-spacing: 0.08em;
    color: var(--white); text-decoration: none;
  }
  .nav-logo span { color: var(--gold); }
  .nav-links { display: flex; gap: 36px; list-style: none; }
  .nav-links a {
    font-size: 13px; font-weight: 500; letter-spacing: 0.08em;
    text-transform: uppercase; color: var(--text-muted);
    text-decoration: none; transition: color 0.2s; position: relative;
  }
  .nav-links a::after {
    content: ''; position: absolute; bottom: -4px; left: 0;
    width: 0; height: 1px; background: var(--gold); transition: width 0.3s;
  }
  .nav-links a:hover { color: var(--text); }
  .nav-links a:hover::after { width: 100%; }
  .btn-outline {
    padding: 9px 22px; border: 1px solid var(--gold);
    color: var(--gold); background: transparent;
    font-family: 'DM Sans', sans-serif; font-size: 13px;
    font-weight: 500; letter-spacing: 0.06em; text-transform: uppercase;
    cursor: pointer; transition: all 0.25s; text-decoration: none;
  }
  .btn-outline:hover { background: var(--gold); color: var(--dark); }
  .nav-links a.active {
  color: var(--text);
}

.nav-links a.active::after {
  width: 100%;
}

  /* HERO */
  .book-hero {
    position: relative;
    min-height: 640px;
    padding-top: 76px;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
  }

  .book-hero::before {
    content: "";
    position: absolute;
    inset: 0;
    background:
      linear-gradient(to bottom, rgba(10,10,10,0.78), rgba(10,10,10,0.68)),
      linear-gradient(to right, rgba(10,10,10,0.6), rgba(10,10,10,0.3)),
      url('${pageContext.request.contextPath}/images/book-bg.jpg') center/cover no-repeat;
    z-index: 0;
    filter: saturate(0.95);
  }

  .book-hero::after {
    content: "";
    position: absolute;
    inset: 0;
    background: radial-gradient(circle at center, rgba(201,169,110,0.08), transparent 55%);
    z-index: 1;
  }

  .book-hero-content {
    position: relative;
    z-index: 2;
    text-align: center;
    max-width: 900px;
    padding: 80px 24px 70px;
  }

  .hero-label {
    display: inline-flex;
    align-items: center;
    gap: 14px;
    margin-bottom: 22px;
  }

  .hero-label::before,
  .hero-label::after {
    content: "";
    width: 46px;
    height: 1px;
    background: var(--gold);
  }

  .hero-label span {
    font-size: 11px;
    letter-spacing: 0.22em;
    text-transform: uppercase;
    color: var(--gold);
  }

  .book-hero h1 {
    font-family: 'Cormorant Garamond', serif;
    font-size: clamp(54px, 7vw, 96px);
    font-weight: 300;
    line-height: 1.02;
    margin-bottom: 14px;
    color: var(--white);
  }

  .book-hero h1 em {
    color: var(--gold);
    font-style: italic;
  }

  .book-hero p {
    font-size: 16px;
    color: rgba(240,237,232,0.8);
    line-height: 1.8;
    max-width: 650px;
    margin: 0 auto;
  }

  /* PAGE WRAP */
  .page-section {
    position: relative;
    padding: 90px 20px 100px;
    background:
      radial-gradient(circle at top, rgba(201,169,110,0.06), transparent 30%),
      var(--dark);
  }

  .booking-wrap {
    max-width: 1150px;
    margin: -110px auto 0;
    position: relative;
    z-index: 3;
  }

  .booking-card {
    background: rgba(17,17,17,0.94);
    border: 1px solid rgba(201,169,110,0.24);
    box-shadow: 0 24px 80px rgba(0,0,0,0.45);
    overflow: hidden;
  }

  .booking-head {
    padding: 34px 32px 22px;
    border-bottom: 1px solid rgba(201,169,110,0.12);
    text-align: center;
  }

  .booking-head h2 {
    font-family: 'Cormorant Garamond', serif;
    font-size: clamp(34px, 4vw, 48px);
    font-weight: 400;
    color: var(--white);
  }

  .booking-head p {
    margin-top: 8px;
    color: var(--text-muted);
    font-size: 14px;
    letter-spacing: 0.08em;
    text-transform: uppercase;
  }

  .booking-body {
    padding: 36px 32px 40px;
  }
.form-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 22px 26px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.form-group.full {
  grid-column: 1 / -1;
}

.form-group label {
  font-size: 11px;
  font-weight: 600;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--text-faint);
}

.form-control,
.form-group select,
.form-group textarea {
  width: 100%;
  background: rgba(255,255,255,0.03);
  border: 1px solid rgba(201,169,110,0.16);
  color: var(--text);
  padding: 14px 16px;
  font-size: 14px;
  font-family: 'DM Sans', sans-serif;
  outline: none;
  transition: border-color 0.22s, background 0.22s;
}

.form-control:focus,
.form-group select:focus,
.form-group textarea:focus {
  border-color: var(--gold);
  background: rgba(255,255,255,0.05);
}

.form-group select {
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  color-scheme: dark;
  cursor: pointer;
}

.form-group select option {
  background: #1A1A1A;
  color: #F0EDE8;
}

.form-group select option:disabled {
  color: #888880;
}

.form-group textarea {
  resize: vertical;
  min-height: 130px;
}

.form-note {
  margin-top: 26px;
  color: var(--text-muted);
  font-size: 13px;
  line-height: 1.7;
}

  .submit-row {
    margin-top: 30px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 20px;
    flex-wrap: wrap;
  }

  .secure-badge {
    color: var(--text-muted);
    font-size: 13px;
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .secure-badge span {
    color: var(--gold);
    font-size: 16px;
  }

  .btn-gold {
    border: none;
    padding: 15px 34px;
    background: linear-gradient(135deg, var(--gold) 0%, var(--gold-light) 100%);
    color: var(--dark);
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    cursor: pointer;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    box-shadow: 0 8px 24px rgba(201,169,110,0.25);
  }

  .btn-gold:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 28px rgba(201,169,110,0.35);
  }

  /* MESSAGE */
  .page-message {
    margin: 0 auto 24px;
    max-width: 1150px;
    padding: 14px 18px;
    border-radius: 0;
    font-size: 14px;
    line-height: 1.6;
  }

  .page-message.error {
    border: 1px solid rgba(255,122,122,0.35);
    background: rgba(255,122,122,0.08);
    color: var(--danger);
  }

  .page-message.success {
    border: 1px solid rgba(135,215,163,0.35);
    background: rgba(135,215,163,0.08);
    color: var(--success);
  }

  /* WHY CHOOSE US */
  .why-book {
    max-width: 1150px;
    margin: 70px auto 0;
    padding: 0 4px;
  }

  .why-book-head {
    text-align: center;
    margin-bottom: 42px;
  }

  .why-book-head h3 {
    font-family: 'Cormorant Garamond', serif;
    font-size: clamp(34px, 4vw, 50px);
    font-weight: 300;
    color: var(--white);
  }

  .why-book-head h3 em {
    color: var(--gold);
    font-style: italic;
  }

  .why-book-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 24px;
  }

  .why-book-card {
    background: var(--dark-2);
    border: 1px solid rgba(201,169,110,0.12);
    padding: 34px 28px;
    text-align: center;
    transition: transform 0.25s, border-color 0.25s;
  }

  .why-book-card:hover {
    transform: translateY(-4px);
    border-color: rgba(201,169,110,0.28);
  }

  .why-icon {
    width: 78px;
    height: 78px;
    margin: 0 auto 18px;
    border-radius: 50%;
    border: 1px solid rgba(201,169,110,0.25);
    background: rgba(201,169,110,0.06);
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--gold);
    font-size: 30px;
  }

  .why-book-card h4 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 28px;
    font-weight: 400;
    color: var(--white);
    margin-bottom: 10px;
  }

  .why-book-card p {
    font-size: 14px;
    color: var(--text-muted);
    line-height: 1.7;
  }

  /* FOOTER */
  footer {
    background: var(--dark);
    border-top: 1px solid rgba(201,169,110,0.1);
    padding: 70px 80px 30px;
  }

  .footer-top {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr 1fr;
    gap: 50px;
    margin-bottom: 46px;
  }

  .footer-brand .nav-logo {
    display: inline-block;
    margin-bottom: 16px;
    font-size: 27px;
  }

  .footer-brand p {
    font-size: 13px;
    color: var(--text-faint);
    line-height: 1.8;
    max-width: 290px;
  }

  .footer-col h5 {
    font-size: 11px;
    font-weight: 600;
    letter-spacing: 0.16em;
    text-transform: uppercase;
    color: var(--gold);
    margin-bottom: 18px;
  }

  .footer-col a {
    display: block;
    font-size: 13px;
    color: var(--text-faint);
    margin-bottom: 12px;
    transition: color 0.2s;
  }

  .footer-col a:hover {
    color: var(--text);
  }

  .footer-bottom {
    padding-top: 22px;
    border-top: 1px solid rgba(255,255,255,0.05);
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 20px;
    flex-wrap: wrap;
  }

  .footer-bottom p {
    font-size: 12px;
    color: var(--text-faint);
  }

  .float-cta {
    position: fixed;
    bottom: 30px;
    right: 30px;
    z-index: 60;
    background: var(--gold);
    color: var(--dark);
    padding: 14px 24px;
    border: none;
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    cursor: pointer;
    box-shadow: 0 8px 30px rgba(201,169,110,0.35);
    transition: transform 0.2s, box-shadow 0.2s;
  }

  .float-cta:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 36px rgba(201,169,110,0.45);
  }
  .booking-popup-overlay {
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,0.65);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 9999;
}

.booking-popup-box {
    background: #111;
    border: 1px solid rgba(201,169,110,0.35);
    padding: 32px 28px;
    width: 90%;
    max-width: 420px;
    text-align: center;
    box-shadow: 0 20px 60px rgba(0,0,0,0.45);
}

.booking-popup-box h3 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 34px;
    font-weight: 400;
    color: #FDFCFA;
    margin-bottom: 12px;
}

.booking-popup-box p {
    font-size: 15px;
    color: #AAA39A;
    margin-bottom: 24px;
    line-height: 1.7;
}

.booking-popup-box button {
    padding: 12px 24px;
    border: none;
    background: linear-gradient(135deg, #C9A96E 0%, #E8C98A 100%);
    color: #0A0A0A;
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    cursor: pointer;
}

  /* RESPONSIVE */
  @media (max-width: 1100px) {
    .why-book-grid {
      grid-template-columns: 1fr;
    }

    .footer-top {
      grid-template-columns: 1fr 1fr;
    }
  }

  @media (max-width: 900px) {
    nav {
      padding: 0 20px;
      height: auto;
      min-height: 76px;
      flex-wrap: wrap;
      gap: 14px;
      padding-top: 14px;
      padding-bottom: 14px;
    }

    .nav-links {
      gap: 18px;
      flex-wrap: wrap;
      justify-content: center;
    }

    .form-grid {
      grid-template-columns: 1fr;
    }

    .booking-wrap {
      margin-top: -80px;
    }
  }

  @media (max-width: 768px) {
    .book-hero-content {
      padding-top: 60px;
    }

    .booking-head,
    .booking-body {
      padding-left: 20px;
      padding-right: 20px;
    }

    .footer-top {
      grid-template-columns: 1fr;
    }

    footer {
      padding-left: 20px;
      padding-right: 20px;
    }

    .user-name {
      max-width: 90px;
    }

    .float-cta {
      right: 18px;
      bottom: 18px;
      padding: 12px 18px;
    }
  }
</style>
</head>
<body>

<%
String error = request.getParameter("error");
String success = request.getParameter("success");
String selectedVehicle = request.getParameter("vehicleName");
if (selectedVehicle == null || selectedVehicle.isEmpty()) {
    selectedVehicle = request.getParameter("vehicle");
}
%>

<!-- NAVBAR -->
<nav>
    <a href="${pageContext.request.contextPath}/home" class="nav-logo">Drive<span>KTM</span></a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/home" >Home</a></li>
        <li><a href="${pageContext.request.contextPath}/vehicles">Vehicles</a></li>
        <li><a href="${pageContext.request.contextPath}/book" class="active">Book</a></li>
        <li><a href="${pageContext.request.contextPath}/about">About</a></li>
        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
    </ul>
    <div class="nav-auth">
        <c:choose>
            <c:when test="${not empty sessionScope.userName}">
                <!-- If user is logged in, show their name and a logout button -->
                <div class="user-info">
                    <span class="user-icon">👤</span> <!-- User Icon -->
                    <span class="user-name">${sessionScope.userName}</span> <!-- User Name -->
                    <a href="${pageContext.request.contextPath}/logout" class="btn-outline">Logout</a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- If user is not logged in, show login button -->
                <a href="${pageContext.request.contextPath}/login" class="btn-outline">Login</a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<!-- HERO -->
<section class="book-hero">
  <div class="book-hero-content">
    <div class="hero-label"><span>Reserve Your Journey Today</span></div>
    <h1>Book Your <em>Ride</em></h1>
    <p>
      Choose your vehicle, set your dates, and reserve with confidence.
      Premium comfort, transparent pricing, and a smooth experience from start to finish.
    </p>
  </div>
</section>

<section class="page-section">

  <% if ("empty".equals(error)) { %>
    <div class="page-message error">Please fill in all required booking details.</div>
  <% } else if ("server".equals(error)) { %>
    <div class="page-message error">Something went wrong while processing your booking. Please try again.</div>
  <% } else if ("invaliddates".equals(error)) { %>
    <div class="page-message error">Drop-off date must be the same as or later than pick-up date.</div>
  <% } else if ("booked".equals(success)) { %>
    <div class="page-message success">Your booking request has been submitted successfully.</div>
  <% } %>

  <div class="booking-wrap">
    <div class="booking-card">
      <div class="booking-head">
        <h2>Booking Details</h2>
        <p>Complete the form below to reserve your vehicle</p>
      </div>

      <div class="booking-body">
        <form action="${pageContext.request.contextPath}/book" method="post">
          <div class="form-grid">

            <div class="form-group">
              <label for="fullName">Full Name</label>
              <input
                type="text"
                id="fullName"
                name="fullName"
                class="form-control"
                placeholder="Enter your full name"
                value="${not empty sessionScope.userName ? sessionScope.userName : param.fullName}"
                required>
            </div>

            <div class="form-group">
              <label for="email">Email Address</label>
              <input
                type="email"
                id="email"
                name="email"
                class="form-control"
                placeholder="Enter your email"
                value="${not empty sessionScope.userEmail ? sessionScope.userEmail : param.email}"
                required>
            </div>

            <div class="form-group">
              <label for="phone">Phone Number</label>
              <input
                type="text"
                id="phone"
                name="phone"
                class="form-control"
                placeholder="+977 98XXXXXXXX"
                value="${param.phone}"
                required>
            </div>

            <div class="form-group">
              <label for="vehicleName">Select Vehicle</label>
        <select id="vehicleName" name="vehicleName" required>
<option value="Toyota Fortuner" <%= "Toyota Fortuner".equals(selectedVehicle) ? "selected" : "" %>>Toyota Fortuner</option>
<option value="Toyota Camry" <%= "Toyota Camry".equals(selectedVehicle) ? "selected" : "" %>>Toyota Camry</option>
<option value="Hyundai Creta" <%= "Hyundai Creta".equals(selectedVehicle) ? "selected" : "" %>>Hyundai Creta</option>
<option value="Honda City" <%= "Honda City".equals(selectedVehicle) ? "selected" : "" %>>Honda City</option>
<option value="Suzuki XL7" <%= "Suzuki XL7".equals(selectedVehicle) ? "selected" : "" %>>Suzuki XL7</option>
<option value="Ford Ranger" <%= "Ford Ranger".equals(selectedVehicle) ? "selected" : "" %>>Ford Ranger</option>
<option value="Mahindra Scorpio" <%= "Mahindra Scorpio".equals(selectedVehicle) ? "selected" : "" %>>Mahindra Scorpio</option>
<option value="Kia Seltos" <%= "Kia Seltos".equals(selectedVehicle) ? "selected" : "" %>>Kia Seltos</option>
<option value="Suzuki Swift" <%= "Suzuki Swift".equals(selectedVehicle) ? "selected" : "" %>>Suzuki Swift</option>
<option value="Toyota Yaris" <%= "Toyota Yaris".equals(selectedVehicle) ? "selected" : "" %>>Toyota Yaris</option>
<option value="MG Hector" <%= "MG Hector".equals(selectedVehicle) ? "selected" : "" %>>MG Hector</option>
<option value="Nissan Magnite" <%= "Nissan Magnite".equals(selectedVehicle) ? "selected" : "" %>>Nissan Magnite</option>
<option value="RE Himalayan" <%= "RE Himalayan".equals(selectedVehicle) ? "selected" : "" %>>RE Himalayan</option>
<option value="KTM Duke 200" <%= "KTM Duke 200".equals(selectedVehicle) ? "selected" : "" %>>KTM Duke 200</option>
<option value="KTM Duke 390" <%= "KTM Duke 390".equals(selectedVehicle) ? "selected" : "" %>>KTM Duke 390</option>
<option value="Yamaha R15" <%= "Yamaha R15".equals(selectedVehicle) ? "selected" : "" %>>Yamaha R15</option>
<option value="Bajaj Pulsar 220" <%= "Bajaj Pulsar 220".equals(selectedVehicle) ? "selected" : "" %>>Bajaj Pulsar 220</option>
<option value="Honda Hornet" <%= "Honda Hornet".equals(selectedVehicle) ? "selected" : "" %>>Honda Hornet</option>
<option value="TVS Apache RTR" <%= "TVS Apache RTR".equals(selectedVehicle) ? "selected" : "" %>>TVS Apache RTR</option>
<option value="Suzuki Gixxer" <%= "Suzuki Gixxer".equals(selectedVehicle) ? "selected" : "" %>>Suzuki Gixxer</option>
<option value="Honda Activa" <%= "Honda Activa".equals(selectedVehicle) ? "selected" : "" %>>Honda Activa</option>
<option value="TVS Ntorq" <%= "TVS Ntorq".equals(selectedVehicle) ? "selected" : "" %>>TVS Ntorq</option>
<option value="Yamaha RayZR" <%= "Yamaha RayZR".equals(selectedVehicle) ? "selected" : "" %>>Yamaha RayZR</option>
<option value="Suzuki Access 125" <%= "Suzuki Access 125".equals(selectedVehicle) ? "selected" : "" %>>Suzuki Access 125</option>
<option value="Aprilia SR 160" <%= "Aprilia SR 160".equals(selectedVehicle) ? "selected" : "" %>>Aprilia SR 160</option>
<option value="Honda Dio" <%= "Honda Dio".equals(selectedVehicle) ? "selected" : "" %>>Honda Dio</option>
<option value="Vespa VXL" <%= "Vespa VXL".equals(selectedVehicle) ? "selected" : "" %>>Vespa VXL</option>
<option value="Yadea Electric" <%= "Yadea Electric".equals(selectedVehicle) ? "selected" : "" %>>Yadea Electric</option>
<option value="Mountain Bike" <%= "Mountain Bike".equals(selectedVehicle) ? "selected" : "" %>>Mountain Bike</option>
<option value="Road Bike" <%= "Road Bike".equals(selectedVehicle) ? "selected" : "" %>>Road Bike</option>
<option value="Hybrid Bike" <%= "Hybrid Bike".equals(selectedVehicle) ? "selected" : "" %>>Hybrid Bike</option>
<option value="City Bicycle" <%= "City Bicycle".equals(selectedVehicle) ? "selected" : "" %>>City Bicycle</option>
</select>
            </div>

            <div class="form-group">
              <label for="pickupLocation">Pick-Up Location</label>
              <input
                type="text"
                id="pickupLocation"
                name="pickupLocation"
                class="form-control"
                placeholder="e.g. Thamel, Kathmandu"
                value="${param.pickupLocation}"
                required>
            </div>

            <div class="form-group">
              <label for="dropoffLocation">Drop-Off Location</label>
              <input
                type="text"
                id="dropoffLocation"
                name="dropoffLocation"
                class="form-control"
                placeholder="e.g. Airport, Kathmandu"
                value="${param.dropoffLocation}"
                required>
            </div>

            <div class="form-group">
              <label for="pickupDate">Pick-Up Date</label>
              <input
                type="date"
                id="pickupDate"
                name="pickupDate"
                class="form-control"
                value="${param.pickupDate}"
                required>
            </div>

            <div class="form-group">
              <label for="dropoffDate">Drop-Off Date</label>
              <input
                type="date"
                id="dropoffDate"
                name="dropoffDate"
                class="form-control"
                value="${param.dropoffDate}"
                required>
            </div>

            <div class="form-group full">
              <label for="message">Special Requests</label>
              <textarea
                id="message"
                name="message"
                placeholder="Add any special requests, delivery needs, or trip notes...">${param.message}</textarea>
            </div>

          </div>

          <div class="form-note">
            By submitting this form, you agree that DriveKTM may contact you to confirm your booking and provide ride details.
          </div>

          <div class="submit-row">
            <div class="secure-badge"><span>🛡</span> Secure booking request with fast confirmation</div>
            <button type="submit" class="btn-gold">Confirm Booking</button>
          </div>
        </form>
      </div>
    </div>

    <div class="why-book">
      <div class="why-book-head">
        <h3>Why Choose <em>DriveKTM</em>?</h3>
      </div>

      <div class="why-book-grid">
        <div class="why-book-card">
          <div class="why-icon">🚘</div>
          <h4>Luxury Vehicles</h4>
          <p>Drive top-tier, well-maintained vehicles designed for comfort, style, and reliability across Nepal.</p>
        </div>

        <div class="why-book-card">
          <div class="why-icon">✔</div>
          <h4>Safe & Secure</h4>
          <p>Enjoy trusted booking, verified vehicles, and dependable support throughout your rental experience.</p>
        </div>

        <div class="why-book-card">
          <div class="why-icon">🕒</div>
          <h4>24/7 Support</h4>
          <p>Our team is available around the clock to assist with bookings, questions, and on-road support.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- FOOTER -->
<footer>
  <div class="footer-top">
    <div class="footer-brand">
      <a href="${pageContext.request.contextPath}/home" class="nav-logo">Drive<span>KTM</span></a>
      <p>Nepal’s trusted premium vehicle rental service. Explore Kathmandu and beyond with comfort, confidence, and style.</p>
    </div>

    <div class="footer-col">
      <h5>Company</h5>
      <a href="${pageContext.request.contextPath}/about">About Us</a>
      <a href="${pageContext.request.contextPath}/vehicles">Our Fleet</a>
      <a href="${pageContext.request.contextPath}/book">Book Now</a>
      <a href="${pageContext.request.contextPath}/contact">Contact</a>
    </div>

    <div class="footer-col">
      <h5>Services</h5>
      <a href="#">Self-Drive</a>
      <a href="#">With Driver</a>
      <a href="#">Corporate Rental</a>
      <a href="#">Airport Transfer</a>
    </div>

    <div class="footer-col">
      <h5>Contact</h5>
      <a href="#">Thamel, Kathmandu</a>
      <a href="tel:+97715000000">+977 1-5000000</a>
      <a href="mailto:info@drivektm.com">info@drivektm.com</a>
      <a href="#">24/7 Customer Care</a>
    </div>
  </div>

  <div class="footer-bottom">
    <p>© 2025 DriveKTM. All rights reserved.</p>
    <p>Privacy Policy · Terms of Service</p>
  </div>
</footer>

<button class="float-cta" onclick="location.href='tel:+97715000000'">📞 Call Us Now</button>

<% if ("booked".equals(success)) { %>
<div class="booking-popup-overlay" id="bookingPopup">
    <div class="booking-popup-box">
        <h3>Booking Confirmed</h3>
        <p>Thank you for booking with DriveKTM.</p>
        <button type="button" onclick="closeBookingPopup()">OK</button>
    </div>
</div>
<% } %>

<script>
  window.addEventListener('scroll', () => {
    document.querySelector('nav').style.background =
      window.scrollY > 80 ? 'rgba(10,10,10,0.97)' : 'rgba(10,10,10,0.88)';
  });

  const today = new Date().toISOString().split('T')[0];
  const pickup = document.getElementById('pickupDate');
  const dropoff = document.getElementById('dropoffDate');

  if (pickup && dropoff) {
    pickup.min = today;
    dropoff.min = today;

    pickup.addEventListener('change', function () {
      dropoff.min = this.value;
      if (dropoff.value && dropoff.value < this.value) {
        dropoff.value = this.value;
      }
    });
  }

  function closeBookingPopup() {
    const popup = document.getElementById("bookingPopup");
    if (popup) {
      popup.style.display = "none";
    }
  }
</script>

</body>
</html>

</body>
</html>