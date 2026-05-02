<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Explore Kathmandu — DriveKTM</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">

<!-- Leaflet CSS -->
<link rel="stylesheet"
      href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
      integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
      crossorigin="" />

<!-- Leaflet JS -->
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

/* ── BUTTONS ── */
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
  transition: all 0.3s;
}

.btn-gold:hover {
  transform: translateY(-2px);
  box-shadow: 0 12px 32px rgba(201,169,110,0.35);
}

/* ── INTRO ── */
.explore-hero {
  min-height: 92vh;
  padding: 150px 80px 90px;
  display: grid;
  grid-template-columns: 0.9fr 1.1fr;
  align-items: center;
  gap: 70px;
  background:
    radial-gradient(circle at 78% 35%, rgba(201,169,110,0.12), transparent 30%),
    radial-gradient(circle at 20% 90%, rgba(201,169,110,0.07), transparent 32%),
    linear-gradient(135deg, #0A0A0A 0%, #111111 55%, #090909 100%);
}

.hero-label {
  display: inline-flex;
  align-items: center;
  gap: 12px;
  color: var(--gold);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  margin-bottom: 22px;
}

.hero-label::after {
  content: '';
  width: 44px;
  height: 1px;
  background: var(--gold);
}

.explore-hero h1 {
  font-family: 'Cormorant Garamond', serif;
  font-size: clamp(54px, 7vw, 92px);
  font-weight: 300;
  line-height: 1.04;
  color: var(--white);
  margin-bottom: 24px;
}

.explore-hero h1 em {
  color: var(--gold);
  font-style: italic;
}

.explore-hero p {
  max-width: 570px;
  color: var(--text-muted);
  font-size: 16px;
  line-height: 1.85;
  margin-bottom: 34px;
}

/* ── HERO MAP PANEL ── */
.hero-map-panel {
  border: 1px solid rgba(201,169,110,0.22);
  background: rgba(17,17,17,0.92);
  min-height: 500px;
  position: relative;
  overflow: hidden;
  box-shadow: 0 24px 80px rgba(0,0,0,0.5);
}

.hero-map-header {
  height: 88px;
  padding: 20px 24px;
  border-bottom: 1px solid rgba(201,169,110,0.16);
  display: flex;
  align-items: center;
  justify-content: space-between;
  background:
    radial-gradient(circle at right, rgba(201,169,110,0.13), transparent 34%),
    rgba(10,10,10,0.65);
}

.hero-map-header span {
  color: var(--gold);
  font-size: 11px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
}

.hero-map-header h3 {
  font-family: 'Cormorant Garamond', serif;
  font-size: 28px;
  font-weight: 400;
  color: var(--white);
  margin-top: 4px;
}

.map-mini-icon {
  width: 48px;
  height: 48px;
  border: 1px solid rgba(201,169,110,0.35);
  background: var(--gold-dim);
  color: var(--gold);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 22px;
}

#heroMap {
  width: 100%;
  height: 412px;
  filter: grayscale(25%) brightness(78%);
}

/* ── ROUTE SECTION ── */
.route-intro {
  padding: 90px 80px 40px;
  background: var(--dark-2);
  text-align: center;
}

.section-label {
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--gold);
  margin-bottom: 12px;
  display: inline-flex;
  align-items: center;
  gap: 12px;
}

.section-label::before,
.section-label::after {
  content: '';
  width: 34px;
  height: 1px;
  background: var(--gold);
}

.section-title {
  font-family: 'Cormorant Garamond', serif;
  font-size: clamp(38px, 5vw, 62px);
  font-weight: 300;
  line-height: 1.15;
  color: var(--white);
  margin-bottom: 18px;
}

.section-title em {
  color: var(--gold);
  font-style: italic;
}

.route-intro p {
  max-width: 760px;
  margin: 0 auto;
  color: var(--text-muted);
  line-height: 1.8;
}

/* Road area */
.explore-route {
  position: relative;
  height: 2850px;
  background:
    radial-gradient(circle at 20% 20%, rgba(201,169,110,0.06), transparent 28%),
    radial-gradient(circle at 80% 60%, rgba(201,169,110,0.08), transparent 30%),
    linear-gradient(180deg, var(--dark-2), var(--dark));
  overflow: hidden;
}

.route-bg {
  position: absolute;
  inset: 0;
  opacity: 0.32;
  background:
    linear-gradient(rgba(10,10,10,0.75), rgba(10,10,10,0.95)),
    repeating-linear-gradient(45deg, rgba(201,169,110,0.08) 0 1px, transparent 1px 80px);
}

.route-svg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 2850px;
  overflow: visible;
}

.road-base {
  fill: none;
  stroke: #1d1d1d;
  stroke-width: 104;
  stroke-linecap: round;
  stroke-linejoin: round;
  filter: drop-shadow(0 25px 40px rgba(0,0,0,0.65));
}

.road-edge {
  fill: none;
  stroke: rgba(201,169,110,0.24);
  stroke-width: 110;
  stroke-linecap: round;
  stroke-linejoin: round;
}

.road-line {
  fill: none;
  stroke: rgba(201,169,110,0.9);
  stroke-width: 5;
  stroke-linecap: round;
  stroke-dasharray: 26 24;
}

.road-progress {
  fill: none;
  stroke: var(--gold-light);
  stroke-width: 7;
  stroke-linecap: round;
  filter: drop-shadow(0 0 12px rgba(201,169,110,0.8));
  stroke-dasharray: 0;
  stroke-dashoffset: 0;
}

/* Moving car */
.moving-car-img {
  position: absolute;
  z-index: 20;
  width: 82px;
  height: auto;
  transform: translate(-50%, -50%);
  filter: drop-shadow(0 12px 22px rgba(0,0,0,0.65));
  will-change: left, top, transform;
  pointer-events: none;
}

/* Stop cards */
.stop-card {
  position: absolute;
  z-index: 10;
  width: min(360px, 30vw);
  background: rgba(17,17,17,0.94);
  border: 1px solid rgba(201,169,110,0.22);
  box-shadow: 0 18px 55px rgba(0,0,0,0.45);
  overflow: hidden;
  opacity: 0.45;
  transform: translateY(25px) scale(0.98);
  transition: all 0.45s ease;
}

.stop-card.active {
  opacity: 1;
  transform: translateY(0) scale(1);
  border-color: rgba(201,169,110,0.85);
  box-shadow: 0 0 28px rgba(201,169,110,0.16), 0 18px 55px rgba(0,0,0,0.5);
}

.stop-head {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 18px 18px 12px;
}

.stop-num {
  width: 42px;
  height: 42px;
  border-radius: 50%;
  border: 1px solid var(--gold);
  color: var(--gold);
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: 'Cormorant Garamond', serif;
  font-size: 20px;
  font-weight: 600;
}

.stop-title h3 {
  color: var(--white);
  font-size: 17px;
  margin-bottom: 4px;
}

.stop-title span {
  color: var(--text-faint);
  font-size: 12px;
}

.stop-photo {
  height: 160px;
  margin: 0 18px 18px;
  border: 1px solid rgba(201,169,110,0.16);
  background-size: cover;
  background-position: center;
  position: relative;
  overflow: hidden;
}

.stop-photo::after {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(to bottom, transparent, rgba(10,10,10,0.55));
}

.stop-desc {
  padding: 0 18px 20px;
  color: var(--text-muted);
  font-size: 13px;
  line-height: 1.7;
}

/* Temporary landmark photo designs. Later replace with real images. */
.swayambhu {
 background-image:
    linear-gradient(rgba(0,0,0,0.05), rgba(0,0,0,0.45)),
    url("${pageContext.request.contextPath}/images/Swayambhu.jpg");
}

.basantapur {
 background-image:
    linear-gradient(rgba(0,0,0,0.05), rgba(0,0,0,0.45)),
    url("${pageContext.request.contextPath}/images/Basantapur.jpg");
}

.patan {
 background-image:
    linear-gradient(rgba(0,0,0,0.05), rgba(0,0,0,0.45)),
    url("${pageContext.request.contextPath}/images/Patan.jpg");
}

.pashupati {
 background-image:
    linear-gradient(rgba(0,0,0,0.05), rgba(0,0,0,0.45)),
    url("${pageContext.request.contextPath}/images/Pashupatinath.png");
}

.boudha {
 background-image:
    linear-gradient(rgba(0,0,0,0.05), rgba(0,0,0,0.45)),
    url("${pageContext.request.contextPath}/images/Boudha.jpg");
}

.bhaktapur {
 background-image:
    linear-gradient(rgba(0,0,0,0.05), rgba(0,0,0,0.45)),
    url("${pageContext.request.contextPath}/images/Bhaktapur.jpeg");
}

.nagarkot {
 background-image:
    linear-gradient(rgba(0,0,0,0.05), rgba(0,0,0,0.45)),
    url("${pageContext.request.contextPath}/images/Nagarkot.jpg");
}

.stop-card:nth-of-type(1) { top: 170px; left: 8%; }
.stop-card:nth-of-type(2) { top: 520px; right: 9%; }
.stop-card:nth-of-type(3) { top: 875px; left: 9%; }
.stop-card:nth-of-type(4) { top: 1230px; right: 8%; }
.stop-card:nth-of-type(5) { top: 1585px; left: 8%; }
.stop-card:nth-of-type(6) { top: 1950px; right: 10%; }
.stop-card:nth-of-type(7) { top: 2320px; left: 11%; }

/* Markers */
.stop-marker {
  position: absolute;
  z-index: 45;
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background: var(--gold);
  box-shadow: 0 0 0 12px rgba(201,169,110,0.10), 0 0 26px rgba(201,169,110,0.85);
  transform: translate(-50%, -50%);
  cursor: pointer;
}

.stop-marker::after {
  content: attr(data-num);
  position: absolute;
  inset: 4px;
  border-radius: 50%;
  background: var(--dark);
  color: var(--gold);
  font-size: 11px;
  font-weight: 600;
  display: flex;
  align-items: center;
  justify-content: center;
}

.marker-1 { left: 52%; top: 8.5%; }
.marker-2 { left: 59%; top: 22%; }
.marker-3 { left: 42%; top: 34%; }
.marker-4 { left: 51%; top: 47%; }
.marker-5 { left: 60%; top: 60%; }
.marker-6 { left: 44%; top: 73%; }
.marker-7 { left: 52%; top: 88%; }

/* ── LANDMARK HOVER POPUPS ── */
.landmark-popup {
  position: absolute;
  z-index: 60;
  width: 310px;
  background: rgba(17,17,17,0.97);
  border: 1px solid rgba(201,169,110,0.45);
  box-shadow: 0 20px 65px rgba(0,0,0,0.65), 0 0 26px rgba(201,169,110,0.12);
  opacity: 0;
  visibility: hidden;
  transform: translateY(16px) scale(0.96);
  transition: opacity 0.25s ease, transform 0.25s ease, visibility 0.25s ease;
  pointer-events: auto;
  overflow: hidden;
}

.landmark-popup.show {
  opacity: 1;
  visibility: visible;
  transform: translateY(0) scale(1);
}

.popup-img {
  height: 145px;
  background-size: cover;
  background-position: center;
  border-bottom: 1px solid rgba(201,169,110,0.16);
}

.popup-body {
  padding: 18px;
}

.popup-body h3 {
  font-family: 'Cormorant Garamond', serif;
  font-size: 27px;
  font-weight: 400;
  color: var(--white);
  margin-bottom: 8px;
}

.popup-body p {
  color: var(--text-muted);
  font-size: 13px;
  line-height: 1.65;
  margin-bottom: 16px;
}

.popup-body a {
  display: inline-block;
  padding: 10px 16px;
  background: var(--gold);
  color: var(--dark);
  text-decoration: none;
  font-size: 11px;
  font-weight: 600;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  transition: 0.25s;
}

.popup-body a:hover {
  background: var(--gold-light);
  transform: translateY(-2px);
}

/* Popup positions near each marker */
.popup-1 { left: 55%; top: 7%; }
.popup-2 { left: 62%; top: 20%; }
.popup-3 { left: 44%; top: 32%; }
.popup-4 { left: 54%; top: 45%; }
.popup-5 { left: 63%; top: 58%; }
.popup-6 { left: 46%; top: 71%; }
.popup-7 { left: 55%; top: 85%; }

.current-stop-box {
  position: sticky;
  top: 94px;
  z-index: 30;
  width: fit-content;
  margin-left: auto;
  margin-right: 80px;
  padding: 16px 22px;
  background: rgba(17,17,17,0.92);
  border: 1px solid rgba(201,169,110,0.35);
  color: var(--text);
  box-shadow: 0 14px 45px rgba(0,0,0,0.4);
}

.current-stop-box small {
  display: block;
  color: var(--text-faint);
  font-size: 10px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  margin-bottom: 4px;
}

.current-stop-box span {
  color: var(--gold);
  font-family: 'Cormorant Garamond', serif;
  font-size: 26px;
}

/* ── MAP SECTION ── */
.map-section {
  padding: 100px 80px;
  background: var(--dark);
}

.map-grid {
  display: grid;
  grid-template-columns: 0.9fr 1.1fr;
  gap: 36px;
  align-items: stretch;
}

.map-info {
  background: var(--dark-2);
  border: 1px solid rgba(201,169,110,0.18);
  padding: 44px;
}

.map-info h2 {
  font-family: 'Cormorant Garamond', serif;
  font-size: 46px;
  font-weight: 300;
  line-height: 1.15;
  color: var(--white);
  margin-bottom: 18px;
}

.map-info h2 em {
  color: var(--gold);
  font-style: italic;
}

.map-info p {
  color: var(--text-muted);
  font-size: 14px;
  line-height: 1.85;
  margin-bottom: 30px;
}

.route-summary {
  display: grid;
  gap: 16px;
}

.summary-item {
  display: flex;
  gap: 14px;
  align-items: center;
  padding: 18px;
  border: 1px solid rgba(201,169,110,0.12);
  background: rgba(255,255,255,0.025);
}

.summary-icon {
  width: 46px;
  height: 46px;
  background: var(--gold-dim);
  border: 1px solid rgba(201,169,110,0.28);
  color: var(--gold);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
}

.summary-item strong {
  display: block;
  color: var(--white);
  font-size: 16px;
  margin-bottom: 3px;
}

.summary-item span {
  color: var(--text-faint);
  font-size: 12px;
}

#exploreMap {
  width: 100%;
  min-height: 560px;
  border: 1px solid rgba(201,169,110,0.18);
  filter: grayscale(25%) brightness(82%);
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

/* ── CTA ── */
.explore-cta {
  padding: 80px;
  background: var(--dark-2);
}

.cta-box {
  border: 1px solid rgba(201,169,110,0.28);
  background:
    radial-gradient(circle at right, rgba(201,169,110,0.16), transparent 30%),
    linear-gradient(135deg, #111, #080808);
  padding: 54px 60px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 30px;
}

.cta-box h2 {
  font-family: 'Cormorant Garamond', serif;
  font-size: 44px;
  font-weight: 300;
  color: var(--white);
  margin-bottom: 10px;
}

.cta-box p {
  color: var(--text-muted);
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

/* ── RESPONSIVE ── */
@media (max-width: 1150px) {
  .explore-hero,
  .map-grid {
    grid-template-columns: 1fr;
  }

  .stop-card {
    width: 330px;
  }

  .current-stop-box {
    margin-right: 40px;
  }
}

@media (max-width: 850px) {
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

  .explore-hero,
  .route-intro,
  .map-section,
  .explore-cta,
  footer {
    padding-left: 24px;
    padding-right: 24px;
  }

  .explore-route {
    height: 3300px;
  }

.route-svg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 2850px;
  overflow: visible;
  pointer-events: none;
}

  .stop-card {
    width: calc(100% - 48px);
    left: 24px !important;
    right: auto !important;
  }

  .stop-card:nth-of-type(1) { top: 220px; }
  .stop-card:nth-of-type(2) { top: 620px; }
  .stop-card:nth-of-type(3) { top: 1020px; }
  .stop-card:nth-of-type(4) { top: 1420px; }
  .stop-card:nth-of-type(5) { top: 1820px; }
  .stop-card:nth-of-type(6) { top: 2220px; }
  .stop-card:nth-of-type(7) { top: 2620px; }

  .landmark-popup {
    width: calc(100% - 48px);
    left: 24px !important;
    right: auto !important;
  }

  .popup-1 { top: 330px; }
  .popup-2 { top: 730px; }
  .popup-3 { top: 1130px; }
  .popup-4 { top: 1530px; }
  .popup-5 { top: 1930px; }
  .popup-6 { top: 2330px; }
  .popup-7 { top: 2730px; }

  .current-stop-box {
    margin: 0 24px 0 auto;
  }

  .footer-top {
    grid-template-columns: 1fr;
  }

  .footer-bottom,
  .cta-box {
    flex-direction: column;
    align-items: flex-start;
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
<section class="explore-hero">
  <div>
    <div class="hero-label">Kathmandu Valley Route</div>
    <h1>One Drive.<br><em>Seven Stories.</em></h1>
    <p>
      Take a virtual DriveKTM journey through Kathmandu Valley. Scroll down and watch the car move through
      famous cultural stops, from Swayambhu to Nagarkot.
    </p>
    <a href="#routeStart" class="btn-gold">Start Exploring</a>
  </div>

  <div class="hero-map-panel">
    <div class="hero-map-header">
      <div>
        <span>Kathmandu Route Map</span>
        <h3>7 Iconic Stops</h3>
      </div>
      <div class="map-mini-icon">📍</div>
    </div>

    <div id="heroMap"></div>
  </div>
</section>

<!-- ROUTE INTRO -->
<section class="route-intro" id="routeStart">
  <div class="section-label">Scroll Journey</div>
  <h2 class="section-title">Follow the Road Through<br><em>Kathmandu Valley</em></h2>
  <p>
    The car moves as you scroll. Each stop introduces one iconic place in the route:
    Swayambhu, Basantapur, Patan, Pashupatinath, Boudha, Bhaktapur, and Nagarkot.
  </p>
</section>

<!-- INTERACTIVE ROUTE -->
<section class="explore-route" id="exploreRoute">

  <div class="route-bg"></div>

  <div class="current-stop-box">
    <small>Current Stop</small>
    <span id="currentStop">Swayambhunath</span>
  </div>

  <svg class="route-svg" viewBox="0 0 1000 2850" preserveAspectRatio="none">
    <path class="road-edge"
          d="M520 100 C770 260 720 500 505 650 C270 815 280 1045 510 1195 C790 1375 740 1635 500 1795 C260 1960 290 2230 535 2395 C720 2525 655 2700 500 2800" />

    <path class="road-base"
          d="M520 100 C770 260 720 500 505 650 C270 815 280 1045 510 1195 C790 1375 740 1635 500 1795 C260 1960 290 2230 535 2395 C720 2525 655 2700 500 2800" />

    <path class="road-line"
          d="M520 100 C770 260 720 500 505 650 C270 815 280 1045 510 1195 C790 1375 740 1635 500 1795 C260 1960 290 2230 535 2395 C720 2525 655 2700 500 2800" />

    <path id="roadProgress" class="road-progress"
          d="M520 100 C770 260 720 500 505 650 C270 815 280 1045 510 1195 C790 1375 740 1635 500 1795 C260 1960 290 2230 535 2395 C720 2525 655 2700 500 2800" />

    <path id="roadPath"
          d="M520 100 C770 260 720 500 505 650 C270 815 280 1045 510 1195 C790 1375 740 1635 500 1795 C260 1960 290 2230 535 2395 C720 2525 655 2700 500 2800"
          fill="none" stroke="transparent" stroke-width="1" />
  </svg>

  <img src="${pageContext.request.contextPath}/images/movingcar.png" 
     alt="DriveKTM car" 
     class="moving-car-img" 
     id="movingCar">
  <!-- HOVER MARKERS -->
  <div class="stop-marker marker-1" data-num="01" data-popup="popup1"></div>
  <div class="stop-marker marker-2" data-num="02" data-popup="popup2"></div>
  <div class="stop-marker marker-3" data-num="03" data-popup="popup3"></div>
  <div class="stop-marker marker-4" data-num="04" data-popup="popup4"></div>
  <div class="stop-marker marker-5" data-num="05" data-popup="popup5"></div>
  <div class="stop-marker marker-6" data-num="06" data-popup="popup6"></div>
  <div class="stop-marker marker-7" data-num="07" data-popup="popup7"></div>

  <!-- HOVER POPUPS -->
  <div class="landmark-popup popup-1" id="popup1">
    <div class="popup-img swayambhu"></div>
    <div class="popup-body">
      <h3>Swayambhunath</h3>
      <p>A hilltop stupa with prayer flags, monkeys, and a beautiful view of Kathmandu Valley.</p>
      <a href="${pageContext.request.contextPath}/book">Book a Ride</a>
    </div>
  </div>

  <div class="landmark-popup popup-2" id="popup2">
    <div class="popup-img basantapur"></div>
    <div class="popup-body">
      <h3>Basantapur</h3>
      <p>The historic heart of old Kathmandu, filled with temples, courtyards, and royal architecture.</p>
      <a href="${pageContext.request.contextPath}/book">Book a Ride</a>
    </div>
  </div>

  <div class="landmark-popup popup-3" id="popup3">
    <div class="popup-img patan"></div>
    <div class="popup-body">
      <h3>Patan</h3>
      <p>A cultural city known for Newari art, ancient temples, palace courtyards, and heritage streets.</p>
      <a href="${pageContext.request.contextPath}/book">Book a Ride</a>
    </div>
  </div>

  <div class="landmark-popup popup-4" id="popup4">
    <div class="popup-img pashupati"></div>
    <div class="popup-body">
      <h3>Pashupatinath</h3>
      <p>One of Nepal’s most sacred temples, located beside the Bagmati River.</p>
      <a href="${pageContext.request.contextPath}/book">Book a Ride</a>
    </div>
  </div>

  <div class="landmark-popup popup-5" id="popup5">
    <div class="popup-img boudha"></div>
    <div class="popup-body">
      <h3>Boudhanath</h3>
      <p>A peaceful stupa area with prayer wheels, Tibetan culture, cafes, and spiritual atmosphere.</p>
      <a href="${pageContext.request.contextPath}/book">Book a Ride</a>
    </div>
  </div>

  <div class="landmark-popup popup-6" id="popup6">
    <div class="popup-img bhaktapur"></div>
    <div class="popup-body">
      <h3>Bhaktapur</h3>
      <p>An ancient royal city known for brick streets, temples, pottery, and preserved heritage.</p>
      <a href="${pageContext.request.contextPath}/book">Book a Ride</a>
    </div>
  </div>

  <div class="landmark-popup popup-7" id="popup7">
    <div class="popup-img nagarkot"></div>
    <div class="popup-body">
      <h3>Nagarkot</h3>
      <p>A scenic viewpoint famous for sunrise, fresh air, mountain views, and peaceful drives.</p>
      <a href="${pageContext.request.contextPath}/book">Book a Ride</a>
    </div>
  </div>

  <!-- STOP CARDS -->
  <article class="stop-card active" data-stop="Swayambhunath">
    <div class="stop-head">
      <div class="stop-num">01</div>
      <div class="stop-title">
        <h3>Swayambhunath</h3>
        <span>Hilltop stupa and city viewpoint</span>
      </div>
    </div>
    <div class="stop-photo swayambhu"></div>
    <p class="stop-desc">
      Start the route from Swayambhu, famous for its stupa, prayer flags, monkeys, and panoramic view of Kathmandu.
    </p>
  </article>

  <article class="stop-card" data-stop="Basantapur">
    <div class="stop-head">
      <div class="stop-num">02</div>
      <div class="stop-title">
        <h3>Basantapur</h3>
        <span>Historic heart of old Kathmandu</span>
      </div>
    </div>
    <div class="stop-photo basantapur"></div>
    <p class="stop-desc">
      Drive toward Basantapur Durbar Square, a cultural center filled with temples, courtyards, and heritage architecture.
    </p>
  </article>

  <article class="stop-card" data-stop="Patan">
    <div class="stop-head">
      <div class="stop-num">03</div>
      <div class="stop-title">
        <h3>Patan</h3>
        <span>Artistic city of temples and courtyards</span>
      </div>
    </div>
    <div class="stop-photo patan"></div>
    <p class="stop-desc">
      Continue to Patan, known for Newari art, ancient palaces, metal craft, and peaceful heritage squares.
    </p>
  </article>

  <article class="stop-card" data-stop="Pashupatinath">
    <div class="stop-head">
      <div class="stop-num">04</div>
      <div class="stop-title">
        <h3>Pashupatinath</h3>
        <span>Sacred temple by Bagmati River</span>
      </div>
    </div>
    <div class="stop-photo pashupati"></div>
    <p class="stop-desc">
      Visit one of Nepal’s most sacred temples, located beside the Bagmati River and surrounded by spiritual heritage.
    </p>
  </article>

  <article class="stop-card" data-stop="Boudhanath">
    <div class="stop-head">
      <div class="stop-num">05</div>
      <div class="stop-title">
        <h3>Boudhanath</h3>
        <span>Peaceful stupa and Tibetan culture</span>
      </div>
    </div>
    <div class="stop-photo boudha"></div>
    <p class="stop-desc">
      Move toward Boudha, where the grand white stupa, prayer wheels, cafes, and calm atmosphere create a memorable stop.
    </p>
  </article>

  <article class="stop-card" data-stop="Bhaktapur">
    <div class="stop-head">
      <div class="stop-num">06</div>
      <div class="stop-title">
        <h3>Bhaktapur</h3>
        <span>Ancient royal city and brick streets</span>
      </div>
    </div>
    <div class="stop-photo bhaktapur"></div>
    <p class="stop-desc">
      Explore Bhaktapur’s old squares, temples, pottery streets, and traditional architecture preserved through time.
    </p>
  </article>

  <article class="stop-card" data-stop="Nagarkot">
    <div class="stop-head">
      <div class="stop-num">07</div>
      <div class="stop-title">
        <h3>Nagarkot</h3>
        <span>Mountain viewpoint and scenic ending</span>
      </div>
    </div>
    <div class="stop-photo nagarkot"></div>
    <p class="stop-desc">
      End the DriveKTM route at Nagarkot, a peaceful viewpoint known for sunrise, fresh air, and mountain scenery.
    </p>
  </article>

</section>

<!-- MAP SECTION -->
<section class="map-section">
  <div class="map-grid">

    <div class="map-info">
      <div class="section-label">Live Route Map</div>
      <h2>Your Kathmandu<br><em>Explore Route</em></h2>
      <p>
        This map shows the complete 7-stop DriveKTM route. It helps users understand the real locations and how the
        journey moves from Kathmandu city toward Bhaktapur and Nagarkot.
      </p>

      <div class="route-summary">
        <div class="summary-item">
          <div class="summary-icon">📍</div>
          <div>
            <strong>7 Stops</strong>
            <span>Swayambhu to Nagarkot</span>
          </div>
        </div>

        <div class="summary-item">
          <div class="summary-icon">🛣️</div>
          <div>
            <strong>Heritage Drive</strong>
            <span>Temples, squares, stupas, and viewpoints</span>
          </div>
        </div>

        <div class="summary-item">
          <div class="summary-icon">🚗</div>
          <div>
            <strong>DriveKTM Experience</strong>
            <span>Interactive route for travelers</span>
          </div>
        </div>
      </div>
    </div>

    <div id="exploreMap"></div>

  </div>
</section>

<!-- CTA -->
<section class="explore-cta">
  <div class="cta-box">
    <div>
      <h2>Ready to explore Kathmandu?</h2>
      <p>Choose your vehicle and start your own Kathmandu Valley journey with DriveKTM.</p>
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

  // Moving car on SVG road
  const routeSection = document.getElementById('exploreRoute');
  const roadPath = document.getElementById('roadPath');
  const roadProgress = document.getElementById('roadProgress');
  const movingCar = document.getElementById('movingCar');
  const currentStop = document.getElementById('currentStop');
  const stopCards = document.querySelectorAll('.stop-card');

  const pathLength = roadPath.getTotalLength();

  roadProgress.style.strokeDasharray = pathLength;
  roadProgress.style.strokeDashoffset = pathLength;

  const stops = [
    { name: 'Swayambhunath', progress: 0.03 },
    { name: 'Basantapur', progress: 0.18 },
    { name: 'Patan', progress: 0.33 },
    { name: 'Pashupatinath', progress: 0.48 },
    { name: 'Boudhanath', progress: 0.63 },
    { name: 'Bhaktapur', progress: 0.78 },
    { name: 'Nagarkot', progress: 0.93 }
  ];

  function updateCarPosition() {
    const rect = routeSection.getBoundingClientRect();
    const sectionHeight = routeSection.offsetHeight;
    const windowHeight = window.innerHeight;

    let progress = -rect.top / (sectionHeight - windowHeight);
    progress = Math.max(0, Math.min(progress, 1));

    const point = roadPath.getPointAtLength(pathLength * progress);

    const routeWidth = routeSection.offsetWidth;
    const routeHeight = routeSection.offsetHeight;

    const x = (point.x / 1000) * routeWidth;
    const y = (point.y / 2850) * routeHeight;

    const nextPoint = roadPath.getPointAtLength(Math.min(pathLength, pathLength * progress + 8));
    const angle = Math.atan2(nextPoint.y - point.y, nextPoint.x - point.x) * 180 / Math.PI;

    movingCar.style.left = x + 'px';
    movingCar.style.top = y + 'px';
    movingCar.style.transform = 'translate(-50%, -50%) rotate(' + angle + 'deg)';

    roadProgress.style.strokeDashoffset = pathLength - (pathLength * progress);

    let activeIndex = 0;

    stops.forEach((stop, index) => {
      if (progress >= stop.progress - 0.08) {
        activeIndex = index;
      }
    });

    currentStop.textContent = stops[activeIndex].name;

    stopCards.forEach((card, index) => {
      if (index === activeIndex) {
        card.classList.add('active');
      } else {
        card.classList.remove('active');
      }
    });
  }

  window.addEventListener('scroll', updateCarPosition);
  window.addEventListener('resize', updateCarPosition);
  window.addEventListener('load', updateCarPosition);

  // Landmark marker hover popup
  const routeMarkers = document.querySelectorAll('.stop-marker');
  const landmarkPopups = document.querySelectorAll('.landmark-popup');

  routeMarkers.forEach(marker => {
    const popupId = marker.getAttribute('data-popup');
    const popup = document.getElementById(popupId);

    marker.addEventListener('mouseenter', () => {
      landmarkPopups.forEach(item => item.classList.remove('show'));
      popup.classList.add('show');
    });

    marker.addEventListener('mouseleave', () => {
      setTimeout(() => {
        if (!popup.matches(':hover')) {
          popup.classList.remove('show');
        }
      }, 120);
    });

    popup.addEventListener('mouseenter', () => {
      popup.classList.add('show');
    });

    popup.addEventListener('mouseleave', () => {
      popup.classList.remove('show');
    });
  });

  // Leaflet route map
  const routePlaces = [
    {
      name: 'Swayambhunath',
      coords: [27.7149, 85.2904],
      desc: 'Hilltop stupa and Kathmandu Valley viewpoint.'
    },
    {
      name: 'Basantapur Durbar Square',
      coords: [27.7047, 85.3078],
      desc: 'Historic heart of old Kathmandu.'
    },
    {
      name: 'Patan Durbar Square',
      coords: [27.6736, 85.3257],
      desc: 'Newari art, courtyards, temples, and heritage.'
    },
    {
      name: 'Pashupatinath Temple',
      coords: [27.7106, 85.3487],
      desc: 'Sacred temple by the Bagmati River.'
    },
    {
      name: 'Boudhanath Stupa',
      coords: [27.7215, 85.3620],
      desc: 'Peaceful stupa and Tibetan culture hub.'
    },
    {
      name: 'Bhaktapur Durbar Square',
      coords: [27.6722, 85.4280],
      desc: 'Ancient royal city and brick streets.'
    },
    {
      name: 'Nagarkot',
      coords: [27.7172, 85.5207],
      desc: 'Scenic mountain viewpoint.'
    }
  ];

  const routeCoordinates = routePlaces.map(place => place.coords);

  function createDriveKtmMap(mapId) {
    const map = L.map(mapId, {
      zoomControl: true,
      scrollWheelZoom: false
    }).setView([27.7047, 85.3900], 11);

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);

    L.polyline(routeCoordinates, {
      color: '#C9A96E',
      weight: 5,
      opacity: 0.9
    }).addTo(map);

    routePlaces.forEach((place, index) => {
      const marker = L.marker(place.coords).addTo(map);

      marker.bindPopup(
        '<b>' + (index + 1) + '. ' + place.name + '</b><br>' +
        place.desc +
        '<br><br><a href="${pageContext.request.contextPath}/book" style="color:#C9A96E;text-decoration:none;font-weight:600;">Book a Ride →</a>'
      );

      marker.on('mouseover', function () {
        this.openPopup();
      });

      marker.on('mouseout', function () {
        this.closePopup();
      });
    });

    const bounds = L.latLngBounds(routeCoordinates);
    map.fitBounds(bounds, { padding: [35, 35] });

    return map;
  }

  createDriveKtmMap('heroMap');
  createDriveKtmMap('exploreMap');
</script>

</body>
</html>