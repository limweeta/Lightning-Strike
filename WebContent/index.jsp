<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<html>
<head>
<link rel="stylesheet" href="./css/bootstrap.css"/>
	
	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<script src="./js/bootstrap.js"></script>
<%
if(session.getAttribute("username") != null){
	response.sendRedirect("mainPage.jsp");
}
if(session.getAttribute("type") == null){
	session.setAttribute("type", "guest");
}
%>
</head>
<script type="text/javascript">
function others() {
	var selected = $('#orgType').val();
	if(selected=="Others"){
		$('#otherOrgType').show();
	}else{
		$('#otherOrgType').hide();
	}
}

function validateForm(theForm) {
	var reason = "";

	  reason += validateFullname(theForm.fullName);
	  reason += validatePhone(theForm.contactNum);
	  reason += validateEmail(theForm.email);
	  reason += validateEmpty(theForm.userName);
	  reason += validateEmpty(theForm.password);
	  reason += validateSelect(theForm.orgType);	
	  if (reason != "") {
	    alert("Some fields need correction:\n" + reason);
	    return false;
	  }

	  return true;
}
function validateSelect(fld){
	var error="";
	if(fld.orgType.value == 0){
		fld.style.background='Yellow';
		error="Please select an Organization type.\n";
	}else{
		fld.style.background='White';
	}
	return error;
	
}

function validateFullname(fld) {
    var error = "";
    var illegalChars = /[0-9]/; // allow letters ONLY
 
    if (fld.value == "") {
        fld.style.background = 'Yellow'; 
        error = "You didn't enter your full name.\n";
    } /* else if ((fld.value.length < 5) || (fld.value.length > 15)) {
        fld.style.background = 'Yellow'; 
        error = "Your full name is the wrong length.\n";
    } */ else if (illegalChars.test(fld.value)) {
        fld.style.background = 'Yellow'; 
        error = "Your full name contains illegal characters.\n";
    } else {
        fld.style.background = 'White';
    } 
    return error;
}

function validatePhone(fld)  
{  
  var error  = "";
  var phoneno = /^[\d\.\-\+]+$/;  
  if(!(fld.value.match(phoneno))||(fld.value.length<8)){  
	  error = "Invalid phone number.\n"; 
	  fld.style.background="Yellow";
  }else if(fld.value=""){  
	  error = "You didn't enter a phone number.\n";  
	  fld.style.background="Yellow"; 
  }  else {
      fld.style.background = 'White';
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
        error = "This field cannot be left blank.\n";
    } else {
        fld.style.background = 'White';
    }
    return error;   
}	
</script>
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
		   		
						 	<a href="./mainPage.jsp">
							<button type="button" id="guest" class="btn btn-primary">Guest</button>
							</a>
							</br>
					   	 <h4>Sponsor</h4>
							 <a href="#myModal" data-toggle="modal">
								<button type="button" id="external" class="btn btn-primary">Sign In</button>
							 </a>
							 <a href="#registerModal" data-toggle="modal">
								<button type="button" id="external" class="btn btn-primary">Register</button>
							 </a>
							
<!-- 					<a href="#myModal" role="button" class="btn btn-large btn-primary" data-toggle="modal">Launch Demo Modal</a> -->
					<!-- Modal HTML -->
					<div id="myModal" class="modal hide fade">
					    <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					        <h3>Sign In</h3>
					    </div>	
					       <form action="authenticate" method="post" onsubmit = "return validateSignInOnSubmit(this)" accept-charset="UTF-8">
					    <div class="modal-body">
					     	  <input type="text" name="userName" id="user_username" style="margin-bottom: 20px; height:30px;" maxlength="25" placeholder="Username" size="45" />
							  <input type="password" name="password" id="user_password" style="margin-bottom: 20px; height:30px;" maxlength="20" placeholder="Password" size="45" />
					    </div>
					    <div class="modal-footer">
				       		<input class="btn btn-primary" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="commit" value="Sign In" /></br>
					    </div>
					   	 </form>
					   	 
					</div>
					</br></br>
					<% String message = (String) session.getAttribute("message"); 
			if(message == null || message.isEmpty()){
				message = "";
			}else if(message.equals("Account successfully created")){
		%>
<%-- 			<font size=-1 color="red"><i><%=message %></i></font> --%>
			<div class="alert alert-success" align="center">
			  <button type="button" class="close" data-dismiss="alert">&times;</button>
			  <strong><%=message %></strong>
			</div>
			
			<%
			session.removeValue("message");
			}else{%>
				<div class="alert alert-danger" align="center">
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
					        <h6>Register</h6>
					    </div>
					       <form action="register" method="post" accept-charset="UTF-8" onsubmit="return validateForm(this)">
					    <div class="modal-body">
						      <input type="text" name="fullName" id="fullName" class="input-large" style="margin-bottom: 20px; height:30px;" placeholder="*Full Name" size="45" maxlength="50"/></br>
						      <input type="text" name="userName" id="userName" class="input-large" style="margin-bottom: 20px; height:30px;" placeholder="*Username" size="45" maxlength="25"/></br>
							  <input type="password" name="password"  id="password" class="input-large" style="margin-bottom: 20px; height:30px;" placeholder="*Password" size="45" maxlength="20"/></br>
							  <input type="text" name="contactNum" id="contactNum" class="input-large" style="margin-bottom: 20px; height:30px;"  placeholder="*Contact Number" size="45" maxlength="30"/></br>
							  <input type="text" name="email"  id="email" class="input-large" style="margin-bottom: 20px; height:30px;" placeholder="*Email" size="45" maxlength="50"/></br>
							  <input type="text" name="coyName"  id="coyName" class="input-large" style="margin-bottom: 20px; height:30px;"  placeholder="Company Name" size="45" maxlength="60"/></br>
							  <input type="text" name="coyContact"  id="coyContact" class="input-large" style="margin-bottom: 20px; height:30px;" placeholder="Company Contact Number" size="45" maxlength="30"/></br>
							  <input type="text" name="coyAdd"  id="coyAdd" class="input-large" style="margin-bottom: 20px; height:30px;" placeholder="Company Address" size="45" maxlength="80"/></br>
							  <select id="orgType" name="orgType" class="input-large" style="margin-bottom: 20px; height:30px;" onChange="others()">
							  		
								<%
							    	  OrganizationDataManager orgdm = new OrganizationDataManager();
								    	  ArrayList<Organization> orgs  = orgdm.retrieveAll();
										  
								    	  for(int i = 0; i < orgs.size(); i++){
								    		Organization org = orgs.get(i); 
								    		String orgType = org.getOrgType();
										   %>
										    	<option value="<%=org.getId()%>"><%=orgType%></option>
										    <%} %>
									<option value="Others">Others</option>
							  </select></br>
							  <input type="text" name="otherOrgType" id="otherOrgType" class="input-large" style="margin-bottom: 20px; height:30px; display:none; " placeholder="Organization Type" size="45" maxlength="50"/>
							  </br>
							  <font color="red">*Fields Are Mandatory</font>
						</div>
					    <div class="modal-footer">
					        <input class="btn btn-primary" style="clear: left;  height: 32px; font-size: 13px;" type="submit" name="register" value="Register" />
					    </div>
					   	 </form>
			</div>
	</div>
</div>
</body>
</html>