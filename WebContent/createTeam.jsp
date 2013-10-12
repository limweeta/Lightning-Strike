<html>
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
	<%@ include file="template.jsp" %> </br>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <script src="./jquery-ui-1.10.3.custom/js/jquery-1.9.1.js"></script>
  <script src="./jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
  <%
  StudentDataManager sdm = new StudentDataManager();
  ArrayList<String> usernameList = sdm.retrieveUsernameList();
  %>
    <script type="text/javascript">
    $(function() {
        var studentNameList = [
                <%
                for(int i = 0; i < usernameList.size(); i++){
                	out.println("\""+usernameList.get(i)+"\",");
                }
                %>
                               ];
        
        $( "#username2" ).autocomplete({
          source: studentNameList
        });
        
        $( "#username3" ).autocomplete({
            source: studentNameList
          });
        
        $( "#username4" ).autocomplete({
            source: studentNameList
          });
        
        $( "#username5" ).autocomplete({
            source: studentNameList
          });
        
        $( "#username6" ).autocomplete({
            source: studentNameList
          });
        
      });
	</script>	
	<%
	RoleDataManager rdm = new RoleDataManager();
	ArrayList<Role> roles = rdm.retrieveAll();
	UserDataManager udm = new UserDataManager();
	
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
						    <select id="teamlimit" name="teamlimit" class="input-large" onchange="javascript: showHide();">
						      <option selected>4</option>
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
						  	<input type="hidden" name="memberRole" value="1" />
						  </div>
						</div>
						
						<!-- Text input-->
						<div id="mem2" class="control-group">
						  <label class="control-label" for="textinput">Member</label>
						  <div class="controls">
						    <input id="username2" name="username" type="text" placeholder="User Name" class="input-large">
						  </div>
						  <label class="control-label" for="selectbasic">Role</label>
						  <div class="controls">
						    <select id="memberRole" name="memberRole" class="input-large">
						     <%
						     for(int i = 0; i < roles.size(); i++){
						    	 Role role = roles.get(i);
						    	 if(role.getId() != 1){
						    	 %>
						    	 <option value="<%=role.getId() %>"><%=role.getRoleName() %></option>
						    	 <%
						    	 }
						     }
						     %>
						    </select>
						  </div>
						</div>
						<!-- Text input-->
						<div id="mem3" class="control-group">
						  <label class="control-label" for="textinput">Member</label>
						  <div class="controls">
						    <input id="username3" name="username" type="text" placeholder="User Name" class="input-large">
						  </div>
						  <label class="control-label" for="selectbasic">Role</label>
						  <div class="controls">
						    <select id="memberRole" name="memberRole" class="input-large">
						       <%
						     for(int i = 0; i < roles.size(); i++){
						    	 Role role = roles.get(i);
						    	 if(role.getId() != 1){
						    	 %>
						    	 <option value="<%=role.getId() %>"><%=role.getRoleName() %></option>
						    	 <% 
						    	 }
						     }
						     %>
						    </select>
						  </div>
						</div>
						<!-- Text input-->
						<div id="mem4" class="control-group">
						  <label class="control-label" for="textinput">Member</label>
						  <div class="controls">
						    <input id="username4" name="username" type="text" placeholder="User Name" class="input-large">
						  </div>
						  <label class="control-label" for="selectbasic">Role</label>
						  <div class="controls">
						    <select id="memberRole" name="memberRole" class="input-large">
						       <%
						     for(int i = 0; i < roles.size(); i++){
						    	 Role role = roles.get(i);
						    	 if(role.getId() != 1){
						    	 %>
						    	 <option value="<%=role.getId() %>"><%=role.getRoleName() %></option>
						    	 <% 
						    	 }
						     }
						     %>
						    </select>
						  </div>
						</div>
						<!-- Text input-->
						<div id="mem5" class="control-group" style="display: none">
						  <label class="control-label" for="textinput">Member</label>
						  <div class="controls">
						    <input id="username5" name="username" type="text" placeholder="User Name" class="input-large">
						  </div>
						  <label class="control-label" for="selectbasic">Role</label>
						  <div class="controls">
						    <select id="memberRole" name="memberRole" class="input-large">
						      <%
						     for(int i = 0; i < roles.size(); i++){
						    	 Role role = roles.get(i);
						    	 if(role.getId() != 1){
						    	 %>
						    	 <option value="<%=role.getId() %>"><%=role.getRoleName() %></option>
						    	 <% 
						    	 }
						     }
						     %>
						    </select>
						  </div>
						</div>
						
						<!-- Text input-->
						<div id="mem6" class="control-group" style="display:none">
						  <label class="control-label" for="textinput">Member</label>
						  <div class="controls">
						    <input id="username6" name="username" type="text" placeholder="User Name" class="input-large">
						  </div>
						  <label class="control-label" for="selectbasic">Role</label>
						  <div class="controls">
						    <select id="memberRole" name="memberRole" class="input-large">
						      <%
						     for(int i = 0; i < roles.size(); i++){
						    	 Role role = roles.get(i);
						    	 if(role.getId() != 1){
						    	 %>
						    	 <option value="<%=role.getId() %>"><%=role.getRoleName() %></option>
						    	 <% 
						    	 }
						     }
						     %>
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
								if(hasTeam){
							%>
						    <button id="createteam" name="createteam" class="btn btn-success" disabled="disabled">Create Team</button><br />
						    <font size=-1 color="red"><i>You already have a team</i></font>
						    <%
								}else{
									%> 
							<input type="submit" id="createteam" value="Create Team" class="btn btn-success">
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