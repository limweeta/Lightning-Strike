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
		<a href="./index.jsp">
		<!-- <img id="banner" src="http://db.tt/mjn0dKYe" alt="index"></a> -->
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
		<%@include file="navbar2.jsp"%>
	</div></br></br>
  </head>
<body>
	<div class="span7 well">
	<div class="row">
	<form class="form-horizontal">
		<fieldset>
		
		<!-- Form Name -->
		<legend>User Profile</legend>
		
			<div class="span1"><a href="#" class="thumbnail"><img src="https://db.tt/8gUG7CxQ" alt=""></a>
			</div>
		<div class="span6">
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="fullname">Name</label>
		  <div class="controls">
		    <input id="fullname" name="fullname" type="text" placeholder="fullname" class="input-large">
		    
		  </div>
		</div>
		<!-- </div></br> --></br>
		<!-- <div class="span3"> -->
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="contactno">Contact</label>
		  <div class="controls">
		    <input id="contactno" name="contactno" type="text" placeholder="contactno" class="input-large">
		  </div>
		</div>
		<!-- </div> --></br>
		<!-- <div class="span4"> -->
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="email">Email</label>
		  <div class="controls">
		    <input id="email" name="email" type="text" placeholder="email" class="input-xlarge">
		    
		  </div>
		</div>
		<!-- </div> --></br>
		<!-- <div class="span5"> -->
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="secondmajor">Second Major</label>
		  <div class="controls">
		    <input id="secondmajor" name="secondmajor" type="text" placeholder="secondmajor" class="input-large">
		    
		  </div>
		</div>
		<!-- </div> --></br>
		<!--  <div class="span6">-->
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="teamname">Team</label>
		  <div class="controls">
		    <input id="teamname" name="teamname" type="text" placeholder="teamname" class="input-large">
		    
		  </div>
		</div>
		<!-- </div> --></br>
		<!-- <div class="span7"> -->
		<!-- Button -->
		<div class="control-group">
		  <label class="control-label" for="editprofile"></label>
		  <div class="controls">
		    <button id="editprofile" name="editprofile" class="btn btn-success">Save Profile</button>
		  </div>
		</div>
		</div></br>
		</fieldset>
	</form>
	</div>
	</div>
</body>
</html>