<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>My Donations</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f8f9fa;
                padding: 30px;
            }
            .container {
                max-width: 800px;
                margin: auto;
            }
            h2 {
                margin-bottom: 20px;
                color: #d9534f;
            }
            form {
                margin-bottom: 25px;
                background: white;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }
            input, select, button {
                padding: 10px;
                margin: 5px;
                font-size: 15px;
            }
            button{
                width: auto;
                padding: 11px;
                background-color: #c62828;
                color: white;
                font-size: 14px;
                font-weight: 600;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            button:hover {
  background-color: #a91f1f;
}
            .donation-card {
                background: white;
                padding: 20px;
                margin-bottom: 15px;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }
            .donation-card h4 {
                margin: 0 0 10px;
            }
            .logout-btn {
                display: inline-block;
                padding: 10px 15px;
                background-color: #5bc0de;
                color: rgba(0, 0, 0, 0.12);
                border: none;
                border-radius: 5px;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>My Donations</h2>

            <%
                HttpSession sess = request.getSession(false);
                if (sess == null || sess.getAttribute("email") == null) {
                    response.sendRedirect("login.html");
                    return;
                }

                String userEmail = (String) sess.getAttribute("email");

                Connection con = null;
                Statement st = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");  // ✅ updated driver
                    con = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/bloodlink?autoReconnect=true&useSSL=false",
                            "root", ""
                    );

                    st = con.createStatement();

                    // ✅ Create table if not exists
                    String createTable = "CREATE TABLE IF NOT EXISTS donations ("
                            + "ID INT AUTO_INCREMENT PRIMARY KEY,"
                            + "Email VARCHAR(100),"
                            + "Bloodgroup VARCHAR(10),"
                            + "Location VARCHAR(50),"
                            + "DonationDate DATE,"
                            + "Units INT)";
                    st.executeUpdate(createTable);

                    // ✅ Insert donation if form submitted
                    String bg = request.getParameter("bloodGroup");
                    String loc = request.getParameter("location");
                    String date = request.getParameter("donationDate");
                    String units = request.getParameter("units");

                    if (bg != null && loc != null && date != null && units != null) {
                        String insertSql = "INSERT INTO donations (Email, Bloodgroup, Location, DonationDate, Units) VALUES (?, ?, ?, ?, ?)";
                        ps = con.prepareStatement(insertSql);
                        ps.setString(1, userEmail);
                        ps.setString(2, bg);
                        ps.setString(3, loc);
                        ps.setString(4, date);
                        ps.setInt(5, Integer.parseInt(units));
                        ps.executeUpdate();
                    }

                    // ✅ Fetch donations
                    String sql = "SELECT * FROM donations WHERE Email=? ORDER BY DonationDate DESC";
                    ps = con.prepareStatement(sql);
                    ps.setString(1, userEmail);
                    rs = ps.executeQuery();
            %>

            <!-- Add Donation Form -->
            <form method="post">
                <select name="bloodGroup" required>
                    <option value="">Select Blood Group</option>
                    <option>A+</option><option>A-</option>
                    <option>B+</option><option>B-</option>
                    <option>O+</option><option>O-</option>
                    <option>AB+</option><option>AB-</option>
                </select>
                <input type="text" name="location" placeholder="Location" required />
                <input type="date" name="donationDate" required />
                <input type="number" name="units" placeholder="Units Donated" min="1" required />
                <button type="submit">Add Donation</button>
            </form>

            <%
                boolean hasDonations = false;
                while (rs.next()) {
                    hasDonations = true;
            %>
            <div class="donation-card">
                <h4>Donation at <%= rs.getString("Location")%></h4>
                <p><strong>Blood Group:</strong> <%= rs.getString("Bloodgroup")%></p>
                <p><strong>Date:</strong> <%= rs.getString("DonationDate")%></p>
                <p><strong>Units Donated:</strong> <%= rs.getInt("Units")%></p>
            </div>
            <%
                    }
                    if (!hasDonations) {
                        out.println("<p>You have not recorded any donations yet.</p>");
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) {
                        rs.close();
                    }
                    if (ps != null) {
                        ps.close();
                    }
                    if (st != null) {
                        st.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                }
            %>

            <br>
            <!-- ✅ Correct Logout link -->
            <a href="Logout" class="logout-btn">Logout</a>
        </div>
    </body>
</html>
