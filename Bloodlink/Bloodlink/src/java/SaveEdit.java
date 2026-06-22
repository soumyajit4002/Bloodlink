import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.sql.*;

public class SaveEdit extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        // 🔒 Prevent browser caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        PrintWriter out = response.getWriter();
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
                out.println("<script type='text/javascript'>");
                out.println("alert('Profile updated successfully!');");
                out.println("window.location='Dashboard.jsp';");
                out.println("if (window.history && window.history.pushState) {");
                out.println("    window.history.pushState(null, null, window.location.href);");
                out.println("    window.onpopstate = function() { window.location.replace('Dashboard.jsp'); };");
                out.println("}");
                out.println("</script>");
            } else {
                showAlert(out, "Error updating profile. Please try again.", "EditProfile.jsp");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace(out);
            showAlert(out, "An error occurred while updating.", "EditProfile.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles profile editing and saving.";
    }

    private void showAlert(PrintWriter out, String message, String redirectPage) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + message + "');");
        out.println("window.location='" + redirectPage + "';");
        out.println("</script>");
    }
}
