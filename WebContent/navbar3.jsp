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
	<div class="navbar">
         <div class="navbar-inner">
           <div class="container">
             <ul class="nav">
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Project<b class="caret"></b></a>
		        <ul class="dropdown-menu">
		          <li><a href="./searchProject.jsp">Search</a></li>
		          <li><a href="./createProject.jsp">Create</a></li>
		          <li><a href="#">My Project</a></li>
		          <li><a href="#">Match to Project</a></li>
		          </ul>
		        </li>
		      
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Team<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchTeam.jsp">Search</a></li>
		          	<li><a href="./createTeam.jsp">Create</a></li>
		          	<li><a href="#">My Team</a></li>
		          	<li><a href="#">Match to Team</a></li>
               	</ul>
               </li>
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">User<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchUser.jsp">Search</a></li>
               		<li><a href="#">My Profile</a></li>
               	</ul>
               </li>
               <li><a href="#" >Schedule</a></li>
               <li><a href="#" >Analytics</a></li>
             </ul>
           </div>
         </div>
     </div>
</html>