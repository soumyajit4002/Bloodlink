<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>BloodLink - User Accounts</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
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
            background: white;
            border-radius: 8px;
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
            background-color: #f2f2f2;
        }

        footer {
            text-align: center;
            padding: 15px;
            margin-top: 30px;
            background: #f4f4f4;
            color: #666;
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Admin Panel</h2>
        <a href="Dashboard.jsp">Dashboard</a>
        <a href="ManageRequests.jsp">Manage Requests</a>
        <a href="#">Donor List</a>
        <a href="UserAccounts.jsp">User Accounts</a>
        <a href="Index_B_Login">Logout</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h1>User Accounts</h1>

        <table>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Phone No</th>
                <th>Password</th>
            </tr>

            <%
                // Database connection and data fetch
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/bloodlink?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useSSL=false",
                        "root", ""
                    );
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM data");

                    while (rs.next()) {
            %>
                        <tr>
                            <td><%= rs.getString("Name") %></td>
                            <td><%= rs.getString("Email") %></td>
                            <td><%= rs.getString("Ph_no") %></td>
                            <td><%= rs.getString("Password") %></td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='4' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (Exception ignored) {}
                    if (stmt != null) try { stmt.close(); } catch (Exception ignored) {}
                    if (conn != null) try { conn.close(); } catch (Exception ignored) {}
                }
            %>
        </table>

        <footer>
            © 2025 BloodLink Admin Portal. All rights reserved.
        </footer>
    </div>

</body>
</html>
