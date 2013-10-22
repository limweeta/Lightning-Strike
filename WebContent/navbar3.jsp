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
	String userType = (String) session.getAttribute("type");
	
	User u = null;
	
	
	if(sessionUser == null || sessionUser.isEmpty()){
		userIdNav = 0;
		projIdNav = 0;
		teamIdNav = 0;
	}else{
		UserDataManager udmNav = new UserDataManager();
		u = udmNav.retrieve(sessionUser);
		try{
			userIdNav = u.getID();
		}catch(Exception e){
			userIdNav = 0;
		}
		
		TeamDataManager tdmNav = new TeamDataManager();
		
		try{
			teamIdNav = tdmNav.retrieveTeamIdByUser(u);
		}catch(Exception e){
			teamIdNav = 0;
		}
		
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
               <%if(userType.equals("Admin")){ %>
               		 <li class="dropdown"><a href="./admin.jsp">Admin</a></li>
               <%} %>
              <!--  <li><a href="#" >Schedule</a></li>
               <li><a href="#" >Analytics</a></li> -->
             </ul>
           </div>
         </div>
     </div>
</html>