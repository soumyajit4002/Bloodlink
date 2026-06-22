<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); 
    response.setHeader("Pragma","no-cache"); 
    response.setDateHeader ("Expires", 0);
    %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Manage Requests - BloodLink Admin</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      background-color: #f8f8f8;
      display: flex;
    }

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
      text-align: center;
      margin-bottom: 30px;
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

    .main-content {
      flex-grow: 1;
      padding: 30px;
    }

    h1 {
      color: #c62828;
      margin-bottom: 20px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: #fff;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    th, td {
      padding: 12px 15px;
      text-align: left;
      border-bottom: 1px solid #ddd;
    }

    th {
      background-color: #c62828;
      color: white;
    }

    tr:hover {
      background-color: #f1f1f1;
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
    <a href="Index_B_Login">Logout</a>
  </div>

  <!-- Main Content -->
  <div class="main-content">
    <h1>Manage Blood Requests</h1>

    <table>
      <tr>
        <th>Name</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Blood Group</th>
        <th>Location</th>
        <th>Urgency</th>
      </tr>

      <%
        String url = "jdbc:mysql://localhost:3306/bloodlink";
        String user = "root";
        String pass = "";

        try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          Connection conn = DriverManager.getConnection(url, user, pass);
          Statement stmt = conn.createStatement();
          ResultSet rs = stmt.executeQuery("SELECT * FROM req");

          while (rs.next()) {
      %>
            <tr>
              <td><%= rs.getString("Name") %></td>
              <td><%= rs.getString("Email") %></td>
              <td><%= rs.getString("Ph") %></td>
              <td><%= rs.getString("Bloodgroup") %></td>
              <td><%= rs.getString("Location") %></td>
              <td><%= rs.getString("Urgency") %></td>
            </tr>
      <%
          }
          conn.close();
        } catch (Exception e) {
          out.println("<tr><td colspan='6' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
        }
      %>
    </table>

    <footer>
      © 2025 BloodLink Admin Portal. All rights reserved.
    </footer>
  </div>

</body>
</html>
