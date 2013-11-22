<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<head>
<link rel="stylesheet" href="./css/bootstrap.css"/>
	
	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<script src="./js/bootstrap.js"></script>
<%
if(session.getAttribute("username") != null){
	response.sendRedirect("mainPage.jsp");
}
%>
</head>

<style type="text/css">
a:hover,
a:focus {
  color: #005580;
  text-decoration: none;
}
.div{
	display: block;
}

.row{
	margin: initial;
}
html, body {
background-color: #eeeeee;
}
.container {
width: 600px !important;
}

.space-container {
height: 100px;
}
.container > .content {
text-align: center;
background-color: #ffffff;
padding: 20px;
margin: 0 -20px;
-webkit-border-radius: 10px 10px 10px 10px;
-moz-border-radius: 10px 10px 10px 10px;
border-radius: 10px 10px 10px 10px;
-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.15);
-moz-box-shadow: 0 1px 2px rgba(0,0,0,.15);
box-shadow: 0 1px 2px rgba(0,0,0,.15);
}

</style>
<body>
<div class="navbar navbar-inverse navbar-fixed-top">
	<div class="navbar-inner">
	<div class="container">
	</div>
	</div>
</div>
<div class="space-container">
</div>
<div class="container">
	<div class="content">
		<div>
			<a href="./index.jsp"><img src="https://db.tt/XeqJvapD" style="height:150px; width:450px; display: inline-block;"></a>
		</div>
		<div class="row">
			<h1>IS480 Matching System</h1>
			
							<a href="http://elearntools.smu.edu.sg/Tools/SSO/login.ashx?id=IS480MSvm">
							<button type="button" id="SSO" class="btn btn-primary">Student</button>
							</a>
							
							<a href="http://elearntools.smu.edu.sg/Tools/SSO/login.ashx?id=IS480MSvm">
							<button type="button" id="SSO" class="btn btn-primary">Faculty</button>
							</a>
		   		
							  <a href="#myModal" data-toggle="modal">
							  <button type="button" id="external" class="btn btn-primary">Sponsor Sign In</button>
							  </a>
						 
						 	<a href="./mainPage.jsp">
							<button type="button" id="guest" class="btn btn-primary">Guest</button>
							</a>
							</br></br>
							
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
				       		<input class="btn btn-primary" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="commit" value="Sign In" /></br>
				       		<a href="#registerModal" data-toggle="modal">Register New Sponsor</a>
					    </div>
					   	 </form>
					</div>
					<% String message = (String) session.getAttribute("message"); 
			if(message == null || message.isEmpty()){
				message = "";
			}else{
		%>
<%-- 			<font size=-1 color="red"><i><%=message %></i></font> --%>
			<div class="alert alert-success" align="center">
			  <button type="button" class="close" data-dismiss="alert">&times;</button>
			  <strong><%=message %></strong>
			</div>
			
			<%
			session.removeValue("message");
			} %>
		</div>
		 <div id="registerModal" class="modal hide fade">
					    <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					        <h3>Register</h3>
					    </div>
					       <form action="register" method="post" accept-charset="UTF-8">
					    <div class="modal-body">
						      <input type="text" name="fullName" id="fullName" style="margin-bottom: 20px; height:30px;" type="text" name="new[fullname]" placeholder="*Full Name" size="45" /></br>
						      <input type="text" name="userName" id="userName" style="margin-bottom: 20px; height:30px;" type="text" name="new[username]" placeholder="*Username" size="45" /></br>
							  <input type="password" name="password"  id="password" style="margin-bottom: 20px; height:30px;" type="password" name="new[password]" placeholder="*Password" size="45" /></br>
							  <input type="text" name="contactNum" id="contactNum" style="margin-bottom: 20px; height:30px;" type="text" name="new[contact]" placeholder="*Contact Number" size="45" /></br>
							  <input type="text" name="email"  id="email" style="margin-bottom: 20px; height:30px;" type="text" name="new[email]" placeholder="*Email" size="45" /></br>
							  <input type="text" name="coyName"  id="coyName" style="margin-bottom: 20px; height:30px;" type="text" name="new[companyname]" placeholder="Company Name" size="45" /></br>
							  <input type="text" name="coyContact"  id="coyContact" style="margin-bottom: 20px; height:30px;" type="text" name="new[companycontact]" placeholder="Company Contact Number" size="45" /></br>
							  <input type="text" name="coyAdd"  id="coyAdd" style="margin-bottom: 20px; height:30px;" type="text" name="new[companyadd]" placeholder="Company Address" size="45" /></br>
							  <select id="orgType" name="orgType" class="input-large">
								<%
							    	  OrganizationDataManager orgdm = new OrganizationDataManager();
								    	  ArrayList<Organization> orgs  = orgdm.retrieveAll();
										  
								    	  for(int i = 0; i < orgs.size(); i++){
								    		Organization org = orgs.get(i); 
								    		String orgType = org.getOrgType();
										   %>
										    	<option value="<%=org.getId()%>"><%=orgType%></option>
										    <%
										    }
										    %>
							  </select></br>  
							  <font color="red">*All Fields Are Mandatory</font>
						</div>
					    <div class="modal-footer">
					        <input class="btn btn-primary" style="clear: left;  height: 32px; font-size: 13px;" type="submit" name="search" value="Register" />
					    </div>
					   	 </form>
			</div>
	</div>
</div>
</body>
</html>