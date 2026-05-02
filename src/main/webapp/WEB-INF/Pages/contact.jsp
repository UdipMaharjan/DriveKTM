<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Contact Us — DriveKTM</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet"
      href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
      integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
      crossorigin="" />

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
        integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo="
        crossorigin=""></script>
<style>
@charset "UTF-8";

:root {
  --gold: #C9A96E;
  --gold-light: #E8C98A;
  --gold-dim: rgba(201,169,110,0.15);
  --dark: #0A0A0A;
  --dark-2: #111111;
  --dark-3: #1A1A1A;
  --dark-4: #222222;
  --text: #F0EDE8;
  --text-muted: #888880;
  --text-faint: #555550;
  --white: #FDFCFA;
}

*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
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

::-webkit-scrollbar {
  width: 4px;
}

::-webkit-scrollbar-track {
  background: var(--dark-2);
}

::-webkit-scrollbar-thumb {
  background: var(--gold);
  border-radius: 2px;
}

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

.nav-logo span {
  color: var(--gold);
}

.nav-links {
  display: flex;
  gap: 36px;
  list-style: none;
}

.nav-links a {
  font-size: 13px; font-weight: 500; letter-spacing: 0.08em;
  text-transform: uppercase; color: var(--text-muted);
  text-decoration: none; transition: color 0.2s; position: relative;
}

.nav-links a::after {
  content: ''; position: absolute; bottom: -4px; left: 0;
  width: 0; height: 1px; background: var(--gold); transition: width 0.3s;
}

.nav-links a:hover {
  color: var(--text);
}

.nav-links a:hover::after {
  width: 100%;
}

.btn-outline {
  padding: 9px 22px; border: 1px solid var(--gold);
  color: var(--gold); background: transparent;
  font-family: 'DM Sans', sans-serif; font-size: 13px;
  font-weight: 500; letter-spacing: 0.06em; text-transform: uppercase;
  cursor: pointer; transition: all 0.25s; text-decoration: none;
}

.btn-outline:hover {
  background: var(--gold);
  color: var(--dark);
}

.nav-links a.active {
  color: var(--text);
}

.nav-links a.active::after {
  width: 100%;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.user-icon {
  color: var(--gold);
  font-size: 15px;
}

.user-name {
  color: var(--text);
  font-size: 13px;
  letter-spacing: 0.04em;
}

/* ── CONTACT PAGE ── */

.contact-page {
  padding-top: 72px;
  background:
    radial-gradient(circle at top right, rgba(201,169,110,0.12), transparent 34%),
    radial-gradient(circle at bottom left, rgba(201,169,110,0.07), transparent 38%),
    var(--dark);
}

.contact-intro {
  padding: 110px 80px 60px;
  text-align: center;
  position: relative;
}

.contact-label {
  display: inline-flex;
  align-items: center;
  gap: 12px;
  color: var(--gold);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  margin-bottom: 18px;
}

.contact-label::before,
.contact-label::after {
  content: '';
  width: 38px;
  height: 1px;
  background: var(--gold);
}

.contact-intro h1 {
  font-family: 'Cormorant Garamond', serif;
  font-size: clamp(48px, 6vw, 82px);
  font-weight: 300;
  line-height: 1.05;
  color: var(--white);
  margin-bottom: 22px;
}

.contact-intro h1 em {
  color: var(--gold);
  font-style: italic;
}

.contact-intro p {
  max-width: 680px;
  margin: 0 auto;
  color: var(--text-muted);
  font-size: 16px;
  line-height: 1.8;
}

/* ── CONTACT CARDS ── */

.contact-cards {
  padding: 20px 80px 70px;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 18px;
}

.contact-card {
  background: linear-gradient(180deg, rgba(255,255,255,0.035), rgba(255,255,255,0.015));
  border: 1px solid rgba(201,169,110,0.14);
  padding: 32px 24px;
  text-align: center;
  transition: all 0.3s;
}

.contact-card:hover {
  transform: translateY(-6px);
  border-color: rgba(201,169,110,0.45);
  background: rgba(201,169,110,0.045);
}

.contact-icon {
  width: 58px;
  height: 58px;
  margin: 0 auto 20px;
  border: 1px solid rgba(201,169,110,0.35);
  background: var(--gold-dim);
  color: var(--gold);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
}

.contact-card h3 {
  font-family: 'Cormorant Garamond', serif;
  font-size: 24px;
  font-weight: 400;
  color: var(--white);
  margin-bottom: 10px;
}

.contact-card p,
.contact-card a {
  color: var(--text-muted);
  text-decoration: none;
  font-size: 13px;
  line-height: 1.7;
}

.contact-card a:hover {
  color: var(--gold);
}

/* ── MAIN CONTACT AREA ── */

.contact-main {
  padding: 30px 80px 100px;
  display: grid;
  grid-template-columns: 1.1fr 0.9fr;
  gap: 36px;
  align-items: stretch;
}

.form-panel,
.info-panel {
  background: var(--dark-2);
  border: 1px solid rgba(201,169,110,0.14);
  position: relative;
  overflow: hidden;
}

.form-panel {
  padding: 46px;
}

.form-panel::before,
.info-panel::before {
  content: '';
  position: absolute;
  top: -120px;
  right: -120px;
  width: 260px;
  height: 260px;
  background: radial-gradient(circle, rgba(201,169,110,0.12), transparent 65%);
  pointer-events: none;
}

.panel-small {
  color: var(--gold);
  font-size: 11px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  margin-bottom: 10px;
  position: relative;
  z-index: 1;
}

.form-panel h2,
.info-panel h2 {
  font-family: 'Cormorant Garamond', serif;
  font-size: 42px;
  font-weight: 300;
  color: var(--white);
  margin-bottom: 14px;
  position: relative;
  z-index: 1;
}

.form-panel p,
.info-panel p {
  color: var(--text-muted);
  font-size: 14px;
  line-height: 1.75;
  margin-bottom: 30px;
  position: relative;
  z-index: 1;
}

.contact-form {
  position: relative;
  z-index: 1;
}

.form-row {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 18px;
}

.form-group {
  margin-bottom: 18px;
}

.form-group label {
  display: block;
  color: var(--text-faint);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  margin-bottom: 8px;
}

.form-group input,
.form-group select,
.form-group textarea {
  width: 100%;
  background: rgba(255,255,255,0.04);
  border: 1px solid rgba(201,169,110,0.18);
  color: var(--text);
  font-family: 'DM Sans', sans-serif;
  font-size: 14px;
  padding: 14px 15px;
  outline: none;
  transition: border-color 0.2s, background 0.2s;
}

.form-group textarea {
  min-height: 150px;
  resize: vertical;
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
  border-color: var(--gold);
  background: rgba(201,169,110,0.045);
}

.form-group select option {
  background: var(--dark-3);
}

.btn-gold {
  padding: 14px 34px;
  background: linear-gradient(135deg, var(--gold) 0%, var(--gold-light) 100%);
  color: var(--dark);
  border: none;
  font-family: 'DM Sans', sans-serif;
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  cursor: pointer;
  transition: all 0.3s;
}

.btn-gold:hover {
  transform: translateY(-2px);
  box-shadow: 0 12px 32px rgba(201,169,110,0.35);
}
#driveKtmMap {
  width: 100%;
  height: 360px;
  border-left: 1px solid rgba(201,169,110,0.18);
  filter: grayscale(30%) brightness(80%);
}

.leaflet-popup-content-wrapper,
.leaflet-popup-tip {
  background: #111111;
  color: #F0EDE8;
  border: 1px solid rgba(201,169,110,0.35);
}

.leaflet-popup-content {
  font-family: 'DM Sans', sans-serif;
  font-size: 13px;
}

.leaflet-control-attribution {
  background: rgba(10,10,10,0.8) !important;
  color: #C9A96E !important;
}

/* ── INFO PANEL ── */

.info-panel {
  padding: 46px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.support-box {
  border: 1px solid rgba(201,169,110,0.18);
  background: rgba(201,169,110,0.05);
  padding: 28px;
  margin-bottom: 28px;
  position: relative;
  z-index: 1;
}

.support-box h3 {
  font-family: 'Cormorant Garamond', serif;
  color: var(--white);
  font-size: 28px;
  font-weight: 400;
  margin-bottom: 10px;
}

.support-box p {
  margin-bottom: 18px;
}

.support-number {
  color: var(--gold);
  font-family: 'Cormorant Garamond', serif;
  font-size: 32px;
  text-decoration: none;
}

.quick-list {
  position: relative;
  z-index: 1;
}

.quick-item {
  display: flex;
  gap: 16px;
  padding: 20px 0;
  border-bottom: 1px solid rgba(255,255,255,0.06);
}

.quick-item:last-child {
  border-bottom: none;
}

.quick-item span {
  width: 42px;
  height: 42px;
  flex-shrink: 0;
  border: 1px solid rgba(201,169,110,0.28);
  background: var(--gold-dim);
  color: var(--gold);
  display: flex;
  align-items: center;
  justify-content: center;
}

.quick-item h4 {
  color: var(--white);
  font-size: 15px;
  margin-bottom: 6px;
}

.quick-item p {
  margin: 0;
  font-size: 13px;
}

/* ── MAP STYLE SECTION ── */

.location-section {
  padding: 0 80px 100px;
}

.location-box {
  min-height: 360px;
  background:
    linear-gradient(135deg, rgba(10,10,10,0.95), rgba(10,10,10,0.7)),
    radial-gradient(circle at 70% 40%, rgba(201,169,110,0.18), transparent 28%),
    linear-gradient(135deg, #151515, #080808);
  border: 1px solid rgba(201,169,110,0.18);
  display: grid;
  grid-template-columns: 1fr 1fr;
  overflow: hidden;
}

.location-text {
  padding: 48px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.location-text h2 {
  font-family: 'Cormorant Garamond', serif;
  font-size: 44px;
  font-weight: 300;
  color: var(--white);
  margin-bottom: 16px;
}

.location-text h2 em {
  color: var(--gold);
  font-style: italic;
}

.location-text p {
  color: var(--text-muted);
  line-height: 1.8;
  font-size: 14px;
  max-width: 480px;
}

.map-art {
  position: relative;
  background:
    linear-gradient(90deg, rgba(10,10,10,0.2), rgba(201,169,110,0.05)),
    repeating-linear-gradient(45deg, rgba(201,169,110,0.08) 0 1px, transparent 1px 35px),
    repeating-linear-gradient(-45deg, rgba(255,255,255,0.04) 0 1px, transparent 1px 40px);
}

.map-pin {
  position: absolute;
  top: 45%;
  left: 48%;
  width: 76px;
  height: 76px;
  border-radius: 50%;
  background: var(--gold);
  color: var(--dark);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 34px;
  box-shadow: 0 0 0 18px rgba(201,169,110,0.12),
              0 0 0 38px rgba(201,169,110,0.05);
  animation: pulse 2.5s infinite;
}

@keyframes pulse {
  0%, 100% {
    transform: scale(1);
  }

  50% {
    transform: scale(1.08);
  }
}

/* ── FOOTER ── */

footer {
  background: var(--dark);
  border-top: 1px solid rgba(201,169,110,0.1);
  padding: 60px 80px 32px;
}

.footer-top {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1fr;
  gap: 60px;
  margin-bottom: 48px;
}

.footer-brand .nav-logo {
  display: inline-block;
  margin-bottom: 16px;
  font-size: 26px;
}

.footer-brand p {
  font-size: 13px;
  color: var(--text-faint);
  line-height: 1.7;
  max-width: 280px;
}

.footer-col h5 {
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  color: var(--gold);
  margin-bottom: 20px;
}

.footer-col a {
  display: block;
  font-size: 13px;
  color: var(--text-faint);
  text-decoration: none;
  margin-bottom: 12px;
  transition: color 0.2s;
}

.footer-col a:hover {
  color: var(--text);
}

.footer-bottom {
  border-top: 1px solid rgba(255,255,255,0.05);
  padding-top: 24px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.footer-bottom p {
  font-size: 12px;
  color: var(--text-faint);
}
.form-message {
  padding: 14px 16px;
  margin-bottom: 22px;
  font-size: 13px;
  line-height: 1.5;
  border: 1px solid;
  position: relative;
  z-index: 1;
}

.form-message.success {
  background: rgba(46, 204, 113, 0.08);
  border-color: rgba(46, 204, 113, 0.45);
  color: #8ff0b2;
}

.form-message.error {
  background: rgba(231, 76, 60, 0.08);
  border-color: rgba(231, 76, 60, 0.45);
  color: #ff9b91;
}

/* ── RESPONSIVE ── */

@media (max-width: 1100px) {
  nav {
    padding: 0 28px;
  }

  .nav-links {
    gap: 22px;
  }

  .contact-intro,
  .contact-cards,
  .contact-main,
  .location-section,
  footer {
    padding-left: 40px;
    padding-right: 40px;
  }

  .contact-cards {
    grid-template-columns: repeat(2, 1fr);
  }

  .contact-main,
  .location-box {
    grid-template-columns: 1fr;
  }

  .footer-top {
    grid-template-columns: 1fr 1fr;
  }

  .map-art {
    min-height: 280px;
  }
}

@media (max-width: 760px) {
  nav {
    height: auto;
    min-height: 72px;
    padding: 18px 22px;
    flex-wrap: wrap;
    gap: 16px;
  }

  .nav-links {
    order: 3;
    width: 100%;
    justify-content: center;
    flex-wrap: wrap;
    gap: 18px;
  }

  .contact-intro {
    padding: 120px 24px 50px;
  }

  .contact-cards,
  .contact-main,
  .location-section,
  footer {
    padding-left: 24px;
    padding-right: 24px;
  }

  .contact-cards {
    grid-template-columns: 1fr;
  }

  .form-panel,
  .info-panel,
  .location-text {
    padding: 32px 24px;
  }

  .form-row {
    grid-template-columns: 1fr;
  }

  .footer-top {
    grid-template-columns: 1fr;
  }

  .footer-bottom {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }
}
</style>
</head>

<body>

<!-- NAVBAR -->
<nav>
  <a href="${pageContext.request.contextPath}/home" class="nav-logo">Drive<span>KTM</span></a>

  <ul class="nav-links">
    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
    <li><a href="${pageContext.request.contextPath}/vehicles">Vehicles</a></li>
    <li><a href="${pageContext.request.contextPath}/book">Book</a></li>
    <li><a href="${pageContext.request.contextPath}/about">About</a></li>
    <li><a href="${pageContext.request.contextPath}/contact" class="active">Contact</a></li>
  </ul>

  <div class="nav-auth">
    <c:choose>
      <c:when test="${not empty sessionScope.userName}">
        <div class="user-info">
          <span class="user-icon">👤</span>
          <span class="user-name">${sessionScope.userName}</span>
          <a href="${pageContext.request.contextPath}/logout" class="btn-outline">Logout</a>
        </div>
      </c:when>

      <c:otherwise>
        <a href="${pageContext.request.contextPath}/login" class="btn-outline">Login</a>
      </c:otherwise>
    </c:choose>
  </div>
</nav>

<main class="contact-page">

  <!-- INTRO -->
  <section class="contact-intro">
    <div class="contact-label">Get in Touch</div>
    <h1>Let’s Plan Your<br><em>Next Ride</em></h1>
    <p>
      Have a question about booking, vehicle availability, pricing, or pickup location?
      Our DriveKTM team is ready to help you choose the right ride for your journey.
    </p>
  </section>

  <!-- CONTACT CARDS -->
  <section class="contact-cards">
    <div class="contact-card">
      <div class="contact-icon">📍</div>
      <h3>Visit Us</h3>
      <p>Thamel, Kathmandu<br>Nepal</p>
    </div>

    <div class="contact-card">
      <div class="contact-icon">📞</div>
      <h3>Call Us</h3>
      <a href="tel:+97715000000">+977 1-5000000</a><br>
      <a href="tel:+9779800000000">+977 9800000000</a>
    </div>

    <div class="contact-card">
      <div class="contact-icon">✉️</div>
      <h3>Email Us</h3>
      <a href="mailto:info@drivektm.com">info@drivektm.com</a><br>
      <a href="mailto:support@drivektm.com">support@drivektm.com</a>
    </div>

    <div class="contact-card">
      <div class="contact-icon">⏰</div>
      <h3>Open Hours</h3>
      <p>Sunday - Friday<br>7:00 AM - 9:00 PM</p>
    </div>
  </section>

  <!-- MAIN CONTACT SECTION -->
  <section class="contact-main">

    <!-- FORM -->
    <div class="form-panel">
      <div class="panel-small">Send Message</div>
      <h2>Write to Us</h2>
      <p>
        Fill out the form below and our team will contact you as soon as possible.
      </p>
      <c:if test="${param.success == 'sent'}">
  <div class="form-message success">
    Your message has been sent successfully. We will contact you soon.
  </div>
</c:if>

<c:if test="${param.error == 'empty'}">
  <div class="form-message error">
    Please fill in all required fields.
  </div>
</c:if>

<c:if test="${param.error == 'failed'}">
  <div class="form-message error">
    Message could not be sent. Please try again.
  </div>
</c:if>

<c:if test="${param.error == 'server'}">
  <div class="form-message error">
    Server error occurred. Please try again later.
  </div>
</c:if>

        <form action="${pageContext.request.contextPath}/contact" method="post" class="contact-form">
        <div class="form-row">
          <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" placeholder="Enter your name" required>
          </div>

          <div class="form-group">
            <label for="phone">Phone Number</label>
            <input type="tel" id="phone" name="phone" placeholder="+977 98XXXXXXXX" required>
          </div>
        </div>

        <div class="form-row">
          <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" placeholder="example@email.com" required>
          </div>

          <div class="form-group">
            <label for="topic">Topic</label>
            <select id="topic" name="topic" required>
              <option value="">Select Topic</option>
              <option value="booking">Booking Inquiry</option>
              <option value="pricing">Pricing Information</option>
              <option value="vehicle">Vehicle Availability</option>
              <option value="support">Customer Support</option>
              <option value="other">Other</option>
            </select>
          </div>
        </div>

        <div class="form-group">
          <label for="message">Your Message</label>
          <textarea id="message" name="message" placeholder="Write your message here..." required></textarea>
        </div>

        <button type="submit" class="btn-gold">Send Message</button>
      </form>
    </div>

    <!-- INFO PANEL -->
    <div class="info-panel">
      <div>
        <div class="panel-small">Need Fast Help?</div>
        <h2>We’re Available</h2>
        <p>
          For urgent rental support, booking changes, or pickup coordination, call our team directly.
        </p>

        <div class="support-box">
          <h3>24/7 Rental Support</h3>
          <p>Quick help for booking, delivery, roadside support, and general rental questions.</p>
          <a href="tel:+97715000000" class="support-number">+977 1-5000000</a>
        </div>
      </div>

      <div class="quick-list">
        <div class="quick-item">
          <span>🚗</span>
          <div>
            <h4>Booking Assistance</h4>
            <p>Get help choosing the right vehicle for your trip.</p>
          </div>
        </div>

        <div class="quick-item">
          <span>📍</span>
          <div>
            <h4>Pickup & Delivery</h4>
            <p>We can coordinate vehicle delivery inside Kathmandu Valley.</p>
          </div>
        </div>

        <div class="quick-item">
          <span>🛡️</span>
          <div>
            <h4>Safety Support</h4>
            <p>Our team is ready to assist during your rental period.</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- LOCATION -->
  <section class="location-section">
    <div class="location-box">
      <div class="location-text">
        <h2>Find Us in<br><em>Kathmandu</em></h2>
        <p>
          DriveKTM operates from the heart of Kathmandu Valley, making it easy for customers to access
          vehicles from major areas like Thamel, Patan, Baneshwor, Airport, and nearby locations.
        </p>
      </div>

 <div id="driveKtmMap"></div>
    </div>
  </section>

</main>

<!-- FOOTER -->
<footer>
  <div class="footer-top">
    <div class="footer-brand">
      <a href="${pageContext.request.contextPath}/home" class="nav-logo">Drive<span>KTM</span></a>
      <p>Nepal's most trusted premium vehicle rental service. Explore the Himalayas on your own terms.</p>
    </div>

    <div class="footer-col">
      <h5>Company</h5>
      <a href="${pageContext.request.contextPath}/about">About Us</a>
      <a href="${pageContext.request.contextPath}/vehicles">Our Fleet</a>
      <a href="#">Careers</a>
      <a href="${pageContext.request.contextPath}/book">Book</a>
    </div>

    <div class="footer-col">
      <h5>Services</h5>
      <a href="#">Self-Drive</a>
      <a href="#">With Driver</a>
      <a href="#">Corporate</a>
      <a href="#">Airport Transfer</a>
    </div>

    <div class="footer-col">
      <h5>Contact</h5>
      <a href="#">Thamel, Kathmandu</a>
      <a href="tel:+97715000000">+977 1-5000000</a>
      <a href="mailto:info@drivektm.com">info@drivektm.com</a>
      <a href="#">24/7 Support</a>
    </div>
  </div>

  <div class="footer-bottom">
    <p>© 2025 DriveKTM. All rights reserved.</p>
    <p>Privacy Policy · Terms of Service</p>
  </div>
</footer>

<script>
  // Nav darkens on scroll
  window.addEventListener('scroll', () => {
    document.querySelector('nav').style.background =
      window.scrollY > 80 ? 'rgba(10,10,10,0.97)' : 'rgba(10,10,10,0.85)';
  });

  // Scroll reveal animation
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.style.opacity = '1';
        entry.target.style.transform = 'translateY(0)';
      }
    });
  }, { threshold: 0.1 });

  document.querySelectorAll('.contact-card, .form-panel, .info-panel, .location-box').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(28px)';
    el.style.transition = 'opacity 0.65s ease, transform 0.65s ease';
    observer.observe(el);
  });
  const driveKtmLocation = [27.7154, 85.3123]; // Thamel, Kathmandu approx

  const map = L.map('driveKtmMap').setView(driveKtmLocation, 14);

  L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: '&copy; OpenStreetMap contributors'
  }).addTo(map);

  L.marker(driveKtmLocation).addTo(map)
    .bindPopup("<b>DriveKTM</b><br>Thamel, Kathmandu<br>Premium Vehicle Rental")
    .openPopup();
</script>

</body>
</html>