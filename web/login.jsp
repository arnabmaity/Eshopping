<%-- 
    Document   : newjsp
    Created on : Sep 26, 2014, 12:13:13 PM
    Author     : arnab
--%>

<%@page import="java.sql.*" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login check Page</title>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            String username, password;
            username = request.getParameter("username");
            password = request.getParameter("password");
            if (username.equals("admin@gmail.com") && password.equals("admin")) {
                session.setAttribute("username", username);
                response.sendRedirect("admin.jsp");
            }
            String driver = "com.mysql.jdbc.Driver";
            String url = "jdbc:mysql://localhost:3306/eshopping";
            Connection conn = null;
            Statement stmt = null;
            Statement stmt1 = null;
            Statement stmt2 = null;
            Statement stmt3 = null;
            try {
                Class.forName(driver);
                conn = DriverManager.getConnection(url, "online_shopping", "arnab");
                stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                stmt3 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ResultSet rs = stmt.executeQuery("Select customer_id,first_name,last_name from customers where email_id = '" + username + "' and password = '" + password + "'");
                /* if (rs.getInt(1) == 1) {
                 out.println("<h1>Hello " + username + "</h1><br/>");
                 out.println("customer id = " + rs.getInt(1) + "<br/>name = " + rs.getString("first_name") + " " + rs.getString("last_name"));
                 session.setAttribute("username", username);
                 response.sendRedirect("insert_products.jsp");

                 }*/
                if (rs.next()) {
                    out.println("<h1>Hello " + username + "</h1><br/>");
                    out.println("customer id = " + rs.getInt(1) + "<br/>name = " + rs.getString("first_name") + " " + rs.getString("last_name"));
                    session.setAttribute("username", username);
                    //   session.setAttribute("customer_id",rs.getString(1));
                    // delete from cart_item where cart_item_id in (select distinct c.cart_item_id from cart_item c,payment p where c.cart_item_id != p.cart_item_id)
                    ResultSet rs1 = stmt1.executeQuery("select * from payment");
                    if (rs1.next()) {
                        ResultSet rs2 = stmt3.executeQuery("select cart_item_id from cart_item where cart_item_id not in(select distinct p.cart_item_id from payment p)");
                      //  out.println(rs2.next());
                        if(rs2.next())
                        stmt2.executeUpdate("delete from cart_item where cart_item_id in ("+rs2.getInt(1)+")");
                        //   conn.commit();
                    } else {
                        stmt2.executeUpdate("delete from cart_item");
                        //   conn.commit();
                    }
                    response.sendRedirect("generating_cart_item_id.jsp");
                } else {
                    session.setAttribute("Error", "Invalid Username or Password");
                    response.sendRedirect("index.jsp");
                }
            } catch (Exception e) {
                out.println(e);
            }
            conn.close();
        %>

    </body>
</html>
