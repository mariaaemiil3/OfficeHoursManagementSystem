<%-- 
    Document   : meetings
    Created on : Jan 11, 2021, 10:17:08 PM
    Author     : Nardin
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <link type="text/css" rel="stylesheet" href="mycss.css">
    <head>

        <title>Messages - Office Hours Management</title>
        <script type="text/javascript">
            function sendajax() {
                var from = document.getElementById("from").value;

                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        document.getElementById("show_response").innerHTML = xmlhttp.responseText;
                    }
                }

                xmlhttp.open("GET", "replyToMessage?from=" + from, true);
                xmlhttp.send();
            }

            function myFunction() {
                document.getElementById("demo").style.display = 'block'";
            }
        </script> 
    </head>
    <body class="Messages">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/staffmembers", "root", "root");
                Statement statement = con.createStatement();
                String username = request.getSession().getAttribute("session_username").toString();
                String type = request.getSession().getAttribute("session_type").toString();

                String confirmmessage = "";
                if (request.getSession().getAttribute("sendingconfirmationmess") != null) {
                    confirmmessage = request.getSession().getAttribute("sendingconfirmationmess").toString();

                }
                String sql = "SELECT * FROM staffmembers.message s INNER JOIN staffmembers.user"
                        + " c ON s.tousername = c.username AND c.username='" + username + "';";
                ResultSet rs = statement.executeQuery(sql);%>
        <header>
            <h1> Messages </h1>
        </header>
        <div class="SendMessage">
            <form action="sendmessage" id="Messageform">
                <div class="table">
                    <label for="fname">Message</label>
                    <br>
                    <textarea class="lab" id="message" name="message" placeholder="write you message" 
                              rows="20" cols="50"></textarea>
                    <br>
                    <input class="lab"type= "text" id="tousername" name="tousername" placeholder="write Staff or subject ID "/>

                    <label for="cars">To:</label>
                    <select id="To" name="To" >
                        <option value="All">All staff of subject</option>
                        <%
                            if (type.equals("0")) {
                        %>
                        <option value="TA"> Specific TA </option>   
                        <%
                        } else if (type.equals("1")) {
                        %>
                        <option value="TA">Specific TA / Student</option> 
                        <%}%>
                    </select>
                    <input type="submit" value="send" class="update">
                </div>
            </form>
        </div>
        <br>
            <p style="color:black;"><% out.print(confirmmessage);
                session.setAttribute("sendingconfirmationmess", " ");%></p>  
        <br>
        <% int counter = 1;
            String toUser = "";
            while (rs.next()) {
                toUser = "";
                if (counter == 1) {
        %>
        <div id="show_response">
            <form>
                <table cellspacing="5" border="1" style="height: 100%; width: 100%;">
                    <tr>

                        <th> From </th>  
                        <th>Content</th> 
                            <% if (type.equals("1")) {%>
                        <th>       </th>
                            <%}
                            %>
                    </tr>

                    <%counter++;
                        }

                    %>
                    <tr>


                        <td><input type="radio" name=myradio value=<%=rs.getString("fromusername")%> id="from">
                            <%=rs.getString("fromusername")%> </td>


                        <td><%=rs.getString("content")%></td>
                        <% if (type.equals("1")) {%>
                        <td>


                            <!-- <input type="button" id="replyButton" value="Reply" onclick="sendajax()" />-->
                            <input  type="submit"  value="Reply" 
                                    formaction="Reply.jsp"/> 

                        </td>

                    </tr>
                    <%}
                    }%>
                    <%if (counter > 1) {%>
                </table>
            </form>

            <br>
            <a href="Userhome.jsp"><input class="Large" type="button" value="Back to Homepage"/></a>
        </div>

        <% }
            } catch (Exception cnfe) {
                System.err.println("Exception: " + cnfe);
            }
        %>
    </body>
</html>
