<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<style type="text/css">
	#smulogo{
	width: 600px;
    height: 200px;
	}
   	#welcome{
   		font-size: 15px;
   		font-family:Courier;
   	}
   	#profilepic{
      	position:fixed;
    	top:15px;
    	right:15px;
   	}
   	#profilelogout{
   		position:fixed;
   		top:80px;
   		right:20px;
   	}
   	#notifications{
    	position:fixed;
    	top:15px;
    	right:80px;
   	}
	h1{
		font-family:"Courier";
		font-weight: bold;
		font-size:20px;
	}
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
	<img src="http://db.tt/mjn0dKYe" id="smulogo"/>
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>  
	<%
		String fullName = (String)session.getAttribute("fullname");
		String username = (String) session.getAttribute("username");
	%>	
	<div id="welcome">Welcome, <%=fullName %></div>
		<%@include file="navbar.jsp"%></br>
	    <div id="profilepic"><a href="#"><img src="http://db.tt/Cfe7G4Z5" width="50" height="50" /></a></div>
	    <div id="profilelogout"><a href="./index.jsp">Logout</a></div>
	    <div id="notifications"><a href="#"><img src="http://db.tt/YtzsJnpm" width="30" height="20" /></a></div>
   
</head>
<body>
 
</br></br></br>
	<div id="profilepic2"><a href="./ViewProfile.html"><img src="http://db.tt/Cfe7G4Z5" width="100" height="100" /></a></div>
	<a href="#">Edit Profile Picture</a>
	</br></br>
	<%
	int id = Integer.parseInt(request.getParameter("id"));
	
	StudentDataManager sdm = new StudentDataManager();
	Student student = sdm.retrieve(id);
	
	%>
	<div class="container" id="userdetails">
	<form id="userprofile">
	<input type="text" id="username" value="<%=student.getFullName()%>">
	<input type="text" id="contactno" value="<%=student.getContactNum()%>">
	<input type="text" id="email" value="<%=student.getEmail()%>">
	<h1>About Me:</h1>
	<!-- if user is a student -->
<!-- 	<font size="4" face="Courier">Second Major:</font></br> -->
<!-- 	<textarea id="secondMajor" cols="97" rows="1"></textarea></br> -->
	</br>
	</form>
	</div>
</body>
</html>