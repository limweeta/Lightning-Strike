<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<style type="text/css">
	h1{
		font-family:"Courier";
		font-weight: bold;
		font-size:20px;
	}

</style>
<head>	
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>  
	<%@include file="template.jsp" %>
</head>
<body>
 
</br></br></br>
	<!-- <div id="profilepic2"><a href="./ViewProfile.html"><img src="http://db.tt/Cfe7G4Z5" width="100" height="100" /></a></div>
	<a href="#">Edit Profile Picture</a> 
	</br></br></br>-->
	<%
	int profileid = 0;
	
	try{
		profileid = Integer.parseInt(request.getParameter("id"));
	}catch(Exception e){
		response.sendRedirect("searchUser.jsp");
	}
	
	UserDataManager udm = new UserDataManager();
	User u = null;
	String userType = "";
	try{
		u = udm.retrieve(profileid);
		userType = u.getType();
	}catch(Exception e){
		response.sendRedirect("searchUser.jsp");
	}
	
	//In case of Sponsor
	SponsorDataManager sponsordm = new SponsorDataManager();
	CompanyDataManager cdm = new CompanyDataManager();
	
	//For student
	StudentDataManager sdm = new StudentDataManager();
	Student student = sdm.retrieve(profileid);
	
	TeamDataManager tdm = new TeamDataManager();
	int teamId = 0;
	
	String teamName = "";
	
	try{
		teamId = tdm.retrievebyStudent(u.getID());
		teamName = tdm.retrieve(teamId).getTeamName();
	}catch(Exception e){
		teamName = "No team yet";
	}
	
	
	ProjectDataManager pdm = new ProjectDataManager();
	ArrayList<Project> projArray = pdm.retrieveAll(); 
	Project proj = null;
	String projName = "";
	int projId =0;
	
	try{
		proj = pdm.getProjFromTeam(projArray, teamId);
		projName = proj.getProjName();
		projId = proj.getId();
	}catch(Exception e){
		projName = "No project yet";
	}
	
	SkillDataManager skdm = new SkillDataManager();
	ArrayList<Skill> allSkills = skdm.retrieveAll();
	ArrayList<String> userSkills = skdm.getUserSkills(u);
	%>
	<div class="container" id="userdetails">
	<%-- <% if(userType.equals("Student")){%>
			<%@include file="studentprofiletemplate.jsp" %>	
	<%}else if(userType.equals("Sponsor")){%>
			<%@include file="sponsorprofiletemplate.jsp" %>
	<%}else{%>
			<%@include file="userprofiletemplate.jsp" %>
	<%}
	%> --%>
<%-- 	<form id="userprofile">
	<font size="4" face="Courier">Name:</font>
	<%=u.getFullName()%></br>
	<font size="4" face="Courier">Contact Number:</font>
	<%=u.getContactNum()%></br>
	<font size="4" face="Courier">Email:</font>
	<%=u.getEmail()%></br>
	<h1>About Me:</h1>
	<!-- if user is a student -->
	<%if(userType.equals("Student")){%>
	<font size="4" face="Courier">Second Major:</font> <%=student.getSecondMajor()%>
	<br /><br />
	<font size="4" face="Courier">Skills:</font><br />
	<%
	if(userSkills.size() < 1){
		%>
		No skills recorded
		<%
	}else{
		int count = 0;
		for(int i  = 0; i < userSkills.size(); i++){
			count = i + 1;
			out.print(userSkills.get(i) + " | ");
			
			if(count % 3 == 0){
				%>
				<br />
				<%
			}
		}
	}
	%>
	<br /><br />
	<font size="4" face="Courier">Team: <a href="teamProfile.jsp?id=<%=teamId%>"><%=teamName%></a></font><br /><br />
	<font size="4" face="Courier">Project: <a href="projectProfile.jsp?id=<%=projId%>"><%=projName%></a></font>
	</br>
	<%} %>
	</form> --%>
	<div class="span9 well">
	<div class="row">
	<form action="updateCurrentProfile" method="post" class="form-horizontal">
		<input type="hidden" name="userId" value="<%=u.getID()%>">
		<fieldset>
		
		<!-- Form Name -->
		<legend>User Profile</legend>
		
			<div class="span1"><a href="#" class="thumbnail"><img src="https://db.tt/8gUG7CxQ" alt=""></a>
			</div>
		<div class="span8">
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="fullname">Name</label>
		  <div class="controls">
		    <input id="fullname" name="fullname" type="text" readonly="readonly" value="<%=u.getFullName()%>" class="input-large">
		    
		  </div>
		</div>
		<!-- </div></br> --></br>
		<!-- <div class="span3"> -->
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="contactno">Contact</label>
		  <div class="controls">
		    <input id="contactno" name="contactno" type="text" value="<%=u.getContactNum()%>" class="input-large">
		  </div>
		</div>
		<!-- </div> --></br>
		<!-- <div class="span4"> -->
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="email">Email</label>
		  <div class="controls">
		    <input id="email" name="email" type="text" value="<%=u.getEmail()%>" readonly="readonly" class="input-xlarge">
		    <input type="hidden" name="type" value="<%=userType%>">
		  </div>
		</div>
		<%if(userType.equals("Student")){%>
		<!-- </div> --></br>
		<!-- <div class="span5"> -->
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="secondmajor">Second Major</label>
		  <div class="controls">
		    <input id="secondmajor" name="secondmajor" type="text" value="<%=student.getSecondMajor()%>" class="input-large">
		    
		  </div>
		</div>
		<div class="control-group">
		  <label class="control-label" for="skills">Skills</label>
		  <div class="controls">
		  <table border=0 width="100%">
		  	<tr>
		    <%
		    int count = 0;
			boolean checked = false;
			for(int i = 0; i < allSkills.size(); i++){
				checked = false;
				%>
				<td>
				<%
				Skill hasSkill = allSkills.get(i);
				count++;
				for(int j  = 0; j < userSkills.size(); j++){
					if(hasSkill.getSkillName().trim().equals(userSkills.get(j).trim())){
						checked=true;
					}
					%>
					<%
				}
				if(checked){
				%>
				<input id="skills" type="checkbox" name="skills" value="<%=allSkills.get(i).getId() %>" checked="checked" />
						<%=allSkills.get(i).getSkillName() %>
				</td>
				<%
				}else{
					%>
				<input id="skills" type="checkbox" name="skills" value="<%=allSkills.get(i).getId() %>" />
						<%=allSkills.get(i).getSkillName() %>
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
		  	<%-- <input id="team" name="team" type="text" placeholder=" <%=ind.getIndustryName() %>" class="input-xlarge"> --%>
		  </div>
		</div>
		<div class="control-group">
		  <label class="control-label" for="team">Team</label>
		  <div class="controls">
		  	<a href="teamProfile.jsp?id=<%=teamId%>"><span class="label label-info"><%=teamName%></span></a>
		  </div>
		</div></br>
		<div class="control-group">
		  <label class="control-label" for="project">Project</label>
		  <div class="controls">
		  	<a href="projectProfile.jsp?id=<%=projId%>"><span class="label label-info"><%=projName%></span></a>
		  </div>
		</div>
		<%} %>
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
	</div>
</body>
</html>