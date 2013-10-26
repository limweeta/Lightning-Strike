<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>

<html>

<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
<script type="text/javascript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
<script src="js/jquery.autocomplete.js"></script>  
<link rel="stylesheet" href="./css/bootstrap.css"  type="text/css"/>

<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="./js/bootstrap.js"></script>

<body>

<div class="span12 well">
	<div class="span12">
		<div class="createTeam">
					<form class="form-horizontal" action="createTeam" method="post" name="createTeam" onsubmit="return validateForm()">
						<fieldset>
						<% String message = (String) session.getAttribute("message"); 
						if(message == null || message.isEmpty()){
							message = "";
						}else{
						%>
						<font size=-1 color="red"><i><%=message %></i></font>
						<%
						session.removeValue("message");
						} %>
						<!-- Form Name -->
						<h3>Create Team</h3>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="teamname">Team Name</label>
						  <div class="controls">
						    <input id="teamname" name="teamname" type="text" placeholder="Team Name" class="input-large" >
						    
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
						  <label class="control-label">Team Limit</label>
						  <div class="controls">
						    <select id="teamlimit" name="teamlimit" class="input-large">
						      <option value="4" selected>4</option>
						      <option value="5">5</option>
						      <option value="6">6</option>
						    </select>
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="projectmanager">Team Members</label>
						</div>
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
						<div class="control-group">
						  <label class="control-label" for="textinput">Member</label>
						  <div id="members" class="controls">
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
						
	<%-- 					<div class="control-group">
						  <label class="control-label" for="textinput">Preferred Industry</label>
						  <div class="controls">
						    <table border="0">
						     <tr>
						     <td><input type="checkbox" onclick="toggleInd(this)" />&nbsp;Select All</td>
						     </tr>
						    	<tr>
								 <%
								  IndustryDataManager idm = new IndustryDataManager();
								  ArrayList<Industry> industries = idm.retrieveAll();
								 
								  for(int i = 0; i < industries.size(); i++){
									  Industry ind = industries.get(i);
									  %><td>
									  <input type="checkbox" name="industry" value="<%=ind.getIndustryId()%>">&nbsp;<%=ind.getIndustryName() %>&nbsp;&nbsp;
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
						</div> --%>
						
						<%-- <div class="control-group">
						  <label class="control-label" for="textinput">Preferred Technology</label>
						  <div class="controls">
						    <table border="0">
						     <tr>
						     <td><input type="checkbox" onclick="toggleTech(this)" />&nbsp;Select All</td>
						     </tr>
						    	<tr>
								 <%
								  TechnologyDataManager tdm = new TechnologyDataManager();
								  ArrayList<Technology> technologies = tdm.retrieveAll();
								 
								  for(int i = 0; i < technologies.size(); i++){
									  Technology tech = technologies.get(i);
									  %><td>
									  <input type="checkbox" name="technology" value="<%=tech.getId()%>">&nbsp;<%=tech.getTechName() %>&nbsp;
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
						 --%>
		<div class="panel-group" id="accordion">
		  <div class="panel panel-default">
			    <div class="panel-heading">
			      <h4 class="panel-title">
			        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFive">
			          Team Skills 
			        </a>
			      </h4>
			    </div>
			    <div id="collapseFive" class="panel-collapse collapse">
			      <div class="panel-body">
				    	<table>
					    	<tr class="spaceunder">
								<%
					            SkillDataManager skdm = new SkillDataManager();
					            ArrayList<Integer> skillset = tdm.retrieveTeamSkills(team);
					            
					            for(int i = 0; i < skillset.size(); i++){
					            	int count = i + 1;
					            	int skillId = skillset.get(i);
					            	Skill skill = skdm.retrieve(skillId);
					            	%><td>
									 <span class = "label label-default"><%=skill.getSkillName()%></span>>&nbsp;&nbsp;
									  </td><td></td>
									   <%
									  if((i+1) % 3 == 0){
									  %>
								  </tr><tr class="spaceunder">
								  <%
									  }

								  %>
						  	</tr>
						</table> 
					</div>
			    </div>
			  </div>
			  </div>
			  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
		          Preferred Skills
		        </a>
		      </h4>
		    </div>
		    <div id="collapseTwo" class="panel-collapse collapse">
		      <div class="panel-body">
		 			<table>
						<tr class="spaceunder">
						     <td><input type="checkbox" onclick="toggleInd(this)" />&nbsp;<span class="label label-default">Select All</span></td>
					     </tr>
				    	<tr class="spaceunder">
							<%
								  SkillDataManager skdm = new SkillDataManager();
								  ArrayList<Skill> skills = skdm.retrieveAll();
								  
								  for(int i = 0; i < skills.size(); i++){
									  Skill skill = skills.get(i);
									  %><td>
									  <input type="checkbox" name="industry" value="<%=skill.getId()%>>">&nbsp;<span class="label label-default"><%=skill.getSkillName() %></span>&nbsp;&nbsp;
									  </td><td></td>
									  <%
									  if((i+1) % 3 == 0){
										  %></tr><tr class="spaceunder">
								<%
									  }
								  }
								  %>
					  	</tr>
					</table>
		 	  </div>
		    </div>
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