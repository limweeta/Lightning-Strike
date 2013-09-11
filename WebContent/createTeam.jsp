<html>
<script type="text/javascript">
function validateForm()
{
var teamName=document.forms["createTeam"]["teamName"].value;
if (teamName==null || teamName=="")
  {
  alert("Team name must be filled out");
  return false;
  }

var teamDesc=document.forms["createTeam"]["teamDesc"].value;
if (teamDesc==null || teamDesc=="")
  {
  alert("Team Description must be filled out");
  return false;
  }

}
</script>
<style type="text/css">
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
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="jQuery/jquery.autocomplete.js"></script>  
    <script>
    jQuery(function(){
		$("#username").autocomplete("usernamedata.jsp");
    });
	</script>
 		 
	<%@ include file="template.jsp" %>
	<%	
		if(username == null){
			response.sendRedirect("index.jsp");
		}
	%>
	</head>
	<body>
		<div id="content-container" class="shadow">
			<div id="content">
				<div class="createTeam">
					<form action="createTeam" method="post" name="createTeam" onsubmit="return validateForm()">
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
						
						
						<input type= "text" id="username" name="username" value="<%=username%>" disabled>
						<input type="hidden" id="username" name="username" value="<%=username%>">
						<input type="hidden" id="memberRole" name="memberRole" value="Project Manager">
						<select value="memberRole" id="memberRole" name="memberRole" disabled>
						  <option value="projectManager">Project Manager</option>
						</select></br>
						
						<input type= "text" id="username" name="username" placeholder="Enter username here">
						<select value="memberRole" id="memberRole" name="memberRole">
						  <option value="developer">Developer</option>
						  <option value="designer">Designer</option>
						  <option value="analyst">Analyst</option>
						  <option value="databaseArchitect">Database Architect</option>
						  <option value="qualityAssurance">Quality Assurance</option>
						</select></br>
						
						<input type= "text" id="username" name="username" placeholder="Enter username here">
						<select value="memberRole" id="memberRole" name="memberRole">
						  <option value="developer">Developer</option>
						  <option value="designer">Designer</option>
						  <option value="analyst">Analyst</option>
						  <option value="databaseArchitect">Database Architect</option>
						  <option value="qualityAssurance">Quality Assurance</option>
						</select></br>
						
						<input type= "text" id="username" name="username" placeholder="Enter username here">
						<select value="memberRole" id="memberRole" name="memberRole">
						  <option value="developer">Developer</option>
						  <option value="designer">Designer</option>
						  <option value="analyst">Analyst</option>
						  <option value="databaseArchitect">Database Architect</option>
						  <option value="qualityAssurance">Quality Assurance</option>
						</select></br>
						
						<input type= "text" id="username" name="username" placeholder="Enter username here">
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