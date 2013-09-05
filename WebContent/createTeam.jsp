<html>

<style type="text/css">
	#smulogo{
	width: 600px;
    height: 200px;
	}
   	#welcome{
   		font-size: 15px;
   		font-family:Courier;
   	}
   	#profilepic{
      	position:fixed;
    	top:15px;
    	right:15px;
   	}
   	#profilelogout{
   		position:fixed;
   		top:80px;
   		right:20px;
   	}
   	#notifications{
    	position:fixed;
    	top:15px;
    	right:80px;
   	}
	h1{
		font-family:Impact;
		font-size:1.75em;
	}
	#teamName{
		width:49.8em;
		font-size:1em;
	}
	#createTeam{
		font-size:1em;
	}
	#teamLimit{
		width:5em;
	}
</style>
	<head>
	<img src="http://db.tt/mjn0dKYe" id="smulogo"/>
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>  
    
	<% 	
		String fullName = (String)session.getAttribute("fullName");
		String username = (String) session.getAttribute("username");
	%>
		<div id="welcome">Welcome, <%=username %></div>
		<%@include file="navbar.jsp"%>
	    <div id="profilepic"><a href="#"><img src="http://db.tt/Cfe7G4Z5" width="50" height="50" /></a></div>
	    <div id="profilelogout"><a href="./index.jsp">Logout</a></div>
	    <div id="notifications"><a href="#"><img src="http://db.tt/YtzsJnpm" width="30" height="20" /></a></div>
	</head>
	<body>
			
		</br></br></br>
		<div id="content-container" class="shadow">
			<div id="content">
				<div class="createTeam">
					<form action="createTeam">
						<font size="4" face="Courier">Team Name:</font></br>
						<input id="teamName" type="text" name="teamName"></br></br>
						<font size="4" face="Courier">Team Description:</font></br>
						<input id="teamDesc" type="text" name="teamDesc"></br>
						</br>
						<font size="4" face="Courier">Team Limit:</font></br>
						<select value="teamLimit" id="teamLimit" name="teamLimit">
						  <option value="4">4</option>
						  <option value="5">5</option>
						  <option value="6">6</option>
						</select></br></br>
						
						<font size="4" face="Courier">Team Members:</font></br>
						<script>
					        $("#username").autocomplete("usernamedata.jsp");
					    </script>
						
						<input type= "text" id="username" name="username" value="<%=username%>" disabled>
						<input type="hidden" id="username" name="username" value="<%=username%>">
						<input type="hidden" id="memberRole" name="memberRole" value="Project Manager">
						<select value="memberRole" id="memberRole" name="memberRole" disabled>
						  <option value="projectManager">Project Manager</option>
						</select></br>
						
						<input type= "text" id="username" name="username" value="username">
						<select value="memberRole" id="memberRole" name="memberRole">
						  <option value="developer">Developer</option>
						  <option value="designer">Designer</option>
						  <option value="analyst">Analyst</option>
						  <option value="databaseArchitect">Database Architect</option>
						  <option value="qualityAssurance">Quality Assurance</option>
						</select></br>
						
						<input type= "text" id="username" name="username" value="username">
						<select value="memberRole" id="memberRole" name="memberRole">
						  <option value="developer">Developer</option>
						  <option value="designer">Designer</option>
						  <option value="analyst">Analyst</option>
						  <option value="databaseArchitect">Database Architect</option>
						  <option value="qualityAssurance">Quality Assurance</option>
						</select></br>
						
						<input type= "text" id="username" name="username" value="username">
						<select value="memberRole" id="memberRole" name="memberRole">
						  <option value="developer">Developer</option>
						  <option value="designer">Designer</option>
						  <option value="analyst">Analyst</option>
						  <option value="databaseArchitect">Database Architect</option>
						  <option value="qualityAssurance">Quality Assurance</option>
						</select></br>
						
						<input type= "text" id="username" name="username" value="username">
						<select value="memberRole" id="memberRole" name="memberRole">
						  <option value="developer">Developer</option>
						  <option value="designer">Designer</option>
						  <option value="analyst">Analyst</option>
						  <option value="databaseArchitect">Database Architect</option>
						  <option value="qualityAssurance">Quality Assurance</option>
						</select></br>
						</br>
						<input type="submit" id="createTeam" name="createTeam" value="Create Team"/>
					</form>
					<br/>
				</div>
			</div>
		</div>
	</body>
</html>