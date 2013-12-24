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

		String spFullName = (String)session.getAttribute("fullname");
		String spUsername = (String) session.getAttribute("username");
		String spType = (String) session.getAttribute("type");
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
              <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Sponsor<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="userProfile.jsp?id=<%=userIdNav %>" style="font-size: 16px; color: white;font-weight: 200;">My Profile</a></li>
               		<li><a href="./myProjects.jsp" style="font-size: 16px; color: white;font-weight: 200;">My Projects</a></li>
               		<li><a href="./sponsorFeedback.jsp" style="font-size: 16px; color: white;font-weight: 200;">Feedback</a></li>
               	</ul>
               </li>
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Project<b class="caret"></b></a>
		        <ul class="dropdown-menu">
		          <li><a href="./searchProject.jsp" style="font-size: 16px; color: white;font-weight: 200;">Search</a></li>
		          <li><a href="./createProject.jsp" style="font-size: 16px; color: white;font-weight: 200;">Create</a></li>
		          <li><a href="#" style="font-size: 16px; color: white;font-weight: 200;">Delete</a></li>
		          </ul>
		        </li>
		      
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Team<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchTeam.jsp" style="font-size: 16px; color: white;font-weight: 200;">Search</a></li>
               	</ul>
               </li>
               
              <!--  <li><a href="#" >Schedule</a></li>
               <li><a href="#" >Analytics</a></li> -->
             </ul>
              <ul class="nav pull-right">
	          <li>
	          	<a class="navbar-username" href="userProfile.jsp?id=<%=u.getID()%>" style="font-size: 16px; color: white;font-weight: bold;"><%=spFullName%> - <%=userType%></a>
	          </li>
	          <li class="dropdown">
	          	<a class="dropdown-toggle navbar-title" data-toggle="dropdown" href="#" style="font-size: 16px; color: white;font-weight: bold;">
	          		<i class="fa fa-cogs fa-lg"></i>
	          	</a>
	          	<ul class="dropdown-menu pull-right">
	          	<li>
	          	<a href="userProfile.jsp?id=<%=u.getID()%>" style="font-size: 16px; color: white;font-weight: 200;">
	          		<i class="fa fa-user"></i>
	          		&nbsp; My Profile
	          	</a>
	          	</li>
	          	<li>
	          	<a href="#" style="font-size: 16px; color: white;font-weight: 200;" onclick="switchRole()">
	          		<i class="fa fa-users"></i>
	          		&nbsp; Switch Roles
	          	</a>
	          	</li>
	          	<li>
	          	<form id="logout" action="logout" method="post" style="display:none;"></form>
	          	<a href="#" onclick="logout.submit()" style="font-size: 16px; color: white;font-weight: 200;"  >
	          		<i class="fa fa-power-off"></i>
	          		&nbsp; Logout
	          	</a>
	          	</li>
	          	</ul>
	          </li>
	            <li id="switchRoles" style="display:none;">
	          	<form action="switchRole" method="post">
		  			<select id="role" name="role" class="input-small" onchange="this.form.submit()">
		  			<option value="#">Choose one...</option>
		  				<%
		  				RoleDataManager rdm = new RoleDataManager();
		  				ArrayList<String> roleTypes = rdm.retrieveUserRole(spUsername, spType);
		  				
		  				for(int i = 0; i < roleTypes.size(); i++){
		  					%>
		  					<option><%=roleTypes.get(i) %></option>
		  					<%
		  				}
		  				%>
		  			</select>
				</form>
	          </li>
	        </ul>
           </div>
         </div>
     </div>
</html>