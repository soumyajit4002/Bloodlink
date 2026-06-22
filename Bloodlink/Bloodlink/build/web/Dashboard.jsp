<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Prevent caching
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); 
    response.setHeader("Pragma","no-cache"); 
    response.setDateHeader ("Expires", 0);

    // Session check
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("name") == null) {
        response.sendRedirect("Index_B_Login.html");
        return;
    }
    String userName = (String) session1.getAttribute("name");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>BloodLink - Dashboard</title>
  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background-color: #f9f9f9;
    }
    .navbar {
      background-color: white;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 14px 30px;
      border-bottom: 1px solid #ddd;
    }
    .logo {
      font-size: 24px;
      font-weight: bold;
      color: #c62828;
    }
    .nav-links a {
      margin-left: 20px;
      text-decoration: none;
      font-weight: bold;
      color: #333;
    }
    .nav-links a:hover {
      color: #c62828;
    }
    .welcome {
      text-align: center;
      padding: 40px 20px 20px;
    }
    .welcome h2 {
      margin-bottom: 8px;
      font-size: 28px;
    }
    .welcome p {
      color: #555;
      font-size: 16px;
    }
    .card-container {
      display: flex;
      justify-content: center;
      flex-wrap: wrap;
      gap: 30px;
      padding: 20px;
      max-width: 900px;
      margin: auto;
    }
    .card {
      background-color: white;
      width: 200px;
      padding: 25px 20px;
      border-radius: 12px;
      text-align: center;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
      transition: 0.3s;
      cursor: pointer;
    }
    .card:hover {
      box-shadow: 0 4px 14px rgba(0, 0, 0, 0.12);
    }
    .card .icon {
      font-size: 40px;
      margin-bottom: 12px;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .card h3 {
      margin: 0;
      font-size: 18px;
    }
    .card p {
      font-size: 14px;
      color: #555;
      margin-top: 8px;
    }
    footer {
      text-align: center;
      padding: 20px;
      color: #777;
      font-size: 14px;
      background-color: #f4f4f4;
      margin-top: 30px;
    }
  </style>
</head>
<body>

  <!-- Navbar -->
  <div class="navbar">
    <div class="logo">🩸 <span>BloodLink</span></div>
    <div class="nav-links">
      <a href="Dashboard.jsp">Dashboard</a>
      <a href="makerequest.html">My Requests</a>
      <a href="MyDonation.jsp">My Donations</a>
      <a href="UpdateProfile.jsp">Update Profile</a>
      <a href="Logout.jsp">Logout</a>
    </div>
  </div>

  <!-- Welcome -->
  <div class="welcome">
    <h2>Welcome, <%= userName %> 👋</h2>
    <p>Glad to have you back. Here's a quick look at your activity:</p>
  </div>

  <!-- Dashboard Cards -->
  <div class="card-container">
    <div class="card" onclick="location.href='makerequest.html'">
      <div class="icon">📥</div>
      <h3>My Requests</h3>
      <p>View and track blood requests</p>
    </div>
    <div class="card" onclick="location.href='MyDonation.jsp'">
      <div class="icon">🩸</div>
      <h3>My Donations</h3>
      <p>See your donation history</p>
    </div>
    <div class="card" onclick="location.href='UpdateProfile.jsp'">
      <div class="icon">🛠️</div>
      <h3>Profile</h3>
      <p>Update your info and availability</p>
    </div>
    <div class="card" onclick="location.href='FindMatches.jsp'">
      <div class="icon">📡</div>
      <h3>Find Requesters</h3>
      <p>Check matching requesters</p>
    </div>
    <div class="card" onclick="location.href='FindDonars.jsp'">
      <div class="icon">🧑‍🤝‍🧑</div>
      <h3>Find Donors</h3>
      <p>Search for available blood donors</p>
    </div>
  </div>

  <!-- Footer -->
  <footer>
    © 2025 BloodLink. All rights reserved.
  </footer>

</body>
</html>
