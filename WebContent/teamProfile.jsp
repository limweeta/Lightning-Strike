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
	%>
		
	<%@ include file="template.jsp" %>
	</head>
	<body>
	<div class="span9 well">
	<div class="row">
	<form action="updateTeam" class="form-horizontal">
		<fieldset>
		
		<!-- Form Name -->
		<legend><%=team.getTeamName() %></legend>
		<input type="hidden" name="teamId" value="<%=teamId %>">
			<div class="span1">
				<img width=500px; height=150px; src="https://db.tt/T1ASL5ed">
			</div></br>
		<div class="span8">
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="fullname">About Us</label>
		  <div class="controls">
		    <textarea id="teamDesc"><%=team.getTeamDesc() %></textarea>
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
            	<a href="userProfile.jsp?id=<%=student.getID()%>"><%=student.getFullName() %></a>
            	| 
            	<%
            	RoleDataManager rdm = new RoleDataManager();
            	int roleId = student.getRole();
            	Role r = rdm.retrieve(roleId);
            	
            	%>
            	<%=r.getRoleName() %> | 
				<form action="removeMember" method="post">
				<input type="hidden" name="userId" value="<%=student.getID()%>">
				<input type="hidden" name="teamId" value="<%=teamId%>">
				<input type="submit" value="Remove from Team" />
				</form>
            	</br>
            	<%
            }
            %>
		  </div>
		</div></br>
		<div class="control-group">
		  <label class="control-label" for="team">Project</label>
		  <div class="controls">
		  	<a href="projectProfile.jsp?id=<%=projId%>"><span class="label label-info"><%=projName %></span></a>
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
            		<br>
            		<%
            	}
            }
            %>
		</div></div>
		
		<div class="control-group">
		  <label class="control-label" for="technology">Preferred Technology</label>
		  <div class="controls">
		  <table border=0 width="100%">
		  	<tr>
		    <%
		    ArrayList<Technology> allTech = techdm.retrieveAll();
		    int count = 0;
			boolean checked = false;
			for(int i = 0; i < allTech.size(); i++){
				checked = false;
				%>
				<td>
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
				<input id="technology" type="checkbox" name="technology" value="<%=allTech.get(i).getId() %>" checked="checked" />
						<%=allTech.get(i).getTechName() %>
				</td>
				<%
				}else{
					%>
				<input id="technology" type="checkbox" name="technology" value="<%=allTech.get(i).getId() %>" />
						<%=allTech.get(i).getTechName() %>
				</td>	
					<%
				}
				if(count % 3 == 0){
					%>
					</tr><tr>
					<%
				}
			}
			%>
			</tr>
			</table>
		  </div>
		</div><br />
		
		<div class="control-group">
		  <label class="control-label" for="industry">Preferred Industry</label>
		  <div class="controls">
		  <table border=0 width="100%">
		  	<tr>
		    <%
		    IndustryDataManager idm = new IndustryDataManager();
		    ArrayList<Industry> allInd = idm.retrieveAll();
		    count = 0;
			checked = false;
			for(int i = 0; i < allInd.size(); i++){
				checked = false;
				%>
				<td>
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
				<input id="industry" type="checkbox" name="industry" value="<%=allInd.get(i).getIndustryId() %>" checked="checked" />
						<%=allInd.get(i).getIndustryName() %>
				</td>
				<%
				}else{
					%>
				<input id="industry" type="checkbox" name="industry" value="<%=allInd.get(i).getIndustryId() %>" />
						<%=allInd.get(i).getIndustryName() %>
				</td>	
					<%
				}
				if(count % 3 == 0){
					%>
					</tr><tr>
					<%
				}
			}
			%>
			</tr>
			</table>
		  </div>
		</div><br />
		
		<%if(username != null){ %>
		<div class="control-group">
		  <label class="control-label" for="request"></label>
		  <div class="controls">
		  	<a href="#"><span class="label label-info">Request to Join</span></a>
		  </div>
		</div></br>
		<div class="control-group">
		  <label class="control-label" for="leave"></label>
		  <div class="controls">
		  	<a href="#"><span class="label label-info">Leave Team</span></a>
		  </div>
		</div></br>
		<% 
		}
		%>
		<!-- </div> --></br>
		<!-- <div class="span7"> -->
		<!-- Button -->
		<div class="control-group">
		  <label class="control-label" for="editprofile"></label>
		  <div class="controls">
		    <button id="editprofile" name="editprofile" class="btn btn-success">Save Profile</button>
		  </div>
		</div>
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
					    <input type="submit" id="delete" name="delete" class="btn btn-warning" value="Delete Team" />
					  </div>
					</div>
				</form>
				<%
			
				}
			}catch(Exception e){}
			
		}
		%>
		
		</div></br>
		</fieldset>
	</div>
	</div>
	</body>

</html>