
<%-- 
    Document   : Userhome
    Created on : Jan 1, 2021, 2:39:14 AM
    Author     : Nardin
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <link type="text/css" rel="stylesheet" href="mycss.css">
    <script type="text/javascript">
        function sendajax() {
            var username = document.getElementById("username").value;


            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function ()
            {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                {
                    document.getElementById("show_response").innerHTML = xmlhttp.responseText;
                }
            }

            xmlhttp.open("GET", "GetContact?username=" + username, true);
            xmlhttp.send();
        }
    </script>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home - Office Hours Management</title>
    </head>

    <body>     
        <%
            String check = "";
            String checkstaff = "";
            if (request.getSession().getAttribute("checkFound") != null) {
                check = request.getSession().getAttribute("checkFound").toString();

            }
            if (request.getSession().getAttribute("checkstaffFound") != null) {
                checkstaff = request.getSession().getAttribute("checkstaffFound").toString();

            }
            String username = request.getSession().getAttribute("session_username").toString();
            String type = request.getSession().getAttribute("session_type").toString();
            String UserEmail = request.getSession().getAttribute("session_useremail").toString();
            String name = request.getSession().getAttribute("session_name").toString();

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/staffmembers", "root", "root");
            Statement statement = con.createStatement();

            String sql = "SELECT* FROM staffmembers.user WHERE username='" + username + "';";
            ResultSet rs = statement.executeQuery(sql);
            rs.next();
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            String today = sdf.format(new Date()).toString();
            SimpleDateFormat formater = new SimpleDateFormat("dd/MM/yyyy");
            Date todays = formater.parse(today);
            Date dateofT;
            int days;

        %>

        <header>
            <h1 class="id">Welcome, <%= rs.getString("name")%> </h1>
        </header>

        <%
            if (type.equals("0")) {
                session.setAttribute("session_tousername", null);
                sql = " Select * from staffmembers.notifications where toUsername = '"
                        + username + "';";
                rs = statement.executeQuery(sql);
                int counter = 0;
                while (rs.next()) {
                    if (!(rs.getString("date") == null)) {
                        dateofT = formater.parse(rs.getString("date"));
                        days = (int) ((todays.getTime() - dateofT.getTime()) / (1000 * 60 * 60 * 24));
                        if (days == 0) {
                            counter++;
                        }
                    } else {
                        counter++;
                    }
                }
                sql = " Select * from staffmembers.message where tousername = '"
                        + username + "';";
                rs = statement.executeQuery(sql);
                int counter1 = 0;
                while (rs.next()) {
                    counter1++;
                }
        %>
        <ul>
            <li><a href="Profile.jsp">Profile</a></li>

            <li><a href="Messages.jsp"class="notification"> <span>Messages</span>
                    <span class="badge" ><%= counter1%> </span></a></li>
            <li><a href="Notifications.jsp"class="notification"> <span>Notifications</span>
                    <span class="badge" ><%= counter%> </span></a></li>
            <li><a href="meetings.jsp">Meetings</a></li>
            <li><a href="#contact">Contact</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="Logout">Logout</a></li>
        </ul>
        <div style="margin-left: 12%">
            <form >
                <label>Enter staff member username: </label>
                <input id="username" name="username" placeholder="Staff member username"/>
                <br>
                <input class = "Large" type="submit" value="View Office hours" 
                       formaction="GetOfficehoursSchedule.jsp" class="update">
                <input class = "getcon" type="button" value="Get Contact" onclick="sendajax()" 
                       class="update" >
                <div id="show_response">  
                        <p style="color:black;"><% out.print(checkstaff);
                        session.setAttribute("checkstaffFound", " ");%></p> 
                </div>
            </form>
        </div>
        <div style="margin-left: 12%">
            <form >

                <label>Enter Subject ID: </label><input id="subjectID" name="subjectID" placeholder="Subject ID"/>
                <br>
                <input class = "getcon" type="submit" value="view staff" formaction="GetSubjectStaff.jsp" class="update">

                    <p style="color:black;"><% out.print(check);
                        session.setAttribute("checkFound", " ");%></p> 
            </form>
        </div>

        <%} else {
            sql = " Select * from staffmembers.notifications where toUsername = '"
                    + username + "';";
            rs = statement.executeQuery(sql);
            int counter = 0;
            while (rs.next()) {
                if (!(rs.getString("date") == null)) {
                    dateofT = formater.parse(rs.getString("date"));
                    days = (int) ((todays.getTime() - dateofT.getTime()) / (1000 * 60 * 60 * 24));
                    if (days == 0) {
                        counter++;
                    }
                } else {
                    counter++;
                }
            }

            sql = " Select * from staffmembers.message where tousername = '"
                    + username + "';";
            rs = statement.executeQuery(sql);
            int counter1 = 0;
            while (rs.next()) {
                counter1++;
            }

        %>
        <ul>
            <li><a href="Profile.jsp">Profile</a></li>   

            <li><a href="Messages.jsp"class="notification"> <span>Messages</span>
                    <span class="badge" ><%= counter1%> </span></a></li>
            <li><a href="Notifications.jsp" class="notification"> <span>Notifications</span>
                    <span class="badge"><%= counter%> </span></a></li>
            <li><a href="staffMeetings.jsp">Meetings</a></li>
            <li><a href="OfficeHours.jsp">Office Hours</a></li>
            <li><a href="#contact">Contact</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="Logout">Logout</a></li>

        </ul>
        <div style="margin-left: 12%">
            <form >
                <label>Enter student username: </label><input id="username" name="username"
                                                              placeholder="Student username"/>
                <input class = "getcon" type="button" value="Get Contact" onclick="sendajax()" 
                       class="update">
                <div id="show_response">  </div>
                <br>

            </form>
        </div>
        <% }%>
        <footer>
            Copyright © 2021 Office Hours Management System
        </footer>
    </body>
</html>
