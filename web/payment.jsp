<%-- 
    Document   : payment
    Created on : Oct 12, 2014, 11:39:33 AM
    Author     : arnab
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*,java.util.*" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Page</title>
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
    <body><p align ="center">
            <br/>        
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
                    String firstname="", middlename = "", lastname="";
                    int payment_id = 0;
                    int customer_id = 1;
                    int total_cost = 0;
                    java.util.Date date = new java.util.Date();
                    SimpleDateFormat sdf = new SimpleDateFormat("E dd-MMM-YYYY hh:mm:ss a");
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshopping", "online_shopping", "arnab");
                        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        stmt.executeUpdate("delete from payment where total_cost = 0");
                        String cart_id = (String) session.getAttribute("cart_item_id");
                        int cart_item_id = Integer.parseInt(cart_id);
                        payment_id = Integer.parseInt(request.getParameter("payment_id"));
                        ResultSet rs = stmt.executeQuery("select customer_id from customers where email_id = '" + username + "'");
                        if (rs.next()) {
                            customer_id = rs.getInt("customer_id");
                        }
                        rs = stmt.executeQuery("select product_price from cart_item where cart_item_id = " + cart_item_id + "");
                        while (rs.next()) {
                            total_cost = total_cost + (rs.getInt("product_price"));
                        }
                        stmt.executeUpdate("insert into payment values (" + customer_id + "," + cart_item_id + "," + total_cost + "," + payment_id + ",'" + sdf.format(date) + "',1,'')");
                        stmt.executeUpdate("delete from payment where total_cost = 0");
                        conn.commit();
                        stmt.executeQuery("commit");
                        out.println("<br/>");
                        rs = stmt.executeQuery("select customer_id,payment_id,cart_item_id as order_id,total_cost,date_purchased from payment where payment_id = " + payment_id + "");
                        ResultSetMetaData rsmd = rs.getMetaData();
                        out.println("<table align = center >");
            %>
    <caption style="font-size: 25px;font-weight: bolder;color: #20845f">My Payment Details</caption>
    <%    out.println("<tr>");
        for (int i = 3; i <= 5; i++) {
            out.println("<th>");
            out.println(rsmd.getColumnName(i));
            out.println("</th>");
        }
        out.println("</tr>");
        while (rs.next()) {
            out.println("<tr>");
            for (int i = 3; i <= 4; i++) {
                if (i == 4) {
                    out.println("<td>");
                    out.println("Rs " + rs.getInt(i));
                    out.println("</td>");
                } else {
                    out.println("<td>");
                    out.println(rs.getInt(i));
                    out.println("</td>");
                }
            }
            out.println("<td>");
            out.println(rs.getString(5));
            out.println("</td>");
            out.println("</tr>");
            out.println("<br/>");
        }
        out.println("</table>");
        rs = stmt.executeQuery("select p.product_name,c.product_price,c.quantity from cart_item c,products p where c.cart_item_id = " + cart_item_id + " and c.product_id = p.product_id and c.product_id <> '0'");
        rsmd = rs.getMetaData();
        if (rs.next()) {
            out.println("<table align = center>");
    %>
    <caption style="font-size: 25px;font-weight: bolder;color: #de805f">My Order Details</caption>
    <%
            out.println("<tr>");
            for (int i = 1; i <= 3; i++) {
                out.println("<th>");
                out.println(rsmd.getColumnName(i));
                out.println("</th>");
            }
            out.println("</tr><br/>");
            rs.previous();
            while (rs.next()) {
                out.println("<tr>");
                for (int i = 1; i <= 3; i++) {
                    if (i == 2) {
                        out.println("<td align = center >Rs " + rs.getString(i) + "</td>");
                    } else {
                        out.println("<td align = center >" + rs.getString(i) + "</td>");
                    }
                }
                out.println("</tr>");
            }
            out.println("</table>");
        }
        rs = stmt.executeQuery("select first_name,middle_name,last_name from customers where email_id = '" + username + "'");
        rs.next();
        if (rs.getString(2) == null) {
            firstname = rs.getString(1);
            lastname = rs.getString(3);
        } else {
            firstname = rs.getString(1);
            middlename = rs.getString(2);
            lastname = rs.getString(3);
        }
    %>

    <strong>Thanks For Shopping <%=firstname + " " + middlename + " " + lastname%></strong>
    <br/>
    <br/>
    <form action="generating_cart_item_id.jsp">
        <input type="submit" value="Shop More" name="shop_more" onmouseover="this.style.backgroundColor = '#66ff00'"; onmouseout="this.style.backgroundColor = '#ccccff'" style="border-radius: 50px;width: 150px;font-weight: bolder;height: 30px;font-size: 19px;font-style: oblique;" />
    </form>
    <br/>
    <form action="logout.jsp">
        <input type="submit" value="LOGOUT" name="logout" style="background-color: violet;border-radius: 50px;font-weight: bolder;width: 100px;height: 40px;font-size: 18px"/>
    </form>
</p>
<%
    conn.close();
} catch (Exception e) {
    // out.println(e);
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshopping", "online_shopping", "arnab");
    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    stmt.executeUpdate("delete from payment where total_cost = 0");
    String cart_id = (String) session.getAttribute("cart_item_id");
    int cart_item_id = Integer.parseInt(cart_id);
    payment_id = Integer.parseInt(request.getParameter("payment_id"));
    ResultSet rs = stmt.executeQuery("select customer_id from customers where email_id = '" + username + "'");
    if (rs.next()) {
        customer_id = rs.getInt("customer_id");
    }
    rs = stmt.executeQuery("select product_price from cart_item where cart_item_id = " + cart_item_id + "");
    while (rs.next()) {
        total_cost = total_cost + (rs.getInt("product_price"));
    }
    out.println("<br/>");
    rs = stmt.executeQuery("select customer_id,payment_id,cart_item_id as Order_id,total_cost,date_purchased from payment where payment_id = " + payment_id + "");
    ResultSetMetaData rsmd = rs.getMetaData();
    out.println("<table align = center >");
%>
<caption style="font-size: 25px;font-weight: bolder;color: #20845f">My Payment Details</caption>
<%
    out.println("<tr>");
    for (int i = 3; i <= 5; i++) {
        out.println("<th>");
        out.println(rsmd.getColumnName(i));
        out.println("</th>");
    }
    out.println("</tr>");
    while (rs.next()) {
        out.println("<tr>");
        for (int i = 3; i <= 4; i++) {
            if (i == 4) {
                out.println("<td>");
                out.println("Rs " + rs.getInt(i));
                out.println("</td>");
            } else {
                out.println("<td>");
                out.println(rs.getInt(i));
                out.println("</td>");
            }
        }
        out.println("<td>");
        out.println(rs.getString(5));
        out.println("</td>");
        out.println("</tr>");
        out.println("<br/>");
    }
    out.println("</table>");
    rs = stmt.executeQuery("select p.product_name,c.product_price,c.quantity from cart_item c,products p where c.cart_item_id = " + cart_item_id + " and c.product_id = p.product_id and c.product_id <> '0'");
    rsmd = rs.getMetaData();
    if (rs.next()) {
        out.println("<table align = center>");
%>
<caption style="font-size: 25px;font-weight: bolder;color: #de805f">My Order Details</caption>
<%out.println("<tr>");
        for (int i = 1; i <= 3; i++) {
            out.println("<th>");
            out.println(rsmd.getColumnName(i));
            out.println("</th>");
        }
        out.println("</tr><br/>");
        rs.previous();
        while (rs.next()) {
            out.println("<tr>");
            for (int i = 1; i <= 3; i++) {
                if (i == 2) {
                    out.println("<td align = center >Rs " + rs.getString(i) + "</td>");
                } else {
                    out.println("<td align = center >" + rs.getString(i) + "</td>");
                }
            }
            out.println("</tr>");
        }
        out.println("</table>");
    }
    rs = stmt.executeQuery("select first_name,middle_name,last_name from customers where email_id = '" + username + "'");
    rs.next();
    if (rs.getString(2) == null) {
        firstname.equals(rs.getString(1));
        lastname = rs.getString(3);
    } else {
        firstname = rs.getString(1);
        middlename = rs.getString(2);
        lastname = rs.getString(3);
    }
%>
<strong>Thanks For Shopping <%=firstname + " " + middlename + " " + lastname%></strong>
<br/>
<br/>
<form action="generating_cart_item_id.jsp">
    <input type="submit" value="Shop More" name="shop_more" onmouseover="this.style.backgroundColor = '#66ff00'"; onmouseout="this.style.backgroundColor = '#ccccff'" style="border-radius: 50px;width: 150px;font-weight: bolder;height: 30px;font-size: 19px;font-style: oblique;" />
</form>
<br/>
<form action="logout.jsp">
    <input type="submit" value="LOGOUT" name="logout" style="background-color: violet;border-radius: 50px;font-weight: bolder;width: 100px;height: 40px;font-size: 18px"/>
</form>
</p>
<%  conn.close();
        }
    }
%>
</body>
</html>
