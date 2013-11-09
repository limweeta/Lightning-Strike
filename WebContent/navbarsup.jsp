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

		String supFullName = (String)session.getAttribute("fullname");
		String supUsername = (String) session.getAttribute("username");
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
		
		function trim(s)
		{
		  return s.replace(/^\s+|\s+$/, '');
		} 

	</script>

	<%
	String sessionUser = (String) session.getAttribute("username");
	String userType = (String) session.getAttribute("type");
	
	User u = null;
	if(userType == null){
		userType = "";
	}
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
         <a href="./index.jsp" style="font-size: 20px; color: white;font-weight: 200;text-decoration: none; float: left; display: block; padding: 10px 40px 10px; margin-left: -20px;">IS480 Matching</a>
         <div class="navbar-inner">
           <div class="container">
             <ul class="nav">
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 20px; color: white;font-weight: 200;">Project<b class="caret"></b></a>
		        <ul class="dropdown-menu">
		          <li><a href="./searchProject.jsp" style="font-size: 20px; color: white;font-weight: 200;">Search</a></li>
		          <li><a href="./createProject.jsp" style="font-size: 20px; color: white;font-weight: 200;">Create</a></li>
		          </ul>
		        </li>
		      
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 20px; color: white;font-weight: 200;">Team<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchTeam.jsp" style="font-size: 20px; color: white;font-weight: 200;">Search</a></li>
		          	<li><a href="./createTeam.jsp" style="font-size: 20px; color: white;font-weight: 200;">Create</a></li>
		          	<li><a href="./teamProfile.jsp?id=<%=teamIdNav %>" style="font-size: 20px; color: white;font-weight: 200;">My Team</a></li>
		          	<li><a href="#" style="font-size: 20px; color: white;font-weight: 200;">Match to Team</a></li>
               	</ul>
               </li>
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 20px; color: white;font-weight: 200;">Student<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchUser.jsp" style="font-size: 20px; color: white;font-weight: 200;">Search</a></li>
               	</ul>
               </li>
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 20px; color: white;font-weight: 200;">Supervisor<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchSup.jsp" style="font-size: 20px; color: white;font-weight: 200;">Search</a></li>
               		<li><a href="userProfile.jsp?id=<%=userIdNav %>" style="font-size: 20px; color: white;font-weight: 200;">My Profile</a></li>
               		<li><a href="./myTeams.jsp" style="font-size: 20px; color: white;font-weight: 200;">My Teams</a></li>
               		<li><a href="./admin.jsp" style="font-size: 20px; color: white;font-weight: 200;">Assign Team</a></li>
               		<li><a href="./admin.jsp" style="font-size: 20px; color: white;font-weight: 200;">Suspend User</a></li>
               	</ul>
               </li>
              <!--  <li><a href="#" >Schedule</a></li>
               <li><a href="#" >Analytics</a></li> -->
             </ul>
              <ul class="nav pull-right">
	          <li>
	          	<a class="navbar-username" href="userProfile.jsp?id=<%=u.getID()%>"><%=supFullName%> - <%=userType%></a>
	          </li>
	          <li class="dropdown">
	          	<a class="dropdown-toggle navbar-title" data-toggle="dropdown" href="#" style="font-size: 20px; color: white;font-weight: 200;">
	          		<i class="fa fa-cogs"></i>
	          	</a>
	          	<ul class="dropdown-menu pull-right">
	          	<li>
	          	<a href="#" style="font-size: 20px; color: white;font-weight: 200;">
	          		<i class="fa fa-caret-square-o-down"></i>
	          		&nbsp; Switch Roles
	          	</a>
	          	</li>
	          	<li>
	          	<form id="logout" action="logout" method="post"></form>
	          	<a href="#" onclick="logout.submit()" style="font-size: 20px; color: white;font-weight: 200;">
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
</html>