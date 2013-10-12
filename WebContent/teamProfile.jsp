<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>

<style type="text/css">
	h1{
		font-family:Impact;
		font-size:1.75em;
	}
	#teamName{
		font-family: Impact;
		font-size:1.5em;
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
	#teamPic{
		font-family:Impact;
		font-size: 1em;
		word-wrap:break-word;
	}
</style>
	<head>
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>  
    
	<% 
		
		String teamId = request.getParameter("id");
		
		if(teamId == null || teamId.isEmpty()){
			response.sendRedirect("searchTeam.jsp");
		}else{
			ProjectDataManager pdm = new ProjectDataManager();
			ArrayList<Project> projs = pdm.retrieveAll();
			
			StudentDataManager sdm = new StudentDataManager();
			ArrayList<Student> members = sdm.getTeamListFromTeamId(Integer.parseInt(teamId));
			
			UserDataManager udm = new UserDataManager();
			
			TeamDataManager tdm = new TeamDataManager();
			Team team = tdm.retrieve(Integer.parseInt(teamId));
			TechnologyDataManager techdm = new TechnologyDataManager();
			
			
			Project teamProj = pdm.getProjFromTeam(Integer.parseInt(teamId));
			String projName = "";
			int projId = 0;
			try{
				projName = teamProj.getProjName();
				projId = teamProj.getId();
			}catch(Exception e){
				projName = "No Project Yet";
			}

		   	String sessionUsername = (String) session.getAttribute("username");
		  	User sessUser = null;
			int sessUserId = 0;
			try{
				 sessUser =  udm.retrieve(sessionUsername);
				 sessUserId = sessUser.getID();
			}catch(Exception e){
				sessUserId = 0;
			}
%>
		
	<%@ include file="template.jsp" %>
	</head>
	<script type="text/javascript">
	function toggleTech(source) {
		  checkboxes = document.getElementsByName('technology');
		  for(var i=0, n=checkboxes.length;i<n;i++) {
		    checkboxes[i].checked = source.checked;
		  }
		}
		
	function toggleInd(source) {
		  checkboxes = document.getElementsByName('industry');
		  for(var i=0, n=checkboxes.length;i<n;i++) {
		    checkboxes[i].checked = source.checked;
		  }
		}
	
	</script>
	<body>
	<div class="span9 well">
				<% String message = (String) session.getAttribute("message"); 
						if(message == null || message.isEmpty()){
							message = "";
						}else{
				%>
						<font size=-1 color="red"><i><%=message %></i></font>
						<%
						session.removeValue("message");
						} %>
	<div class="row">
	<form action="updateTeam" class="form-horizontal" method=post>
		<input type="hidden" name="pmId" value="<%=team.getPmId()%>">
		<!-- Form Name -->
		<legend><%=team.getTeamName() %></legend>
		<input type="hidden" name="teamId" value="<%=teamId %>">
		<input type="hidden" name="teamName" value="<%=team.getTeamName() %>">
		<div class="span9">
		<!-- Text input-->
		<input type="hidden" name="teamLimit" value="<%=team.getTeamLimit() %>">
		<div class="control-group">
		  <label class="control-label" for="fullname">About Us</label>
		  <div class="controls">
		  <%if(sessUserId == team.getPmId()){ %>
		    <textarea id="teamDesc" name="teamDesc"><%=team.getTeamDesc() %></textarea>
		  <%}else{ %>
		  	<textarea id="teamDesc" name="teamDesc" readonly="readonly"><%=team.getTeamDesc() %></textarea>
		  <%}%>
		  </div>
		</div>
		<!-- </div></br> --></br>
		<!-- <div class="span3"> -->
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="members">Members</label>
		  <div class="controls">
		  <!-- add control to edit if it's the pm -->
		   <%
            for(int i=0; i < members.size(); i++){
            	Student student = members.get(i);
            	%>
            	<a href="userProfile.jsp?id=<%=student.getID()%>"><%=student.getFullName() %></a> &nbsp;| 
            	<%
            	RoleDataManager rdm = new RoleDataManager();
            	int roleId = student.getRole();
            	Role r = rdm.retrieve(roleId);
            	%>
            	<%=r.getRoleName() %> <br />
	            	<%
	            		if(sessUserId == team.getPmId()){
	            	%>
				<form action="removeMember" method="post">
				<input type="hidden" name="userId" value="<%=student.getID()%>">
				<input type="hidden" name="teamId" value="<%=teamId%>">
				<input type="submit" value="Remove from Team" onclick="return confirm('Are you sure you want to remove <%=student.getFullName() %> from this team?');return false;" />
				<br />
				</form>
					<%
	            		}
					%>
            	<%
            }
            %>
		  </div>
		</div></br>
		<div class="control-group">
		  <label class="control-label" for="project">Project</label>
		  <div class="controls">
		  	<a href="projectProfile.jsp?id=<%=projId%>"><span class="label label-info"><%=projName %></span></a>
		  </div>
		</div></br>
		<div class="control-group">
		  <label class="control-label" for="supervisor">Supervisor</label>
		  <div class="controls">
		  	<a href="#"><span class="label label-info">
			<%
			int supId = team.getSupId(); 
			String supervisorName = "";
			
			  try{
				  supervisorName = udm.retrieve(supId).getFullName();
			  }catch(Exception e){
				  supervisorName = "No supervisor yet";
			  }
			%><%=supervisorName %>
			</span></a>
		  </div>
		</div></br>
		
		<label class="control-label" for="teamskills">Team Skills</label>
		<div class="span1 well">
		    <%
            SkillDataManager skdm = new SkillDataManager();
            ArrayList<Integer> skillset = skdm.getUserSkills(members);
            
            for(int i = 0; i < skillset.size(); i++){
            	int count = i + 1;
            	int skillId = skillset.get(i);
            	Skill skill = skdm.retrieve(skillId);
            	%>
            	<%=skill.getSkillName() + " | " %>
            	<%
            	if(count % 3 == 0){
            		%>
            		</br>
            		<%
            	}
            }
            %>
           
		</div>
		</br></br></br></br></br></br></br></br></br>
		
		  <label class="control-label" for="technology">Preferred Technology</label>
		
		 <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Technology<b class="caret"></b></a>
	      	<ul class="dropdown-menu">
	     		<li><input type="checkbox" onclick="toggleTech(this)" />Select All</li>
		    <%
		    ArrayList<Technology> allTech = techdm.retrieveAll();
		    int count = 0;
			boolean checked = false;
			for(int i = 0; i < allTech.size(); i++){
				checked = false;
				%>
				
				<%
				Technology hasTech = allTech.get(i);
				count++;
				for(int j  = 0; j < allTech.size(); j++){
					if(techdm.hasPrefTech(Integer.parseInt(teamId), hasTech.getId())){
						checked=true;
					}
					%>
					<%
				}
				if(checked){
				%>
				<li>
				<input id="technology" type="checkbox" name="technology" value="<%=allTech.get(i).getId() %>" checked="checked" />
						<%=allTech.get(i).getTechName() %>
				</li>
				<%
				}else{
					%>
				<li>
				<input id="technology" type="checkbox" name="technology" value="<%=allTech.get(i).getId() %>" />
						<%=allTech.get(i).getTechName() %>
				</li>	
					<%
				}
				if(count % 3 == 0){
					%>
				
					<%
				}%>
				
			<%}
			%>
			</ul>
			</li>
		</br>
		 
		
		  <label class="control-label" for="prefindustry">Preferred Industry</label>
		 
		  	<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Industry<b class="caret"></b></a>
	      	<ul class="dropdown-menu">
	     		<li><input type="checkbox" onclick="toggleInd(this)" />Select All</li>
		    <%
		    IndustryDataManager idm = new IndustryDataManager();
		    ArrayList<Industry> allInd = idm.retrieveAll();
		    count = 0;
			checked = false;
			for(int i = 0; i < allInd.size(); i++){
				checked = false;
				%>
				
				<%
				Industry hasInd = allInd.get(i);
				count++;
				for(int j  = 0; j < allInd.size(); j++){
					if(idm.hasPrefInd(Integer.parseInt(teamId), hasInd.getIndustryId())){
						checked=true;
					}
					%>
					<%
				}
				if(checked){
				%>
				<li>
				<input id="industry" type="checkbox" name="industry" value="<%=allInd.get(i).getIndustryId() %>" checked="checked" />
						<%=allInd.get(i).getIndustryName() %>
				</li>
				<%
				}else{
					%>
				<li>
				<input id="industry" type="checkbox" name="industry" value="<%=allInd.get(i).getIndustryId() %>" />
						<%=allInd.get(i).getIndustryName() %>
				</li>	
					<%
				}
				if(count % 3 == 0){
					%>
				
					<%
				}%>
				
			<% }
			%>
			</ul>
			</li>
		</br>
		
		<%if(username != null){ %>
		<div class="control-group">
		  <label class="control-label" for="request"></label>
		  <div class="controls">
		  	<a href="#"><span class="label label-info">Request to Join</span></a>
		  </div>
		</div></br>
		<% 
		}
		%>
		</br>
		<%
		try{
			if(udm.retrieve(username).getID() == team.getPmId()){
				%>
		<div class="control-group">
		  <label class="control-label" for="updateTeam"></label>
		  <div class="controls">
		    <input type="submit" id="updateTeam" name="Save Profile" class="btn btn-success">
		  </div>
		</div>
		
			<%
			
				}
			}catch(Exception e){}
		%></div>
		</form>
		<%
		try{
			if(udm.retrieve(username).getID() == team.getPmId()){
				%>
				<form method="post" action="deleteTeam">
					<input type="hidden" name="teamId" value="<%=teamId %>">
					<div class="control-group">
					  <label class="control-label" for="delete"></label>
					  <div class="controls">
					   <input type="submit" id="delete" value="Delete" onclick="return confirm('Do you wish to delete this team?');return false;" class="btn btn-danger">
					 <!--    <div id = "alert_placeholder"></div>
						<script>
						bootstrap_alert = function() {}
						bootstrap_alert.warning = function(message) {
						            $('#alert_placeholder').html('<div class="alert"><a class="close" data-dismiss="alert">×</a><span>'+message+'</span></div>')
						        }
						
						$('#delete').on('click', function() {
						            bootstrap_alert.warning('Team has been deleted!');
						});
						</script> -->
					  </div>
					</div>
				</form>
				<%
				}
			}catch(Exception e){}
		}
		%>
		</div>
		</div>
	</body>

</html>