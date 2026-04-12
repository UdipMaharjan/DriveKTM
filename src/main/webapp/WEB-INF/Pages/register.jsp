<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Register — DriveKTM</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    --text-muted: #888880;
    --text-faint: #555550;
    --white: #FDFCFA;
    --error: #e05c5c;
    --success: #6ec98a;
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

  nav {
    position: fixed; top: 0; left: 0; right: 0; z-index: 100;
    display: flex; align-items: center; justify-content: space-between;
    padding: 0 48px; height: 72px;
    background: rgba(10,10,10,0.85);
    backdrop-filter: blur(20px);
    border-bottom: 1px solid rgba(201,169,110,0.12);
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

  .auth-page {
    min-height: 100vh;
    padding: 120px 80px 80px;
    background:
      radial-gradient(circle at top left, rgba(201,169,110,0.08), transparent 28%),
      linear-gradient(180deg, #0a0a0a 0%, #111111 100%);
  }

  .auth-shell {
    display: grid;
    grid-template-columns: 1.15fr minmax(420px, 520px);
    min-height: calc(100vh - 200px);
    background: var(--dark-2);
    border: 1px solid rgba(201,169,110,0.12);
    box-shadow: 0 24px 80px rgba(0,0,0,0.45);
    overflow: hidden;
  }

  .left-panel {
    position: relative;
    overflow: hidden;
    padding: 56px;
    display: flex;
    align-items: flex-end;
    background: linear-gradient(135deg, #0d0b08 0%, #1a1208 50%, #0a0a0a 100%);
    min-height: 720px;
  }
  .left-panel::before {
    content: '';
    position: absolute; inset: 0;
    background:
      radial-gradient(ellipse 70% 60% at 60% 35%, rgba(201,169,110,0.12) 0%, transparent 72%),
      radial-gradient(ellipse 42% 36% at 18% 82%, rgba(201,169,110,0.06) 0%, transparent 62%);
  }
  .left-panel-content {
    position: relative; z-index: 2; width: 100%;
  }
  .left-tagline {
    font-size: 11px; font-weight: 500; letter-spacing: 0.2em;
    text-transform: uppercase; color: var(--gold);
    margin-bottom: 16px; display: flex; align-items: center; gap: 10px;
  }
  .left-tagline::before { content: ''; display: block; width: 28px; height: 1px; background: var(--gold); }
  .left-headline {
    font-family: 'Cormorant Garamond', serif;
    font-size: clamp(38px, 4vw, 58px);
    font-weight: 300; line-height: 1.08;
    color: var(--white); margin-bottom: 18px;
  }
  .left-headline em { font-style: italic; color: var(--gold); }
  .left-desc {
    font-size: 14px; font-weight: 300; color: var(--text-muted);
    line-height: 1.8; max-width: 480px; margin-bottom: 28px;
  }
  .left-image-frame {
    width: min(100%, 560px);
    height: 320px;
    border: 1px solid rgba(201,169,110,0.24);
    background: rgba(255,255,255,0.03);
    display: flex; align-items: center; justify-content: center;
    overflow: hidden;
    margin-bottom: 28px;
    position: relative;
  }
  .left-image-frame::before {
    content: '';
    position: absolute;
    font-size: 12px; letter-spacing: 0.18em; text-transform: uppercase;
    color: rgba(240,237,232,0.45);
  }
  .left-image-frame img {
    width: 100%; height: 100%; object-fit: cover; display: block;
  }
  .left-note {
    font-size: 12px; color: var(--text-faint); line-height: 1.7;
    max-width: 520px;
  }

  .right-panel {
    background: var(--dark-2);
    border-left: 1px solid rgba(201,169,110,0.1);
    display: flex; align-items: center; justify-content: center;
    padding: 56px 48px;
    position: relative; overflow-y: auto;
  }
  .right-panel::before {
    content: ''; position: absolute; top: 0; left: 0; right: 0; height: 3px;
    background: linear-gradient(to right, transparent, var(--gold), transparent);
  }

  .form-container {
    width: 100%;
    animation: slideUp 0.7s cubic-bezier(0.16,1,0.3,1) both;
  }
  @keyframes slideUp {
    from { opacity: 0; transform: translateY(32px); }
    to   { opacity: 1; transform: translateY(0); }
  }

  .form-eyebrow {
    font-size: 10px; font-weight: 500; letter-spacing: 0.2em;
    text-transform: uppercase; color: var(--gold);
    margin-bottom: 12px; display: flex; align-items: center; gap: 10px;
  }
  .form-eyebrow::before { content: ''; display: block; width: 20px; height: 1px; background: var(--gold); }
  .form-title {
    font-family: 'Cormorant Garamond', serif;
    font-size: 40px; font-weight: 300; color: var(--white);
    margin-bottom: 8px; line-height: 1.1;
  }
  .form-title em { font-style: italic; color: var(--gold); }
  .form-subtitle {
    font-size: 13px; color: var(--text-muted); margin-bottom: 36px;
  }
  .form-subtitle a, .login-link a, .register-link a, .forgot-link, .terms-wrap a {
    color: var(--gold); text-decoration: none;
  }
  .form-subtitle a:hover, .login-link a:hover, .register-link a:hover, .forgot-link:hover, .terms-wrap a:hover { text-decoration: underline; }

  .server-error {
    background: rgba(224,92,92,0.08); border: 1px solid rgba(224,92,92,0.3);
    color: var(--error); padding: 12px 16px; font-size: 13px;
    margin-bottom: 24px; display: flex; align-items: center; gap: 8px;
  }
  .server-success {
    background: rgba(110,201,138,0.08); border: 1px solid rgba(110,201,138,0.3);
    color: var(--success); padding: 12px 16px; font-size: 13px;
    margin-bottom: 24px; display: flex; align-items: center; gap: 8px;
  }

  .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
  .form-group { display: flex; flex-direction: column; gap: 7px; margin-bottom: 18px; }
  .form-group label {
    font-size: 10px; font-weight: 500; letter-spacing: 0.15em;
    text-transform: uppercase; color: var(--text-faint);
  }
  .input-wrap { position: relative; display: flex; align-items: center; }
  .input-icon {
    position: absolute; left: 14px; z-index: 1;
    color: var(--text-faint); font-size: 14px; pointer-events: none;
    transition: color 0.2s;
  }
  .input-wrap input, .input-wrap select {
    width: 100%;
    background: rgba(255,255,255,0.04);
    border: 1px solid rgba(201,169,110,0.2);
    color: var(--text);
    font-family: 'DM Sans', sans-serif;
    font-size: 13px; padding: 12px 14px 12px 42px;
    outline: none; transition: border-color 0.2s, background 0.2s;
    appearance: none;
  }
  .input-wrap select option { background: #1a1a1a; }
  .input-wrap input:focus, .input-wrap select:focus { border-color: var(--gold); background: rgba(201,169,110,0.04); }
  .input-wrap.has-error input, .input-wrap.has-error select { border-color: var(--error); }
  .input-error { font-size: 11px; color: var(--error); display: none; margin-top: 2px; }
  .input-wrap.has-error ~ .input-error { display: block; }

  .toggle-pw {
    position: absolute; right: 14px;
    background: none; border: none; cursor: pointer;
    color: var(--text-faint); font-size: 14px; padding: 0;
    transition: color 0.2s; z-index: 2;
  }
  .toggle-pw:hover { color: var(--gold); }

  .checkbox-wrap, .terms-wrap {
    display: flex; align-items: flex-start; gap: 10px;
    margin-bottom: 24px; margin-top: 4px;
  }
  .checkbox-wrap input[type="checkbox"], .terms-wrap input[type="checkbox"] {
    width: 16px; height: 16px; flex-shrink: 0; margin-top: 2px;
    accent-color: var(--gold); cursor: pointer;
  }
  .checkbox-wrap span, .terms-wrap span { font-size: 12px; color: var(--text-muted); line-height: 1.6; }

  .form-options {
    display: flex; justify-content: space-between; align-items: center;
    gap: 14px; margin-bottom: 24px;
  }

  .btn-gold {
    width: 100%; padding: 15px;
    background: linear-gradient(135deg, var(--gold) 0%, var(--gold-light) 100%);
    color: var(--dark); border: none;
    font-family: 'DM Sans', sans-serif; font-size: 13px; font-weight: 600;
    letter-spacing: 0.12em; text-transform: uppercase; cursor: pointer;
    transition: all 0.3s; position: relative; overflow: hidden; margin-bottom: 24px;
  }
  .btn-gold::after {
    content: ''; position: absolute; inset: 0;
    background: linear-gradient(135deg, var(--gold-light) 0%, var(--gold) 100%);
    opacity: 0; transition: opacity 0.3s;
  }
  .btn-gold:hover::after { opacity: 1; }
  .btn-gold span { position: relative; z-index: 1; }
  .btn-gold:disabled { opacity: 0.5; cursor: not-allowed; }

  .divider {
    display: flex; align-items: center; gap: 12px;
    color: var(--text-faint); font-size: 11px; letter-spacing: 0.12em;
    text-transform: uppercase; margin-bottom: 22px;
  }
  .divider::before, .divider::after {
    content: ''; flex: 1; height: 1px; background: rgba(201,169,110,0.14);
  }

  .social-btns { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 20px; }
  .btn-social {
    border: 1px solid rgba(201,169,110,0.16);
    background: rgba(255,255,255,0.03);
    color: var(--text);
    padding: 12px 14px; cursor: pointer;
    display: inline-flex; align-items: center; justify-content: center; gap: 10px;
    font-family: 'DM Sans', sans-serif; font-size: 13px;
  }

  .register-link, .login-link { text-align: center; font-size: 13px; color: var(--text-muted); }
  .step-indicator { display: flex; align-items: center; gap: 8px; margin-bottom: 32px; }
  .step-dot {
    width: 8px; height: 8px; border-radius: 50%;
    background: rgba(201,169,110,0.2);
    border: 1px solid rgba(201,169,110,0.3);
  }
  .step-dot.active { background: var(--gold); border-color: var(--gold); }
  .step-line { flex: 1; height: 1px; background: rgba(201,169,110,0.15); }
  .pw-strength { margin-top: 8px; }
  .pw-strength-bar {
    height: 3px; background: rgba(255,255,255,0.06);
    border-radius: 2px; overflow: hidden; margin-bottom: 4px;
  }
  .pw-strength-fill { height: 100%; width: 0; border-radius: 2px; transition: width 0.3s, background 0.3s; }
  .pw-strength-label { font-size: 10px; color: var(--text-faint); letter-spacing: 0.08em; }

  footer { background: var(--dark); border-top: 1px solid rgba(201,169,110,0.1); padding: 60px 80px 32px; }
  .footer-top { display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 60px; margin-bottom: 48px; }
  .footer-brand .nav-logo { display: inline-block; margin-bottom: 16px; font-size: 26px; }
  .footer-brand p { font-size: 13px; color: var(--text-faint); line-height: 1.7; max-width: 280px; }
  .footer-col h5 { font-size: 11px; font-weight: 500; letter-spacing: 0.15em; text-transform: uppercase; color: var(--gold); margin-bottom: 20px; }
  .footer-col a { display: block; font-size: 13px; color: var(--text-faint); text-decoration: none; margin-bottom: 12px; transition: color 0.2s; }
  .footer-col a:hover { color: var(--text); }
  .footer-bottom { border-top: 1px solid rgba(255,255,255,0.05); padding-top: 24px; display: flex; justify-content: space-between; align-items: center; }
  .footer-bottom p { font-size: 12px; color: var(--text-faint); }

  @media (max-width: 1100px) {
    .auth-page { padding: 110px 24px 60px; }
    .auth-shell { grid-template-columns: 1fr; }
    .left-panel { min-height: 520px; }
  }
  @media (max-width: 768px) {
    nav { padding: 0 20px; }
    .nav-links { display: none; }
    .auth-page { padding: 100px 16px 40px; }
    .left-panel, .right-panel { padding: 32px 22px; }
    .left-image-frame { height: 240px; }
    .form-row, .social-btns, .footer-top { grid-template-columns: 1fr; }
    .form-options, .footer-bottom { flex-direction: column; align-items: flex-start; }
    footer { padding: 44px 20px 28px; }
  }
</style>
</head>
<body>
<nav>
  <a href="${pageContext.request.contextPath}/home" class="nav-logo">Drive<span>KTM</span></a>
  <ul class="nav-links">
    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
    <li><a href="${pageContext.request.contextPath}/vehicles">Vehicles</a></li>
    <li><a href="${pageContext.request.contextPath}/book">Book</a></li>
    <li><a href="${pageContext.request.contextPath}/about">About</a></li>
    <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
  </ul>
  <div>
   <a href="${pageContext.request.contextPath}/login" class="btn-outline">Login</a>
  </div>
</nav>

<main class="auth-page">
  <section class="auth-shell">
    <div class="left-panel">
      <div class="left-panel-content">
        <div class="left-tagline">Join DriveKTM</div>
        <h2 class="left-headline">Start Your Next<br><em>Journey in Nepal</em></h2>
        <p class="left-desc">Create your account to book faster, save your details, and unlock a smoother rental experience with DriveKTM.</p>

        <div class="left-image-frame">
          <img src="${pageContext.request.contextPath}/images/image5.png" alt="DriveKTM register side image">
        </div>

        <p class="left-note"></p>
      </div>
    </div>

    <div class="right-panel">
      <div class="form-container">

    <div class="form-eyebrow">Get Started</div>
    <h1 class="form-title">Create <em>Account</em></h1>
    <p class="form-subtitle">Already have an account? <a href="login.jsp">Sign in</a></p>

    <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm" novalidate>

      <!-- Name row -->
      <div class="form-row">
        <div class="form-group">
          <label for="firstName">First Name</label>
          <div class="input-wrap" id="firstNameWrap">
            <span class="input-icon">👤</span>
            <input type="text" id="firstName" name="firstName"
                   placeholder="Anil"
                   value="${not empty param.firstName ? param.firstName : ''}"
                   required>
          </div>
          <span class="input-error" id="firstNameError">First name is required.</span>
        </div>
        <div class="form-group">
          <label for="lastName">Last Name</label>
          <div class="input-wrap" id="lastNameWrap">
            <span class="input-icon">👤</span>
            <input type="text" id="lastName" name="lastName"
                   placeholder="Sharma"
                   value="${not empty param.lastName ? param.lastName : ''}"
                   required>
          </div>
          <span class="input-error" id="lastNameError">Last name is required.</span>
        </div>
      </div>

      <!-- Email -->
      <div class="form-group">
        <label for="email">Email Address</label>
        <div class="input-wrap" id="emailWrap">
          <span class="input-icon">✉</span>
          <input type="email" id="email" name="email"
                 placeholder="you@example.com"
                 value="${not empty param.email ? param.email : ''}"
                 autocomplete="email" required>
        </div>
        <span class="input-error" id="emailError">Please enter a valid email.</span>
      </div>

      <!-- Phone -->
      <div class="form-group">
        <label for="phone">Phone Number</label>
        <div class="input-wrap" id="phoneWrap">
          <span class="input-icon">📱</span>
          <input type="tel" id="phone" name="phone"
                 placeholder="+977 98XXXXXXXX"
                 value="${not empty param.phone ? param.phone : ''}"
                 autocomplete="tel">
        </div>
        <span class="input-error" id="phoneError">Please enter a valid phone number.</span>
      </div>

      <!-- Password row -->
      <div class="form-row">
        <div class="form-group">
          <label for="password">Password</label>
          <div class="input-wrap" id="passwordWrap" style="position:relative;">
            <span class="input-icon">🔒</span>
            <input type="password" id="password" name="password"
                   placeholder="Min. 8 characters"
                   autocomplete="new-password" required>
            <button type="button" class="toggle-pw" id="togglePw">👁</button>
          </div>
          <div class="pw-strength">
            <div class="pw-strength-bar"><div class="pw-strength-fill" id="strengthFill"></div></div>
            <span class="pw-strength-label" id="strengthLabel"></span>
          </div>
          <span class="input-error" id="passwordError">Password must be at least 8 characters.</span>
        </div>
        <div class="form-group">
          <label for="confirmPassword">Confirm Password</label>
          <div class="input-wrap" id="confirmWrap" style="position:relative;">
            <span class="input-icon">🔒</span>
            <input type="password" id="confirmPassword" name="confirmPassword"
                   placeholder="Re-enter password"
                   autocomplete="new-password" required>
            <button type="button" class="toggle-pw" id="toggleConfirm">👁</button>
          </div>
          <span class="input-error" id="confirmError">Passwords do not match.</span>
        </div>
      </div>

      <!-- License type -->
      <div class="form-group">
        <label for="licenseType">License Type</label>
        <div class="input-wrap">
          <span class="input-icon">🪪</span>
          <select id="licenseType" name="licenseType">
            <option value="">Select License Type</option>
            <option value="A">Category A — Motorcycle</option>
            <option value="B">Category B — Light Vehicle (Car)</option>
            <option value="C">Category C — Heavy Vehicle</option>
            <option value="none">No License (Scooter only)</option>
          </select>
        </div>
      </div>

      <!-- Terms -->
      <div class="terms-wrap">
        <input type="checkbox" id="terms" name="terms" required>
        <span>I agree to the <a href="terms.jsp">Terms of Service</a> and <a href="privacy.jsp">Privacy Policy</a> of DriveKTM.</span>
      </div>
      <span class="input-error" id="termsError" style="margin-top:-12px; margin-bottom:14px; display:none;">You must accept the terms to continue.</span>

      <button type="submit" class="btn-gold" id="submitBtn">
        <span>Create My Account</span>
      </button>

    </form>

    <div class="login-link">
      Already registered? <a href="login.jsp">Sign in to your account</a>
    </div>

  </div>
    </div>
  </section>
</main>

<footer>
  <div class="footer-top">
    <div class="footer-brand">
      <a href="home.jsp" class="nav-logo">Drive<span>KTM</span></a>
      <p>Nepal's most trusted premium vehicle rental service. Explore the Himalayas on your own terms.</p>
    </div>
    <div class="footer-col">
      <h5>Company</h5>
      <a href="about.jsp">About Us</a>
      <a href="home.jsp#vehicles">Our Fleet</a>
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

<script>
  // Password toggle — main
  document.getElementById('togglePw').addEventListener('click', function() {
    const pw = document.getElementById('password');
    pw.type = pw.type === 'password' ? 'text' : 'password';
    this.textContent = pw.type === 'password' ? '👁' : '🙈';
  });

  // Password toggle — confirm
  document.getElementById('toggleConfirm').addEventListener('click', function() {
    const pw = document.getElementById('confirmPassword');
    pw.type = pw.type === 'password' ? 'text' : 'password';
    this.textContent = pw.type === 'password' ? '👁' : '🙈';
  });

  // Password strength meter
  document.getElementById('password').addEventListener('input', function() {
    const val = this.value;
    const fill = document.getElementById('strengthFill');
    const label = document.getElementById('strengthLabel');
    let score = 0;
    if (val.length >= 8) score++;
    if (/[A-Z]/.test(val)) score++;
    if (/[0-9]/.test(val)) score++;
    if (/[^A-Za-z0-9]/.test(val)) score++;

    const levels = [
      { pct: '0%',   color: 'transparent', text: '' },
      { pct: '25%',  color: '#e05c5c',     text: 'Weak' },
      { pct: '50%',  color: '#e09a5c',     text: 'Fair' },
      { pct: '75%',  color: '#c9c96e',     text: 'Good' },
      { pct: '100%', color: '#6ec98a',     text: 'Strong' },
    ];
    const lvl = levels[score];
    fill.style.width = lvl.pct;
    fill.style.background = lvl.color;
    label.textContent = lvl.text;
    label.style.color = lvl.color;
  });

  // Form validation
  document.getElementById('registerForm').addEventListener('submit', function(e) {
    let valid = true;

    function validate(inputId, wrapId, errorId, condition, msg) {
      const wrap = document.getElementById(wrapId);
      const err  = document.getElementById(errorId);
      if (condition) {
        wrap.classList.add('has-error');
        err.style.display = 'block';
        if (msg) err.textContent = msg;
        valid = false;
      } else {
        wrap.classList.remove('has-error');
        err.style.display = 'none';
      }
    }

    const fn = document.getElementById('firstName').value.trim();
    validate('firstName','firstNameWrap','firstNameError', !fn, 'First name is required.');

    const ln = document.getElementById('lastName').value.trim();
    validate('lastName','lastNameWrap','lastNameError', !ln, 'Last name is required.');

    const em = document.getElementById('email').value.trim();
    validate('email','emailWrap','emailError', !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(em), 'Please enter a valid email.');

    const pw = document.getElementById('password').value;
    validate('password','passwordWrap','passwordError', pw.length < 8, 'Password must be at least 8 characters.');

    const cp = document.getElementById('confirmPassword').value;
    validate('confirmPassword','confirmWrap','confirmError', cp !== pw, 'Passwords do not match.');

    const terms = document.getElementById('terms');
    const termsError = document.getElementById('termsError');
    if (!terms.checked) {
      termsError.style.display = 'block';
      valid = false;
    } else {
      termsError.style.display = 'none';
    }

    if (!valid) e.preventDefault();
  });

  // Clear errors on input
  ['firstName','lastName','email','password','confirmPassword'].forEach(id => {
    const el = document.getElementById(id);
    if (el) el.addEventListener('input', function() {
      this.closest('.input-wrap').classList.remove('has-error');
    });
  });
</script>
</body>
</html>
