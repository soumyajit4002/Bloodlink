import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class Login extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/bloodlink?autoReconnect=true&useSSL=false", "root", ""
            );

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM data WHERE email='" + email + "' AND password='" + password + "'");

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("email", email);
                session.setAttribute("name", rs.getString("Name"));
                response.sendRedirect("Dashboard.jsp");
            } else {
                showAlert(out, "Invalid Email or Password!", "login.html");
            }
        } catch (Exception e) {
            showAlert(out, "Server error: " + e.getMessage(), "login.html");
        } finally {
            out.close();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }

    public String getServletInfo() { return "Login Servlet"; }

    private void showAlert(PrintWriter out, String message, String redirectPage) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + message + "');");
        out.println("location='" + redirectPage + "';");
        out.println("</script>");
    }
}
