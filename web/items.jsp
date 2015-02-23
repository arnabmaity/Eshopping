<%-- 
    Document   : items
    Created on : Oct 10, 2014, 10:13:14 PM
    Author     : arnab
--%>

<%@page import = "java.sql.*;"%>
<!DOCTYPE html>
<html>
    <style>
        .bigimg1
        {
            width: 300px;
            height: 500px;
            -webkit-transition-property: width, height; // Safari 
            -webkit-transition-duration: 2s; // Safari 
            transition-property: width, height;
            transition-duration: 2s;
        }
        .bigimg1:hover {
            width: 600px;
            height: 800px;
        }
        .table_data:hover
        {
            font-size: xx-large;
            font-weight: inherit;
        }
    </style>
    <%
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        String username = (String) session.getAttribute("username");
        if (username == null || username == "") {
    %>
    <form action="index.jsp">
        <input type="submit" value="LOGIN" name="login" onmouseover="this.style.backgroundColor = '#00FF77'"; onmouseout="this.style.backgroundColor = ''" style="position: fixed; right: 30px;top: 30px" />
    </form>
    <form action="products.jsp">
        <input type="submit" value="Show All Products" name="all" style="border-radius: 40px;width: 150px;height: 30px;font-weight: bolder" />
    </form>
    <%
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshopping", "online_shopping", "arnab");
        Statement stmt = conn.createStatement();
        /*String cart_id = (String) session.getAttribute("cart_item_id");
         int cart_item_id = Integer.parseInt(cart_id);*/
        String product_id = request.getParameter("product_id");
        try {
            ResultSet rs = stmt.executeQuery("SELECT PRODUCT_NAME,PRODUCT_PRICE,OS_VERSION,PROCESSOR,FCAMERA,RCAMERA,BATTERY,FVIEW,RVIEW FROM PRODUCTS WHERE PRODUCT_ID = '" + product_id + "'");
            if (rs.next()) {
                out.println("<table align = " + "center>");
                out.println("<tr>");
                out.println("<td align = " + "center>");
                out.println("<img class = bigimg1 name = bigimg1 src = ./product_images/" + rs.getString(8) + ">");
                out.println("</td></tr>");
                out.println("<tr><td align = " + "center>");
    %>
    <img class = "img1" src = "./product_images/<%=rs.getString(8)%>" width = "70" height = "90" onmouseover = "bigimg1.src = './product_images/<%=rs.getString(8)%>';"></img><img class = "img2" src = "./product_images/<%=rs.getString(9)%>" width = "70" height = "90" onmouseover = "bigimg1.src = './product_images/<%=rs.getString(9)%>';"></img>
    <%
            out.println("</td>");
            out.println("</tr>");
            for (int i = 1; i <= 7; i++) {
                if (i == 2) {
                    out.println("<tr>");
                    out.println("<td class = table_data align = center>");
                    out.println("Rs " + rs.getString(i));
                    out.println("</td>");
                    out.println("</tr>");
                } else {
                    out.println("<tr><td class = table_data align = center>");
                    out.println(rs.getString(i));
                    out.println("</td></tr>");
                }
            }
            out.println("</table>");
        }
    %>

    <%                } catch (Exception e) {
            out.println(e);
        }
    %>
    <center/><a href= "cart_item.jsp?product_id=<%=product_id%>"><img src="add_to_cart.jpg" alt=""/></a>
        <%
            conn.close();
        } else {
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
</p>
<br/>
<a href="show_cart.jsp"><img src="show_cart.jpg" alt="" width="50" height="50" style="position: fixed; right: 30px;top: 30px"/></a>
<form action="products.jsp">
    <input type="submit" value="Show All Products" name="all" style="border-radius: 40px;width: 150px;height: 30px;font-weight: bolder"/>
</form>
<%
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshopping", "online_shopping", "arnab");
    Statement stmt = conn.createStatement();
    /*String cart_id = (String) session.getAttribute("cart_item_id");
     int cart_item_id = Integer.parseInt(cart_id);*/
    String product_id = request.getParameter("product_id");
    try {
        ResultSet rs = stmt.executeQuery("SELECT PRODUCT_NAME,PRODUCT_PRICE,OS_VERSION,PROCESSOR,FCAMERA,RCAMERA,BATTERY,FVIEW,RVIEW FROM PRODUCTS WHERE PRODUCT_ID = '" + product_id + "'");
        if (rs.next()) {
            out.println("<table align = " + "center>");
            out.println("<tr>");
            out.println("<td align = " + "center>");
            out.println("<img class = bigimg1 name = bigimg1 src = ./product_images/" + rs.getString(8) + ">");
            out.println("</td></tr>");
            out.println("<tr><td align = " + "center>");
            //out.println("<img src = " + rs.getString(9) + ">");
%>
<img class = "img1" src = "./product_images/<%=rs.getString(8)%>" width = "70" height = "90" onmouseover = "bigimg1.src = './product_images/<%=rs.getString(8)%>';"></img><img class = "img2" src = "./product_images/<%=rs.getString(9)%>" width = "70" height = "90" onmouseover = "bigimg1.src = './product_images/<%=rs.getString(9)%>';"></img>
<%
        out.println("</td>");
        out.println("</tr>");
        for (int i = 1; i <= 7; i++) {
            if (i == 2) {
                out.println("<tr>");
                out.println("<td class = table_data align = center>");
                out.println("Rs " + rs.getString(i));
                out.println("</td>");
                out.println("</tr>");
            } else {
                out.println("<tr><td class = table_data align = center>");
                out.println(rs.getString(i));
                out.println("</td></tr>");
            }
        }
        out.println("</table>");
    }
%>

<%                } catch (Exception e) {
        out.println(e);
    }
%>
<center/>
<a href= "cart_item.jsp?product_id=<%=product_id%>"><img src="add_to_cart.jpg" alt=""/></a>
    <%
            conn.close();
        }
    %>
</body>
</html>