<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%> 
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>   <!-- ✅ Enable Session -->
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); 
    response.setHeader("Pragma","no-cache"); 
    response.setDateHeader ("Expires", 0);
    %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Find Matches</title>
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

            .filter-box {
                display: flex;
                gap: 10px;
                margin-bottom: 25px;
            }

            select, .search-btn {
                padding: 10px;
                font-size: 14px;
            }

            .search-btn {
                background-color: #d9534f;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 5px;
            }

            .match-card {
                background: white;
                padding: 20px;
                margin-bottom: 15px;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .match-info {
                display: flex;
                align-items: center;
            }

            .avatar {
                width: 60px;
                height: 60px;
                background-color: #d9534f;
                border-radius: 50%;
                margin-right: 15px;
            }

            .details h4 {
                margin: 0;
                font-size: 18px;
            }

            .btn-group {
                display: flex;
                gap: 10px;
            }

            .btn-contact, .btn-email {
                padding: 8px 12px;
                border: none;
                color: white;
                background-color: #5bc0de;
                border-radius: 5px;
                cursor: pointer;
            }

            .btn-email {
                background-color: #5cb85c;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <h2>Find Matching Requesters</h2>

            <!-- Search Form -->
            <form method="get" class="filter-box">
                <select name="bloodGroup">
                    <option value="">All Blood Groups</option>
                    <option>A+</option><option>A-</option>
                    <option>B+</option><option>B-</option>
                    <option>O+</option><option>O-</option>
                    <option>AB+</option><option>AB-</option>
                </select>
                <select name="location">
                    <option value="">Select Locations</option>
                    <option>Kolkata</option>
                    <option>Delhi</option>
                    <option>Mumbai</option>
                    <option>Chennai</option>
                </select>
                <button class="search-btn" type="submit">Search</button>
            </form>

            <%
                HttpSession sess = request.getSession();

                // Store filters in session
                if (request.getParameter("bloodGroup") != null) {
                    sess.setAttribute("bloodGroup", request.getParameter("bloodGroup"));
                }
                if (request.getParameter("location") != null) {
                    sess.setAttribute("location", request.getParameter("location"));
                }

                // Retrieve from request or session
                String bg = request.getParameter("bloodGroup");
                if (bg == null || bg.isEmpty()) {
                    bg = (String) sess.getAttribute("bloodGroup");
                }

                String lo = request.getParameter("location");
                if (lo == null || lo.isEmpty()) {
                    lo = (String) sess.getAttribute("location");
                }

                Connection con = null;
                Statement st = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bloodlink?autoReconnect=true&useSSL=false", "root", "");
                    st = con.createStatement();
                    rs = st.executeQuery("SELECT * FROM req WHERE Bloodgroup='" + bg + "' and location='" + lo + "'");

                    while (rs.next()) {
                        String name = rs.getString("Name");
                        String bloodGroup = rs.getString("Bloodgroup");
                        String location = rs.getString("Location");
                        String email = rs.getString("Email");
                        String phone = rs.getString("Ph");
            %>
 <script>
    function showalert() {
        let number="<%= phone %>";
        alert("Number: "+number);
        return false;
    }
</script>
            <!-- Donor Card -->
            <div class="match-card">
                <div class="match-info">
                    <div class="avatar"></div>
                    <div class="details">
                        <h4><%= name%></h4>
                        <p>Blood Group: <%= bloodGroup%></p>
                        <p>Location: <%= location%></p>
                    </div>
                </div>
                <div class="btn-group">
                    <form onclick="showalert()">
                        <button class="btn-contact" type="submit">Call</button>
                    </form>
                    <form action="mailto:<%= email%>">
                        <button class="btn-email" type="submit">Email</button>
                    </form>
                </div>
            </div>
                        
            <%
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Err: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) {
                        rs.close();
                    }
                    if (st != null) {
                        st.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                }
            %>
        </div>
    </body>
</html>
