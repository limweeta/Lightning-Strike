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
			
			Project teamProj = pdm.getProjFromTeam(projs, Integer.parseInt(teamId));
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
	<form action="updateProfile" class="form-horizontal">
		<fieldset>
		
		<!-- Form Name -->
		<legend><%=team.getTeamName() %></legend>
		
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
		   <%
            for(int i=0; i < members.size(); i++){
            	Student student = members.get(i);
            	%>
            	<a href="userProfile.jsp?id=<%=student.getID()%>"><%=student.getFullName() %></a></br>
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
		</div></br>
		
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
			
		try{
			if(udm.retrieve(username).getID() == team.getPmId()){
				%>
				<form method="post" action="deleteTeam">
					<input type="hidden" name="teamId" value="<%=teamId %>">
					<div class="control-group">
					  <label class="control-label" for="delete"></label>
					  <div class="controls">
					    <button id="delete" name="delete" class="btn btn-warning">Delete Team</button>
					  </div>
					</div>
				</form>
				<%
			
				}
			}catch(Exception e){}
			
		%>
		
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
		</div></br>
		</fieldset>
	</form>
	</div>
	</div>
	</body>

</html>