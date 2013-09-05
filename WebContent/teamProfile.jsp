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
	textarea{
		resize: none;
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
		<div id="welcome">Welcome, <%=fullName %></div>
		<%@include file="navbar.jsp"%>
	    <div id="profilepic"><a href="#"><img src="http://db.tt/Cfe7G4Z5" width="50" height="50" /></a></div>
	    <div id="profilelogout"><a href="./index.jsp">Logout</a></div>
	    <div id="notifications"><a href="#"><img src="http://db.tt/YtzsJnpm" width="30" height="20" /></a></div>
	</head>
	<body>
		<div id="teamprofilepic"><a href="#"><img src="http://db.tt/T1ASL5ed" width="675" height="200" /></a></div>
		<div id="aboutus"></br></br>
			<font size="4" face="Courier">About Us:</font></br>
			 <textarea id="about" rows="10" cols="75" disabled>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</textarea>
             </br></br>
            <font size="4" face="Courier">Members:</font></br>
            <font size="4" face="Courier">Project:</font></br> 	
		</div>
		<a href="#">Request to Join</a>
		<a href="#">Leave Team</a>
		<a href="#">Remove Team</a>
	</body>

</html>