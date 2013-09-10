<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<style type="text/css">
	@import "./css/template.css";
</style>
<head>
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>  
	<%
		String fullName = (String)session.getAttribute("fullname");
		String username = (String) session.getAttribute("username");
	%>
	<div id="topbanner">
	<div class="headercontainer">
		<img id="banner" src="http://db.tt/mjn0dKYe">
		<%
			if(fullName == null){
				fullName = "guest";
			}
		%>
		<table id="profile">
			<tr>
				<td><div id="welcome">Welcome, <%=fullName %></div></td>
				<td><a href="#"><img src="http://db.tt/YtzsJnpm" id="notifications" width="30" height="20" /></a></td>
				<td><a href="#"><img src="http://db.tt/Cfe7G4Z5" id="profilepic" width="50" height="50" /></a></td>
		   	</tr>
		   	<tr>
		   	<td></td>
		   	<td></td>
		   	<%
			if(fullName == null){
			%>
		   	<td><a href="./index.jsp" id="profilelogout">Logout</a></td>
		   	<%
			}
			%>
		   	</tr>
	   	</table>
	</div>	
	</div>
	<div class="navcontainer">
		<%@include file="navbar.jsp"%>
	</div></br></br>
  </head>
<body>
 
</br></br></br>
	
</body>
</html>