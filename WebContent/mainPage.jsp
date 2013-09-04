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
	    <div id="profilepic"><a href="#"><img src="http://db.tt/Cfe7G4Z5" width="50" height="50" /></a></div>
	    <div id="profilelogout"><a href="./index.jsp">Logout</a></div>
	    <div id="notifications"><a href="#"><img src="http://db.tt/YtzsJnpm" width="30" height="20" /></a></div>
	    
	    <div id="div-1a">
					<div class="login-area">
						<div id="loginError" class="error"></div><br/>
						<input type="button" id="createProject" name="createProject" value="Create Project" onclick="javascript:window.location='createProject.jsp'"/>
					</div>
				</div>
				
		<div id="div-1b">
					<div class="login-area">
						<div id="loginError" class="error"></div><br/>
						<input type="button" id="loginBtn" name="loginBtn" value="SSO Login" onclick="./login.jsp;"/>
					</div>
				</div>
</head>
</body>
</html>