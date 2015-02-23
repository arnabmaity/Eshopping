<%-- 
    Document   : show_orders
    Created on : Oct 22, 2014, 11:56:56 AM
    Author     : arnab
--%>

<%@page import="java.sql.*" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>order details</title>
    </head>
    <style>
        body
        {
            background: url(images/bg.jpg) no-repeat center center fixed; 
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }
    </style>
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
                out.println("Hello " + username + "<br/>");
                int customer_id = 0;
        %>
        <br/>
        <form name="my_account" action="my_account.jsp">
            <input type="submit" value="My Account" name="my_account" style="background-color: #ffcc00;border-radius: 50px;font-weight: bolder;width: 120px;height: 40px;font-size: 18px" />
        </form>
        </br>
        <form action="delete_from_cart_item.jsp">
            <input type="submit" value="LOGOUT" name="logout" style="background-color: violet;border-radius: 50px;font-weight: bolder;width: 100px;height: 40px;font-size: 18px" />
        </form>
        <br/>

        <a href="show_cart.jsp"><img src="show_cart.jpg" alt="" width="50" height="50" style="position: fixed; right: 30px;top: 30px"/></a>
        <br/>
        <form action="products.jsp">
            <input type="submit" value="Show All Products" name="all" style="border-radius: 40px;width: 150px;height: 30px;font-weight: bolder"/>
        </form>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshopping", "online_shopping", "arnab");
                Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                ResultSet rs = stmt.executeQuery("select customer_id from customers where email_id = '" + username + "'");
                if (rs.next()) {
                    customer_id = rs.getInt(1);
                }
                int cart_item_id = Integer.parseInt(request.getParameter("cart_item_id"));
                rs = stmt.executeQuery("select p.fview as PRODUCT_IMAGE,p.product_name,c.quantity,c.product_price,c.product_id from products p,cart_item c where p.product_id = c.product_id and cart_item_id = " + cart_item_id + "");
                ResultSetMetaData rsmd = rs.getMetaData();
                out.println("<h1 align = center>My Orders</h1>");
                if (rs.next() != false) {
                    rs.beforeFirst();
                    out.println("<table align = center>");
                    out.println("<tr>");
                    for (int i = 1; i <= 4; i++) {
                        out.println("<th>" + rsmd.getColumnName(i) + "</th>");
                    }
                }
                out.println("</tr>");
                while (rs.next()) {
                    out.println("<tr>");
                    for (int i = 1; i <= 4; i++) {
                        out.println("<td align = center>");
                        if (i == 1) {
        %>
        <a href="items.jsp?product_id=<%=rs.getString(5)%>"><img src="./product_images/<%=rs.getString(1)%>" width="60" height="90"></a>
            <%
                                } else if (i == 4) {
                                    out.println("Rs " + rs.getString(i));
                                } else {
                                    out.println(rs.getString(i));
                                }
                                out.println("</td>");
                            }
                        }
                        out.println("</table>");
                        conn.close();
                    } catch (Exception e) {
                        out.println(e);
                    }
                }
            %>
    </body>
</html>
