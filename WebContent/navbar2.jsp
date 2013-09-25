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
		          </ul>
		        </li>
		      
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Team<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchTeam">Search</a></li>
		          	<li><a href="./createTeam">Create</a></li>
               	</ul>
               </li>
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">User<b class="caret"></b></a>
               	<ul class="dropdown-menu">
               		<li><a href="./searchUser.jsp">Search</a></li>
               	</ul>
               </li>
               <li><a href="#" >Schedule</a></li>
               <li><a href="#" >Analytics</a></li>
             </ul>
             <ul class="nav pull-right">
	          <li class="dropdown">
	            <a class="dropdown-toggle" href="#" data-toggle="dropdown">Register<strong class="caret"></strong></a>
	            <div class="dropdown-menu" style="padding: 15px; padding-bottom: 0px;">
	              	<form action="" method="post" accept-charset="UTF-8">
					  <input id="new_username" style="margin-bottom: 20px; height:30px;" type="text" name="new[username]" placeholder="Username" size="45" />
					  <input id="new_fullname" style="margin-bottom: 20px; height:30px;" type="text" name="new[fullname]" placeholder="Full Name" size="45" />
					  <input id="new_contact" style="margin-bottom: 20px; height:30px;" type="text" name="new[contact]" placeholder="Contact Number" size="45" />
					  <input id="new_email" style="margin-bottom: 20px; height:30px;" type="text" name="new[email]" placeholder="Email" size="45" />
					  <input id="new_companyname" style="margin-bottom: 20px; height:30px;" type="text" name="new[companyname]" placeholder="Company Name" size="45" />
					  <input id="new_companyadd" style="margin-bottom: 20px; height:30px;" type="text" name="new[companyadd]" placeholder="Company Address" size="45" />
					  <input id="new_companycontact" style="margin-bottom: 20px; height:30px;" type="text" name="new[companycontact]" placeholder="Company Contact" size="45" />
					  <input id="new_password" style="margin-bottom: 20px; height:30px;" type="password" name="new[password]" placeholder="Password" size="45" />
					  <div id="loginError" class="error"></div>
					  <div class="field-container">
							<input type="hidden" class="right rounded" name="type" id="type" value="sponsor" />
					  </div>
					  <input class="btn btn-primary" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="commit" value="Register" />
					</form>
	            </div>
	          </li>
	          <li class="divider-vertical"></li>
	          <li><a href="http://elearntools.smu.edu.sg/Tools/SSO/login.ashx?id=IS480MSvm">Single Sign On</a></li>
	          <li class="divider-vertical"></li>
	          <li class="dropdown">
	            <a class="dropdown-toggle" href="#" data-toggle="dropdown">Sign In <strong class="caret"></strong></a>
	            <div class="dropdown-menu" style="padding: 15px; padding-bottom: 0px;">
	              	<form action="authenticate" method="post" accept-charset="UTF-8">
					  <input id="user_username" style="margin-bottom: 20px; height:30px;" type="text" name="user[username]" placeholder="Username" size="45" />
					  <input id="user_password" style="margin-bottom: 20px; height:30px;" type="password" name="user[password]" placeholder="Password" size="45" />
					  <input class="btn btn-primary" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="commit" value="Sign In" />
					</form>
	            </div> 
	          </li>
	        </ul>
           </div>
         </div>
     </div>
</html>