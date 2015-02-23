<%-- 
    Document   : new
    Created on : Sep 29, 2014, 8:20:40 PM
    Author     : arnab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            String username = (String) session.getAttribute("username");
            if (username == null || username == "") {
                session.setAttribute("Error", "You Have Successfully Logged Out");
                response.sendRedirect("index.jsp");
            } else {
                session.setAttribute("username", null);
                session.invalidate();
                response.sendRedirect("logout.jsp");
            }
        %>
    </body>
</html>
