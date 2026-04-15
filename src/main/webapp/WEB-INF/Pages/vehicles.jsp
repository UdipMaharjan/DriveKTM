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
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
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

<%
    ArrayList<HashMap<String, String>> cars =
        (ArrayList<HashMap<String, String>>) request.getAttribute("cars");

    ArrayList<HashMap<String, String>> bikes =
        (ArrayList<HashMap<String, String>>) request.getAttribute("bikes");

    ArrayList<HashMap<String, String>> scooters =
        (ArrayList<HashMap<String, String>>) request.getAttribute("scooters");

    ArrayList<HashMap<String, String>> bicycles =
        (ArrayList<HashMap<String, String>>) request.getAttribute("bicycles");
%>

<section class="vehicles-page">

    <!-- CARS -->
    <section class="category-section">
        <div class="category-head">
            <h2 class="category-title">Cars</h2>
        </div>

        <div class="vehicles-grid">
            <% if (cars != null) {
                for (HashMap<String, String> v : cars) {
                    String name = v.get("name");
                    String encodedName = java.net.URLEncoder.encode(name, "UTF-8");
            %>

            <div class="vehicle-card">
                <div class="vehicle-img">
                    <img src="<%= request.getContextPath() %>/images/<%= v.get("image") %>" alt="<%= name %>">
                </div>

                <div class="vehicle-body">
                    <div class="vehicle-tag"><%= v.get("tag") %></div>
                    <div class="vehicle-name"><%= name %></div>
                    <div class="vehicle-type"><%= v.get("type") %></div>
                    <div class="vehicle-price">From <strong>Rs. <%= v.get("price") %></strong> / day</div>

                    <div class="vehicle-specs">
                        <span class="spec">⛽ <%= v.get("fuel") %></span>
                        <span class="spec">👥 <%= v.get("seats") %></span>
                        <span class="spec">⭐ <%= v.get("feature") %></span>
                    </div>

                    <button class="btn-sm"
                        onclick="location.href='<%= request.getContextPath() %>/book?vehicle=<%= encodedName %>'">
                        Book Now
                    </button>
                </div>
            </div>

            <% } } %>
        </div>
    </section>

    <!-- BIKES -->
    <section class="category-section">
        <div class="category-head">
            <h2 class="category-title">Bikes</h2>
        </div>

        <div class="vehicles-grid">
            <% if (bikes != null) {
                for (HashMap<String, String> v : bikes) {
                    String name = v.get("name");
                    String encodedName = java.net.URLEncoder.encode(name, "UTF-8");
            %>

            <div class="vehicle-card">
                <div class="vehicle-img">
                    <img src="<%= request.getContextPath() %>/images/<%= v.get("image") %>" alt="<%= name %>">
                </div>

                <div class="vehicle-body">
                    <div class="vehicle-tag"><%= v.get("tag") %></div>
                    <div class="vehicle-name"><%= name %></div>
                    <div class="vehicle-type"><%= v.get("type") %></div>
                    <div class="vehicle-price">From <strong>Rs. <%= v.get("price") %></strong> / day</div>

                    <div class="vehicle-specs">
                        <span class="spec">⛽ <%= v.get("fuel") %></span>
                        <span class="spec">👥 <%= v.get("seats") %></span>
                        <span class="spec">⭐ <%= v.get("feature") %></span>
                    </div>

                    <button class="btn-sm"
                        onclick="location.href='<%= request.getContextPath() %>/book?vehicle=<%= encodedName %>'">
                        Book Now
                    </button>
                </div>
            </div>

            <% } } %>
        </div>
    </section>

    <!-- SCOOTERS -->
    <section class="category-section">
        <div class="category-head">
            <h2 class="category-title">Scooters</h2>
        </div>

        <div class="vehicles-grid">
            <% if (scooters != null) {
                for (HashMap<String, String> v : scooters) {
                    String name = v.get("name");
                    String encodedName = java.net.URLEncoder.encode(name, "UTF-8");
            %>

            <div class="vehicle-card">
                <div class="vehicle-img">
                    <img src="<%= request.getContextPath() %>/images/<%= v.get("image") %>" alt="<%= name %>">
                </div>

                <div class="vehicle-body">
                    <div class="vehicle-tag"><%= v.get("tag") %></div>
                    <div class="vehicle-name"><%= name %></div>
                    <div class="vehicle-type"><%= v.get("type") %></div>
                    <div class="vehicle-price">From <strong>Rs. <%= v.get("price") %></strong> / day</div>

                    <div class="vehicle-specs">
                        <span class="spec">⛽ <%= v.get("fuel") %></span>
                        <span class="spec">👥 <%= v.get("seats") %></span>
                        <span class="spec">⭐ <%= v.get("feature") %></span>
                    </div>

                    <button class="btn-sm"
                        onclick="location.href='<%= request.getContextPath() %>/book?vehicle=<%= encodedName %>'">
                        Book Now
                    </button>
                </div>
            </div>

            <% } } %>
        </div>
    </section>

    <!-- BICYCLES -->
    <section class="category-section">
        <div class="category-head">
            <h2 class="category-title">Bicycles</h2>
        </div>

        <div class="vehicles-grid">
            <% if (bicycles != null) {
                for (HashMap<String, String> v : bicycles) {
                    String name = v.get("name");
                    String encodedName = java.net.URLEncoder.encode(name, "UTF-8");
            %>

            <div class="vehicle-card">
                <div class="vehicle-img">
                    <img src="<%= request.getContextPath() %>/images/<%= v.get("image") %>" alt="<%= name %>">
                </div>

                <div class="vehicle-body">
                    <div class="vehicle-tag"><%= v.get("tag") %></div>
                    <div class="vehicle-name"><%= name %></div>
                    <div class="vehicle-type"><%= v.get("type") %></div>
                    <div class="vehicle-price">From <strong>Rs. <%= v.get("price") %></strong> / day</div>

                    <div class="vehicle-specs">
                        <span class="spec">⛽ <%= v.get("fuel") %></span>
                        <span class="spec">👥 <%= v.get("seats") %></span>
                        <span class="spec">⭐ <%= v.get("feature") %></span>
                    </div>

                    <button class="btn-sm"
                        onclick="location.href='<%= request.getContextPath() %>/book?vehicle=<%= encodedName %>'">
                        Book Now
                    </button>
                </div>
            </div>

            <% } } %>
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