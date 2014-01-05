<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<style type="text/css">
.navbar .container {
	height: 40px;
}
.navbar-username {
color: white;
}


</style>

	<%
		int projIdNav = 0;
		int teamIdNav = 0;
		int userIdNav = 0;

		String afullName = (String)session.getAttribute("fullname");
		String ausername = (String) session.getAttribute("username");
		String atype = (String) session.getAttribute("type");
	%>
	<link rel="stylesheet" href="./css/bootstrap.css"  type="text/css"/>
	<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<script src="./js/bootstrap.js"></script>
	<script>
		$(function() {
		  // Setup drop down menu
		  $('.dropdown-toggle').dropdown();
		 
		  // Fix input element click problem
		  $('.dropdown input, .dropdown label').click(function(e) {
		    e.stopPropagation();
		  });
		   
		});
		
		function switchRole(){
			$('#switchRoles').show();
		}	
		
		function switchRoleHide(){
			$('#switchRoles').hide();
		}
		
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

			  reason += validateFullname(theForm.fullName);
			  reason += validatePhone(theForm.contactNum);
			  reason += validateEmail(theForm.email);
			  reason += validateUsername(theForm.userName);
			  reason += validatePassword(theForm.password);
			  reason += validateSelect(theForm.orgType);	
			  if (reason != "") {
			    alert("Some fields need correction:\n" + reason);
			    return false;
			  }
			  return true;
		}
		
		function validateSelect(fld){
			var error="";
			if(fld.value == "default"){
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
		 
		    if (fld.value.length == 0) {
		        fld.style.background = 'Yellow'; 
		        error = "Please enter your full name.\n";
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
		  if(!(fld.value.match(phoneno))){  
			  error = "Invalid phone number.\n"; 
			  fld.style.background='Yellow';
		  }else if(fld.value.length == 0){  
			  error = "Please enter a phone number.\n";  
			  fld.style.background='Yellow'; 
		  }else if(fld.value.length<8){
			  error="Invalid phone number. \n";
			  fld.style.background='Yellow';
		  }else {
		      fld.style.background = 'White';
		  }
		  return error;
		}  

		function validateEmail(fld) {
		    var error="";
		    var tfld = trim(fld.value);                        // value of field with whitespace trimmed off
		    var emailFilter = /^[^@]+@[^@.]+\.[^@]*\w\w$/ ;
		    var illegalChars= /[\(\)\<\>\,\;\:\\\"\[\]]/ ;
		    
		    if (fld.value.length == 0) {
		        fld.style.background = 'Yellow';
		        error = "Please enter an email address.\n";
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

		function validateUsername(fld) {
		    var error = "";
		  
		    if (fld.value.length == 0) {
		        fld.style.background = 'Yellow'; 
		        error = "Please enter your username.\n";
		    } else {
		        fld.style.background = 'White';
		    }
		    return error;   
		}

		function validatePassword(fld) {
		    var error = "";
		  
		    if (fld.value.length == 0) {
		        fld.style.background = 'Yellow'; 
		        error = "Please enter your password.\n";
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

	<%
	String sessionUser = (String) session.getAttribute("username");
	String userType = (String) session.getAttribute("type");
	
	if(userType == null){
		userType = "";
	}
	
	User u = null;
	
	if(sessionUser == null || sessionUser.isEmpty()){
		userIdNav = 0;
		projIdNav = 0;
		teamIdNav = 0;
	}else{
		UserDataManager udmNav = new UserDataManager();
		u = udmNav.retrieve(sessionUser);
		userIdNav = u.getID();
		
		TeamDataManager tdmNav = new TeamDataManager();
		teamIdNav = tdmNav.retrieveTeamIdByUser(u);
		
		ProjectDataManager pdmNav = new ProjectDataManager();
		Project p = pdmNav.getProjFromTeam(teamIdNav);
		
		if(userType.equalsIgnoreCase("sponsor")){
			teamIdNav = 0;
			try{
				projIdNav = pdmNav.getProjIdFromSponsor(userIdNav);
			}catch(Exception e){
				projIdNav = 0;
			}
		}else{
			if(p == null){
				try{
					if(pdmNav.hasProj(u)){
						p = pdmNav.retrieveProjIdFromCreator(u.getID());
						projIdNav = p.getId();
					}
				}catch(Exception e){
					projIdNav = 0;	
				}
			}else{
				projIdNav = p.getId();
			}
		}	
	}
	%>
	
	<div class="navbar navbar-inverse navbar-fixed-top">
         <a href="./index.jsp" style="float: left; display: block; padding: 10px 40px 10px; margin-left: -20px;">
			<img src="https://db.tt/9CiHK6oq" style="height:25px; width:135px; display:inline-block;border:0; vertical-align:middle;">
		</a>
         <div class="navbar-inner">
           <div class="container">
             <ul class="nav">
               <!-- <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Admin<b class="caret"></b></a>
  			   	 <ul class="dropdown-menu">
		          <li><a href="./adminAssignRev.jsp" style="font-size: 16px; color: white;font-weight: 200;">Assign Reviewer</a></li>
		          <li><a href="./adminAssignSup.jsp" style="font-size: 16px; color: white;font-weight: 200;">Assign Supervisor</a></li>
				  <li><a href="./adminSuspend.jsp" style="font-size: 16px; color: white;font-weight: 200;">Suspend User</a></li>
				  <li><a href="./adminSuspended.jsp" style="font-size: 16px; color: white;font-weight: 200;">Suspended Users</a></li>		         
		          <li><a href="./adminTerm.jsp" style="font-size: 16px; color: white;font-weight: 200;">Manage Term</a></li>
		          <li><a href="./adminTeam.jsp" style="font-size: 16px; color: white;font-weight: 200;">Manage Team</a></li>
		          <li><a href="./adminDeleteSponsor.jsp" style="font-size: 16px; color: white;font-weight: 200;">Delete Sponsor</a></li>
		         </ul>
  			   </li> -->
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Project<b class="caret"></b></a>
		        <ul class="dropdown-menu">
		          <li><a href="./searchProject.jsp" style="font-size: 16px; color: white;font-weight: 200;">Search</a></li>
		          <li><a href="./adminAddRole.jsp" style="font-size: 16px; color: white;font-weight: 200;">Add Role</a></li>
		          <li><a href="./adminAddTech.jsp" style="font-size: 16px; color: white;font-weight: 200;">Add Technology</a></li>
		        </ul>
		       </li>
		      
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Team<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchTeam.jsp" style="font-size: 16px; color: white;font-weight: 200;">Search</a></li> 
		          <!--	<li class="dropdown"><a href="./adminAssignSup.jsp" style="font-size: 16px; color: white;font-weight: 200;">Assign Supervisor</a></li>
               		<li class="dropdown"><a href="./adminAssignRev.jsp" style="font-size: 16px; color: white;font-weight: 200;">Assign Reviewer</a></li> -->
              		<li class="dropdown"><a href="./adminTeam.jsp" style="font-size: 16px; color: white;font-weight: 200;">Manage Team</a></li>	
               	</ul>
               </li>
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Student<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchStudent.jsp" style="font-size: 16px; color: white;font-weight: 200;">Search</a></li>
               		<li><a href="./adminSuspend.jsp" style="font-size: 16px; color: white;font-weight: 200;">Suspend User</a></li>
               		<li><a href="./adminSuspended.jsp" style="font-size: 16px; color: white;font-weight: 200;">Suspended Users</a></li>
               	</ul>
               </li>
                <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Sponsor<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="#registerModal" data-toggle="modal" style="font-size: 16px; color: white;font-weight: 200;">Register</a></li>
               		<li><a href="./searchSponsor.jsp" style="font-size: 16px; color: white;font-weight: 200;">Search</a></li>
               		<li><a href="./adminDeleteSponsor.jsp" style="font-size: 16px; color: white;font-weight: 200;">Delete Sponsor</a></li>
					<li><a href="./adminSuspend.jsp" style="font-size: 16px; color: white;font-weight: 200;">Suspend User</a></li>
					<li><a href="./adminSuspended.jsp" style="font-size: 16px; color: white;font-weight: 200;">Suspended Users</a></li>
               	</ul>
               </li>
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Supervisor<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchSup.jsp" style="font-size: 16px; color: white;font-weight: 200;">Search</a></li>
               		<li class="dropdown"><a href="./adminAssignSup.jsp" style="font-size: 16px; color: white;font-weight: 200;">Assign Supervisor</a></li>
               		<li class="dropdown"><a href="./adminAssignRev.jsp" style="font-size: 16px; color: white;font-weight: 200;">Assign Reviewer</a></li>
					<li class="dropdown"><a href="#" style="font-size: 16px; color: white;font-weight: 200;">Match Supervisor to Team</a></li>
					<li><a href="./adminSuspend.jsp" style="font-size: 16px; color: white;font-weight: 200;">Suspend User</a></li>
					<li><a href="./adminSuspended.jsp" style="font-size: 16px; color: white;font-weight: 200;">Suspended Users</a></li>
               	</ul>
               </li>
                <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Term<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./adminTerm.jsp" style="font-size: 16px; color: white;font-weight: 200;">Manage Term</a></li>
               		<li><a href="./export.jsp" style="font-size: 16px; color: white;font-weight: 200;">Export</a></li>
               	</ul>
               </li>
               <li class="dropdown"><a href="#" style="font-size: 16px; color: white;font-weight: bold;">Charts</a>
               </li>
              
              <!--  <li><a href="#" >Schedule</a></li>
               <li><a href="#" >Analytics</a></li> -->
             </ul>
              <ul class="nav pull-right">
	          <li>
	          	<a class="navbar-username" href="userProfile.jsp?id=<%=u.getID()%>" style="font-size: 16px; color: white;font-weight: bold;"><%=afullName%> - <%=userType%></a>
	          </li>
	          <li class="dropdown">
	          	<a class="dropdown-toggle navbar-title" data-toggle="dropdown" href="#">
	          		<i class="fa fa-cogs fa-lg" style="color:white;"></i>
	          	</a>
	          	<ul class="dropdown-menu pull-right">
	          	<li>
	          	<a href="userProfile.jsp?id=<%=u.getID()%>" style="font-size: 16px; color: white;font-weight: 200;">
	          		<i class="fa fa-user"></i>
	          		&nbsp; My Profile
	          	</a>
	          	</li>
	          	<!-- <li>
	          	<a href="#" style="font-size: 16px; color: white;font-weight: 200;">
	          		<i class="fa fa-users"></i>
	          		&nbsp; Switch Roles
	          	</a>
	          	</li> -->
	          	
	          	
	         
	          <li id="switchRoles" style="padding-top:5px;">
	          	<form action="switchRole" method="post" onsubmit="this.reset()" style="margin: 0 20 0px;">
	          		<i class="fa fa-users" style="color:white; padding-right:8px;"></i> 
		  			<select id="role" name="role" class="input-small" onChange="this.form.submit()" >
		  			<option value="#">Role</option>
		  				<%
		  				RoleDataManager rdm = new RoleDataManager();
		  				ArrayList<String> roleTypes = rdm.retrieveUserRole(ausername, atype);
		  				
		  				for(int i = 0; i < roleTypes.size(); i++){
		  					%>
		  					<option><%=roleTypes.get(i) %></option>
		  					<%
		  				}
		  				%>
		  			</select>
				</form>
	          </li>
	          
	          <li>
	          	<form id="logout" action="logout" method="post" style="display:none;"></form>
	          	<a href="#" onclick="logout.submit()" style="font-size: 16px; color: white;font-weight: 200;">
	          		<i class="fa fa-power-off"></i>
	          		&nbsp; Logout
	          	</a>
	          	</li>
	          
	          </ul>
	           </li>
	           
	        </ul>

           </div>
         </div>
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
			
</html>