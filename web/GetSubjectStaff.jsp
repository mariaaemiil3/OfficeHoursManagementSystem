<%-- 
    Document   : GetOfficehoursSchedule
    Created on : Jan 10, 2021, 6:41:46 PM
    Author     : Nardin
--%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>
<%@page import=" javax.servlet.http.HttpServlet"%>
<%@page import ="javax.servlet.http.HttpServletRequest"%>
<%@page import= "javax.servlet.http.HttpServletResponse"%>
<%@page import ="javax.servlet.http.HttpSession"%>

<% Class.forName("com.mysql.jdbc.Driver").newInstance(); %>
<!DOCTYPE html>
<html>
    <link type="text/css" rel="stylesheet" href="mycss.css">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Subject Staff - Office Hours Management</title>
    </head>

    <body>     
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/staffmembers", "root", "root");
                Statement statement = con.createStatement();
                String subjectid = request.getParameter("subjectID");
                String sql = "SELECT* FROM staffmembers.subjecttostaff s INNER JOIN "
                        + "staffmembers.user d ON s.username = d.username INNER JOIN "
                        + "staffmembers.subject b "
                        + "ON b.subjectid = s.subjectid "
                        + "AND s.subjectid ='" + subjectid + "';";
                ResultSet rs = statement.executeQuery(sql);
                int counter = 1;
                while (rs.next()) {
                    if (counter == 1) {
        %>
        <header>
            <h1> Subject Staff </h1>
        </header>
        <form action="reservation">
            <div class="table">
                <table cellspacing="5" border="1" style="height: 100%; width: 100%;">
                    <tr>
                        <th>Subject Name</th> 
                        <th>Staff Member Name</th>
                        <th>Staff Member Username</th> 
                        <th>Email</th> 
                        <th>Phone Number</th>  
                    </tr>

                    <%counter++;
                        }
                    %>
                    <tr>
                        <td><%=rs.getString("subjectname")%></td>
                        <td><%=rs.getString("name")%></td>
                        <td><%=rs.getString("username")%></td>
                        <td><%=rs.getString("email")%></td>
                        <td><%=rs.getString("phonenumber")%></td>
                    </tr>
                    <%} %>
                    <%if (counter > 1) {%>
                </table>
            </div>
        </form>
        <br>
        <a href="Userhome.jsp"><input class="Large" type="button" value="Back to Homepage"/></a>
            <% } else {
                    out.println("<script type=\"text/javascript\">");
                    out.println("window.alert('No Staff Members found for this subject to display');");
                    out.println("window.location.href=\"Userhome.jsp\";");
                    out.println("</script>");
                }%>

        <%
            } catch (Exception cnfe) {
                System.err.println("Exception: " + cnfe);
            }
        %>
    </body>
</html>
