<%-- 
    Document   : newjsp
    Created on : Sep 26, 2014, 12:13:13 PM
    Author     : arnab
--%>

<%@page import = "java.sql.*;"%>
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
                String product_id = "";
                String nokia = request.getParameter("NOK");
                String micromax = request.getParameter("MIC");
                String sony = request.getParameter("SON");
                if (nokia != null) {
                    product_id = "NOK%";
                } else if (micromax != null) {
                    product_id = "MIC%";
                } else if (sony != null) {
                    product_id = "SON%";
                }
        %>
        <form action="index.jsp">
            <input type="submit" value="LOGIN" name="login" onmouseover="this.style.backgroundColor = '#00FF77'"; onmouseout="this.style.backgroundColor = ''" style="position: fixed; right: 30px;top: 30px" />
        </form>
        <br/>
        <form action="products.jsp">
            <input type="submit" value="Show All Products" name="all" style="border-radius: 40px;width: 150px;height: 30px;font-weight: bolder"/>
        </form>
    </p>
    <p align="center">
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshopping", "online_shopping", "arnab");
                Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                //   String cart_id = (String) session.getAttribute("cart_item_id");
              /*  if (cart_id != null || cart_id != "") {
                 int cart_item_id = Integer.parseInt(cart_id);
                 }*/
                String rn;
                ResultSet rs = stmt.executeQuery("SELECT fview,product_name,product_price,product_id FROM PRODUCTS where product_id != '0' and product_id like '" + product_id + "' order by product_price");
                while (rs.next()) {
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
                        conn.close();
                    } catch (Exception e) {
                        out.println(e);
                    }
                } else {
                    String product_id = "";
                    String nokia = request.getParameter("NOK");
                    String micromax = request.getParameter("MIC");
                    String sony = request.getParameter("SON");
                    if (nokia != null) {
                        product_id = "NOK%";
                    } else if (micromax != null) {
                        product_id = "MIC%";
                    } else if (sony != null) {
                        product_id = "SON%";
                    }
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
            <br/>
            <br/>
            <form action="products.jsp">
                <input type="submit" value="Show All Products" name="all" style="border-radius: 40px;width: 150px;height: 30px;font-weight: bolder"/>
            </form>
            <a href="show_cart.jsp"><img src="show_cart.jpg" alt="" width="50" height="50" style="position: fixed; right: 30px;top: 30px"/></a>
            </p>
            <p align="center">
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshopping", "online_shopping", "arnab");
                        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        String rn;
                        ResultSet rs = stmt.executeQuery("SELECT fview,product_name,product_price,product_id FROM PRODUCTS where product_id != '0' and product_id like '" + product_id + "' order by product_price");
                        while (rs.next()) {
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
                                    conn.close();
                                } catch (Exception e) {
                                    out.println(e);
                                }

                            }
                        %>
                    </p>


                    </body>
                    </html>