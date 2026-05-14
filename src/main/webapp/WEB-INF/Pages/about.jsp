<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>About Us — DriveKTM</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">

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

/* ── COMMON BUTTONS ── */
.btn-gold {
  display: inline-block;
  padding: 14px 30px;
  background: linear-gradient(135deg, var(--gold) 0%, var(--gold-light) 100%);
  color: var(--dark);
  border: none;
  font-family: 'DM Sans', sans-serif;
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  text-decoration: none;
  cursor: pointer;
  transition: transform 0.25s, box-shadow 0.25s;
}

.btn-gold:hover {
  transform: translateY(-2px);
  box-shadow: 0 12px 32px rgba(201,169,110,0.35);
}

.btn-dark-outline {
  display: inline-block;
  padding: 13px 28px;
  border: 1px solid rgba(201,169,110,0.55);
  color: var(--gold);
  background: rgba(0,0,0,0.2);
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  text-decoration: none;
  transition: all 0.25s;
}

.btn-dark-outline:hover {
  background: var(--gold);
  color: var(--dark);
}

/* ── HERO ── */
.about-hero {
  min-height: 92vh;
  padding: 160px 80px 90px;
  position: relative;
  overflow: hidden;
  display: flex;
  align-items: center;

  background-image: url("${pageContext.request.contextPath}/images/aboutusBanner.png");
  background-size: cover;
  background-position: center center;
  background-repeat: no-repeat;
}
.about-hero::before {
  display: none;
}
.about-hero-content {
  position: relative;
  z-index: 2;
  max-width: 720px;
  animation: fadeUp 1s ease both;
}

.eyebrow {
  display: inline-flex;
  align-items: center;
  gap: 12px;
  color: var(--gold);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  margin-bottom: 22px;
}

.eyebrow::after {
  content: '';
  width: 42px;
  height: 1px;
  background: var(--gold);
}

.about-hero h1 {
  font-family: 'Cormorant Garamond', serif;
  font-size: clamp(52px, 7vw, 92px);
  font-weight: 300;
  line-height: 1.05;
  color: var(--white);
  margin-bottom: 24px;
}

.about-hero h1 em {
  color: var(--gold);
  font-style: italic;
}

.about-hero p {
  max-width: 560px;
  font-size: 16px;
  line-height: 1.8;
  color: rgba(240,237,232,0.76);
  margin-bottom: 34px;
}

.hero-actions {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
}

@keyframes fadeUp {
  from {
    opacity: 0;
    transform: translateY(35px);
  }

  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* ── STATS ── */
.stats-bar {
  background: var(--dark-3);
  border-top: 1px solid rgba(201,169,110,0.14);
  border-bottom: 1px solid rgba(201,169,110,0.1);
  padding: 30px 80px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.stat {
  text-align: center;
  flex: 1;
}

.stat-icon {
  font-size: 24px;
  color: var(--gold);
  margin-bottom: 8px;
}

.stat-num {
  font-family: 'Cormorant Garamond', serif;
  font-size: 38px;
  font-weight: 600;
  color: var(--gold);
  line-height: 1;
}

.stat-label {
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--text-faint);
  margin-top: 8px;
}

.stat-divider {
  width: 1px;
  height: 58px;
  background: rgba(201,169,110,0.18);
}

/* ── SECTIONS ── */
section {
  padding: 100px 80px;
}

.section-label {
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--gold);
  margin-bottom: 12px;
  display: flex;
  align-items: center;
  gap: 12px;
}

.section-label::before {
  content: '';
  display: block;
  width: 30px;
  height: 1px;
  background: var(--gold);
}

.section-title {
  font-family: 'Cormorant Garamond', serif;
  font-size: clamp(36px, 4vw, 56px);
  font-weight: 300;
  line-height: 1.15;
  color: var(--white);
}

.section-title em {
  color: var(--gold);
  font-style: italic;
}

/* ── WHO WE ARE ── */
.who-section {
  background: var(--dark);
  position: relative;
}

.who-grid {
  display: grid;
  grid-template-columns: 1fr 1.1fr;
  gap: 70px;
  align-items: center;
}

.who-text p {
  font-size: 15px;
  line-height: 1.85;
  color: var(--text-muted);
  margin-top: 22px;
  max-width: 590px;
}

.who-image-card {
  border: 1px solid rgba(201,169,110,0.35);
  background: linear-gradient(135deg, rgba(201,169,110,0.12), rgba(255,255,255,0.02));
  padding: 12px;
  position: relative;
  overflow: hidden;
}

.who-image-card::after {
  content: '';
  position: absolute;
  inset: 12px;
  border: 1px solid rgba(255,255,255,0.05);
  pointer-events: none;
}

.who-image {
  min-height: 420px;
  background:
    linear-gradient(to bottom, rgba(10,10,10,0.1), rgba(10,10,10,0.72)),
    url("${pageContext.request.contextPath}/images/image5.png");
  background-size: cover;
  background-position: center;
}

.experience-badge {
  position: absolute;
  left: 34px;
  bottom: 34px;
  background: var(--gold);
  color: var(--dark);
  padding: 22px 26px;
  font-family: 'Cormorant Garamond', serif;
}

.experience-badge strong {
  display: block;
  font-size: 44px;
  line-height: 1;
}

.experience-badge span {
  font-size: 14px;
}

/* ── MISSION VISION ── */
.mission-section {
  background: var(--dark-2);
}

.mission-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 26px;
  margin-top: 56px;
}

.mission-card {
  background: var(--dark-3);
  border: 1px solid rgba(201,169,110,0.16);
  padding: 42px;
  position: relative;
  overflow: hidden;
  transition: transform 0.3s, border-color 0.3s;
}

.mission-card:hover {
  transform: translateY(-5px);
  border-color: rgba(201,169,110,0.45);
}

.mission-card::before {
  content: '';
  position: absolute;
  right: -80px;
  top: -80px;
  width: 180px;
  height: 180px;
  background: radial-gradient(circle, rgba(201,169,110,0.16), transparent 70%);
}

.mission-icon {
  width: 64px;
  height: 64px;
  border: 1px solid rgba(201,169,110,0.35);
  background: var(--gold-dim);
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--gold);
  font-size: 30px;
  margin-bottom: 24px;
}

.mission-card small {
  display: block;
  color: var(--gold);
  font-size: 11px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  margin-bottom: 8px;
}

.mission-card h3 {
  font-family: 'Cormorant Garamond', serif;
  font-size: 34px;
  font-weight: 400;
  color: var(--white);
  margin-bottom: 14px;
}

.mission-card p {
  font-size: 14px;
  color: var(--text-muted);
  line-height: 1.75;
}

/* ── WHY CHOOSE ── */
.choose-section {
  background: var(--dark);
}

.choose-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 22px;
  margin-top: 56px;
}

.choose-card {
  background: var(--dark-3);
  border: 1px solid rgba(201,169,110,0.14);
  padding: 34px 26px;
  text-align: center;
  transition: all 0.3s;
}

.choose-card:hover {
  border-color: rgba(201,169,110,0.45);
  transform: translateY(-5px);
  background: rgba(201,169,110,0.045);
}

.choose-icon {
  font-size: 34px;
  color: var(--gold);
  margin-bottom: 18px;
}

.choose-card h4 {
  font-family: 'Cormorant Garamond', serif;
  font-size: 24px;
  font-weight: 400;
  color: var(--white);
  margin-bottom: 12px;
}

.choose-card p {
  font-size: 13px;
  color: var(--text-muted);
  line-height: 1.7;
}

/* ── JOURNEY ── */
.journey-section {
  background: var(--dark-2);
}

.timeline {
  margin-top: 70px;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 32px;
  position: relative;
}

.timeline::before {
  content: '';
  position: absolute;
  top: 34px;
  left: 8%;
  right: 8%;
  height: 1px;
  background: linear-gradient(to right, transparent, var(--gold), var(--gold), transparent);
  opacity: 0.4;
}

.timeline-item {
  text-align: center;
  position: relative;
  z-index: 2;
}

.timeline-icon {
  width: 70px;
  height: 70px;
  margin: 0 auto 20px;
  border-radius: 50%;
  border: 1px solid rgba(201,169,110,0.55);
  background: var(--dark-2);
  color: var(--gold);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 28px;
}

.timeline-year {
  font-family: 'Cormorant Garamond', serif;
  font-size: 28px;
  color: var(--gold);
  font-weight: 600;
  margin-bottom: 6px;
}

.timeline-item h4 {
  font-size: 15px;
  color: var(--white);
  margin-bottom: 10px;
}

.timeline-item p {
  font-size: 13px;
  color: var(--text-muted);
  line-height: 1.65;
}

/* ── CTA ── */
.cta-section {
  padding: 80px;
  background: var(--dark);
}

.cta-box {
  border: 1px solid rgba(201,169,110,0.35);
  background:

    url("${pageContext.request.contextPath}/images/sss.png");
  background-size: cover;
  background-position: center right;
  padding: 52px 58px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 40px;
}

.cta-box h2 {
  font-family: 'Cormorant Garamond', serif;
  font-size: 42px;
  font-weight: 300;
  color: var(--white);
  margin-bottom: 10px;
}

.cta-box p {
  color: var(--text-muted);
  font-size: 15px;
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

/* ── FLOAT CTA ── */
.float-cta {
  position: fixed;
  bottom: 32px;
  right: 32px;
  z-index: 50;
  background: var(--gold);
  color: var(--dark);
  padding: 14px 24px;
  font-family: 'DM Sans', sans-serif;
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  cursor: pointer;
  border: none;
  box-shadow: 0 8px 32px rgba(201,169,110,0.4);
  transition: transform 0.2s, box-shadow 0.2s;
  display: flex;
  align-items: center;
  gap: 8px;
}

.float-cta:hover {
  transform: translateY(-2px);
  box-shadow: 0 12px 40px rgba(201,169,110,0.5);
}

/* ── RESPONSIVE ── */
@media (max-width: 1100px) {
  nav {
    padding: 0 28px;
  }

  .nav-links {
    gap: 22px;
  }

  .about-hero,
  section,
  .cta-section {
    padding-left: 40px;
    padding-right: 40px;
  }

  .stats-bar {
    padding-left: 40px;
    padding-right: 40px;
  }

  .who-grid,
  .mission-grid {
    grid-template-columns: 1fr;
  }

  .choose-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .timeline {
    grid-template-columns: repeat(2, 1fr);
  }

  .timeline::before {
    display: none;
  }

  .footer-top {
    grid-template-columns: 1fr 1fr;
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

  .about-hero {
    padding: 150px 24px 70px;
  }

  section,
  .cta-section {
    padding: 70px 24px;
  }

  .stats-bar {
    flex-direction: column;
    gap: 24px;
  }

  .stat-divider {
    width: 80px;
    height: 1px;
  }

  .choose-grid,
  .timeline,
  .footer-top {
    grid-template-columns: 1fr;
  }

  .cta-box {
    flex-direction: column;
    align-items: flex-start;
    padding: 38px 28px;
  }

  .footer-bottom {
    flex-direction: column;
    gap: 12px;
    align-items: flex-start;
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

<!-- NAVBAR -->
<nav>
  <a href="${pageContext.request.contextPath}/home" class="nav-logo">Drive<span>KTM</span></a>

  <ul class="nav-links">
    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
    <li><a href="${pageContext.request.contextPath}/vehicles">Vehicles</a></li>
    <li><a href="${pageContext.request.contextPath}/book">Book</a></li>
    <li><a href="${pageContext.request.contextPath}/about" class="active">About</a></li>
    <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
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

<!-- HERO -->
<section class="about-hero">
  <div class="about-hero-content">
    <div class="eyebrow">About DriveKTM</div>

    <h1>
      Driven by Trust,<br>
      Inspired by <em>Kathmandu</em>
    </h1>

    <p>
      DriveKTM is a premium vehicle rental service built for people who want to explore Kathmandu Valley with comfort,
      confidence, and freedom. From stylish cars to city-friendly rides, we make every journey smooth, safe, and memorable.
    </p>

    <div class="hero-actions">
      <a href="${pageContext.request.contextPath}/explore" class="btn-gold">Explore Our Fleet</a>
      <a href="${pageContext.request.contextPath}/contact" class="btn-dark-outline">Contact Us</a>
    </div>
  </div>
</section>

<!-- STATS BAR -->
<div class="stats-bar">
  <div class="stat">
    <div class="stat-icon">🚗</div>
    <div class="stat-num">300+</div>
    <div class="stat-label">Vehicles</div>
  </div>

  <div class="stat-divider"></div>

  <div class="stat">
   
    <div class="stat-num">5,000+</div>
    <div class="stat-label">Happy Customers</div>
  </div>

  <div class="stat-divider"></div>

  <div class="stat">
 
    <div class="stat-num">250K+</div>
    <div class="stat-label">Trips Completed</div>
  </div>

  <div class="stat-divider"></div>

  <div class="stat">
 
    <div class="stat-num">24/7</div>
    <div class="stat-label">Support</div>
  </div>

  <div class="stat-divider"></div>

  <div class="stat">
  
    <div class="stat-num">4.9</div>
    <div class="stat-label">Average Rating</div>
  </div>
</div>

<!-- WHO WE ARE -->
<section class="who-section">
  <div class="who-grid">
    <div class="who-text">
      <div class="section-label">Who We Are</div>
      <h2 class="section-title">Premium Rentals for<br><em>Modern Travelers</em></h2>

      <p>
        DriveKTM is a Kathmandu-based vehicle rental platform created to make transportation simple, stylish, and reliable.
        Whether you are a tourist, student, business traveler, or local explorer, we provide vehicles that match your route,
        budget, and comfort needs.
      </p>

      <p>
        Our service focuses on transparent pricing, well-maintained vehicles, easy booking, and dependable support.
        We understand the roads, traffic, culture, and travel needs of Kathmandu Valley, so we help you travel with complete peace of mind.
      </p>
    </div>

    <div class="who-image-card">
      <div class="who-image"></div>
      <div class="experience-badge">
        <strong>12+</strong>
        <span>Years of Excellence</span>
      </div>
    </div>
  </div>
</section>

<!-- MISSION AND VISION -->
<section class="mission-section">
  <div class="section-label">Our Purpose</div>
  <h2 class="section-title">Mission and <em>Vision</em></h2>

  <div class="mission-grid">
    <div class="mission-card">
      <div class="mission-icon">🎯</div>
      <small>Our Mission</small>
      <h3>Our Mission</h3>
      <p>
        To make travel in Kathmandu easy, safe, and premium by offering quality vehicles, transparent pricing,
        quick booking, and friendly customer service.
      </p>
    </div>

    <div class="mission-card">
      <div class="mission-icon">👁️</div>
      <small>Our Vision</small>
      <h3>Our Vision</h3>
      <p>
        To become Nepal’s most trusted mobility brand by setting a higher standard for smart, reliable,
        and customer-focused vehicle rental services.
      </p>
    </div>
  </div>
</section>

<!-- WHY CHOOSE US -->
<section class="choose-section">
  <div class="section-label">Why Choose Us</div>
  <h2 class="section-title">The Better Way to<br><em>Explore Kathmandu</em></h2>

  <div class="choose-grid">
    <div class="choose-card">
      <div class="choose-icon">🚙</div>
      <h4>Wide Fleet Selection</h4>
      <p>
        Choose from cars, SUVs, bikes, scooters, and bicycles for different travel needs and occasions.
      </p>
    </div>

    <div class="choose-card">
      <div class="choose-icon">🏷️</div>
      <h4>Transparent Pricing</h4>
      <p>
        No hidden charges or confusing costs. What you see is what you pay.
      </p>
    </div>

    <div class="choose-card">
      <div class="choose-icon">🛡️</div>
      <h4>Safe and Insured</h4>
      <p>
        Our vehicles are regularly checked and maintained for a safer rental experience.
      </p>
    </div>

    <div class="choose-card">
      <div class="choose-icon">📍</div>
      <h4>Doorstep Delivery</h4>
      <p>
        Get your selected vehicle delivered to your preferred location inside Kathmandu Valley.
      </p>
    </div>
  </div>
</section>

<!-- JOURNEY -->
<section class="journey-section">
  <div class="section-label">Our Journey</div>
  <h2 class="section-title">Growing with<br><em>Kathmandu Valley</em></h2>

  <div class="timeline">
    <div class="timeline-item">
      <div class="timeline-icon">🚩</div>
      <div class="timeline-year">2013</div>
      <h4>Founded</h4>
      <p>
        DriveKTM started with a simple goal: reliable and premium vehicle rental in Kathmandu.
      </p>
    </div>

    <div class="timeline-item">
      <div class="timeline-icon">🚗</div>
      <div class="timeline-year">2018</div>
      <h4>Expanded Fleet</h4>
      <p>
        We added more vehicle categories to serve tourists, locals, and daily travelers.
      </p>
    </div>

    <div class="timeline-item">
      <div class="timeline-icon">🎧</div>
      <div class="timeline-year">2022</div>
      <h4>24/7 Support</h4>
      <p>
        Round-the-clock support was introduced to make every journey more dependable.
      </p>
    </div>

    <div class="timeline-item">
      <div class="timeline-icon">🏔️</div>
      <div class="timeline-year">2026</div>
      <h4>Trusted Across KTM</h4>
      <p>
        DriveKTM became a trusted mobility partner for thousands of happy customers.
      </p>
    </div>
  </div>
</section>

<!-- CTA -->
<section class="cta-section">
  <div class="cta-box">
    <div>
      <h2>Ready to ride with DriveKTM?</h2>
    </div>

    <a href="${pageContext.request.contextPath}/book" class="btn-gold">Book Your Ride</a>
  </div>
</section>

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
    <p>© 2026 DriveKTM. All rights reserved.</p>
    <p>Privacy Policy · Terms of Service</p>
  </div>
</footer>

<button class="float-cta" onclick="location.href='${pageContext.request.contextPath}/contact'">
  📞 Call Us Now
</button>

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

  document.querySelectorAll('.stat, .mission-card, .choose-card, .timeline-item, .who-text, .who-image-card').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(26px)';
    el.style.transition = 'opacity 0.65s ease, transform 0.65s ease';
    observer.observe(el);
  });
</script>

</body>
</html>