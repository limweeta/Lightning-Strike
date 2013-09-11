<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<style type="text/css">
	@import "./css/template.css";
	#username{
		position:absolute;
		left:20%;
		top:55%;
	}
	#email{
		position:absolute;
		left:40%;
		top:55%;
	}
	#contactno{
		position:absolute;
		left:20%;
		top:63%;
	}
</style>
<head>
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>  
	<%
		String fullName = (String)session.getAttribute("fullname");
		String username = (String) session.getAttribute("username");
		int id=Integer.parseInt((String)session.getAttribute("profileid"));
		//int iD = Integer.parseInt(id);
		StudentDataManager sdm = new StudentDataManager();
		Student student = sdm.retrieve(id);
	%>
	<div id="topbanner">
	<div class="headercontainer">
		<a href="./index.jsp">
		<img id="banner" src="http://db.tt/mjn0dKYe" alt="index"></a>
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
			if(!fullName.equals("guest")){
			%>
		   		<td>
		   		<form action="logout" method="post">
		   			<input type="submit" id="profilelogout" value="Logout">
		   		</form>
		   		</td>
		   	<%
			}
			%>
			   	
			</tr> 
			<tr>
		   	<td></td>
		   	<td></td>
		   	
		   	</tr>
	   	</table>
	</div>	
	</div>
	<div class="navcontainer">
		<%@include file="navbar.jsp"%>
	</div></br></br></br>
  </head>
<body>
	<form id="userprofile">
	<input type="text" id="username" value="<%=student.getFullName()%>">
	<input type="text" id="contactno" value="<%=student.getContactNum()%>">
	<input type="text" id="email" value="<%=student.getEmail()%>">
	<h1>About Me:</h1>
	<font size="4" face="Courier">Second Major:</font></br>
	<input type="text" id="secondMajor" value="<%=student.getSecondMajor()%>"></br>
	</br>
	</form>
</body>
</html>