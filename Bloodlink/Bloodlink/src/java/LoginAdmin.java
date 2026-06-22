import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * @author Soumalya
 */
public class LoginAdmin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Hardcoded Admin Credentials
        String adminEmail = "admin@gmail.com";
        String adminPassword = "123";   // this acts as admin ID here
        String adminName = "admin";

        try {
            if (email.equals(adminEmail) && password.equals(adminPassword)) {
                // Create session
                HttpSession session1 = request.getSession();
                session1.setAttribute("email", adminEmail);
                session1.setAttribute("name", adminName);

                // Redirect to Admin Dashboard
                response.sendRedirect("admin.jsp");
            } else {
                // Invalid login
                out.println("<html><body>");
                out.println("<script type='text/javascript'>");
                out.println("alert('Invalid Admin ID or Email!');");
                out.println("location='LoginAdmin.html';");
                out.println("</script>");
                out.println("</body></html>");
            }

        } catch (Exception e) {
            out.println("<html><body>");
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
            out.println("</body></html>");
        } finally {
            out.close();
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
        return "Admin Login Servlet";
    }
}
