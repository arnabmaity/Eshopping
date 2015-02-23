<%-- 
    Document   : generating_cart_item_id
    Created on : Oct 11, 2014, 10:52:06 AM
    Author     : arnab
--%>

<%@page import="java.sql.*" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart_Item_Id</title>
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
                    int cart_item_id = 0;
                    ResultSet rs = stmt.executeQuery("Select distinct cart_item_id from cart_item order by cart_item_id");
                    if (rs.last()) {
                        rs.last();
                        cart_item_id = rs.getInt(1);
                    }
                    cart_item_id = cart_item_id + 1;
                    stmt.executeUpdate("Insert into cart_item values(0," + cart_item_id + ",0,0)");
                    out.println("cart_item_id = " + cart_item_id);
                    session.setAttribute("cart_item_id", String.valueOf(cart_item_id));
                    stmt.executeUpdate("delete from cart_item where cart_item_id = " + cart_item_id + " and product_id = '0'");
        %>
        <script>
            window.location.href = "products.jsp";
        </script>
        <%
                    conn.close();
                } catch (Exception e) {
                    out.println(e);
                }
            }
        %>
    </body>
</html>
