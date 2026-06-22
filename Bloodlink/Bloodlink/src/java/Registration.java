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
import javax.servlet.http.*;

/**
 *
 * @author Soumyajit Chakrabort
 */
public class Registration extends HttpServlet {

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
            String a1, a2, a3, a4,a5,a6;
            a1 = request.getParameter("t1");
            a2 = request.getParameter("t2");
            a3 = request.getParameter("t3");
            a4 = request.getParameter("t4");
            a5 = request.getParameter("t5");
            a6 = request.getParameter("gender");

            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bloodlink?autoReconnect=true&useSSL=false", "root", "");
            st = conn.createStatement();

            String str1 = "CREATE TABLE IF NOT EXISTS data(Name VARCHAR(50), Email VARCHAR(50) PRIMARY KEY, Ph_no VARCHAR(15), Password VARCHAR(50), Address VARCHAR(100), Gender VARCHAR(10))";
            st.executeUpdate(str1);

            String str = "INSERT INTO data(Name, Email, Ph_no, Password, Address, Gender) VALUES ('" + a1 + "','" + a2 + "','" + a3 + "','" + a4 + "','" + a5 + "','" + a6 + "')";
            result = st.executeUpdate(str);

            if (result == 1) {
                // Start session and set attribute
                HttpSession session = request.getSession();
                session.setAttribute("userEmail", a2);  // Or use name, ID, etc.

                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head><title>Servlet Registration</title></head>");
                out.println("<body>");
                out.println("<script type='text/javascript'>");
                out.println("alert('User Registered Successfully!!');");
                out.println("location='login.html';");
                out.println("</script>");
                out.println("</body>");
                out.println("</html>");
            }
        } catch (Exception e) {
            out.println("<script type='text/javascript'>");
            out.println("alert('ERROR OCCURRED!Email already exist');");
            out.println("location='login.html';");
            out.println("</script>");

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

    private Statement executequery(String str1) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
