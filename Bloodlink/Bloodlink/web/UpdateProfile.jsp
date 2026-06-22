<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    // ? Prevent page caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("email") == null) {
        response.sendRedirect("Index_B_Login.html");
        return;
    }

    String email = (String) session1.getAttribute("email");
    String name = "", phone = "", gender = "", address = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bloodlink", "root", "");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM data WHERE email=?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("Name");
            phone = rs.getString("Ph_no");
            gender = rs.getString("Gender");
            address = rs.getString("Address");
        }

        rs.close(); 
        ps.close(); 
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Profile</title>
  <style>
    body {
      font-family: 'Segoe UI', Arial, sans-serif;
      background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
      height: 100vh;
      margin: 0;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .container {
      background: white;
      padding: 40px 50px;
      border-radius: 15px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.1);
      width: 400px;
      text-align: center;
    }

    h2 {
      margin-bottom: 25px;
      color: #333;
    }

    label {
      display: block;
      text-align: left;
      margin-bottom: 5px;
      font-weight: 600;
      color: #444;
    }

    input[type="text"] {
      width: 100%;
      padding: 10px 12px;
      margin-bottom: 15px;
      border: 1px solid #ccc;
      border-radius: 8px;
      box-sizing: border-box;
      font-size: 15px;
      transition: all 0.3s ease;
    }

    input[type="text"]:focus {
      border-color: #5b9bd5;
      box-shadow: 0 0 5px rgba(91,155,213,0.3);
      outline: none;
    }

    button {
      background-color: #5b9bd5;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 8px;
      cursor: pointer;
      font-size: 15px;
      transition: background-color 0.3s;
    }

    button:hover {
      background-color: #4a8ac1;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Edit Your Profile</h2>
    <form action="SaveEdit" method="post">
      <label>Name:</label>
      <input type="text" name="name" value="<%= name %>">
      <label>Phone:</label>
      <input type="text" name="phone" value="<%= phone %>">
      <label>Gender:</label>
      <input type="text" name="gender" value="<%= gender %>">
      <label>Address:</label>
      <input type="text" name="address" value="<%= address %>">
      <button type="submit">Update Profile</button>
    </form>
  </div>

  <!-- ? Prevent going back after form submit -->
  <script>
    if (window.history && window.history.pushState) {
      window.history.pushState(null, null, window.location.href);
      window.onpopstate = function () {
        window.location.replace('Dashboard.jsp');
      };
    }
  </script>
</body>
</html>
