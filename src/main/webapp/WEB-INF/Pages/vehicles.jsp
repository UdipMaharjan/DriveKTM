<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DriveKTM — Vehicles</title>
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
    --text: #F0EDE8;
    --text-muted: #888880;
    --text-faint: #555550;
    --white: #FDFCFA;
  }

  * { box-sizing: border-box; margin: 0; padding: 0; }
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


  .hero-mini {
    padding: 150px 80px 70px;
    text-align: center;
    background:
      linear-gradient(to bottom, rgba(10,10,10,0.82), rgba(10,10,10,0.95)),
      radial-gradient(circle at top center, rgba(201,169,110,0.08), transparent 45%);
  }

  .hero-label {
    font-size: 11px;
    font-weight: 500;
    letter-spacing: 0.2em;
    text-transform: uppercase;
    color: var(--gold);
    margin-bottom: 14px;
  }

  .hero-title {
    font-family: 'Cormorant Garamond', serif;
    font-size: clamp(42px, 6vw, 76px);
    font-weight: 300;
    color: var(--white);
    line-height: 1.08;
    margin-bottom: 14px;
  }

  .hero-title em {
    color: var(--gold);
    font-style: italic;
  }

  .hero-sub {
    max-width: 700px;
    margin: 0 auto;
    font-size: 16px;
    line-height: 1.8;
    color: rgba(240,237,232,0.76);
  }

  .vehicles-page {
    padding: 40px 80px 100px;
  }

  .category-section {
    margin-bottom: 80px;
  }

  .category-head {
    display: flex;
    align-items: center;
    gap: 18px;
    margin-bottom: 26px;
  }

  .category-head::before,
  .category-head::after {
    content: "";
    flex: 1;
    height: 1px;
    background: rgba(201,169,110,0.22);
  }

  .category-title {
    font-family: 'Cormorant Garamond', serif;
    font-size: clamp(32px, 4vw, 46px);
    font-weight: 400;
    color: var(--gold);
    white-space: nowrap;
  }

  .vehicles-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 24px;
  }

  .vehicle-card {
    background: var(--dark-2);
    border: 1px solid rgba(201,169,110,0.08);
    transition: transform 0.3s, border-color 0.3s, box-shadow 0.3s;
    overflow: hidden;
  }

  .vehicle-card:hover {
    transform: translateY(-6px);
    border-color: rgba(201,169,110,0.3);
    box-shadow: 0 18px 50px rgba(0,0,0,0.35);
  }

  .vehicle-img {
    width: 100%;
    aspect-ratio: 4/3;
    background: linear-gradient(135deg, #1a1208, #0d0d0d);
    overflow: hidden;
  }

  .vehicle-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
  }

  .vehicle-body {
    padding: 18px 18px 22px;
  }

  .vehicle-tag {
    font-size: 10px;
    font-weight: 500;
    letter-spacing: 0.16em;
    text-transform: uppercase;
    color: var(--gold);
    margin-bottom: 8px;
  }

  .vehicle-name {
    font-family: 'Cormorant Garamond', serif;
    font-size: 24px;
    font-weight: 400;
    color: var(--white);
    margin-bottom: 4px;
    line-height: 1.2;
  }

  .vehicle-type {
    font-size: 12px;
    color: var(--text-faint);
    margin-bottom: 14px;
  }

  .vehicle-price {
    font-size: 13px;
    color: var(--text-muted);
    margin-bottom: 16px;
  }

  .vehicle-price strong {
    color: var(--gold);
    font-size: 20px;
    font-weight: 600;
  }

  .vehicle-specs {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-bottom: 18px;
  }

  .spec {
    font-size: 11px;
    color: var(--text-faint);
    display: inline-flex;
    align-items: center;
    gap: 5px;
  }

  .btn-sm {
    width: 100%;
    padding: 11px 18px;
    background: transparent;
    border: 1px solid rgba(201,169,110,0.4);
    color: var(--gold);
    font-family: 'DM Sans', sans-serif;
    font-size: 11px;
    font-weight: 600;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    cursor: pointer;
    transition: all 0.25s;
  }

  .btn-sm:hover {
    background: var(--gold);
    color: var(--dark);
  }

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

  .float-cta {
    position: fixed; bottom: 32px; right: 32px; z-index: 50;
    background: var(--gold); color: var(--dark);
    padding: 14px 24px; font-family: 'DM Sans', sans-serif;
    font-size: 12px; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase;
    cursor: pointer; border: none; box-shadow: 0 8px 32px rgba(201,169,110,0.4);
    transition: transform 0.2s, box-shadow 0.2s;
  }

  .float-cta:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 40px rgba(201,169,110,0.5);
  }

  @media (max-width: 1200px) {
    .vehicles-grid {
      grid-template-columns: repeat(3, 1fr);
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
    .vehicles-page,
    .hero-mini,
    footer {
      padding-left: 20px;
      padding-right: 20px;
    }

    .vehicles-grid {
      grid-template-columns: repeat(2, 1fr);
    }

    .footer-top {
      grid-template-columns: 1fr 1fr;
      gap: 34px;
    }

    .footer-bottom {
      flex-direction: column;
      gap: 10px;
      text-align: center;
    }
  }

  @media (max-width: 600px) {
    .vehicles-grid {
      grid-template-columns: 1fr;
    }

    .footer-top {
      grid-template-columns: 1fr;
    }

    .hero-mini {
      padding-top: 140px;
      padding-bottom: 50px;
    }
  }
</style>
</head>
<body>

<!-- NAVBAR -->
<nav>
    <a href="${pageContext.request.contextPath}/home" class="nav-logo">Drive<span>KTM</span></a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/home" >Home</a></li>
        <li><a href="${pageContext.request.contextPath}/vehicles"class="active">Vehicles</a></li>
        <li><a href="${pageContext.request.contextPath}/book" >Book</a></li>
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

<section class="hero-mini">
  <div class="hero-label">Our Fleet</div>
  <h1 class="hero-title">Explore Our <em>Vehicles</em></h1>
  <p class="hero-sub">
    Choose from premium cars, adventure bikes, city scooters, and bicycles.
    Built for comfort, convenience, and every type of journey in Kathmandu and beyond.
  </p>
</section>

<section class="vehicles-page">

  <!-- CARS -->
  <section class="category-section">
    <div class="category-head">
      <h2 class="category-title">Cars</h2>
    </div>

    <div class="vehicles-grid">
      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/ToyotaFortuner.png" alt="Toyota Fortuner"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Premium SUV</div>
          <div class="vehicle-name">Toyota Fortuner</div>
          <div class="vehicle-type">7 Seater SUV</div>
          <div class="vehicle-price">From <strong>Rs. 4,500</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Diesel</span><span class="spec">👥 7 Seats</span><span class="spec">❄️ AC</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Toyota%20Fortuner'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/ToyotaCamry.png" alt="Toyota Camry"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Executive Sedan</div>
          <div class="vehicle-name">Toyota Camry</div>
          <div class="vehicle-type">Luxury Sedan</div>
          <div class="vehicle-price">From <strong>Rs. 3,200</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⚡ Hybrid</span><span class="spec">👥 5 Seats</span><span class="spec">❄️ AC</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Toyota%20Camry'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/Creta.png" alt="Hyundai Creta"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Compact SUV</div>
          <div class="vehicle-name">Hyundai Creta</div>
          <div class="vehicle-type">Comfort SUV</div>
          <div class="vehicle-price">From <strong>Rs. 3,600</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👥 5 Seats</span><span class="spec">❄️ AC</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Hyundai%20Creta'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/HondaCity.png" alt="Honda City"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">City Sedan</div>
          <div class="vehicle-name">Honda City</div>
          <div class="vehicle-type">Sedan</div>
          <div class="vehicle-price">From <strong>Rs. 2,900</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👥 5 Seats</span><span class="spec">❄️ AC</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Honda%20City'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/SuzukuiXL7.png" alt="Suzuki XL7"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">MPV</div>
          <div class="vehicle-name">Suzuki XL7</div>
          <div class="vehicle-type">Family MPV</div>
          <div class="vehicle-price">From <strong>Rs. 3,300</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👥 7 Seats</span><span class="spec">❄️ AC</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Suzuki%20XL7'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/FordRanger.png" alt="Ford Ranger"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Pickup</div>
          <div class="vehicle-name">Ford Ranger</div>
          <div class="vehicle-type">Pickup Truck</div>
          <div class="vehicle-price">From <strong>Rs. 4,200</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Diesel</span><span class="spec">👥 5 Seats</span><span class="spec">🏔️ Off-road</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Ford%20Ranger'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/MahindraScorpio.png" alt="Mahindra Scorpio"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Adventure SUV</div>
          <div class="vehicle-name">Mahindra Scorpio</div>
          <div class="vehicle-type">SUV</div>
          <div class="vehicle-price">From <strong>Rs. 4,000</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Diesel</span><span class="spec">👥 7 Seats</span><span class="spec">🏔️ 4x4</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Mahindra%20Scorpio'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/KiaSeltos.png" alt="Kia Seltos"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Modern SUV</div>
          <div class="vehicle-name">Kia Seltos</div>
          <div class="vehicle-type">SUV</div>
          <div class="vehicle-price">From <strong>Rs. 3,700</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👥 5 Seats</span><span class="spec">❄️ AC</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Kia%20Seltos'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/SuzukiSwift.png" alt="Suzuki Swift"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Hatchback</div>
          <div class="vehicle-name">Suzuki Swift</div>
          <div class="vehicle-type">City Car</div>
          <div class="vehicle-price">From <strong>Rs. 2,200</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👥 5 Seats</span><span class="spec">🏙️ City</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Suzuki%20Swift'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/ToyotaYaris.png" alt="Toyota Yaris"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Compact Sedan</div>
          <div class="vehicle-name">Toyota Yaris</div>
          <div class="vehicle-type">Sedan</div>
          <div class="vehicle-price">From <strong>Rs. 2,800</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👥 5 Seats</span><span class="spec">❄️ AC</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Toyota%20Yaris'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/MGHector.png" alt="MG Hector"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Premium SUV</div>
          <div class="vehicle-name">MG Hector</div>
          <div class="vehicle-type">SUV</div>
          <div class="vehicle-price">From <strong>Rs. 4,100</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👥 5 Seats</span><span class="spec">❄️ AC</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=MG%20Hector'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/NissanMagnite.png" alt="Nissan Magnite"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Compact SUV</div>
          <div class="vehicle-name">Nissan Magnite</div>
          <div class="vehicle-type">SUV</div>
          <div class="vehicle-price">From <strong>Rs. 2,700</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👥 5 Seats</span><span class="spec">🏙️ City</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Nissan%20Magnite'">Book Now</button>
        </div>
      </div>
    </div>
  </section>

  <!-- BIKES -->
  <section class="category-section">
    <div class="category-head">
      <h2 class="category-title">Bikes</h2>
    </div>

    <div class="vehicles-grid">
      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/bike1.jpg" alt="RE Himalayan"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Adventure Bike</div>
          <div class="vehicle-name">RE Himalayan</div>
          <div class="vehicle-type">Touring Bike</div>
          <div class="vehicle-price">From <strong>Rs. 1,800</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👤 2 Seats</span><span class="spec">🏔️ Off-road</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=RE%20Himalayan'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/bike2.jpg" alt="KTM Duke 200"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Street Bike</div>
          <div class="vehicle-name">KTM Duke 200</div>
          <div class="vehicle-type">Naked Sports</div>
          <div class="vehicle-price">From <strong>Rs. 1,700</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👤 2 Seats</span><span class="spec">⚡ Quick Ride</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=KTM%20Duke%20200'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/bike3.jpg" alt="KTM Duke 390"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Performance Bike</div>
          <div class="vehicle-name">KTM Duke 390</div>
          <div class="vehicle-type">Street Bike</div>
          <div class="vehicle-price">From <strong>Rs. 2,300</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👤 2 Seats</span><span class="spec">🔥 Power</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=KTM%20Duke%20390'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/bike4.jpg" alt="Yamaha R15"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Sports Bike</div>
          <div class="vehicle-name">Yamaha R15</div>
          <div class="vehicle-type">Sport Ride</div>
          <div class="vehicle-price">From <strong>Rs. 1,900</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👤 2 Seats</span><span class="spec">🏁 Sports</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Yamaha%20R15'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/bike5.jpg" alt="Bajaj Pulsar 220"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Touring Bike</div>
          <div class="vehicle-name">Bajaj Pulsar 220</div>
          <div class="vehicle-type">Street Touring</div>
          <div class="vehicle-price">From <strong>Rs. 1,500</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👤 2 Seats</span><span class="spec">🛣️ Touring</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Bajaj%20Pulsar%20220'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/bike6.jpg" alt="Honda Hornet"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Street Bike</div>
          <div class="vehicle-name">Honda Hornet</div>
          <div class="vehicle-type">Urban Bike</div>
          <div class="vehicle-price">From <strong>Rs. 1,400</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👤 2 Seats</span><span class="spec">🏙️ City</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Honda%20Hornet'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/bike7.jpg" alt="TVS Apache RTR"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Sports Street</div>
          <div class="vehicle-name">TVS Apache RTR</div>
          <div class="vehicle-type">Performance Bike</div>
          <div class="vehicle-price">From <strong>Rs. 1,600</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👤 2 Seats</span><span class="spec">⚡ Agile</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=TVS%20Apache%20RTR'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/bike8.jpg" alt="Suzuki Gixxer"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Sport Ride</div>
          <div class="vehicle-name">Suzuki Gixxer</div>
          <div class="vehicle-type">Street Sport</div>
          <div class="vehicle-price">From <strong>Rs. 1,550</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👤 2 Seats</span><span class="spec">🏁 Ride</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Suzuki%20Gixxer'">Book Now</button>
        </div>
      </div>
    </div>
  </section>

  <!-- SCOOTERS -->
  <section class="category-section">
    <div class="category-head">
      <h2 class="category-title">Scooters</h2>
    </div>

    <div class="vehicles-grid">
      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/scooter1.jpg" alt="Honda Activa"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">City Scooter</div>
          <div class="vehicle-name">Honda Activa</div>
          <div class="vehicle-type">Daily Ride</div>
          <div class="vehicle-price">From <strong>Rs. 800</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👤 2 Seats</span><span class="spec">🏙️ City</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Honda%20Activa'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/scooter2.jpg" alt="TVS Ntorq"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Sport Scooter</div>
          <div class="vehicle-name">TVS Ntorq</div>
          <div class="vehicle-type">Youth Ride</div>
          <div class="vehicle-price">From <strong>Rs. 950</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👤 2 Seats</span><span class="spec">⚡ Sporty</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=TVS%20Ntorq'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/scooter3.jpg" alt="Yamaha RayZR"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Light Scooter</div>
          <div class="vehicle-name">Yamaha RayZR</div>
          <div class="vehicle-type">Urban Scooter</div>
          <div class="vehicle-price">From <strong>Rs. 900</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👤 2 Seats</span><span class="spec">🏙️ Urban</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Yamaha%20RayZR'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/scooter4.jpg" alt="Suzuki Access 125"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Comfort Scooter</div>
          <div class="vehicle-name">Suzuki Access 125</div>
          <div class="vehicle-type">Commuter</div>
          <div class="vehicle-price">From <strong>Rs. 920</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👤 2 Seats</span><span class="spec">🛵 Easy Ride</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Suzuki%20Access%20125'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/scooter5.jpg" alt="Aprilia SR 160"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Performance Scooter</div>
          <div class="vehicle-name">Aprilia SR 160</div>
          <div class="vehicle-type">Sport Scooter</div>
          <div class="vehicle-price">From <strong>Rs. 1,100</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👤 2 Seats</span><span class="spec">🔥 Fast</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Aprilia%20SR%20160'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/scooter6.jpg" alt="Honda Dio"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Youth Scooter</div>
          <div class="vehicle-name">Honda Dio</div>
          <div class="vehicle-type">City Ride</div>
          <div class="vehicle-price">From <strong>Rs. 850</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👤 2 Seats</span><span class="spec">🏙️ Smooth</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Honda%20Dio'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/scooter7.jpg" alt="Vespa VXL"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Premium Scooter</div>
          <div class="vehicle-name">Vespa VXL</div>
          <div class="vehicle-type">Classic Style</div>
          <div class="vehicle-price">From <strong>Rs. 1,250</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⛽ Petrol</span><span class="spec">👤 2 Seats</span><span class="spec">✨ Premium</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Vespa%20VXL'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/scooter8.jpg" alt="Yadea Electric"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Electric Scooter</div>
          <div class="vehicle-name">Yadea Electric</div>
          <div class="vehicle-type">Eco Ride</div>
          <div class="vehicle-price">From <strong>Rs. 1,000</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">⚡ Electric</span><span class="spec">👤 2 Seats</span><span class="spec">🌿 Eco</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Yadea%20Electric'">Book Now</button>
        </div>
      </div>
    </div>
  </section>

  <!-- BICYCLES -->
  <section class="category-section">
    <div class="category-head">
      <h2 class="category-title">Bicycles</h2>
    </div>

    <div class="vehicles-grid">
      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/cycle1.jpg" alt="Mountain Bike"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Adventure Cycle</div>
          <div class="vehicle-name">Mountain Bike</div>
          <div class="vehicle-type">Trail Ready</div>
          <div class="vehicle-price">From <strong>Rs. 500</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">🚲 Bicycle</span><span class="spec">👤 1 Rider</span><span class="spec">🏔️ Trail</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Mountain%20Bike'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/cycle2.jpg" alt="Road Bike"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Road Cycle</div>
          <div class="vehicle-name">Road Bike</div>
          <div class="vehicle-type">Speed Ride</div>
          <div class="vehicle-price">From <strong>Rs. 550</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">🚲 Bicycle</span><span class="spec">👤 1 Rider</span><span class="spec">🛣️ Road</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Road%20Bike'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/cycle3.jpg" alt="Hybrid Bike"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">Hybrid Cycle</div>
          <div class="vehicle-name">Hybrid Bike</div>
          <div class="vehicle-type">Mixed Terrain</div>
          <div class="vehicle-price">From <strong>Rs. 520</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">🚲 Bicycle</span><span class="spec">👤 1 Rider</span><span class="spec">🌿 Hybrid</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=Hybrid%20Bike'">Book Now</button>
        </div>
      </div>

      <div class="vehicle-card">
        <div class="vehicle-img"><img src="${pageContext.request.contextPath}/images/cycle4.jpg" alt="City Bicycle"></div>
        <div class="vehicle-body">
          <div class="vehicle-tag">City Cycle</div>
          <div class="vehicle-name">City Bicycle</div>
          <div class="vehicle-type">Urban Ride</div>
          <div class="vehicle-price">From <strong>Rs. 450</strong> / day</div>
          <div class="vehicle-specs">
            <span class="spec">🚲 Bicycle</span><span class="spec">👤 1 Rider</span><span class="spec">🏙️ City</span>
          </div>
          <button class="btn-sm" onclick="location.href='${pageContext.request.contextPath}/book?vehicle=City%20Bicycle'">Book Now</button>
        </div>
      </div>
    </div>
  </section>

</section>

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
      <a href="${pageContext.request.contextPath}/book">Book Now</a>
      <a href="${pageContext.request.contextPath}/contact">Contact</a>
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

<button class="float-cta" onclick="window.open('https://www.youtube.com/watch?v=dQw4w9WgXcQ', '_blank')">📞 Call Us Now</button>

<script>
  window.addEventListener('scroll', () => {
    document.querySelector('nav').style.background =
      window.scrollY > 80 ? 'rgba(10,10,10,0.97)' : 'rgba(10,10,10,0.85)';
  });

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.style.opacity = '1';
        entry.target.style.transform = 'translateY(0)';
      }
    });
  }, { threshold: 0.08 });

  document.querySelectorAll('.vehicle-card').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(24px)';
    el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(el);
  });
</script>

</body>
</html>