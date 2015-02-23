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
    <style>
        body
        {
            background: url() no-repeat center center fixed;
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
        %>
        <div>
            <p align="center">

            <table border="20"  style="border-bottom-color: #99ff66;border-left-width: 20px;border-right-color: #9999ff;border-left-color: yellowgreen;border-top-color: #9999ff;">
                <tr>
                    <td align="center" style="width: 1000px;height: 50px;background: #ffff99"><font style="color: #3300cc;font-size: xx-large;font-size: 80px;font-stretch: extra-condensed;font-style: oblique;font-variant-caps: all-small-caps;font-weight: bold">Welcome To MobiKart</font></td>
                </tr>
            </table>
            <form action="index.jsp">
                <input type="submit" value="LOGIN" name="login" onmouseover="this.style.backgroundColor = '#00FF77'"; onmouseout="this.style.backgroundColor = ''" style="position: fixed; right: 30px;top: 30px;" />
            </form>
            <br/>
            <table border="0">
                <tr><td style="width: 500px;height: 50px;font-weight: bold;font-size: xx-large">Brands</td></tr>
            </table>
            <form action="selected_products.jsp">            
                <table>
                    <tr>
                        <td style="border-radius: 50px"><input type="submit" value="NOKIA" name="NOK" style="border-radius: 50px;width: 100px;height: 60px;background-color: burlywood;font-size: 25px;font-family: cursive;color: #ff3399" /></td>
                        <td><input type="submit" value="MICROMAX" name="MIC" style="border-radius: 50px;width: 160px;height: 60px;background-color: burlywood;font-size: 25px;font-family: cursive;color: #3300ff" /></td>
                        <td><input type="submit" value="SONY" name="SON" style="border-radius: 50px;width: 100px;height: 60px;background-color: burlywood;font-size: 25px;font-family: cursive;color: #ff0000" /></td>
                    </tr>
                </table>
            </form>
            <br/>
            <form action="searched_products.jsp">
                <table border="0" align = center>
                    <tr>
                        <th>MODEL NAME</th>
                        <th>PRICE RANGE</th>
                        <th>OS VERSION</th>
                        <th>PROCESSOR</th>
                        <th>FRONT CAMERA</th>
                        <th>REAR CAMERA</th>
                        <th>BATTERY</th>
                    </tr>
                    <tbody>
                        <tr>
                            <td><input type="text" name="product_name" value="" placeholder="e.g. Xperia E3 SS" /></td>
                            <td><select name="product_price">
                                    <option>select range</option>
                                    <option>2000-5000</option>
                                    <option>5000-9000</option>
                                    <option>9000-10000</option>
                                    <option>10000-15000</option>
                                    <option>15000-20000</option>
                                    <option>20000-38000</option>
                                </select></td>
                            <td><input type="text" name="os_version" value="" placeholder="e.g. Windows Phone 8.1 OS" /></td>
                            <td><input type="text" name="processor" value="" placeholder="e.g. 1.2GHz Qualcomm Snapdragon"/></td>
                            <td><input type="text" name="fcamera" value="" placeholder="e.g. 5 Megapixel" /></td>
                            <td><input type="text" name="rcamera" value="" placeholder="e.g. 8 Megapixel" /></td>
                            <td><input type="text" name="battery" value="" placeholder="e.g. 2800mAh" /></td>
                            <td><input type="submit" value="Search" name="search" style="border-radius: 60px;width: 90px;height: 25px;font-family: fantasy;font-weight: 200px;font-size: medium;background-color: #00cc99" /></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </p>
    </div>
    <p align="center">
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshopping", "online_shopping", "arnab");
                Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                String rn;
                ResultSet rs = stmt.executeQuery("SELECT fview,product_name,product_price,product_id FROM PRODUCTS where product_id != '0' order by product_price");
                while (rs.next()) {
        %>
    <table align ="center" style=" float: left;">
        <%            for (int i = 1; i <= 3; i++) {
                if (i == 1) {
                    out.println("<tr>");
        %>
        <td align ="center" style="width: 432px;height: 500px">
            <a href="items.jsp?product_id=<%=rs.getString(4)%>"><img src="./product_images/<%=rs.getString(1)%>" alt="<%=rs.getString(1)%>" width="200" height="400"></a>
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
                %>
            <div>
                <p align="center">

                <table border="20"  style="border-bottom-color: #99ff66;border-left-width: 20px;border-right-color: #9999ff;border-left-color: yellowgreen;border-top-color: #9999ff;">
                    <tr>
                        <td align="center" style="width: 1000px;height: 50px;background: #ffff99"><font style="color: #3300cc;font-size: xx-large;font-size: 80px;font-stretch: extra-condensed;font-style: oblique;font-variant-caps: all-small-caps;font-weight: bold">Welcome To MobiKart</font></td>
                    </tr>
                </table>
                </p>
                <p>
                <form name="my_account" action="my_account.jsp">
                    <input type="submit" value="My Account" name="my_account" style="background-color: #ffcc00;border-radius: 50px;font-weight: bolder;width: 120px;height: 40px;font-size: 18px" />
                </form>
                <form action="delete_from_cart_item.jsp">
                    <input type="submit" value="LOGOUT" name="logout" style="background-color: violet;border-radius: 50px;font-weight: bolder;width: 100px;height: 40px;font-size: 18px" />
                </form>

                <br/>
                <div>
                    <a href="show_cart.jsp"><img src="show_cart.jpg" alt="" width="50" height="50" style="position: fixed; right: 30px;top: 10px"/></a>
                </div>

                <table border="0">
                    <tr><td style="width: 500px;height: 50px;font-weight: bold;font-size: xx-large">Brands</td></tr>
                </table>
                <form action="selected_products.jsp">            
                    <table>
                        <tr>
                            <td style="border-radius: 50px"><input type="submit" value="NOKIA" name="NOK" style="border-radius: 50px;width: 100px;height: 60px;background-color: burlywood;font-size: 25px;font-family: cursive;color: #ff3399" /></td>
                            <td><input type="submit" value="MICROMAX" name="MIC" style="border-radius: 50px;width: 160px;height: 60px;background-color: burlywood;font-size: 25px;font-family: cursive;color: #3300ff" /></td>
                            <td><input type="submit" value="SONY" name="SON" style="border-radius: 50px;width: 100px;height: 60px;background-color: burlywood;font-size: 25px;font-family: cursive;color: #ff0000" /></td>
                        </tr>
                    </table>
                </form>
                <br/>
                <form action="searched_products.jsp">
                    <table border="0" align = center>
                        <tr>
                            <th>MODEL NAME</th>
                            <th>PRICE RANGE</th>
                            <th>OS VERSION</th>
                            <th>PROCESSOR</th>
                            <th>FRONT CAMERA</th>
                            <th>REAR CAMERA</th>
                            <th>BATTERY</th>
                        </tr>
                        <tbody>
                            <tr>
                                <td><input type="text" name="product_name" value="" placeholder="e.g. Xperia E3 SS" /></td>
                                <td><select name="product_price">
                                        <option>select range</option>
                                        <option>2000-5000</option>
                                        <option>5000-9000</option>
                                        <option>9000-10000</option>
                                        <option>10000-15000</option>
                                        <option>15000-20000</option>
                                        <option>20000-38000</option>
                                    </select></td>
                                <td><input type="text" name="os_version" value="" placeholder="e.g. Windows Phone 8.1 OS" /></td>
                                <td><input type="text" name="processor" value="" placeholder="e.g. 1.2GHz Qualcomm Snapdragon"/></td>
                                <td><input type="text" name="fcamera" value="" placeholder="e.g. 5 Megapixel" /></td>
                                <td><input type="text" name="rcamera" value="" placeholder="e.g. 8 Megapixel" /></td>
                                <td><input type="text" name="battery" value="" placeholder="e.g. 2800mAh" /></td>
                                <td><input type="submit" value="Search" name="search" style="border-radius: 60px;width: 90px;height: 25px;font-family: fantasy;font-weight: 200px;font-size: medium;background-color: #00cc99"/></td>
                            </tr>
                        </tbody>
                    </table>
                </form>
                </p>
                <p align="center">
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshopping", "online_shopping", "arnab");
                            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                            //    String cart_id = (String) session.getAttribute("cart_item_id");
                            //    int cart_item_id = Integer.parseInt(cart_id);
                            String rn;
                            ResultSet rs = stmt.executeQuery("SELECT fview,product_name,product_price,product_id FROM PRODUCTS where product_id != '0' order by product_price");
                            while (rs.next()) {
                    %>
                <table border ="0" align = "center" style="float: left;border: #66ccff" onmouseover="this.border = '1'" onmouseout="this.border = '0'">
                    <%            for (int i = 1; i <= 3; i++) {
                            if (i == 1) {
                                out.println("<tr>");
                                //            out.println("<td align = " + "center>");
%>
                    <td align = "center" style="height: 500px;width: 432px">
                        <a href="items.jsp?product_id=<%=rs.getString(4)%>"><img src= "./product_images/<%=rs.getString(1)%>" width="200" height="400"></a>
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
                            %>

                        <%
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