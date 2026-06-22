<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); 
    response.setHeader("Pragma","no-cache"); 
    response.setDateHeader ("Expires", 0);
    
    HttpSession session1 = request.getSession(false);
    if (session1 != null) {
        session1.invalidate();
        response.sendRedirect("Index_B_Login.html");
    } else {
        response.sendRedirect("Index_B_Login.html");
    }
%>
