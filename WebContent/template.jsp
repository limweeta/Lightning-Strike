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
	
		UserDataManager um = new UserDataManager();
		String fullName = (String)session.getAttribute("fullname");
		String username = (String) session.getAttribute("username");
		User user = um.retrieve(username);
	%>
	<div class="header">
		<a href="./index.jsp"><img src="https://dl.dropboxusercontent.com/u/40747801/IS480Logo%20copy.png"></a>
		
		<table id="profile">
			<tr>
			<%
			if(fullName == null){
				fullName = "guest";
			%>
				<td><div id="welcome">Welcome, <%=fullName %></div></td>
				<!-- <td><a href="#"><img src="http://db.tt/YtzsJnpm" id="notifications" width="30" height="20" /></a></td>
				<td><a href="#"><img src="http://db.tt/Cfe7G4Z5" id="profilepic" width="50" height="50" /></a></td>	 -->
			   	<td></td> 
			   	<td></td>
			<%}else {%>
				<td><div id="welcome">Welcome, <a href="userProfile.jsp?id=<%=user.getID()%>"> <%=fullName %></a></div></td>
				<!-- <td><a href="#"><img src="http://db.tt/YtzsJnpm" id="notifications" width="30" height="20" /></a></td>
				<td><a href="#"><img src="http://db.tt/Cfe7G4Z5" id="profilepic" width="50" height="50" /></a></td>	 -->
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
			</tr> 
	   	</table>
	</div>	
	</br>
			<% if(type.equalsIgnoreCase("admin")){ %>
			
				<%@ include file="adminnavbar.jsp" %>
			
			<%} else if(type==""){%>
				
				<%@ include file="guestnavbar.jsp" %>
				
			<%} else if(type.equalsIgnoreCase("student")){%>
			
				<%@ include file="studentnavbar.jsp" %>
				
			<%} else if(type.equalsIgnoreCase("sponsor")){ %>
			
				<%@ include file="sponsornavbar.jsp" %>
				
			<%}else if(type.equalsIgnoreCase("supervisor")){%>
			
				<%@ include file="supnavbar.jsp" %>
				
			<%}else if(type.equalsIgnoreCase("supervisor")){%>
			
			<%@ include file="supnavbar.jsp" %>
			
			<%} %>
</br>
  </head>

</html>