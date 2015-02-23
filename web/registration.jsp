<%-- 
    Document   : registration
    Created on : Sep 17, 2014, 12:02:16 PM
    Author     : arnab
--%>

<%@page import="java.sql.*,java.text.*,java.util.*" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration Status Page</title>
    </head>
    <h1 align ="center">Registration Status</h1>
    <body align = "center">
        <style>
            .font1
            {
                font-family: cursive;
                font-size: xx-large;
            }
            .font2
            {
                font-size: xx-large;
            }
            html
            {
                background: url() no-repeat center center fixed; 
                //  -webkit-background-size: cover;
                //  -moz-background-size: cover;
                //  -o-background-size: cover;
                background-size: cover;
            }
        </style>
        <%
            //firstname=arnab&middlename=&lastname=maity&dob=1994-03-16&address=43%2F1A+Middle+Road&city=Kolkata&state=West+Bengal&country=India&email=arnmaity16%40gmail.com&mobile=9674487417&password=123&confirm_password=123&Educational_Qualification=10%2B2&gender=male&ok=Submit
            //  static int sa = 1;;;
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            String pincode, fn, mn, ln, dd, mm, yy, dob, addr, city, state, country, email, pass, cpass, edu, sex, mob;
            int c = 0;
            SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yyyy");/* format in which the date is to be formatted*/

            SimpleDateFormat pd = new SimpleDateFormat("yyyy-MM-dd");/* format in which the date is present */

            int flag = 0, passcheck = 0;
            fn = request.getParameter("firstname");
            mn = request.getParameter("middlename");
            ln = request.getParameter("lastname");
            dob = request.getParameter("dob");
            java.util.Date date = (java.util.Date) pd.parse(dob);
            dob = df.format(date);
            addr = request.getParameter("address");
            city = request.getParameter("city");
            pincode = request.getParameter("pincode");
            state = request.getParameter("state");
            country = request.getParameter("country");
            email = request.getParameter("email");
            pass = request.getParameter("password");
            cpass = request.getParameter("confirm_password");
            edu = request.getParameter("Educational_Qualification");
            sex = request.getParameter("gender");
            mob = request.getParameter("mobile");
            String driver = "com.mysql.jdbc.Driver";
            String url = "jdbc:mysql://localhost:3306/eshopping";
            Connection conn = null;
            Statement stmt = null;
            int cid = 0;
            try {
                // int cid = 0;
                Class.forName(driver);
                conn = DriverManager.getConnection(url, "online_shopping", "arnab");
                stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ResultSet rs = stmt.executeQuery("select customer_id from customers order by customer_id");
                if (rs.last()) {
                    cid = rs.getInt("customer_id");
                }
                cid = cid + 1;

                int i = stmt.executeUpdate("Insert into customers values (" + cid + ",'" + fn + "','" + mn + "','" + ln + "','" + dob + "','" + addr + "','" + city + "','" + state + "','" + country + "','" + email + "','" + mob + "','" + pass + "','" + edu + "','" + sex + "','" + pincode + "')");
                out.println("<p class = font1 >Registration Successful<br/>");
                // out.println("<br/>" + i + " row inserted");

                out.println("<br/>Welcome " + fn + " " + ln);

                out.println("");
                out.println("<hr/>");
                out.println("<p class = font2 >Firstname : " + fn + "<br/>");
                out.println("Lastname : " + ln + "<br/>");
                out.println("Gender : " + sex + "<br/>");
                out.println("date of birth : " + dob + "<br/>");
                out.println("Address : " + addr + "<br/>");
                out.println("City : " + city + "<br/>");
                out.println("State : " + state + "<br/>");
                out.println("Country : " + country + "<br/>");
                out.println("Mobile Number : " + mob + "<br/>");
                out.println("Email_id : " + email + "<br/>");
                out.println("Password : " + pass + "<br/>");
                out.println("Educational Qualification : " + edu + "<br/></p>");
        %>
        <form action="login.jsp">
            <input type="text" hidden="" name="username" value="<%=email%>" />
            <input type="text" name="password" hidden="" value="<%=pass%>" />
            <input type="submit" value="LOGIN" name="login" />
        </form>
        <%
                conn.close();
            } catch (Exception e) {
                // conn.rollback();
                out.println(e);
                out.println("<b>Email_id In Use.Please Enter Another Email-id in Registration Page</b>");
                //out.println(cid);
                //out.println(e);
                out.println("");
                out.println("<hr/>");
                out.println("<p class = font2 >Firstname : " + fn + "<br/>");
                out.println("Lastname : " + ln + "<br/>");
                out.println("Gender : " + sex + "<br/>");
                out.println("date of birth : " + dob + "<br/>");
                out.println("Address : " + addr + "<br/>");
                out.println("City : " + city + "<br/>");
                out.println("State : " + state + "<br/>");
                out.println("Country : " + country + "<br/>");
                out.println("Mobile Number : " + mob + "<br/>");
                out.println("Email_id : " + email + "<br/>");
                out.println("Password : " + pass + "<br/>");
                out.println("Educational Qualification : " + edu + "<br/></p>");
                conn.close();
                if (conn != null) {
                    conn = null;

                }
            }
        %>    

    </body>
</html>