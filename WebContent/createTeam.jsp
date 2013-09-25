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
	UserDataManager udm = new UserDataManager();
		String type = "";
		
		try{
			type = udm.retrieve(username).getType();
		}catch(Exception e){
			
				response.sendRedirect("index.jsp");
			
		}
		
		
	%>
	</head>
	<body>
		<div id="content-container" class="shadow">
			<div id="content">
				<div class="createTeam">
					<form class="form-horizontal" action="createTeam" method="post" name="createTeam" onsubmit="return validateForm()">
						<fieldset>
						
						<!-- Form Name -->
						<legend>Create Team</legend>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="teamname">Team Name</label>
						  <div class="controls">
						    <input id="teamname" name="teamname" type="text" placeholder="Team Name" class="input-large">
						    
						  </div>
						</div>
						
						<!-- Textarea -->
						<div class="control-group">
						  <label class="control-label" for="teamdescription">Team Description</label>
						  <div class="controls">                     
						    <textarea id="teamdescription" name="teamdescription"></textarea>
						  </div>
						</div>
						
						<!-- Select Basic -->
						<div class="control-group">
						  <label class="control-label" for="teamlimit">Team Limit</label>
						  <div class="controls">
						    <select id="teamlimit" name="teamlimit" class="input-large">
						      <option>4</option>
						      <option>5</option>
						      <option>6</option>
						    </select>
						  </div>
						</div>
						
						<label class="control-label" for="teammembers">Team Members:</label>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="projectmanager">Project Manager</label>
						  <div class="controls">
						    <input id="projectmanager" name="projectmanager" type="text" placeholder="<%=username%>" class="input-large" disabled>
						    <input type="hidden" id="username" name="username" value="<%=username%>">
						  </div>
						</div>
						
						<!-- Button Drop Down -->
						<div class="control-group">
						  <label class="control-label" for="member1">Member</label>
						  <div class="controls">
						    <div class="input-append">
						      <input id="member1" name="member1" class="input-large" placeholder="User Name" type="text">
						      <div class="btn-group">
						        <button class="btn dropdown-toggle" data-toggle="dropdown">
						          Member Role
						          <span class="caret"></span>
						        </button>
						        <ul class="dropdown-menu">
						          <li><a href="#">Developer</a></li>
						          <li><a href="#">Designer</a></li>
						          <li><a href="#">Analyst</a></li>
						          <li><a href="#">Database Architect</a></li>
						          <li><a href="#">Quality Assurance</a></li>
						        </ul>
						      </div>
						    </div>
						  </div>
						</div>
						
						<!-- Button -->
						<div class="control-group">
						  <label class="control-label" for="createteam"></label>
						  <div class="controls">
						    <button id="createteam" name="createteam" class="btn btn-success">Create Team</button>
						  </div>
						</div>
						
						</fieldset>
						</form>
					
					<br/>
				</div>
			</div>
		</div>
	</body>
</html>