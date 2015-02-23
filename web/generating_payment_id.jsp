<%-- 
    Document   : generating_payment_id
    Created on : Oct 22, 2014, 11:25:33 AM
    Author     : arnab
--%>

<%@page import="java.sql.*" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String username = (String) session.getAttribute("username");
            if (username == null || username == "") {
                session.setAttribute("Error", "Please Login to Surf The Site");
                response.sendRedirect("index.html");
            } else {
                String firstname, middlename = "", lastname;
                int payment_id = 0;
                int customer_id = 1;
                int total_cost = 0;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshopping", "online_shopping", "arnab");
                    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    ResultSet rs = stmt.executeQuery("select payment_id from payment order by payment_id");
                    if (rs.last()) {
                        payment_id = rs.getInt("payment_id");
                    }
                    payment_id = payment_id + 1;
        %>
        <script>
            window.location.href = "payment.jsp?payment_id=<%=payment_id%>";
        </script>>
        <%
        conn.close();
     } catch (Exception e) {
         out.println(e);
     }
 }
        %>
    </body>
</html>
