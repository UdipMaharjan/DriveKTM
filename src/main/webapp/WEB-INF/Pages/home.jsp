<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DriveKTM — Premium Car Rental Kathmandu</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
    --text-muted: #888880;
    --text-faint: #555550;
    --white: #FDFCFA;
  }

  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
  html { scroll-behavior: smooth; }

  body {
    font-family: 'DM Sans', sans-serif;
    background: var(--dark);
    color: var(--text);
    overflow-x: hidden;
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
  /* ── HERO VIDEO ── */
  .hero {
    position: relative; width: 100%; height: 100vh;
    min-height: 700px; overflow: hidden;
    display: flex; align-items: center; justify-content: flex-start;;
    padding-top: 72px;
  }

  .hero-video {
    position: absolute; inset: 0;
    width: 100%; height: 100%; object-fit: cover;
    z-index: 0;
  }

  .hero-overlay {
    position: absolute; inset: 0; z-index: 1;
    background:
      linear-gradient(to bottom, rgba(10,10,10,0.5) 0%, rgba(10,10,10,0.3) 50%, rgba(10,10,10,0.75) 100%),
      linear-gradient(to right, rgba(10,10,10,0.6) 0%, transparent 60%);
  }

  .hero-content {
    position: relative; z-index: 2;
    text-align: left; padding: 0 80px;
    max-width: 800px;
    animation: heroIn 1.2s cubic-bezier(0.16,1,0.3,1) both;
  }

  @keyframes heroIn {
    from { opacity: 0; transform: translateY(40px); }
    to   { opacity: 1; transform: translateY(0); }
  }

  .hero-eyebrow {
    display: inline-flex; align-items: center; gap: 12px;
    margin-bottom: 20px;
  }
  .hero-eyebrow span {
    font-size: 11px; font-weight: 500; letter-spacing: 0.2em;
    text-transform: uppercase; color: var(--gold);
  }
  .hero-eyebrow::before,
  .hero-eyebrow::after {
    content: ''; display: block; width: 40px; height: 1px; background: var(--gold);
  }

  .hero h1 {
    font-family: 'Cormorant Garamond', serif;
    font-size: clamp(52px, 7vw, 96px);
    font-weight: 300; line-height: 1.05;
    color: var(--white); margin-bottom: 16px;
  }
  .hero h1 em { font-style: italic; color: var(--gold); }

  .hero-sub {
    font-size: 16px; font-weight: 300;
    color: rgba(240,237,232,0.75); line-height: 1.7;
    max-width: 520px; 
  }

  .scroll-hint {
    position: absolute; bottom: 32px; left: 50%;
    transform: translateX(-50%); z-index: 3;
    display: flex; flex-direction: column; align-items: center; gap: 8px;
    color: var(--text-faint); font-size: 10px;
    letter-spacing: 0.15em; text-transform: uppercase;
    animation: bounceDown 2s ease-in-out infinite;
  }
  .scroll-hint::after {
    content: ''; width: 1px; height: 40px;
    background: linear-gradient(to bottom, var(--gold), transparent);
  }
  @keyframes bounceDown {
    0%, 100% { transform: translateX(-50%) translateY(0); }
    50%       { transform: translateX(-50%) translateY(6px); }
  }

  /* ── BOOKING BAR (below hero) ── */
  .booking-bar {
    background: var(--dark-2);
    border-top: 2px solid var(--gold);
    border-bottom: 1px solid rgba(201,169,110,0.15);
    padding: 40px 80px;
    box-shadow: 0 8px 48px rgba(0,0,0,0.5);
  }

  .booking-bar-title {
    font-family: 'Cormorant Garamond', serif;
    font-size: 13px; font-weight: 400;
    letter-spacing: 0.2em; text-transform: uppercase;
    color: var(--gold); margin-bottom: 20px;
    display: flex; align-items: center; gap: 12px;
  }
  .booking-bar-title::before {
    content: ''; display: block; width: 24px; height: 1px; background: var(--gold);
  }

  .booking-bar-form {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr 1fr 1fr auto;
    gap: 14px; align-items: end;
  }

  .form-group { display: flex; flex-direction: column; gap: 6px; }
  .form-group label {
    font-size: 10px; font-weight: 500; letter-spacing: 0.15em;
    text-transform: uppercase; color: var(--text-faint);
  }
  .form-group select,
  .form-group input[type="date"] {
    background: rgba(255,255,255,0.04);
    border: 1px solid rgba(201,169,110,0.2);
    color: var(--text);
    font-family: 'DM Sans', sans-serif;
    font-size: 13px; padding: 12px 14px;
    outline: none; transition: border-color 0.2s;
    appearance: none; width: 100%;
    color-scheme: dark;
  }
  .form-group select:focus,
  .form-group input[type="date"]:focus { border-color: var(--gold); }
  .form-group select option { background: #1a1a1a; }

  .btn-gold {
    padding: 13px 32px;
    background: linear-gradient(135deg, var(--gold) 0%, var(--gold-light) 100%);
    color: var(--dark); border: none;
    font-family: 'DM Sans', sans-serif;
    font-size: 12px; font-weight: 600; letter-spacing: 0.12em;
    text-transform: uppercase; cursor: pointer;
    transition: all 0.3s; white-space: nowrap;
    position: relative; overflow: hidden;
  }
  .btn-gold::after {
    content: ''; position: absolute; inset: 0;
    background: linear-gradient(135deg, var(--gold-light) 0%, var(--gold) 100%);
    opacity: 0; transition: opacity 0.3s;
  }
  .btn-gold:hover::after { opacity: 1; }
  .btn-gold span { position: relative; z-index: 1; }

  /* ── STATS BAR ── */
  .stats-bar {
    background: var(--dark-3);
    border-bottom: 1px solid rgba(201,169,110,0.1);
    padding: 24px 80px;
    display: flex; justify-content: space-between; align-items: center;
  }
  .stat { text-align: center; }
  .stat-num {
    font-family: 'Cormorant Garamond', serif;
    font-size: 36px; font-weight: 600; color: var(--gold); line-height: 1;
  }
  .stat-label {
    font-size: 11px; font-weight: 500; letter-spacing: 0.12em;
    text-transform: uppercase; color: var(--text-faint); margin-top: 4px;
  }
  .stat-divider { width: 1px; height: 40px; background: rgba(201,169,110,0.15); }

  /* ── SECTIONS ── */
  section { padding: 100px 80px; }

  .section-label {
    font-size: 11px; font-weight: 500; letter-spacing: 0.2em;
    text-transform: uppercase; color: var(--gold); margin-bottom: 12px;
    display: flex; align-items: center; gap: 12px;
  }
  .section-label::before { content: ''; display: block; width: 30px; height: 1px; background: var(--gold); }
  .section-title {
    font-family: 'Cormorant Garamond', serif;
    font-size: clamp(36px, 4vw, 54px); font-weight: 300; line-height: 1.15; color: var(--white);
  }
  .section-title em { font-style: italic; color: var(--gold); }

  /* ── VEHICLES ── */
  #vehicles { background: var(--dark-2); }
  .section-header {
    display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 60px;
  }
  .vehicles-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 2px; }
  .vehicle-card {
    position: relative; overflow: hidden; cursor: pointer;
    background: var(--dark-3); border: 1px solid rgba(201,169,110,0.08);
    transition: border-color 0.3s, transform 0.3s;
  }
  .vehicle-card:hover {
    border-color: rgba(201,169,110,0.4); transform: translateY(-4px);
    z-index: 2; box-shadow: 0 20px 60px rgba(0,0,0,0.4);
  }
  .vehicle-img {
    width: 100%; aspect-ratio: 4/3; object-fit: cover; display: block;
    background: linear-gradient(135deg, #1a1208, #0d0d0d);
    position: relative; overflow: hidden;
  }
  .car-icon { width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; padding: 24px; }
  .vehicle-body { padding: 20px 20px 24px; }
  .vehicle-tag { font-size: 10px; font-weight: 500; letter-spacing: 0.15em; text-transform: uppercase; color: var(--gold); margin-bottom: 8px; }
  .vehicle-name { font-family: 'Cormorant Garamond', serif; font-size: 22px; font-weight: 400; color: var(--white); margin-bottom: 4px; }
  .vehicle-price { font-size: 13px; color: var(--text-muted); margin-bottom: 16px; }
  .vehicle-price strong { color: var(--gold); font-size: 18px; }
  .vehicle-specs { display: flex; gap: 12px; margin-bottom: 20px; }
  .spec { font-size: 11px; color: var(--text-faint); display: flex; align-items: center; gap: 4px; }
  .btn-sm {
    padding: 10px 20px; background: transparent;
    border: 1px solid rgba(201,169,110,0.4); color: var(--gold);
    font-family: 'DM Sans', sans-serif; font-size: 11px; font-weight: 500;
    letter-spacing: 0.1em; text-transform: uppercase; cursor: pointer; transition: all 0.25s;
  }
  .btn-sm:hover { background: var(--gold); color: var(--dark); }

  /* ── PROCESS ── */
  #process { background: var(--dark-3); }
  .process-steps { display: grid; grid-template-columns: repeat(4, 1fr); gap: 0; margin-top: 60px; position: relative; }
  .process-steps::before {
    content: ''; position: absolute; top: 36px; left: 10%; right: 10%;
    height: 1px; background: linear-gradient(to right, transparent, var(--gold), var(--gold), transparent); opacity: 0.3;
  }
  .step { text-align: center; padding: 0 24px; }
  .step-num {
    width: 72px; height: 72px; margin: 0 auto 24px;
    background: var(--dark-2); border: 1px solid rgba(201,169,110,0.3);
    display: flex; align-items: center; justify-content: center;
    font-family: 'Cormorant Garamond', serif; font-size: 28px; font-weight: 400; color: var(--gold);
    position: relative; z-index: 1;
  }
  .step h4 { font-family: 'Cormorant Garamond', serif; font-size: 20px; font-weight: 400; color: var(--white); margin-bottom: 10px; }
  .step p { font-size: 13px; color: var(--text-faint); line-height: 1.6; }

  /* ── WHY US ── */
  #why { background: var(--dark); position: relative; overflow: hidden; }
  #why::before {
    content: ''; position: absolute; top: 0; right: 0; width: 600px; height: 600px;
    background: radial-gradient(circle, rgba(201,169,110,0.06) 0%, transparent 70%); pointer-events: none;
  }
  .why-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 80px; align-items: center; margin-top: 60px; }
  .features-list { display: flex; flex-direction: column; gap: 32px; }
  .feature {
    display: flex; gap: 20px; padding: 28px; background: var(--dark-3);
    border: 1px solid rgba(201,169,110,0.08); transition: border-color 0.3s, background 0.3s;
  }
  .feature:hover { border-color: rgba(201,169,110,0.25); background: rgba(201,169,110,0.04); }
  .feature-icon {
    width: 48px; height: 48px; flex-shrink: 0;
    background: var(--gold-dim); border: 1px solid rgba(201,169,110,0.2);
    display: flex; align-items: center; justify-content: center; font-size: 20px;
  }
  .feature-body h4 { font-family: 'Cormorant Garamond', serif; font-size: 20px; font-weight: 400; color: var(--white); margin-bottom: 6px; }
  .feature-body p { font-size: 13px; color: var(--text-muted); line-height: 1.6; }
  .why-visual { position: relative; }
  .why-img-wrap { position: relative; aspect-ratio: 4/5; overflow: hidden; }
  .why-img-bg { width: 100%; height: 100%; background: linear-gradient(135deg, #1a1208 0%, #111 60%, #1a1a1a 100%); display: flex; align-items: center; justify-content: center; }
  .why-badge {
    position: absolute; bottom: -20px; left: -20px;
    background: var(--gold); color: var(--dark); padding: 24px 28px;
    font-family: 'Cormorant Garamond', serif;
  }
  .why-badge .big { font-size: 42px; font-weight: 600; line-height: 1; display: block; }
  .why-badge .sm { font-size: 13px; font-weight: 400; }

  /* ── TESTIMONIALS ── */
  #testimonials { background: var(--dark-2); }
  .testimonials-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; margin-top: 60px; }
  .testimonial {
    background: var(--dark-3); border: 1px solid rgba(201,169,110,0.1);
    padding: 36px; position: relative; transition: border-color 0.3s, transform 0.3s;
  }
  .testimonial:hover { border-color: rgba(201,169,110,0.3); transform: translateY(-4px); }
  .testimonial::before {
    content: '"'; font-family: 'Cormorant Garamond', serif; font-size: 80px; line-height: 0.8;
    color: rgba(201,169,110,0.2); position: absolute; top: 24px; right: 28px;
  }
  .stars { color: var(--gold); font-size: 13px; margin-bottom: 16px; }
  .testimonial p { font-size: 14px; line-height: 1.75; color: var(--text-muted); margin-bottom: 28px; }
  .reviewer { display: flex; align-items: center; gap: 14px; border-top: 1px solid rgba(201,169,110,0.1); padding-top: 20px; }
  .reviewer-avatar {
    width: 44px; height: 44px; border-radius: 50%;
    background: linear-gradient(135deg, var(--gold-dim), rgba(201,169,110,0.1));
    border: 1px solid rgba(201,169,110,0.3);
    display: flex; align-items: center; justify-content: center;
    font-family: 'Cormorant Garamond', serif; font-size: 16px; color: var(--gold); font-weight: 600;
  }
  .reviewer-name { font-size: 14px; font-weight: 500; color: var(--white); }
  .reviewer-tag { font-size: 11px; color: var(--text-faint); letter-spacing: 0.05em; }

  /* ── FOOTER ── */
  footer { background: var(--dark); border-top: 1px solid rgba(201,169,110,0.1); padding: 60px 80px 32px; }
  .footer-top { display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 60px; margin-bottom: 48px; }
  .footer-brand .nav-logo { display: inline-block; margin-bottom: 16px; font-size: 26px; }
  .footer-brand p { font-size: 13px; color: var(--text-faint); line-height: 1.7; max-width: 280px; }
  .footer-col h5 { font-size: 11px; font-weight: 500; letter-spacing: 0.15em; text-transform: uppercase; color: var(--gold); margin-bottom: 20px; }
  .footer-col a { display: block; font-size: 13px; color: var(--text-faint); text-decoration: none; margin-bottom: 12px; transition: color 0.2s; }
  .footer-col a:hover { color: var(--text); }
  .footer-bottom { border-top: 1px solid rgba(255,255,255,0.05); padding-top: 24px; display: flex; justify-content: space-between; align-items: center; }
  .footer-bottom p { font-size: 12px; color: var(--text-faint); }

  .float-cta {
    position: fixed; bottom: 32px; right: 32px; z-index: 50;
    background: var(--gold); color: var(--dark);
    padding: 14px 24px; font-family: 'DM Sans', sans-serif;
    font-size: 12px; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase;
    cursor: pointer; border: none; box-shadow: 0 8px 32px rgba(201,169,110,0.4);
    transition: transform 0.2s, box-shadow 0.2s; display: flex; align-items: center; gap: 8px;
  }
  .float-cta:hover { transform: translateY(-2px); box-shadow: 0 12px 40px rgba(201,169,110,0.5); }

  .btn-text {
    font-size: 13px; font-weight: 500; letter-spacing: 0.1em; text-transform: uppercase;
    color: var(--gold); background: none; border: none; cursor: pointer;
    display: flex; align-items: center; gap: 8px; transition: gap 0.2s;
  }
  .btn-text:hover { gap: 14px; }
  .btn-text::after { content: '→'; }
</style>
</head>
<body>

<!-- NAVBAR -->
<nav>
    <a href="${pageContext.request.contextPath}/home" class="nav-logo">Drive<span>KTM</span></a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/home" class="active">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/vehicles">Vehicles</a></li>
        <li><a href="${pageContext.request.contextPath}/book">Book</a></li>
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

<!-- ══════════════════════════════════════════
     HERO — full-height video banner
     Video file: videos/vid1.mp4
════════════════════════════════════════════ -->
<section class="hero">

  <video autoplay muted loop playsinline class="hero-video">
    <source src="${pageContext.request.contextPath}/videos/Newone.mp4" type="video/mp4">
  </video>

  <div class="hero-overlay"></div>

  <div class="hero-content">
    <div class="hero-eyebrow"><span>Premium Car Rental · Nepal</span></div>
    <h1>Explore<br>Kathmandu<br><em>with Ease</em></h1>
    <p class="hero-sub">Discover the ancient temples, vibrant streets, and mountain vistas of Nepal in comfort. Handpicked fleet, transparent pricing, zero hassle.</p>
  </div>

  <div class="scroll-hint">Scroll</div>
</section>

<!-- ══════════════════════════════════════════
     BOOKING BAR — full-width, below the hero
════════════════════════════════════════════ -->
<div class="booking-bar">
  <div class="booking-bar-title">Book Your Ride</div>
  <form action="search.jsp" method="get" class="booking-bar-form">
    <div class="form-group">
      <label for="vehicle">Vehicle Type</label>
      <select id="vehicle" name="vehicle">
        <option value="">Select Vehicle</option>
        <option value="suv">SUV / 4×4</option>
        <option value="sedan">Sedan</option>
        <option value="bike">Motorcycle</option>
        <option value="scooter">Scooter</option>
      </select>
    </div>
    <div class="form-group">
      <label for="pickup">Pick-Up Location</label>
      <select id="pickup" name="pickup">
        <option value="">Select Location</option>
        <option value="airport">Tribhuvan Airport</option>
        <option value="thamel">Thamel, Kathmandu</option>
        <option value="patan">Patan Durbar Square</option>
        <option value="bhaktapur">Bhaktapur</option>
      </select>
    </div>
    <div class="form-group">
      <label for="dropoff">Drop-Off Location</label>
      <select id="dropoff" name="dropoff">
        <option value="">Select Location</option>
        <option value="airport">Tribhuvan Airport</option>
        <option value="thamel">Thamel, Kathmandu</option>
        <option value="patan">Patan Durbar Square</option>
        <option value="bhaktapur">Bhaktapur</option>
      </select>
    </div>
    <div class="form-group">
      <label for="pickupDate">Pick-Up Date</label>
      <input type="date" id="pickupDate" name="pickupDate">
    </div>
    <div class="form-group">
      <label for="dropoffDate">Drop-Off Date</label>
      <input type="date" id="dropoffDate" name="dropoffDate">
    </div>
    <div>
      <button type="submit" class="btn-gold">
        <span>Search Vehicles</span>
      </button>
    </div>
  </form>
</div>

<!-- STATS BAR -->
<div class="stats-bar">
  <div class="stat">
    <div class="stat-num">300+</div>
    <div class="stat-label">Vehicles Available</div>
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
    <div class="stat-num">4.9★</div>
    <div class="stat-label">Average Rating</div>
  </div>
</div>

<!-- VEHICLES -->
<section id="vehicles">
  <div class="section-header">
    <div>
      <div class="section-label">Our Fleet</div>
      <h2 class="section-title">Popular <em>Vehicles</em></h2>
    </div>
    <button class="btn-text">View All Fleet</button>
  </div>
  <div class="vehicles-grid">

    <div class="vehicle-card">
   <div class="vehicle-img">
     <img src="${pageContext.request.contextPath}/images/ToyotaFortuner.png" 
       alt="Fortuner" 
       style="width:100%; height:100%; object-fit:cover; display:block;">
      </div>
      <div class="vehicle-body">
        <div class="vehicle-tag">Premium SUV</div>
        <div class="vehicle-name">Toyota Fortuner</div>
        <div class="vehicle-price">From <strong>Rs. 4,500</strong> / day</div>
        <div class="vehicle-specs">
          <span class="spec">⛽ Diesel</span>
          <span class="spec">👥 7 Seats</span>
          <span class="spec">❄️ AC</span>
        </div>
        <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=ToyotaFortuner'">Book Now</button>
      </div>
    </div>

    <div class="vehicle-card">
   <div class="vehicle-img">
     <img src="${pageContext.request.contextPath}/images/ToyotaCamry.png" 
       alt="Fortuner" 
       style="width:100%; height:100%; object-fit:cover; display:block;">
      </div>
      <div class="vehicle-body">
        <div class="vehicle-tag">Executive Sedan</div>
        <div class="vehicle-name">Toyota Camry</div>
        <div class="vehicle-price">From <strong>Rs. 3,200</strong> / day</div>
        <div class="vehicle-specs">
          <span class="spec">⚡ Hybrid</span>
          <span class="spec">👥 5 Seats</span>
          <span class="spec">❄️ AC</span>
        </div>
        <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Toyota%20Camry'">Book Now</button>
      </div>
    </div>

    <div class="vehicle-card">
   <div class="vehicle-img">
     <img src="${pageContext.request.contextPath}/images/Himalayan.png" 
       alt="Fortuner" 
       style="width:100%; height:100%; object-fit:cover; display:block;">
      </div>
      <div class="vehicle-body">
        <div class="vehicle-tag">Adventure Bike</div>
        <div class="vehicle-name">RE Himalayan</div>
        <div class="vehicle-price">From <strong>Rs. 1,800</strong> / day</div>
        <div class="vehicle-specs">
          <span class="spec">⛽ Petrol</span>
          <span class="spec">👤 2 Seats</span>
          <span class="spec">🏔️ Off-road</span>
        </div>
        <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=RE%20Himalayan'">Book Now</button>
      </div>
    </div>

    <div class="vehicle-card">
   <div class="vehicle-img">
     <img src="${pageContext.request.contextPath}/images/HondaActiva.png" 
       alt="Fortuner" 
       style="width:100%; height:100%; object-fit:cover; display:block;">
      </div>
      <div class="vehicle-body">
        <div class="vehicle-tag">City Scooter</div>
        <div class="vehicle-name">Honda Activa</div>
        <div class="vehicle-price">From <strong>Rs. 800</strong> / day</div>
        <div class="vehicle-specs">
          <span class="spec">⛽ Petrol</span>
          <span class="spec">👤 2 Seats</span>
          <span class="spec">🏙️ City</span>
        </div>
        <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Honda%20Activa'">Book Now</button>
      </div>
    </div>

  </div>
</section>

<!-- HOW IT WORKS -->
<section id="process">
  <div class="section-label">Simple Process</div>
  <h2 class="section-title">On the Road in<br><em>4 Easy Steps</em></h2>
  <div class="process-steps">
    <div class="step">
      <div class="step-num">01</div>
      <h4>Choose Vehicle</h4>
      <p>Browse our curated fleet and select the perfect vehicle for your journey.</p>
    </div>
    <div class="step">
      <div class="step-num">02</div>
      <h4>Set Your Dates</h4>
      <p>Pick your rental duration — hourly, daily, or long-term rates available.</p>
    </div>
    <div class="step">
      <div class="step-num">03</div>
      <h4>Confirm Booking</h4>
      <p>Secure checkout with instant confirmation and flexible cancellation policy.</p>
    </div>
    <div class="step">
      <div class="step-num">04</div>
      <h4>Hit the Road</h4>
      <p>Pick up at your location or have the vehicle delivered to your doorstep.</p>
    </div>
  </div>
</section>

<!-- WHY US -->
<section id="why">
  <div class="section-label">Why DriveKTM</div>
  <h2 class="section-title">The Finest Way<br>to <em>Explore Nepal</em></h2>
  <div class="why-grid">
    <div class="features-list">
      <div class="feature">
        <div class="feature-icon">🚗</div>
        <div class="feature-body">
          <h4>Wide Range of Vehicles</h4>
          <p>From rugged mountain 4×4s to nimble city scooters — over 300 meticulously maintained vehicles at your disposal.</p>
        </div>
      </div>
      <div class="feature">
        <div class="feature-icon">💎</div>
        <div class="feature-body">
          <h4>Transparent Pricing</h4>
          <p>No hidden fees. No surprises. What you see is what you pay — with competitive rates and no security deposit hassles.</p>
        </div>
      </div>
      <div class="feature">
        <div class="feature-icon">🛡️</div>
        <div class="feature-body">
          <h4>Full Insurance Cover</h4>
          <p>Every rental includes comprehensive insurance and 24/7 roadside assistance across Nepal.</p>
        </div>
      </div>
      <div class="feature">
        <div class="feature-icon">📍</div>
        <div class="feature-body">
          <h4>Doorstep Delivery</h4>
          <p>We deliver the vehicle to your hotel, airport, or any location in the Kathmandu Valley.</p>
        </div>
      </div>
    </div>
    <div class="why-visual">
      <div class="why-img-wrap">
        <div class="why-img-bg">
          <svg viewBox="0 0 400 500" xmlns="http://www.w3.org/2000/svg" width="100%" height="100%">
            <defs>
              <radialGradient id="carGlow" cx="50%" cy="60%" r="50%">
                <stop offset="0%" stop-color="#C9A96E" stop-opacity="0.2"/>
                <stop offset="100%" stop-color="#C9A96E" stop-opacity="0"/>
              </radialGradient>
            </defs>
            <rect width="400" height="500" fill="#111"/>
            <rect width="400" height="500" fill="url(#carGlow)"/>
            <path d="M0 350 L80 200 L160 300 L220 150 L300 280 L360 180 L400 260 L400 500 L0 500Z" fill="rgba(201,169,110,0.05)"/>
            <path d="M0 380 L100 250 L180 330 L250 200 L320 300 L400 230 L400 500 L0 500Z" fill="rgba(201,169,110,0.04)"/>
            <g transform="translate(60,200)">
              <rect x="0" y="60" width="280" height="55" rx="5" fill="#C9A96E" opacity="0.7"/>
              <path d="M40 60 L70 20 L210 20 L240 60Z" fill="#A07D50" opacity="0.8"/>
              <rect x="73" y="24" width="134" height="34" rx="3" fill="rgba(180,220,255,0.25)"/>
              <circle cx="65" cy="115" r="22" fill="#1a1a1a" stroke="#C9A96E" stroke-width="2"/>
              <circle cx="65" cy="115" r="9" fill="#333"/>
              <circle cx="215" cy="115" r="22" fill="#1a1a1a" stroke="#C9A96E" stroke-width="2"/>
              <circle cx="215" cy="115" r="9" fill="#333"/>
            </g>
            <text x="200" y="450" text-anchor="middle" font-family="Cormorant Garamond" font-size="14" fill="#C9A96E" fill-opacity="0.4" letter-spacing="4">KATHMANDU VALLEY</text>
          </svg>
        </div>
      </div>
      <div class="why-badge">
        <span class="big">12+</span>
        <span class="sm">Years of Excellence</span>
      </div>
    </div>
  </div>
</section>

<!-- TESTIMONIALS -->
<section id="testimonials">
  <div class="section-label">Reviews</div>
  <h2 class="section-title">What Our <em>Travelers Say</em></h2>
  <div class="testimonials-grid">
    <div class="testimonial">
      <div class="stars">★★★★★</div>
      <p>Rented a Fortuner for a week to drive to Pokhara and back. The vehicle was immaculate, the booking process seamless, and the team was incredibly responsive.</p>
      <div class="reviewer">
        <div class="reviewer-avatar">A</div>
        <div>
          <div class="reviewer-name">Anil Sharma</div>
          <div class="reviewer-tag">Kathmandu, Nepal</div>
        </div>
      </div>
    </div>
    <div class="testimonial">
      <div class="stars">★★★★★</div>
      <p>As a solo traveler, I needed something reliable and affordable. The scooter was perfect for exploring the city. Doorstep delivery to my hotel in Thamel was a game changer.</p>
      <div class="reviewer">
        <div class="reviewer-avatar">P</div>
        <div>
          <div class="reviewer-name">Priya Joshi</div>
          <div class="reviewer-tag">Mumbai, India</div>
        </div>
      </div>
    </div>
    <div class="testimonial">
      <div class="stars">★★★★★</div>
      <p>Hired a Royal Enfield for the Annapurna circuit road trip. Best experience ever. The bike was in perfect condition, and DriveKTM's roadside support gave me complete peace of mind.</p>
      <div class="reviewer">
        <div class="reviewer-avatar">R</div>
        <div>
          <div class="reviewer-name">Rahul Thakur</div>
          <div class="reviewer-tag">Delhi, India</div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- FOOTER -->
<footer>
  <div class="footer-top">
    <div class="footer-brand">
      <a href="home.jsp" class="nav-logo">Drive<span>KTM</span></a>
      <p>Nepal's most trusted premium vehicle rental service. Explore the Himalayas on your own terms.</p>
    </div>
    <div class="footer-col">
      <h5>Company</h5>
      <a href="about.jsp">About Us</a>
      <a href="#vehicles">Our Fleet</a>
      <a href="careers.jsp">Careers</a>
      <a href="book.jsp">Book</a>
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

<button class="float-cta" onclick="window.open('https://www.youtube.com/watch?v=dQw4w9WgXcQ', '_blank')">
  📞 Call Us Now
</button>

<script>
  // Nav darkens on scroll
  window.addEventListener('scroll', () => {
    document.querySelector('nav').style.background =
      window.scrollY > 80 ? 'rgba(10,10,10,0.97)' : 'rgba(10,10,10,0.85)';
  });

  // Set min date for date inputs to today
  const today = new Date().toISOString().split('T')[0];
  document.getElementById('pickupDate').min = today;
  document.getElementById('dropoffDate').min = today;
  document.getElementById('pickupDate').addEventListener('change', function() {
    document.getElementById('dropoffDate').min = this.value;
  });

  // Scroll-reveal animation
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.style.opacity = '1';
        entry.target.style.transform = 'translateY(0)';
      }
    });
  }, { threshold: 0.1 });

  document.querySelectorAll('.vehicle-card, .feature, .testimonial, .step').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(24px)';
    el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(el);
  });
</script>
</body>
</html>
