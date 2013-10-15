<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<html>
	
	<link rel="stylesheet" href="./css/bootstrap.css"  type="text/css"/>
	
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
	</script>
	<div class="container">
		<h1><a href="./index.jsp">IS480 Matching System</a></h1>
	</div>
	<%
	String sessionUser = (String) session.getAttribute("username");
	
	int projIdNav = 0;
	int teamIdNav = 0;
	int userIdNav = 0;
	
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
		
		if(p == null){
			projIdNav = 0;
		}else{
			projIdNav = p.getTeamId();
		}
	}
	%>
	<div class="navbar">
         <div class="navbar-inner">
           <div class="container">
             <ul class="nav">
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Project<b class="caret"></b></a>
		        <ul class="dropdown-menu">
		          <li><a href="./searchProject.jsp">Search</a></li>
		          <li><a href="./createProject.jsp">Create</a></li>
		          <li><a href="./projectProfile.jsp?id=<%=projIdNav %>">My Project</a></li>
		          <li><a href="#">Match to Project</a></li>
		          </ul>
		        </li>
		      
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Team<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchTeam.jsp">Search</a></li>
		          	<li><a href="./createTeam.jsp">Create</a></li>
		          	<li><a href="./teamProfile.jsp?id=<%=teamIdNav %>">My Team</a></li>
		          	<li><a href="#">Match to Team</a></li>
               	</ul>
               </li>
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">User<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchUser.jsp">Search</a></li>
               		<li><a href="userProfile.jsp?id=<%=userIdNav %>">My Profile</a></li>
               	</ul>
               </li>
              <!--  <li><a href="#" >Schedule</a></li>
               <li><a href="#" >Analytics</a></li> -->
             </ul>
             <ul class="nav pull-right">
	          <li class="dropdown">
	            <a class="dropdown-toggle" href="#" data-toggle="dropdown">Register<strong class="caret"></strong></a>
	            <div class="dropdown-menu" style="padding: 15px; padding-bottom: 0px;">
	              	<form action="register" method="post" onSubmit ="window.location.href = './registerSuccess.jsp';" accept-charset="UTF-8">
					  <input type="text" name="userName" id="userName" style="margin-bottom: 20px; height:30px;" type="text" name="new[username]" placeholder="Username" size="45" />
					  <input type="text" name="fullName" id="fullName" style="margin-bottom: 20px; height:30px;" type="text" name="new[fullname]" placeholder="Full Name" size="45" />
					  <input type="text" name="contactNum" id="contactNum" style="margin-bottom: 20px; height:30px;" type="text" name="new[contact]" placeholder="Contact Number" size="45" />
					  <input type="text" name="email"  id="email" style="margin-bottom: 20px; height:30px;" type="text" name="new[email]" placeholder="Email" size="45" />
					  <input type="text" name="coyName"  id="coyName" style="margin-bottom: 20px; height:30px;" type="text" name="new[companyname]" placeholder="Company Name" size="45" />
					  <input type="text" name="coyContact"  id="coyContact" style="margin-bottom: 20px; height:30px;" type="text" name="new[companycontact]" placeholder="Company Contact Number" size="45" />
					  <input type="text" name="coyAdd"  id="coyAdd" style="margin-bottom: 20px; height:30px;" type="text" name="new[companyadd]" placeholder="Company Address" size="45" />
					  <input type="password" name="password"  id="password" style="margin-bottom: 20px; height:30px;" type="password" name="new[password]" placeholder="Password" size="45" />
					  <div id="loginError" class="error"></div>
					  <div class="field-container">
							<input type="hidden" class="right rounded" name="type" id="type" value="sponsor" />
					  </div>
					  <input class="btn btn-primary" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="commit" value="Register" />
					</form>
	            </div>
	          </li>
	          <li class="divider-vertical"></li>
	          <li><a href="http://elearntools.smu.edu.sg/Tools/SSO/login.ashx?id=IS480MSvm">SMU Users Sign-In(SSO)</a></li>
	          <li class="divider-vertical"></li>
	          <li class="dropdown">
	            <a class="dropdown-toggle" href="#" data-toggle="dropdown">External Sign In <strong class="caret"></strong></a>
	            <div class="dropdown-menu" style="padding: 15px; padding-bottom: 0px;">
	              	<form action="authenticate" method="post" accept-charset="UTF-8">
					  <input type="text" name="userName" id="user_username" style="margin-bottom: 20px; height:30px;" type="text" name="user[username]" placeholder="Username" size="45" />
					  <input type="password" name="password" id="user_password" style="margin-bottom: 20px; height:30px;" type="password" name="user[password]" placeholder="Password" size="45" />
					  <input class="btn btn-primary" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="commit" value="Sign In" />
					</form>
	            </div> 
	          </li>
	        </ul>
           </div>
         </div>
     </div>
</html>