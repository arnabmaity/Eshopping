<%-- 
    Document   : update
    Created on : Oct 11, 2014, 1:36:37 PM
    Author     : arnab
--%>

<%@page import="java.sql.*" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Page</title>
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
                    int cart_item_id = Integer.parseInt(request.getParameter("cart_item_id"));
                    String product_id = request.getParameter("product_id");
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    out.println("Before getting delete Parameter");
                    String delete = request.getParameter("delete");
                    out.println("After getting delete Parameter");
                    int product_price = 0;
                    if (" ".equals(delete)) {
                        stmt.executeUpdate("delete from cart_item where cart_item_id = " + cart_item_id + " and product_id = '" + product_id + "'");
                        response.sendRedirect("show_cart.jsp");
                    } else {
                        if (quantity > 0) {
                            ResultSet rs = stmt.executeQuery("select product_price from products where product_id = '" + product_id + "'");
                            if (rs.next()) {
                                product_price = rs.getInt("product_price");
                                product_price = product_price * quantity;
                            }
                            stmt.executeUpdate("update cart_item set quantity = " + quantity + ",product_price = " + product_price + " where cart_item_id = " + cart_item_id + " and  product_id = '" + product_id + "'");
                        } else {
                            stmt.executeUpdate("delete from cart_item where cart_item_id = " + cart_item_id + " and product_id = '" + product_id + "'");
                        }
                        response.sendRedirect("show_cart.jsp");
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println(e);
                }
            }
        %>
    </body>
</html>