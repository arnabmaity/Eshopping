<%-- 
    Document   : my_account
    Created on : Oct 21, 2014, 9:55:44 PM
    Author     : arnab
--%>

<%@page import="java.sql.*" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Account</title>
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

        </br>
        <form action="delete_from_cart_item.jsp">
            <input type="submit" value="LOGOUT" name="logout" style="background-color: violet;border-radius: 50px;font-weight: bolder;width: 100px;height: 40px;font-size: 18px" />
        </form>
        <br/>
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
                rs = stmt.executeQuery("select pay.payment_id,pay.cart_item_id as ORDER_ID,pay.total_cost,pay.date_purchased as DATE_ORDERED, if(pay.order_status = '1','On Way','Delivered') as ORDER_STATUS,pay.date_delivered from payment pay where customer_id = " + customer_id + " order by payment_id desc");
                ResultSetMetaData rsmd = rs.getMetaData();
                if (rs.next() != false) {
                    rs.beforeFirst();
                    out.println("<table align = center>");
        %>
    <caption style="font-size: 25px;font-weight: bolder;color: #de805f">My Orders</caption>
    <%    out.println("<tr>");
            for (int i = 1; i <= 6; i++) {
                out.println("<th>" + rsmd.getColumnName(i) + "</th>");
            }
        }
        out.println("</tr>");
        while (rs.next()) {
            out.println("<tr>");
            for (int i = 1; i <= 6; i++) {
                out.println("<td align = center>");
                if (i == 2) {
    %>
    <a href="show_orders.jsp?cart_item_id=<%=rs.getString(2)%>"><input type="button" value="<%=rs.getString(2)%>" name="cart_item_id" /></a>
        <%
                            } else if (i == 3) {
                                out.println("Rs " + rs.getString(i));
                            } else if (rs.getString(i) == null) {
                                out.println("Not Delivered Yet");
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
