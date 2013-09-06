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
		String fullName = (String)session.getAttribute("fullname");
		String username = (String) session.getAttribute("username");
	%>	
	<div id="welcome">Welcome, <%=fullName %></div>
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
					<form action="createProject" method="post">
						<font size="4" face="Courier">Project Name:</font></br>
						<input id="projectName" type="text" name="projectName"></br></br>	
						<font size="4" face="Courier">Project Term:</font></br>
						<select name="projectTerm">
						  <option value="2013/2014T1">2013/2014 T1</option>
						  <option value="2013/2014T2">2013/2014 T2</option>
						  <option value="2012/2013T1">2012/2013 T1</option>
						  <option value="2012/2013T2">2012/2013 T2</option>
						</select></br></br>
						<font size="4" face="Courier">Project Description:</font></br>
						<textarea name="projectDescription" cols="97" rows="10"></textarea></br></br>
						<font size="4" face="Courier">Project Status:</font></br>
						<select name="projectStatus">
						  <option value="open">Open</option>
						  <option value="ongoing">Ongoing</option>
						  <option value="closed">Closed</option>
						</select></br></br>
						<font size="4" face="Courier">Industry Type:</font></br>
						<select name="industryType">
						  <option value="banking">Banking</option>
						  <option value="IT">IT</option>
						  <option value="Health">Health</option>
						</select></br></br>
						
						<!-- Company name to have autocomplete in accordance to database -->
						<!-- include hidden field for id -->
						<font size="4" face="Courier">Project Organization:</font></br>
						<input id="projectOrganization" type="text" name="projectOrganization"></br></br>
					<!-- 
						<font size="4" face="Courier">Contact Details: </font></br>
						<font size="4" face="Courier">Contact Name: </font>&nbsp;&nbsp;
						<input type="text" name="contactName">
						<font size="4" face="Courier">Contact Number: </font>&nbsp;&nbsp;<input type="text" name="contactNumber"></br></br>
						<font size="4" face="Courier">Team Name:</font></br>
						 -->
						<!-- Team name to be extracted from session -->
						<!-- include hidden field for id -->
						<!-- Team name field to be uneditable -->
					
					 <!--  
						<input id="teamName" type="text" name="teamName"></br></br>
						<font size="4" face="Courier">Project Diagrams:</font></br>
						<textarea id="projectDiagrams" cols="97" rows="10" disabled></textarea></br>
						</br>-->
						<input id="createProject" type="submit" value="Create Project"> 
					</form>
					<br/>
				</div>
			</div>
		</div>
	</body>
</html>