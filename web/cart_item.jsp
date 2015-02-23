<%-- 
    Document   : Cart
    Created on : Oct 10, 2014, 10:23:53 PM
    Author     : arnab
--%>

<%@page import="java.sql.*" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CART_ITEM</title>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            String username = (String) session.getAttribute("username");
            if (username == null || username == "") {
                session.setAttribute("Error", "Please Login to Add to Cart");
                response.sendRedirect("index.jsp");
            } else {
                int cart_item_id = 0;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshopping", "online_shopping", "arnab");
                    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    String product_id = request.getParameter("product_id");
                    String cart_id = (String) session.getAttribute("cart_item_id");
                    cart_item_id = Integer.parseInt(cart_id);
                    ResultSet rs = stmt.executeQuery("Select product_price from products where product_id = '" + product_id + "'");
                    rs.next();
                    String product_price = rs.getString("product_price");
                    out.println("cart_item_id = " + cart_item_id);
                    out.println("<br/>Added To Cart");
        %>
        <form name="my_account" action="my_account.jsp">
            <input type="submit" value="My Account" name="my_account" />
        </form>
        <br/>
        <a href="show_cart.jsp">
            <img src="show_cart.jpg" alt="" width="50" height="40"/>
        </a>
        <%
            stmt.executeUpdate("insert into cart_item values('" + product_id + "'," + cart_item_id + ",1," + product_price + ")");
            response.sendRedirect("show_cart.jsp");
            conn.close();
        } catch (SQLException e) {

        %>
        <script>
            window.location.href = "show_cart.jsp";
        </script>
        <%} catch (Exception e) {
                    out.println(e);
                }
            }
        %>
    </body>
</html>
