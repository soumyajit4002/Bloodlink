<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("email") == null) {
        response.sendRedirect("Index_B_Login.html");
        return;
    }

    String email = (String) session1.getAttribute("email");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String gender = request.getParameter("gender");
    String address = request.getParameter("address");

    String message = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bloodlink", "root", "");

        PreparedStatement ps = con.prepareStatement(
            "UPDATE data SET Name=?, Ph_no=?, Gender=?, Address=? WHERE Email=?"
        );
        ps.setString(1, name);
        ps.setString(2, phone);
        ps.setString(3, gender);
        ps.setString(4, address);
        ps.setString(5, email);

        int rows = ps.executeUpdate();
        if (rows > 0) {
            message = "? Profile updated successfully!";
        } else {
            message = "?? Error updating profile. Please try again.";
        }

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        message = "? An error occurred while updating.";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Update Profile | BloodLink</title>
  <style>
    body {
      background-color: #f8f8f8;
      font-family: Arial, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .message-box {
      background: white;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 0 10px rgba(0,0,0,0.2);
      text-align: center;
      width: 350px;
    }
    h2 {
      color: #333;
      margin-bottom: 10px;
    }
    p {
      font-size: 16px;
      margin: 10px 0 25px;
    }
    .btn {
      background-color: #e74c3c;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      font-size: 15px;
      text-decoration: none;
      cursor: pointer;
    }
    .btn:hover {
      background-color: #c0392b;
    }
  </style>
</head>
<body>
  <div class="message-box">
    <h2><%= message %></h2>
    <form action="profile.jsp" method="get">
      <button class="btn">Back to Profile</button>
    </form>
  </div>
</body>
</html>
