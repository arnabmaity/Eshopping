<%-- 
    Document   : index
    Created on : Oct 12, 2014, 12:28:16 AM
    Author     : arnab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <title>Login  Form</title>
        <meta name="description" content="Custom Login Form Styling with CSS3" />
        <meta name="keywords" content="css3, login, form, custom, input, submit, button, html5, placeholder" />
        <meta name="author" content="Codrops" />
        <link rel="shortcut icon" href="../favicon.ico"> 
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <script src="js/modernizr.custom.63321.js"></script>
        <!--[if lte IE 7]><style>.main{display:none;} .support-note .note-ie{display:block;}</style><![endif]-->
        <style>	
            @import url(http://fonts.googleapis.com/css?family=Montserrat:400,700|Handlee);
            body {
                background: #eedfcc url(images/bg3.jpg) no-repeat center top;
                -webkit-background-size: cover;
                -moz-background-size: cover;
                background-size: cover;
            }
            .container > header h1,
            .container > header h2 {
                color: #fff;
                text-shadow: 0 1px 1px rgba(0,0,0,0.5);
            }
        </style>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            String error = (String) (session.getAttribute("Error"));
            if (error != "" && error != null) {
                out.println(error);
            }
        %>
        <br><br><br>
    <marquee behavior ="alternate" scrollamount="10" onmouseover="this.stop();" onmouseout="this.start();">
        <a href="products.jsp"><img src="./product_images/MIC004f.jpeg" width="40" height="80"/><img src="./product_images/NOK003f.jpeg" width="45" height="79"/><img src="./product_images/NOK005f.jpg" width="45" height="79"/></a>
    </marquee>
    <div class="container">
        <header>
            <h1><strong>Login Form</strong></h1>				
        </header>
        <section class="main">
            <form class="form-5 clearfix" name="index" action="login.jsp" method="get">
                <p>
                    <input type="text" placeholder="username/email-id" name="username">
                    <input type="password" name="password" id="password" placeholder="Password"> 
                </p>
                <button type="submit" name="submit">
                    <i class="icon-arrow-right"></i>
                    <span>Sign in</span>
                </button>     
            </form>​​​​
            <br/>
            <p align="center" style="font-size: x-large"><a href="registration.html"><strong>Register Here</strong></a></p>
        </section>

    </div>
    <br><br><br>
    <marquee direction="right" behavior ="alternate" scrollamount="10" onmouseover="this.stop();" onmouseout="this.start();" >
        <a href="products.jsp"><img src="./product_images/NOK002f.jpeg" width="40" height="80"/><img src="./product_images/NOK003f.jpeg" width="45" height="79"/><img src="./product_images/NOK005f.jpg" width="45" height="79"/></a>
    </marquee>
    <!-- jQuery if needed -->
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.placeholder.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $('input, textarea').placeholder();
        });
    </script>
</body>
</html>