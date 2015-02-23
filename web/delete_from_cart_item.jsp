<%-- 
    Document   : delete_from_cart_item
    Created on : Oct 13, 2014, 8:25:18 PM
    Author     : arnab
--%>

<%@page import="java.sql.*" contentType="text/html" pageEncoding="UTF-8"%>
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
                session.setAttribute("Error", "Please Login to Surf The Site");
                response.sendRedirect("index.html");
            } else {

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshopping", "online_shopping", "arnab");
                    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    String cart_id = (String) session.getAttribute("cart_item_id");
                    int cart_item_id = Integer.parseInt(cart_id);
                    stmt.executeUpdate("delete from cart_item where cart_item_id = " + cart_item_id + "");
                    response.sendRedirect("logout.jsp");
                    conn.close();
                } catch (Exception e) {
                    out.println(e);
                }
            }
        %>
    </body>
</html>
