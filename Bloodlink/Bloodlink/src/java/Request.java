/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 *
 * @author Soumalya
 */
public class Request extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Connection conn;
        Statement st;
        //  ResultSet rs;
        int result = 0;
        try {
            /* TODO output your page here. You may use following sample code. */
            String a1, a2, a3, a4, a5, a6;
            a1 = request.getParameter("name");
            a2 = request.getParameter("email");
            a3 = request.getParameter("ph");
            a4 = request.getParameter("bloodGroup");
            a5 = request.getParameter("location");
            a6 = request.getParameter("urgency");
            

            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bloodlink?autoReconnect=true&useSSL=false", "root", "");
            st = conn.createStatement();
            String str1;
            str1 = "Create table if not exists req(Name varchar(50), Email varchar(20), Ph varchar(10), Bloodgroup varchar(20), Location varchar(100), Urgency varchar(10))";
            st.executeUpdate(str1);
            String str = "INSERT INTO REQ(Name, Email, Ph, Bloodgroup, Location, Urgency) VALUES ('" + a1 + "','" + a2 + "','" + a3 + "','"+a4+"','"+a5+"','"+a6+"')";
            result = st.executeUpdate(str);
            /* TODO output your page here. You may use following sample code. */
           
           // ... inside your try block, after successful result ...
            if (result == 1) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<script type='text/javascript'>");
                out.println("alert('Requested Successfully!!');");
                // Use replace() instead of assigning to window.location
                out.println("window.location.replace('Dashboard.jsp');");
                out.println("</script>");
                out.println("</head><body>");
                out.println("</body>");
                out.println("</html>");
            }
// ... rest of your code ...

            out.println("</head><body>");
            out.println("</body>");
            out.println("</html>");

        } catch (ClassNotFoundException | SQLException e) {
            out.println("ERROR OCCURED! May be primary key violated or invalid data entry.");
        } finally {
            out.close();
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
