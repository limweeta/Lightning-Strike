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
		String type = (String) session.getAttribute("type");
		if(type == null){
			type = "";
		}
	%>
<!-- 		<a href="./index.jsp"> -->
		<!-- <img id="banner" src="http://db.tt/mjn0dKYe" alt="index"></a> -->
		<%-- <div class="header">

		<table id="profile">
			<tr></tr>
			<tr></tr>
			<tr>
			<%
			if(fullName == null){
				fullName = "guest";%>
				<td><div id="welcome">Welcome, <%=fullName %></div></br></td>			   	 
			   	<td></td>
			   	<td></td>
			<%}else {%>
				<td><div id="welcome">Welcome, <a href="userProfile.jsp?id=<%=user.getID()%>"> <%=fullName %></a></div></br></td>
			   	<td></td> 
			   	<td></td>
			
			<%}%>
				
		   	<%
			if(!fullName.equals("guest")){
			%>
		   		<td>
		   		</br>
		   		<form action="logout" method="post">
		   			<!-- <input type="submit" id="profilelogout" value="Logout"> -->
		   			<div class="control-group">
						  <div class="controls">
						   <!-- <button id="logout" name="logout" class="btn btn-danger">Logout</button><br /> -->
							&nbsp;&nbsp;<input type="submit" id="logout" value="Logout" class="btn btn-danger">
						  </div>
					</div>
		   		</form>
		   		</td>
		   		<td>&nbsp;&nbsp;&nbsp;</td>
		   	<%
			}
			%>
			</tr> 
			<%
			if(fullName.equals("guest")){
			%>
		   		<tr>
		   		<td>
		   			<!-- <input type="submit" id="profilelogout" value="Logout"> -->
		   			<div class="control-group">
						  <div class="controls">
						   <!-- <button id="logout" name="logout" class="btn btn-danger">Logout</button><br /> -->
							<a href="http://elearntools.smu.edu.sg/Tools/SSO/login.ashx?id=IS480MSvm">
							<button type="button" id="SSO" class="btn btn-primary">Single Sign On</button>
							</a>
						  </div>
					</div>
		   		</td>
		   		<td>
		   			<!-- <input type="submit" id="profilelogout" value="Logout"> -->
		   			<div class="control-group">
						  <div class="controls">
						   <!-- <button id="logout" name="logout" class="btn btn-danger">Logout</button><br /> -->
							  <a href="#myModal" data-toggle="modal">
							  <button type="button" id="external" class="btn btn-primary">External Sign In</button>&nbsp;&nbsp;
							  </a>
						  </div>
					</div>
<!-- 					<a href="#myModal" role="button" class="btn btn-large btn-primary" data-toggle="modal">Launch Demo Modal</a> -->
					<!-- Modal HTML -->
					<div id="myModal" class="modal hide fade">
					    <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					        <h3>Sign In</h3>
					    </div>
					       <form action="authenticate" method="post" onsubmit = "return validateSignInOnSubmit(this)" accept-charset="UTF-8">
					    <div class="modal-body">
					     	  <input type="text" name="userName" id="user_username" style="margin-bottom: 20px; height:30px;" type="text" name="user[username]" placeholder="Username" size="45" />
							  <input type="password" name="password" id="user_password" style="margin-bottom: 20px; height:30px;" type="password" name="user[password]" placeholder="Password" size="45" />
					    </div>
					    <div class="modal-footer">
					        <input class="btn btn-primary" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="commit" value="Sign In" />
					    </div>
					   	 </form>
					</div>
		   		</td>
		   		</tr>
		   	<%
			}
			%>
	   	</table>
	   	</div> --%>
	</br>	
			<% if(type.equalsIgnoreCase("admin")){ %>
			
				<%@ include file="navbaradmin.jsp" %>
			
			<%} else if(type==""){%>
				
				<%@ include file="navbarguest.jsp" %>
				
			<%} else if(type.equalsIgnoreCase("student")){%>
			
				<%@ include file="navbarstudent.jsp" %>
				
			<%} else if(type.equalsIgnoreCase("sponsor")){ %>
			
				<%@ include file="navbarsponsor.jsp" %>
				
			<%}else if(type.equalsIgnoreCase("supervisor")){%>
			
				<%@ include file="navbarsup.jsp" %>
				
			<%}else if(type.equalsIgnoreCase("faculty")){%>
			
				<%@ include file="navbarsup.jsp" %>
			
		<%} %>
	</br></br>
  </head>
<body>
<%
String message = (String) session.getAttribute("message");
if(message == null || message.isEmpty()){
	message = "";
}
%>
<font color=red><i><%=message %></i></font>
<%
session.removeValue("message");
%>
<div class="container">
		<div class="panel panel-primary">
		<div class="panel-heading">
			<h2 class="panel-title">Announcements</h2>
		</div>
		<div class="panel-body">
			<table>
				<th>Number</th>
				<th>Date/Time</th>
				<th>Announcement</th>
				<%
				AnnouncementDataManager adm = new AnnouncementDataManager();
				ArrayList<Announcement> announcements = adm.retrieveAll();
				
				for(int i=0; i < announcements.size(); i++){
					Announcement ann = announcements.get(i);
					%>
					<tr>
						<td align="center"><%=i+1 %></td>
						<td align="center"><%=ann.getTimestamp() %></td>
						<td align="center"><%=ann.getAnnouncement() %></td>
					</tr>
					<%
				}
				%>
				
			</table>
			
		</div>
	</div>
		<% if(type.equalsIgnoreCase("admin")){ %>
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h2 class="panel-title">Add Announcements</h2>
		</div>
		<div class="panel-body">
			<form action="addAnn" method="post">
			<textarea class = "announcement" name="announcement" rows="3" cols="1500"></textarea><br />
			<input type="submit" value="Add Announcement" class="btn btn-success">
			</form>
		</div>
		</div>
		</div>
	<% } %>
</body>
</html>