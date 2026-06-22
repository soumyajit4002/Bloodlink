<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
    // Disable caching (prevents back button access after logout)
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Check session
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("email") == null) {
        response.sendRedirect("LoginAdmin.html");
        return;
    }

    String adminName = (String) session1.getAttribute("name");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>BloodLink - Admin Dashboard</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background-color: #f8f8f8;
      display: flex;
    }

    /* Sidebar */
    .sidebar {
      width: 220px;
      height: 100vh;
      background-color: #c62828;
      color: white;
      display: flex;
      flex-direction: column;
      padding: 20px;
    }

    .sidebar h2 {
      margin: 0 0 30px;
      font-size: 22px;
      text-align: center;
    }

    .sidebar a {
      color: white;
      text-decoration: none;
      padding: 12px 10px;
      border-radius: 6px;
      margin-bottom: 10px;
      display: block;
      transition: background 0.3s;
    }

    .sidebar a:hover {
      background-color: #b71c1c;
    }

    /* Main Content */
    .main-content {
      flex-grow: 1;
      padding: 30px;
    }

    .main-content h1 {
      margin-bottom: 20px;
      color: #c62828;
    }

    .dashboard-cards {
      display: flex;
      flex-wrap: wrap;
      gap: 30px;
    }

    .card {
      background-color: #fff;
      width: 220px;
      padding: 20px;
      border-radius: 12px;
      text-align: center;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
      transition: 0.3s;
    }

    .card:hover {
      box-shadow: 0 4px 14px rgba(0,0,0,0.12);
    }

    .card .icon {
      font-size: 28px;
      margin-bottom: 10px;
      color: #c62828;
    }

    .card h3 {
      margin: 10px 0 5px;
      font-size: 18px;
    }

    .card p {
      font-size: 14px;
      color: #555;
    }

    footer {
      text-align: center;
      padding: 20px;
      color: #777;
      font-size: 14px;
      background-color: #f4f4f4;
      margin-top: 40px;
    }
  </style>
</head>
<body>

  <!-- Sidebar -->
  <div class="sidebar">
    <h2>Admin Panel</h2>
    <a href="Dashboard.jsp">Dashboard</a>
    <a href="ManageRequests.jsp">Manage Requests</a>
    <a href="UserAccounts.jsp">User Accounts</a>
    <a href="Logout.jsp">Logout</a>
  </div>

  <!-- Main Content -->
  <div class="main-content">
    <h1>Welcome, <%= adminName %></h1>

    <div class="dashboard-cards">
      <div class="card">
       <div class="icon">?</div>
        <h3>New Requests</h3>
        <p>View pending blood requests</p>
      </div>
      <div class="card">
        <div class="icon">?</div>
        <h3>Verified Donors</h3>
        <p>Check and approve donors</p>
      </div>
      <div class="card">
        <div class="icon">?</div>
        <h3>Reports</h3>
        <p>Generate system reports</p>
      </div>
      <div class="card">
        <div class="icon">??</div>
        <h3>Settings</h3>
        <p>Update admin settings</p>
      </div>
    </div>

    <footer>
      © 2025 BloodLink Admin Portal. All rights reserved.
    </footer>
  </div>

</body>
</html>
