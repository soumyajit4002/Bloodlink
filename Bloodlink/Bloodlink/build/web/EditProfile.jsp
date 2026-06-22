<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("email") == null) {
        response.sendRedirect("Index_B_Login.html");
        return;
    }

    String email = (String) session1.getAttribute("email");
    String name = "";
    
    String phone = "";
    String address = "";
    String gender = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bloodlink", "root", "");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM data WHERE email=?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("Name");
            phone = rs.getString("Ph_no");
            address = rs.getString("Address");
            gender = rs.getString("Gender");
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Edit Profile | BloodLink</title>
  <link rel="stylesheet" href="profile.css">
  <style>
    .edit-container {
      width: 400px;
      margin: 60px auto;
      background: #fff;
      padding: 25px;
      border-radius: 15px;
      box-shadow: 0 0 10px rgba(0,0,0,0.2);
    }
    .edit-container h2 {
      text-align: center;
      margin-bottom: 20px;
    }
    .edit-container label {
      display: block;
      margin: 10px 0 5px;
      font-weight: bold;
    }
    .edit-container input, .edit-container select, .edit-container textarea {
      width: 100%;
      padding: 8px;
      border-radius: 5px;
      border: 1px solid #ccc;
    }
    .edit-container button {
      margin-top: 20px;
      width: 100%;
      padding: 10px;
      background-color: #e74c3c;
      color: white;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
    }
    .edit-container button:hover {
      background-color: #c0392b;
    }
  </style>
</head>
<body>
  <div class="edit-container">
    <h2>Edit Profile</h2>
    <form action="SaveEdit" method="post">
      <label>Name:</label>
      <input type="text" name="name" value="<%= name %>" required>

      <label>Phone Number:</label>
      <input type="text" name="phone" value="<%= phone %>" required>

      <label>Gender:</label>
      <select name="gender" required>
        <option value="Male" <%= gender.equals("Male") ? "selected" : "" %>>Male</option>
        <option value="Female" <%= gender.equals("Female") ? "selected" : "" %>>Female</option>
        <option value="Other" <%= gender.equals("Other") ? "selected" : "" %>>Other</option>
      </select>

      <label>Address:</label>
      <textarea name="address" rows="3" required><%= address %></textarea>

      <button type="submit">Save Changes</button>
    </form>
  </div>
</body>
</html>
