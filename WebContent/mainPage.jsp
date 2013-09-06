<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SMU IS480 Matching System</title>
<% 	
		String fullName = (String)session.getAttribute("fullname");
		String userType = (String) session.getAttribute("type");
%>
<body>
		<div id="welcome">Welcome, <%=fullName %>. You are a <%=userType %></div>
		<%@include file="navbar.jsp"%>
	    <div id="profilepic"><a href="#"><img src="http://db.tt/Cfe7G4Z5" width="50" height="50" /></a></div>
	    <div id="profilelogout"><a href="./index.jsp">Logout</a></div>
	    <div id="notifications"><a href="#"><img src="http://db.tt/YtzsJnpm" width="30" height="20" /></a></div>
	    
	     <div data-role="header" data-theme="b">
        <h1>Announcements</h1>
    </div>
    <div id="updates">
       <iframe src="http://" style="border:1px #000000 solid;" name="updates" scrolling="yes" frameborder="1" marginheight="1000px" marginwidth="1000px" height="600px" width="1000px"></iframe>
    </div>
    <div data-role="footer" class="ui-bar" data-theme="b">
    </div>
				
</head>
</body>
</html>