<html>
<script type="text/javascript">
function validateForm()
{
var teamName=document.forms["createTeam"]["teamname"].value;
if (teamName==null || teamName=="")
  {
  alert("Team name must be filled out");
  return false;
  }

var teamDesc=document.forms["createTeam"]["teamdesc"].value;
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
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" />
    <script src="jquery/jquery.autocomplete.js" />
    <script type="text/javascript">
    $(document).ready(function(){
    	$(" #teamname ").autocomplete("usernamedata.jsp");
    });
	</script>
	 
	<%@ include file="template.jsp" %> </br>	
	<%
	UserDataManager udm = new UserDataManager();
	StudentDataManager sdm = new StudentDataManager();
	boolean hasTeam = false;
		String type = "";
		try{
			type = udm.retrieve(username).getType();
			if(sdm.hasTeam(udm.retrieve(username))){
				hasTeam = true;
			}
		}catch(Exception e){
				response.sendRedirect("index.jsp");
		}
	%>
	</head>
	<body>
		<div id="content-container" >
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
						  <label class="control-label" for="teamdesc">Team Description</label>
						  <div class="controls">                     
						    <textarea id="teamdesc" name="teamdesc"></textarea>
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
						  	<input type="hidden" name="memberRole" value="Project Manager" />
						  </div>
						</div>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="textinput">Member</label>
						  <div class="controls">
						    <input id="username" name="username" type="text" placeholder="User Name" class="input-large">
						  </div>
						  <label class="control-label" for="selectbasic">Role</label>
						  <div class="controls">
						    <select id="memberRole" name="memberRole" class="input-large">
						      <option>Developer</option>
						      <option>Designer</option>
						      <option>Analyst</option>
						      <option>Database Architect</option>
						      <option>Quality Assurance</option>
						    </select>
						  </div>
						</div>
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="textinput">Member</label>
						  <div class="controls">
						    <input id="username" name="username" type="text" placeholder="User Name" class="input-large">
						  </div>
						  <label class="control-label" for="selectbasic">Role</label>
						  <div class="controls">
						    <select id="memberRole" name="memberRole" class="input-large">
						      <option>Developer</option>
						      <option>Designer</option>
						      <option>Analyst</option>
						      <option>Database Architect</option>
						      <option>Quality Assurance</option>
						    </select>
						  </div>
						</div>
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="textinput">Member</label>
						  <div class="controls">
						    <input id="username" name="username" type="text" placeholder="User Name" class="input-large">
						  </div>
						  <label class="control-label" for="selectbasic">Role</label>
						  <div class="controls">
						    <select id="memberRole" name="memberRole" class="input-large">
						      <option>Developer</option>
						      <option>Designer</option>
						      <option>Analyst</option>
						      <option>Database Architect</option>
						      <option>Quality Assurance</option>
						    </select>
						  </div>
						</div>
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="textinput">Member</label>
						  <div class="controls">
						    <input id="username" name="username" type="text" placeholder="User Name" class="input-large">
						  </div>
						  <label class="control-label" for="selectbasic">Role</label>
						  <div class="controls">
						    <select id="memberRole" name="memberRole" class="input-large">
						      <option>Developer</option>
						      <option>Designer</option>
						      <option>Analyst</option>
						      <option>Database Architect</option>
						      <option>Quality Assurance</option>
						    </select>
						  </div>
						</div>
						
						<div class="control-group">
						  <label class="control-label" for="textinput">Preferred Industry</label>
						  <div class="controls">
						    <table>
						    	<tr>
								 <%
								  IndustryDataManager idm = new IndustryDataManager();
								  ArrayList<Industry> industries = idm.retrieveAll();
								 
								  for(int i = 0; i < industries.size(); i++){
									  Industry ind = industries.get(i);
									  %><td>
									  <input type="checkbox" name="industry" value="<%=ind.getIndustryId()%>">&nbsp;<%=ind.getIndustryName() %>
									  </td>
									  <%
									  if((i+1) % 3 == 0){
										  %>
										  </tr><tr>
										  <%
									  }
								  }
								  %>
								  	</tr>
						    </table>
						  </div>
						</div>
						
						<div class="control-group">
						  <label class="control-label" for="textinput">Preferred Technology</label>
						  <div class="controls">
						    <table>
						    	<tr>
								 <%
								  TechnologyDataManager tdm = new TechnologyDataManager();
								  ArrayList<Technology> technologies = tdm.retrieveAll();
								 
								  for(int i = 0; i < technologies.size(); i++){
									  Technology tech = technologies.get(i);
									  %><td>
									  <input type="checkbox" name="technology" value="<%=tech.getId()%>">&nbsp;<%=tech.getTechName() %>
									  </td>
									  <%
									  if((i+1) % 3 == 0){
										  %>
										  </tr><tr>
										  <%
									  }
								  }
								  %>
								  	</tr>
						    </table>
						  </div>
						</div>
						
						<!-- Button -->
						<div class="control-group">
						  <label class="control-label" for="createteam"></label>
						  <div class="controls">
						  	<%
								if(!hasTeam){
							%>
						    <button id="createteam" name="createteam" class="btn btn-success" disabled="disabled">Create Team</button><br />
						    <font size=-1 color="red"><i>You already have a team</i></font>
						    <%
								}else{
									%> 
							<button id="createteam" name="createteam" class="btn btn-success">Create Team</button>
									<%
								}
						    %>
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