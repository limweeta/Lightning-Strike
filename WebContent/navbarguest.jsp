<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<style type="text/css">
.navbar .container {
	height: 40px;
}
.navbar-username {
color: white ;
}


</style>


	<%
		int projIdNav = 0;
		int teamIdNav = 0;
		int userIdNav = 0;
		
		String gfullName = (String)session.getAttribute("fullname");
		String gusername = (String) session.getAttribute("username");
		if(gfullName==null){
			gfullName="Guest";
		}
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
			{  
			  var phoneno = /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/;  
			  if(fld.value.match(phoneno))  
			     {  
			       return true;    
			     }  
			   else  
			     {  
			       alert("Not a valid Phone Number");  
				    return error; 
			     }    
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
          <a href="./index.jsp" style="font-size: 18px; color: white;font-weight: 200;text-decoration: none; float: left; display: block; padding: 10px 40px 10px; margin-left: -20px;">
			<img src="https://db.tt/9CiHK6oq" style="height:25px; width:135px; display:inline-block;border:0; vertical-align:middle;">
			</a>
		 <div class="navbar-inner">
           <div class="container">
             <ul class="nav">
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Project<b class="caret"></b></a>
		        <ul class="dropdown-menu">
		          <li><a href="./searchProject.jsp" style="font-size: 16px; color: white;font-weight: 200;">Search</a></li>
		          </ul>
		        </li>
		      
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Team<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchTeam.jsp" style="font-size: 16px; color: white;font-weight: 200;">Search</a></li>
               	</ul>
               </li>
              
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Student<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchStudent.jsp" style="font-size: 16px; color: white;font-weight: 200;">Search</a></li>
               	</ul>
               </li>
               
                <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Sponsor<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchSponsor.jsp" style="font-size: 16px; color: white;font-weight: 200;">Search</a></li>
               	</ul>
               </li>
                 <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Supervisor<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchSup.jsp" style="font-size: 16px; color: white;font-weight: 200;">Search</a></li>
               	</ul>
               </li>
              <!--  <li><a href="#" >Schedule</a></li>
               <li><a href="#" >Analytics</a></li> -->
             </ul>
              <ul class="nav pull-right">
	          <li>
	          	<a class="navbar-username" href="#" style="font-size: 16px; color: white;font-weight: bold;"><%=gfullName%></a>
	          </li>
	          <li class="dropdown">
	          	<a class="dropdown-toggle navbar-title" data-toggle="dropdown" href="#" style="font-size: 16px; color: white;font-weight: bold;">
	          		<i class="fa fa-cogs fa-lg"></i>
	          	</a>
	          	<ul class="dropdown-menu pull-right">
	          	<li>
	          	<a href="./index.jsp" style="font-size: 16px; color: white;font-weight: 200;">
	          		<i class="fa fa-reply"></i>
	          		&nbsp; Back to Main Page
	          	</a>
	          	</li>
	          	</ul>
	        </ul>
           </div>
         </div>
     </div>
     <div id="register" class="modal hide fade">
					    <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					        <h3>Register</h3>
					    </div>
					       <form action="register" method="post"  onsubmit = "return validateRegisterOnSubmit(this)" accept-charset="UTF-8">
					    <div class="modal-body">
					    <input type="text" name="userName" id="userName" style="margin-bottom: 20px; height:30px;" type="text" name="new[username]" placeholder="Username" size="45" /></br>
							  <input type="password" name="password"  id="password" style="margin-bottom: 20px; height:30px;" type="password" name="new[password]" placeholder="Password" size="45" /></br>
							  <input type="text" name="fullName" id="fullName" style="margin-bottom: 20px; height:30px;" type="text" name="new[fullname]" placeholder="Full Name" size="45" /></br>
							  <input type="text" name="contactNum" id="contactNum" style="margin-bottom: 20px; height:30px;" type="text" name="new[contact]" placeholder="Contact Number" size="45" /></br>
							  <input type="text" name="email"  id="email" style="margin-bottom: 20px; height:30px;" type="text" name="new[email]" placeholder="Email" size="45" /></br>
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
</html>