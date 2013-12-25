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
		String supType = (String) session.getAttribute("type");
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
			
			$('switchRoles').show();
		}
		
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
          <a href="./index.jsp" style="font-size: 18px; color: white;font-weight: 200;text-decoration: none; float: left; display: block; padding: 10px 40px 10px; margin-left: -20px;">
			<img src="https://db.tt/9CiHK6oq" style="height:25px; width:135px; display:inline-block;border:0; vertical-align:middle;">
		</a>
		<div class="navbar-inner">
           <div class="container">
             <ul class="nav">
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Project<b class="caret"></b></a>
		        <ul class="dropdown-menu">
		          <li><a href="./searchProject.jsp" style="font-size: 16px; color: white;font-weight: 200;">Search</a></li>
		          <li><a href="./createProject.jsp" style="font-size: 16px; color: white;font-weight: 200;">Create</a></li>
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
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Supervisor<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchSup.jsp" style="font-size: 16px; color: white;font-weight: 200;">Search</a></li>
               		<li><a href="userProfile.jsp?id=<%=userIdNav %>" style="font-size: 16px; color: white;font-weight: 200;">My Profile</a></li>
               		<li><a href="./myTeams.jsp" style="font-size: 16px; color: white;font-weight: 200;">My Teams</a></li>
               	</ul>
               </li>
                <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 16px; color: white;font-weight: bold;">Sponsor<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchSponsor.jsp" style="font-size: 16px; color: white;font-weight: 200;">Search</a></li>
               	</ul>
               </li>
              <!--  <li><a href="#" >Schedule</a></li>
               <li><a href="#" >Analytics</a></li> -->
             </ul>
              <ul class="nav pull-right">
	          <li>
	          	<a class="navbar-username" href="userProfile.jsp?id=<%=u.getID()%>" style="font-size: 16px; color: white;font-weight: bold;"><%=supFullName%> - <%=userType%></a>
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
	          	<a href="#" style="font-size: 16px; color: white;font-weight: 200;"  onclick="switchRole()">
	          		<i class="fa fa-users"></i>
	          		&nbsp; Switch Roles
	          	</a>
	          	</li>
	          	<li>
	          	<form id="logout" action="logout" method="post" style="display:none;"></form>
	          	<a href="#" onclick="logout.submit()" style="font-size: 16px; color: white;font-weight: 200;">
	          		<i class="fa fa-power-off"></i>
	          		&nbsp; Logout
	          	</a>
	          	</li>
	          	 <li id="switchRoles" style="display:none;">
	          	<form action="switchRole" method="post" onsubmit="this.form.reset()">
		  			<select id="role" name="role" class="input-small" onchange="this.form.submit()">
		  			<option value="#">Choose one...</option>
		  				<%
		  				RoleDataManager rdm = new RoleDataManager();
		  				ArrayList<String> roleTypes = rdm.retrieveUserRole(supUsername, supType);
		  				
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
	          </li>
	        </ul>
           </div>
         </div>
     </div>
</html>