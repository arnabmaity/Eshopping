<%-- 
    Document   : searched_products
    Created on : Oct 22, 2014, 10:25:18 PM
    Author     : arnab
--%>

<%@page import="java.sql.*" contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Products</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
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
            <input type="submit" value="Show All Products" name="all" style="border-radius: 40px;width: 150px;height: 30px;font-weight: bolder"/>
        </form>
        <br/>
        <br/><p align="center">
            <%
                int c = 0;
                String product_name, battery, fcamera, rcamera, processor, os_version;
                product_name = request.getParameter("product_name").toUpperCase();
                //  out.println(product_name);
                if (product_name == "") {
                    product_name = "%";
                }
                battery = request.getParameter("battery").toUpperCase();
                //    out.println(battery);
                if (battery == "") {
                    battery = "%";
                }
                fcamera = request.getParameter("fcamera").toUpperCase();
                //    out.println(fcamera);
                if (fcamera == "") {
                    fcamera = "%";
                }
                rcamera = request.getParameter("rcamera").toUpperCase();
                //    out.println(rcamera);
                if (rcamera == "") {
                    rcamera = "%";
                }
                processor = request.getParameter("processor").toUpperCase();
                //   out.println(processor);
                if (processor == "") {
                    processor = "%";
                }
                os_version = request.getParameter("os_version").toUpperCase();
                //     out.println(os_version);
                if (os_version == "") {
                    os_version = "%";
                }
                String prod_price = request.getParameter("product_price");
                //    out.println(prod_price);
                String[] product_price = new String[2];
                product_price[0] = "0";
                product_price[1] = "0";
                if (!prod_price.startsWith("s")) {
                    product_price = prod_price.split("-");
                } else {
                    product_price[0] = "0";
                    product_price[1] = "100000000000000";
                }
                //     out.println(product_price[0]);
                //     out.println(product_price[1]);
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshopping", "online_shopping", "arnab");
                    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    String rn;
                    ResultSet rs = stmt.executeQuery("SELECT fview,product_name,product_price,product_id FROM PRODUCTS where product_price between '" + product_price[0] + "' and '" + product_price[1] + "' and product_name like '%" + product_name + "%' and battery like '%" + battery + "%' and fcamera like '%" + fcamera + "%' and rcamera like '%" + rcamera + "%' and processor like '%" + processor + "%' and os_version like '%" + os_version + "%' order by product_price");
                    if (rs.next()) {
                        rs.beforeFirst();
                        while (rs.next()) {
                            if (!rs.getString(4).equalsIgnoreCase("0")) {
            %>
        <table align ="center" style=" float: left;">
            <%
                for (int i = 1; i <= 3; i++) {
                    if (i == 1) {
                        out.println("<tr>");
            %>
            <td align ="center" style="width: 432px;height: 500px">
                <a href="items.jsp?product_id=<%=rs.getString(4)%>"><img src="./product_images/<%=rs.getString(1)%>" width="200" height="400"></a>
                    <%
                                                out.println("</td>");
                                                out.println("</tr>");
                                            } else if (i == 3) {
                                                out.println("<tr>");
                                                out.println("<td align = " + "center>");
                                                out.println("Rs " + rs.getString(i));
                                                out.println("</td>");
                                                out.println("</tr>");
                                            } else {
                                                out.println("<tr>");
                                                out.println("<td align = " + "center>");
                                                out.println(rs.getString(i));
                                                out.println("</td>");
                                                out.println("</tr>");
                                            }
                                        }
                                    }
                                }
                            } else {
                                out.println("<b>SORRY YOUR SEARCH PRODUCED NO RESULTS</b>");
                            }
                            conn.close();
                        } catch (Exception e) {
                            out.println(e);
                        }
                    } else {
                    %>
                <p>
                <form name="my_account" action="my_account.jsp">
        <input type="submit" value="My Account" name="my_account" style="background-color: #ffcc00;border-radius: 50px;font-weight: bolder;width: 120px;height: 40px;font-size: 18px" />
    </form>
    </br>
    <form action="delete_from_cart_item.jsp">
        <input type="submit" value="LOGOUT" name="logout" style="background-color: violet;border-radius: 50px;font-weight: bolder;width: 100px;height: 40px;font-size: 18px" />
    </form>
                <br/>
                <form action="products.jsp">
                    <input type="submit" value="Show All Products" name="all" style="border-radius: 40px;width: 150px;height: 30px;font-weight: bolder"/>
                </form>
                <a href="show_cart.jsp"><img src="show_cart.jpg" alt="" width="50" height="50" style="position: fixed; right: 30px;top: 30px"/></a>
                <br/>
                <br/>
                <p align="center">
                    <%
                        int c = 0;
                        String product_name, battery, fcamera, rcamera, processor, os_version;
                        product_name = request.getParameter("product_name").toUpperCase();
                        //  out.println(product_name);
                        if (product_name == "") {
                            product_name = "%";
                        }
                        battery = request.getParameter("battery").toUpperCase();
                        //    out.println(battery);
                        if (battery == "") {
                            battery = "%";
                        }
                        fcamera = request.getParameter("fcamera").toUpperCase();
                        //    out.println(fcamera);
                        if (fcamera == "") {
                            fcamera = "%";
                        }
                        rcamera = request.getParameter("rcamera").toUpperCase();
                        //    out.println(rcamera);
                        if (rcamera == "") {
                            rcamera = "%";
                        }
                        processor = request.getParameter("processor").toUpperCase();
                        //   out.println(processor);
                        if (processor == "") {
                            processor = "%";
                        }
                        os_version = request.getParameter("os_version").toUpperCase();
                        //     out.println(os_version);
                        if (os_version == "") {
                            os_version = "%";
                        }
                        String prod_price = request.getParameter("product_price");
                        //    out.println(prod_price);
                        String[] product_price = new String[2];
                        product_price[0] = "0";
                        product_price[1] = "0";
                        if (!prod_price.startsWith("s")) {
                            product_price = prod_price.split("-");
                        } else {
                            product_price[0] = "0";
                            product_price[1] = "100000000000000";
                        }
                        //     out.println(product_price[0]);
                        //     out.println(product_price[1]);
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshopping", "online_shopping", "arnab");
                            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            String rn;
                            ResultSet rs = stmt.executeQuery("SELECT fview,product_name,product_price,product_id FROM PRODUCTS where product_price between '" + product_price[0] + "' and '" + product_price[1] + "' and product_name like '%" + product_name + "%' and battery like '%" + battery + "%' and fcamera like '%" + fcamera + "%' and rcamera like '%" + rcamera + "%' and processor like '%" + processor + "%' and os_version like '%" + os_version + "%' order by product_price");
                            if (rs.next()) {
                                rs.beforeFirst();
                                while (rs.next()) {
                                    if (!rs.getString(4).equalsIgnoreCase("0")) {
                    %>
                <table align ="center" style=" float: left;">
                    <%
                        for (int i = 1; i <= 3; i++) {
                            if (i == 1) {
                                out.println("<tr>");
                    %>
                    <td align ="center" style="width: 432px;height: 500px">
                        <a href="items.jsp?product_id=<%=rs.getString(4)%>"><img src="./product_images/<%=rs.getString(1)%>" width="200" height="400"></a>
                            <%
                                                            out.println("</td>");
                                                            out.println("</tr>");
                                                        } else if (i == 3) {
                                                            out.println("<tr>");
                                                            out.println("<td align = " + "center>");
                                                            out.println("Rs " + rs.getString(i));
                                                            out.println("</td>");
                                                            out.println("</tr>");
                                                        } else {
                                                            out.println("<tr>");
                                                            out.println("<td align = " + "center>");
                                                            out.println(rs.getString(i));
                                                            out.println("</td>");
                                                            out.println("</tr>");
                                                        }
                                                    }
                                                }
                                            }
                                        } else {
                                            out.println("<b>SORRY YOUR SEARCH PRODUCED NO RESULTS</b>");
                                        }
                                        conn.close();
                                    } catch (Exception e) {
                                        out.println(e);
                                    }
                                }
                            %>
                        </body>
                        </html>