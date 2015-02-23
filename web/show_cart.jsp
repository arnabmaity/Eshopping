<%-- 
    Document   : show_cart
    Created on : Oct 11, 2014, 12:19:06 PM
    Author     : arnab
--%>

<%@page import="java.sql.*" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
    </head>
    <style>
        .save:hover
        {
            background-color: #66cc00;
        }        
        body
        {
            background: url(images/bg7.jpg) no-repeat center center fixed;
            // background-color: #ffb253;
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
                int sub_total = 0;
        %>
        <p>
            <br/>
        <form name="my_account" action="my_account.jsp">
            <input type="submit" value="My Account" name="my_account" style="background-color: #ffcc00;border-radius: 50px;font-weight: bolder;width: 120px;height: 40px;font-size: 18px" />
        </form>
        </br>
        <form action="delete_from_cart_item.jsp">
            <input type="submit" value="LOGOUT" name="logout" style="background-color: violet;border-radius: 50px;font-weight: bolder;width: 100px;height: 40px;font-size: 18px" />
        </form>
        </br>
        <form action="products.jsp">
            <input type="submit" value="Show All Products" name="all" style="border-radius: 40px;width: 150px;height: 30px;font-weight: bolder"/>
        </form>

    </p>
    <%            try {
            out.println("hello " + username);
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshopping", "online_shopping", "arnab");
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String cart_id = (String) session.getAttribute("cart_item_id");
            int cart_item_id = Integer.parseInt(cart_id);
            ResultSet rs = stmt.executeQuery("select c.cart_item_id,c.product_id,p.product_name,c.product_price,c.quantity,p.fview as image from cart_item c,products p where c.cart_item_id = " + cart_item_id + " and c.product_id = p.product_id and c.product_id <> '0'");
            ResultSetMetaData rsmd = rs.getMetaData();
            if (rs.next()) {
    %>
    <table align = center border="0" style="position: static">
        <caption style="font-size: xx-large;font-weight: bolder">My Cart</caption>
        <%
            out.println("<tr>");
            out.println("<th align = center>");
            out.println(rsmd.getColumnName(6));
            out.println("</th>");
            for (int i = 3; i <= 5; i++) {
                out.println("<th align = center>");
                out.println(rsmd.getColumnName(i));
                out.println("</th>");
            }
            out.println("</tr>");
            rs.beforeFirst();
            while (rs.next()) {

        %>
        <form action="update.jsp">
            <%        out.println("<tr>");
                out.println("<td align = center><a href=items.jsp?product_id=" + rs.getString(2) + "><img src = ./product_images/" + rs.getString(6) + " width = 60 height = 90 ></a></td>");
                for (int i = 3; i <= 4; i++) {
                    if (i == 1) {
                        out.println("<td align = center>");%>
            <input type="number" name="cart_item_id" id="cart_item_id" value="<%=rs.getString(i)%>" readonly="readonly"  style="border: none;background: transparent;width: 30px;height: 30px;"/>
            <% out.println("</td>");
            } else if (i == 2) {
                out.println("<td align = center>");%>
            <input type="text" name="product_id" id="product_id" value="<%=rs.getString(i)%>" readonly="readonly"  style="border: none;background: transparent;width: 50px;height: 30px"/>
            <% out.println("</td>");
            } else if (i == 4) {
            %>
            <td align = center style="font-size: 20px;font-weight: bolder;width: 100px;height: 28px">
                <% out.println("Rs " + rs.getString(i));
                    out.println("</td>");
                } else {
                %>
            <td align = center style="font-size: 20px;font-weight: bolder;width: 400px;height: 28px">
                <%    out.println(rs.getString(i));
                            out.println("</td>");
                        }
                    }
                    out.println("<td align = center>");
                %>                 
                <input type="number" name="quantity" id="quantity" value="<%=rs.getInt(5)%>" style="width: 60px;height: 30px;border: none;background: transparent;font-weight: bolder;font-size: 20px"/>
                <br/>
                <input class="save" type="submit" value="Save" name="save" style="font-weight: bolder;" />
                <%
                    out.println("</td>");
                    out.println("<td align = center>");
                %>
                <input type="submit" value=" " name="delete" id="delete" style="width: 50px;height: 50px;background: url(delete.jpg);border: none;"/>
                <%
                    out.println("</td>");
                    out.println("<td align = center>");
                %>
                <input type="hidden" name="cart_item_id" id="cart_item_id" value="<%=rs.getString(1)%>" readonly="readonly"  style="border: none;background: transparent;width: 30px;height: 30px;"/>
                <%
                    out.println("</td>");
                    out.println("<td align = center>");%>
                <input type="hidden" name="product_id" id="product_id" value="<%=rs.getString(2)%>" readonly="readonly"  style="border: none;background: transparent;width: 50px;height: 30px"/>
                <%
                        out.println("</td>");
                        out.println("</tr></form>");
                        out.println("<br/>");
                    }
                    out.println("</table>");
                %>
        </form>
        <p align="center">
            <%
                rs = stmt.executeQuery("select product_price from cart_item where cart_item_id = " + cart_item_id + "");
                while (rs.next()) {
                    sub_total = sub_total + (rs.getInt("product_price"));
                }
                out.println("<b style='font-size: 25px'>SUB TOTAL : Rs " + sub_total + "</b>");
            %>
        </p>
        <form align="center" action="generating_payment_id.jsp">
            <input type="submit" value="PLACE ORDER" name="place_order" style="background-color: #66cc00;border-radius: 50px;font-weight: bolder;width: 150px;height: 40px;font-size: 18px" />
        </form>
        <%
        } else {
            out.println("<br/><br/><strong align = center>No Items To Display" + "</strong>");  %>

        <%
                        conn.close();
                    }
                } catch (Exception e) {
                    out.println(e);
                }
            }
        %>
</body>
</html>
