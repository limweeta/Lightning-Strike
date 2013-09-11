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
			
			try{
				projName = teamProj.getProjName();
			}catch(Exception e){
				projName = "No Project Yet";
			}
	%>
		
	<%@ include file="template.jsp" %>
	</head>
	<body>
	<div id="teamName"><%=team.getTeamName() %></div></br>
	<div id="teamPic">
		<textarea id="teamPic" rows="7" cols="150" disabled>TEAM PICTURE</textarea>
	</div>
		<div id="aboutus"></br>
			<font size="4" face="Courier">About Us:</font></br>
			 <textarea id="about" rows="10" cols="75"><%=team.getTeamDesc() %>
			 </textarea> </br></br>
            <font size="4" face="Courier">Members:
            </br>
            <%
            for(int i=0; i < members.size(); i++){
            	Student student = members.get(i);
            	%>
            	<%=student.getFullName() %><br>
            	<%
            }
            %>
            </font></br>
            <font size="4" face="Courier">Project: <%=projName %></br>	
            <br>
            Team Skills:<br>
            <%
            SkillDataManager skdm = new SkillDataManager();
            ArrayList<Integer> skillset = skdm.getUserSkills(members);
            
            for(int i = 0; i < skillset.size(); i++){
            	int count = i + 1;
            	int skillId = skillset.get(i);
            	Skill skill = skdm.retrieve(skillId);
            	%>
            	<%=skill.getSkillName() %>
            	<%
            	if(count % 5 == 0){
            		%>
            		<br>
            		<%
            	}
            }
            %>
            </font>
		</div>
		<%if(username != null){ %>
		<a href="#">Request to Join</a></br>
		<a href="#">Leave Team</a></br>
		<% 
		}
			
		try{
			if(udm.retrieve(username).getID() == team.getPmId()){
				%>
		<form method="post" action="deleteTeam">
		<input type="hidden" name="teamId" value="<%=teamId %>">
	<input type=submit value="Delete">
	</form>
				<%
			
			}
		}catch(Exception e){}
		
		%>
		
		
		<%
		}
		%>
	</body>

</html>