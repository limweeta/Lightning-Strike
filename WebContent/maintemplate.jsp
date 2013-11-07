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
		UserDataManager udm = new UserDataManager();
		String fullName = (String)session.getAttribute("fullname");
		String username = (String) session.getAttribute("username");
		User user = udm.retrieve(username);
	%>
	<script>
	
	function validateSignInOnSubmit(theForm) {
		var reason = "";

		  reason += validateUserUsername(theForm.user_username);
		  reason += validateUserPassword(theForm.user_password);		      
		  if (reason != "") {
		    alert(reason);
		    return false;
		  }

		  return true;
	}

	function validateUserUsername(fld) {
	    var error = "";
	    
	    if (fld.value == "") {
	        fld.style.background = 'Yellow'; 
	        error = "You didn't enter a username.\n";
	    } else {
	        fld.style.background = 'White';
	    } 
	    return error;
	}
	
	function validateUserPassword(fld) {
	    var error = "";
	    
	    if (fld.value == "") {
	        fld.style.background = 'Yellow'; 
	        error = "You didn't enter a password.\n";
	    } else {
	        fld.style.background = 'White';
	    } 
	    return error;
	}
	
	function validateRegisterOnSubmit(theForm) {
		var reason = "";

		  reason += validateUsername(theForm.userName);
		  reason += validateFullname(theForm.fullName);
		  reason += validatePhone(theForm.contactNum);
		  reason += validateEmail(theForm.email);
		  reason += validateEmpty(theForm.coyName);
		  reason += validatePhone(theForm.coyContact);
		  reason += validateCoyAdd(theForm.coyAdd);
		  reason += validatePassword(theForm.password);		      
		  if (reason != "") {
		    alert("Some fields need correction:\n" + reason);
		    return false;
		  }

		  return true;
	}
	
	function validateUsername(fld) {
	    var error = "";
	    //var illegalChars = /\W/; // allow letters, numbers and underscores
	 
	    if (fld.value == "") {
	        fld.style.background = 'Yellow'; 
	        error = "You didn't enter a username.\n";
	    } else if (fld.value.length < 5) {
	        fld.style.background = 'Yellow'; 
	        error = "Your username is the too short.\n";
	    } /* else if (illegalChars.test(fld.value)) {
	        fld.style.background = 'Yellow'; 
	        error = "Your username contains illegal characters.\n";
	    }  */else {
	        fld.style.background = 'White';
	    } 
	    return error;
	}
	
	
	function validateFullname(fld) {
	    var error = "";
	    var illegalChars = /[0-9]/; // allow letters ONLY
	 
	    if (fld.value == "") {
	        fld.style.background = 'Yellow'; 
	        error = "You didn't enter your full name.\n";
	    } else if ((fld.value.length < 5) || (fld.value.length > 15)) {
	        fld.style.background = 'Yellow'; 
	        error = "Your full name is the wrong length.\n";
	    } else if (illegalChars.test(fld.value)) {
	        fld.style.background = 'Yellow'; 
	        error = "Your full name contains illegal characters.\n";
	    } else {
	        fld.style.background = 'White';
	    } 
	    return error;
	}

	function validatePhone(fld) {
	    var error = "";
	    var stripped = fld.value.replace(/[\(\)\.\-\ ]/g, '');     

	   if (fld.value == "") {
	        error = "You didn't enter a phone number.\n";
	        fld.style.background = 'Yellow';
	    } else if (isNaN(parseInt(stripped))) {
	        error = "The phone number contains illegal characters.\n";
	        fld.style.background = 'Yellow';
	    } else if (!(stripped.length == 8)) {
	        error = "The phone number is too short.\n";
	        fld.style.background = 'Yellow';
	    } 
	    return error;
	}

	function validateEmail(fld) {
	    var error="";
	    var tfld = trim(fld.value);                        // value of field with whitespace trimmed off
	    var emailFilter = /^[^@]+@[^@.]+\.[^@]*\w\w$/ ;
	    var illegalChars= /[\(\)\<\>\,\;\:\\\"\[\]]/ ;
	    
	    if (fld.value == "") {
	        fld.style.background = 'Yellow';
	        error = "You didn't enter an email address.\n";
	    } else if (!emailFilter.test(tfld)) {              //test email for illegal characters
	        fld.style.background = 'Yellow';
	        error = "Please enter a valid email address.\n";
	    } else if (fld.value.match(illegalChars)) {
	        fld.style.background = 'Yellow';
	        error = "The email address contains illegal characters.\n";
	    } else {
	        fld.style.background = 'White';
	    }
	    return error;
	}

	function validateEmpty(fld) {
	    var error = "";
	  
	    if (fld.value.length == 0) {
	        fld.style.background = 'Yellow'; 
	        error = "You didn't enter your company name.\n";
	    } else {
	        fld.style.background = 'White';
	    }
	    return error;   
	}

	function validateCoyAdd(fld) {
	    var error = "";
	   // var illegalChars = /\W_/; // allow letters and numbers
	 
	    if (fld.value == "") {
	        fld.style.background = 'Yellow'; 
	        error = "You didn't enter an address.\n";
	    } else if (fld.value.length < 5) {
	        fld.style.background = 'Yellow'; 
	        error = "Your address is the too short.\n";
	    }else {
	        fld.style.background = 'White';
	    } 
	    return error;
	}

	function validatePassword(fld) {
	    var error = "";
	    //var illegalChars = /[\W_]/; // allow only letters and numbers 
	 
	    if (fld.value == "") {
	        fld.style.background = 'Yellow';
	        error = "You didn't enter a password.\n";
	    } else if ((fld.value.length < 7) || (fld.value.length > 15)) {
	        error = "Your password must be between 7-15 characters. \n";
	        fld.style.background = 'Yellow';
	    } else if (!((fld.value.search(/(a-z)+/)) && (fld.value.search(/(0-9)+/)))) {
	        error = "Your password must contain at least one numeral.\n";
	        fld.style.background = 'Yellow';
	    } else {
	        fld.style.background = 'White';
	    }
	   return error;
	}  

	function trim(s)
	{
	  return s.replace(/^\s+|\s+$/, '');
	} 

	</script>
<!-- 		<a href="./index.jsp"> -->
		<!-- <img id="banner" src="http://db.tt/mjn0dKYe" alt="index"></a> -->
		<div class="header">

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
</body>
</html>