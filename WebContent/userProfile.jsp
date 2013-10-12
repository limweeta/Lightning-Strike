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
<%
String sessionUsername = (String) session.getAttribute("username");

if(sessionUsername == null || sessionUsername.isEmpty()){
	sessionUsername = "";
}
%>
<head>	
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
	<link rel="stylesheet" type="text/css" href="./css/bootstrap.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>  
    <script src="./js/bootstrap.js"></script>
    <link type="text/css" href="./css/bootstrap-responsive.css" rel="stylesheet">
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
		teamId = 0;
		teamName = "No team yet";
	}
	
	
	ProjectDataManager pdm = new ProjectDataManager();
	ArrayList<Project> projArray = pdm.retrieveAll(); 
	Project proj = null;
	String projName = "";
	int projId =0;
	
	if(teamId != 0){
		try{
			proj = pdm.getProjFromTeam(teamId);
			projName = proj.getProjName();
			projId = proj.getId();
		}catch(Exception e){
			projName = "No project yet";
		}
	}else{
		projName = "No project yet";
	}
	
	
	SkillDataManager skdm = new SkillDataManager();
	ArrayList<Skill> allSkills = skdm.retrieveAll();
	ArrayList<String> userSkills = skdm.getUserSkills(u);
	%>
	<div class="container" id="userdetails">
	
	<div class="span9 well">
<!-- 	<div class="row"> -->
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
			<%
				if(sessionUsername.equals(u.getUsername())){
			%>
		    	<input id="contactno" name="contactno" type="text" value="<%=u.getContactNum()%>" class="input-large">
		    <%}else{ %>
		    	<input id="contactno" name="contactno" type="text" value="<%=u.getContactNum()%>" class="input-large" readonly="readonly">
		    <%} %>
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
		  	<%
				if(sessionUsername.equals(u.getUsername())){
			%>
		    <input id="secondmajor" name="secondmajor" type="text" value="<%=student.getSecondMajor()%>" class="input-large">
		     <%}else{ %>
		     <input id="secondmajor" name="secondmajor" type="text" value="<%=student.getSecondMajor()%>" class="input-large" readonly="readonly">
		    <%} %>
		  </div>
		</div>
		
		  <label class="control-label" for="skills">Skills</label>
		  
		  <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Skills<b class="caret"></b></a>
	      	<ul class="dropdown-menu">
	     		<li><input type="checkbox" onclick="toggleTech(this)" />Select All</li>
		 <%
		    int count = 0;
			boolean checked = false;
			for(int i = 0; i < allSkills.size(); i++){
				checked = false;
				%>
				<!-- <script>var tab = [</script> -->
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
				<li>
				<input id="skills" type="checkbox" name="skills" value="<%=allSkills.get(i).getId() %>" checked="checked" />
						<%=allSkills.get(i).getSkillName() %>
				</li>
				<%--  <script>{ id: "<%=i%>", label: "<%=allSkills.get(i).getSkillName() %>", isChecked: true },</script> --%>
				<%
				}else{
					%>
				<li>
				<input id="skills" type="checkbox" name="skills" value="<%=allSkills.get(i).getId() %>" />
						<%=allSkills.get(i).getSkillName() %>
				</li>	
				<%-- <script>{ id: "<%=i%>", label: "<%=allSkills.get(i).getSkillName() %>", isChecked: false },</script> --%>
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
		  	<%-- <input id="team" name="team" type="text" placeholder=" <%=ind.getIndustryName() %>" class="input-xlarge"> --%>
		 </br> 
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
		<%
		if(sessionUsername.equals(u.getUsername())){
		%>
		<div class="control-group">
		  <label class="control-label" for="editprofile"></label>
		  <div class="controls">
		    <input type="submit" id="editprofile" value="Save Profile" class="btn btn-success">
		  </div>
		</div>
		<%
		}
		%>
		</div></br>
		</fieldset>
	</form>
<!-- 	</div> -->
	</div>
	</div>
</body>
</html>