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
	.container > .content {
	
	background-color: #ffffff;
	padding: 20px;
	margin: 0 -20px;
	-webkit-border-radius: 10px 10px 10px 10px;
	-moz-border-radius: 10px 10px 10px 10px;
	border-radius: 10px 10px 10px 10px;
	-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.15);
	-moz-box-shadow: 0 1px 2px rgba(0,0,0,.15);
	box-shadow: 0 1px 2px rgba(0,0,0,.15);
	}
	
	.panel-title .accordion-toggle:after {
    /* symbol for "collapsed" panels */
    font-family:FontAwesome;
	font-size:16px;
    content: '\f067'; 
    float:right; 
	}
</style>
<%
String sessionUsername = (String) session.getAttribute("username");

if(sessionUsername == null || sessionUsername.isEmpty()){
	sessionUsername = "";
}
%>
<head>	
	
	<link rel="stylesheet" type="text/css" href="./css/bootstrap.css" />
    <script src="./js/bootstrap.js"></script>
    <link type="text/css" href="./css/bootstrap-responsive.css" rel="stylesheet">

<script type="text/javascript">
function toggleSkill(source) {
	  checkboxes = document.getElementsByName('skills');
	  for(var i=0, n=checkboxes.length;i<n;i++) {
	    checkboxes[i].checked = source.checked;
	  }
	}
        function validateFormOnSubmit(theForm) {
        	var reason = "";

        	  reason += validateFullname(theForm.fullname);
        	  reason += validatePhone(theForm.contactno);
        	  reason += validateEmail(theForm.email);
        	  reason += validateEmpty(theForm.secondmajor);
        		      
        	  if (reason != "") {
        	    alert("Some fields need correction:\n" + reason);
        	    return false;
        	  }

        	  return true;
        }
        
        function validateFullname(fld) {
            var error = "";
            var illegalChars = /[0-9]/; // allow letters ONLY
         
            if (fld.value == "") {
                fld.style.background = 'Yellow'; 
                error = "You didn't enter your full name.\n";
            } /* else if ((fld.value.length < 5) || (fld.value.length > 15)) {
                fld.style.background = 'Yellow'; 
                error = "Your full name is the wrong length.\n";
            } */ else if (illegalChars.test(fld.value)) {
                fld.style.background = 'Yellow'; 
                error = "Your full name contains illegal characters.\n";
            } else {
                fld.style.background = 'White';
            } 
            return error;
        }

        
        function validatePhone(fld)  
        {  
          var error  = "";
          var phoneno = /^[\d\.\-\+]+$/;  
          if(!(fld.value.match(phoneno))||(fld.value.length<8)){  
        	  error = "Invalid phone number.\n"; 
        	  fld.style.background="Yellow";
          }else if(fld.value=""){  
        	  error = "You didn't enter a phone number.\n";  
        	  fld.style.background="Yellow"; 
          }  
          return error;
        }  
        
        function validateEmail(fld) {
            var error="";
            var tfld = trim(fld.value);                        // value of field with whitespace trimmed off
            var emailFilter = /^[^@]+@[^@.]+\.[^@]*\w\w$/ ;
            var illegalChars= /[\(\)\<\>\,\;\:\\\"\[\]]/ ;
            
            if (fld.value == "") {
                fld.style.background = 'Yellow';
                error = "You didn't enter an email address.\n";
            } else if (!emailFilter.test(tfld)) {              //test email for illegal characters
                fld.style.background = 'Yellow';
                error = "Please enter a valid email address.\n";
            } else if (fld.value.match(illegalChars)) {
                fld.style.background = 'Yellow';
                error = "The email address contains illegal characters.\n";
            } else {
                fld.style.background = 'White';
            }
            return error;
        }

        function validateEmpty(fld) {
            var error = "";
          
            if (fld.value.length == 0) {
                fld.style.background = 'Yellow'; 
                error = "Second major cannot be left blank.\n";
            } else {
                fld.style.background = 'White';
            }
            return error;   
        }	
        function others() {
        	var selected = $('#orgType').val();
        	if(selected=="Others"){
        		$('#otherOrgType').show();
        	}
        }
	</script>	
</head>
<%
	int profileid = 0;

	UserDataManager udm = new UserDataManager();
	User uProfile = null;
	String sessiontype = (String) session.getAttribute("type");
	
	SkillDataManager skdm = new SkillDataManager();
	ArrayList<Skill> langSkills = skdm.retrieveAllLang();
	ArrayList<Skill> otherSkills = skdm.retrieveAllOthers();
	ArrayList<String> userSkills = new ArrayList<String>(); 
	ArrayList<String> userLangSkills = new ArrayList<String>(); 
	ArrayList<String> userOtherSkills = new ArrayList<String>(); 
	
	boolean invalidAccess = false;
	
	String usertype = "";
	
	if(usertype == null || usertype.isEmpty()){
		usertype="";
	}

	String requestedUserName = ""; 
	try{
		profileid = Integer.parseInt(request.getParameter("id"));
		uProfile = udm.retrieve(profileid);
		usertype = (String) session.getAttribute("type");
		userSkills = skdm.getUserSkills(uProfile);
		userLangSkills = skdm.getUserLangSkills(uProfile);
		userOtherSkills = skdm.getUserOtherSkills(uProfile);
		requestedUserName = uProfile.getUsername();
	}catch(Exception e){
		session.setAttribute("message","Please choose a valid profile to view");
		invalidAccess = true;
		response.sendRedirect("searchUser.jsp");
	}
%>
<% if(!invalidAccess){ %>
<%@include file="template.jsp" %>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <script src="./jquery-ui-1.10.3.custom/js/jquery-1.9.1.js"></script>
  <script src="./jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
  <%
	StudentDataManager sdm 			= new StudentDataManager();
	ArrayList<String> majorList 	= sdm.retrieveAllMajors();
%>
<script type="text/javascript">
    $(function() {
        var majorList = [
                <%
                for(int i = 0; i < majorList.size(); i++){
                	out.println("\""+majorList.get(i)+"\",");
                }
                %>
           ];
        
        $( "#secondmaj" ).autocomplete({
            source: majorList
          });
 </script>
<body>
	<%
	//In case of Sponsor
	SponsorDataManager sponsordm = new SponsorDataManager();
	CompanyDataManager cdm = new CompanyDataManager();
	
	//For student
	
	Student student = sdm.retrieve(profileid);
	
	TeamDataManager tdm = new TeamDataManager();
	int teamId = 0;
	int visitorTeamId = 0;
	String teamName = "";
	String teamProfLink = "#";
	try{
		teamId = tdm.retrievebyStudent(uProfile.getID());
		teamName = tdm.retrieve(teamId).getTeamName();
		teamProfLink = "teamProfile.jsp?id=" + teamId;
	}catch(Exception e){
		teamId = 0;
		teamName = "No team yet";
		teamProfLink = "#";
	}
	
	try{
		visitorTeamId = tdm.retrievebyStudent(udm.retrieve(username).getID());
	}catch(Exception e){
		visitorTeamId = 0;
	}
	
	ProjectDataManager pdm = new ProjectDataManager();
	ArrayList<Project> projArray = pdm.retrieveAll(); 
	Project proj = null;
	String projName = "";
	int projId =0;
	
	String projProfLink = "#";
	
	if(teamId != 0){
		try{
			proj = pdm.getProjFromTeam(teamId);
			projName = proj.getProjName();
			projId = proj.getId();
			
			projProfLink = "projectProfile.jsp?id=" + projId;
		}catch(Exception e){
			projName = "No project yet";
			projProfLink = "#";
		}
	}else{
		try{
			proj = pdm.retrieveProjIdFromCreator(profileid);
			projName = proj.getProjName();
			projId = proj.getId();
			projProfLink = "projectProfile.jsp?id=" + projId;
		}catch(Exception e){
			projName = "No project yet";
			projProfLink = "#";
		}
	}
	
	ArrayList<Team> teamInvites = tdm.retrieveAllInvites(profileid);
	ArrayList<Team> teamRequests = tdm.retrieveStudentRequests(profileid);

	%>
	<div class="container" id="userdetails">
	
	<div class="content">
<!-- 	<div class="row"> -->
		
		<% String message = (String) session.getAttribute("message"); 
			if(message == null || message.isEmpty()){
				message = "";
			}else{
		%>
<%-- 			<font size=-1 color="red"><i><%=message %></i></font> --%>
			<div class="alert alert-success">
			  <button type="button" class="close" data-dismiss="alert">&times;</button>
			  <strong><%=message %></strong>
			</div>
			
			<%
			session.removeValue("message");
			} %>
		<!-- Form Name -->
		<h3>User Profile</h3>
		<%if (usertype.equalsIgnoreCase("Student")){ %>
		<div class="panel-group" id="accordion">
		  <div class="panel panel-default">
		    <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#collapseOne" style="cursor:pointer;">
		      <h4 class="panel-title">
		        <a class="accordion-toggle">
		          Team Invitations (<%=teamRequests.size() %>)
		        </a>
		      </h4>
		    </div>
		<div id="collapseOne" class="panel-collapse collapse">
		      <div class="panel-body">
		 			<table width="100%">
				    	<tr class="spaceunder">
							 <%
		  if(teamRequests.size() == 0){
			  out.println("None");
		  }else{
		  	for(int i = 0; i < teamRequests.size(); i++){
		  		Team team = teamRequests.get(i);
		  		%>
		  		<td>
		  		<a href="teamProfile.jsp?id=<%=team.getId()%>"><%=team.getTeamName() %></a> <br /><br />
		  		<form method="post" action="acceptInvite">
		  		<input type="hidden" name="stdId" value="<%=profileid %>">
		  		<input type="hidden" name="teamId" value="<%=team.getId() %>">
		  		<input type="submit" value="Accept Team Invite" class="btn btn-warning">
		  		</form>
		  		<form method="post" action="rejectInvite">	
		  		<input type="hidden" name="stdId" value="<%=profileid %>">
		  		<input type="hidden" name="teamId" value="<%=team.getId() %>">
		  		<input type="submit" value="Reject Invite" class="btn btn-danger">
		  		</form>
		  		</td>
		  		<%
		  		if((i+1) % 5 == 0){
		  			%>
		  			</tr><tr class="spaceunder">
		  			<%
		  		}
		  	}
		  }
		  %>
					  	</tr>
					</table>
		 	  </div>
		    </div>
		  </div>
		  
		  <br />
		
		<div class="panel-group" id="accordion">
		  <div class="panel panel-default">
		    <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#collapseTwo" style="cursor:pointer;">
		      <h4 class="panel-title">
		        <a class="accordion-toggle">
		          Team Requests (<%=teamInvites.size() %>)
		        </a>
		      </h4>
		    </div>
		<div id="collapseTwo" class="panel-collapse collapse">
		      <div class="panel-body">
		 			<table width="100%">
				    	<tr class="spaceunder">
							 <%
		  if(teamInvites.size() == 0){
			  out.println("None");
		  }else{
		  	for(int i = 0; i < teamInvites.size(); i++){
		  		Team team = teamInvites.get(i);
		  		%>
		  		<td>
		  		<a href="teamProfile.jsp?id=<%=team.getId()%>"><%=team.getTeamName() %></a> <br /><br />
		  		<font size=-1 color="grey"><i>Awaiting response...</i></font>
		  		</td>
		  		<%
		  		if((i+1) % 5 == 0){
		  			%>
		  			</tr><tr class="spaceunder">
		  			<%
		  		}
		  	}
		  }
		  %>
		  			 	</tr>
					</table>
		 	  </div>
		    </div>
		  </div>
		  
		  <br />
	</div>
	</div>
	<%} %>
	<form action="updateCurrentProfile" method="post" onsubmit = "return validateFormOnSubmit(this)" class="form-horizontal">
		<input type="hidden" name="userId" value="<%=uProfile.getID()%>">
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="fullname">Name</label>
		  <div class="controls">
		 <%if(sessionUsername.equals(uProfile.getUsername())){ %>
		    <input id="fullname" name="fullname" type="text" value="<%=uProfile.getFullName()%>" class="input-large" maxlength="50">
		 <% }else{%>
		    <%=uProfile.getFullName()%>
		 <% 
		 	
		 }	 
		%>
			</div>
		</div>
		 <div class="control-group">
		  <label class="control-label" for="contact">Contact</label>
		  <div class="controls">
			<%
				if(sessionUsername.equals(uProfile.getUsername())){
			%>
		    	<input id="contact" name="contact" type="text" value="<%=uProfile.getContactNum()%>" class="input-large" maxlength="30">
		    <%}else{ %>
		    	<%=uProfile.getContactNum()%>
		    <%} %>
		  </div>
		</div>
		<div class="control-group">
		  <label class="control-label" for="email">Email</label>
		  <div class="controls">
		  <%if(sessionUsername.equals(uProfile.getUsername())){ %>
		    <input id="email" name="email" type="text" value="<%=uProfile.getEmail()%>" class="input-xlarge" maxlength="50">
		     <% }else{%>
		    <a href="mailto:<%=uProfile.getEmail()%>"><%=uProfile.getEmail()%></a>
		 <% 	
		 }	 
		%>
		    <input type="hidden" name="type" value="<%=type%>">
		  </div>
		</div>
		<!-- </div></br> -->
		<!-- <div class="span3"> -->
		<!-- Text input-->
		<%if(usertype.equals("Sponsor")){ 
			Sponsor sponsor = sponsordm.retrieve(username);
		
			ArrayList<Project> sponsoredProjects = pdm.retrieveAllFromSponsor(sponsor);
			%>
			<div class="control-group">
			  <label class="control-label" for="email">Projects Sponsored:</label>
			  <div class="controls">
			  <% for(int i = 0; i < sponsoredProjects.size(); i++){ 
			  		Project sponsoredProject = sponsoredProjects.get(i);
			  		String sponsoredProjName = sponsoredProject.getProjName();
			  		int sponsoredProjId = sponsoredProject.getId();
			  %>
			    <a href="projectProfile.jsp?id=<%=sponsoredProjId%>"><%=sponsoredProjName %></a><br />
			    <% } %>
			  </div>
			</div>
		<% } %>
		<!-- </div> -->
		<!-- <div class="span4"> -->
		<!-- Text input-->
			
		<%if(usertype.equalsIgnoreCase("Student")){%>
		<!-- </div> -->
		<!-- <div class="span5"> -->
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="secondMajor">Second Major</label>
		  <div class="controls">
		  	 
		  	<%
				if(sessionUsername.equals(uProfile.getUsername())){
			%>
			<select id="secondmaj" name="secondmajor" class="input-large">
			<%
			
		    	  SecondMajorDataManager secondMajordm = new SecondMajorDataManager();
			    	  ArrayList<SecondMajor> secondMajors  = secondMajordm.retrieveAll();
					  
			    	  for(int i = 0; i < secondMajors.size(); i++){
			    		SecondMajor showSecondMajor = secondMajors.get(i); 
			    		String secMaj = showSecondMajor.getSecondMajor();
			    		String studentSecMaj = student.getSecondMajor();
			    		if(secMaj.equalsIgnoreCase(studentSecMaj)){	
			%>
					   <option value="<%=secMaj%>" selected="selected"><%=secMaj%></option>
					    <%}else{ %>
					    	<option value="<%=secMaj%>"><%=secMaj%></option>
					    <%
					    }
					}
			    %></select><%
				}else{
					out.println(student.getSecondMajor());
				}
					  %>
					
		     
		  </div>
		</div>

		  
		  <div class="panel-group" id="accordion">
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
		         Skills
		        </a>
		      </h4>
		    </div>
		    <div id="collapseThree" class="panel-collapse collapse in">
		      <div class="panel-body">
							<%
							if(username.equalsIgnoreCase(requestedUserName)){
							    int count = 0;
								boolean checked = false;
								%>
								<table>
								<h2>Language</h2>
				    	<tr class="spaceunder">
				    	<%
								for(int i = 0; i < langSkills.size(); i++){
									checked = false;
									Skill hasSkill = langSkills.get(i);
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
								<td>
								  <input type="checkbox" name="skills" value="<%=langSkills.get(i).getId() %>" checked="checked">&nbsp;<span class="label label-default"><%=langSkills.get(i).getSkillName() %></span>&nbsp;&nbsp;
								  </td><td></td>
								   <%
								  }else{
								  %><td>
								  <input type="checkbox" name="skills" value="<%=langSkills.get(i).getId() %>">&nbsp;<span class="label label-default"><%=langSkills.get(i).getSkillName() %></span>&nbsp;&nbsp;
								  </td><td></td>
								  <%  
									}
								  if((i+1) % 3 == 0){
									  %>
									  </tr><tr class="spaceunder">
									  <%
								  }
							  }
								%>
								</tr></table>
								<table>
								<h2>Others</h2>
				    	<tr class="spaceunder">
								<%
								for(int i = 0; i < otherSkills.size(); i++){
									checked = false;
									Skill hasSkill = otherSkills.get(i);
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
								<td>
								  <input type="checkbox" name="skills" value="<%=otherSkills.get(i).getId() %>" checked="checked">&nbsp;<span class="label label-default"><%=otherSkills.get(i).getSkillName() %></span>&nbsp;&nbsp;
								  </td><td></td>
								   <%
								  }else{
								  %><td>
								  <input type="checkbox" name="skills" value="<%=otherSkills.get(i).getId() %>">&nbsp;<span class="label label-default"><%=otherSkills.get(i).getSkillName() %></span>&nbsp;&nbsp;
								  </td><td></td>
								  <%  
									}
								  if((i+1) % 3 == 0){
									  %>
									  </tr><tr class="spaceunder">
									  <%
								  }
							  }
								%>
								</tr></table>
								<%
							}else{
								%>
								<table>
								<h2>Language</h2>
				    	<tr class="spaceunder">
								<%
								if(userLangSkills.size() < 1){
									out.println("No skill indicated");
								}else{
									
									for(int i  = 0; i < userLangSkills.size(); i++){
										Skill skill = skdm.retrieveSkill(userLangSkills.get(i));
										%>
										<td>
									 <span class="label label-default"><%=skill.getSkillName() %></span>&nbsp;&nbsp;
									  </td><td></td>
								<%
									}
								}
								%>
							  	</tr>
								</table>
								<table>
								<h2>Others</h2>
				    	<tr class="spaceunder">
								<%
								if(userLangSkills.size() < 1){
									out.println("No skill indicated");
								}else{
										
									for(int i  = 0; i < userOtherSkills.size(); i++){
										Skill skill = skdm.retrieveSkill(userOtherSkills.get(i));
										%>
										<td>
									 <span class="label label-default"><%=skill.getSkillName() %></span>&nbsp;&nbsp;
									  </td><td></td>
										<%
									}
								}
								%>
							  	</tr>
								</table>
							<%
							}
								  %>
		 	  </div>
		    </div>
		  </div>
		  </div>
		  	<%-- <input id="team" name="team" type="text" placeholder=" <%=ind.getIndustryName() %>" class="input-xlarge"> --%>
		 </br> 
		<div class="control-group">
		  <label class="control-label" for="team">Team</label>
		  <div class="controls">
		  	<a href="<%=teamProfLink%>"><span class="label label-info"><%=teamName%></span></a>
		  </div>
		</div></br>
		<div class="control-group">
		  <label class="control-label" for="project">Project</label>
		  <div class="controls">
		  	<a href="<%=projProfLink%>"><span class="label label-info"><%=projName%></span></a>
		  </div>
		</div>
		<%}else if(usertype.equalsIgnoreCase("Sponsor")){ 
		Sponsor sponsor = sponsordm.retrieve(username);
		Company company = cdm.retrieve(profileid);
		int orgId = company.getOrgType();
		OrganizationDataManager odm = new OrganizationDataManager();
		Organization org = odm.retrieve(orgId);
		String orgType = org.getOrgType();
		
		ArrayList<Team> invitedTeams = sponsordm.getInvitedTeams(sponsor);
		%>
		<div class="control-group">
		  <label class="control-label" for="coyName">Invited Teams </label>
		  <div class="controls">
		    <%
		    if(invitedTeams.size() < 1){
		    	%>
		    	You have not invited any teams to view your project
		    	<%
		    }else{
		    	for(int i = 0; i < invitedTeams.size(); i++){
		    		Team team = invitedTeams.get(i);
		    		%>
		    		<a href="teamProfile.jsp?id=<%=team.getId()%>"><%=team.getTeamName() %></a><br />
		    		<%
		    	}
		    }
		    %>
		  </div>
		</div>
		
		<div class="control-group">
		  <label class="control-label" for="coyName">Company </label>
		  <div class="controls">
		  <input type="hidden" name="coyId" value="<%=company.getID()%>">
		    <input id="coyName" name="coyname" type="text" value="<%=company.getCoyName()%>" readonly="readonly" class="input-xlarge" maxlength="60">
		  </div>
		</div>
		<div class="control-group">
		  <label class="control-label" for="orgType">Organization Type </label>
		  <div class="controls">
		    <select id="orgType" name="orgType" class="input-large"onChange="others()">
			  		<option value="" selected="selected" disabled style="color:#BDBDBD;">Choose Organization Type</option>
				<%
			    	  OrganizationDataManager orgdm = new OrganizationDataManager();
				    	  ArrayList<Organization> orgs  = orgdm.retrieveAll();
						  
				    	  for(int i = 0; i < orgs.size(); i++){
				    		Organization o = orgs.get(i); 
				    		String oType = o.getOrgType();
						   %>
						    	<option value="<%=o.getId()%>"><%=oType%></option>
						    <%} %>
					<option value="Others">Others</option>
			  </select>
		  </div>
		</div>
		<div  id="otherOrgType" class="control-group" style="display:none;">
			<div class="controls">
				<input type="text" name="orgType" class="input-large"placeholder="Organization Type" size="45" maxlength="50"/>
			</div>
		</div>
		<%}else if(usertype.equalsIgnoreCase("Supervisor")){ %>
		<div class="control-group">
		  <label class="control-label" for="coyName">Supervising Teams </label>
		  <div class="controls">
		    <%
			ArrayList<Team> teams = tdm.retrieveSupervisingTeams(requestedUserName);
			
			if(teams.size() < 1){
				out.println("No teams under supervision");
			}else{
				for(int i = 0; i < teams.size(); i++){
					Team t = teams.get(i);
					%>
					<a href="teamProfile.jsp?id=<%=t.getId()%>"><%=t.getTeamName() %></a><br />
					<%
				}
			}
			%>
		  </div>
		</div>
			
		
		<%} %>
		<!-- Button -->
		<%
		if(sessionUsername.equals(uProfile.getUsername())){
		%>
		<input type="submit" id="editprofile" value="Save" class="btn btn-success">
		</form>
		<%
		}else{
		%></form>
		<%
		}
		%>
		<%if(sessiontype.equalsIgnoreCase("Student")&&!sessionUsername.equalsIgnoreCase(uProfile.getUsername())){ %>
		  <form action="inviteStudent" method="post">
		  	<input type="hidden" name="studentId" value="<%=profileid%>">
		  	<input type="hidden" name="visitorTeamId" value="<%=visitorTeamId%>">
		    <input type="submit" id="inviteStudent" value="Invite" class="btn btn-info" onclick="this.disabled=true;this.value='Invited';">
		   </form>
		<%}%>
		</div> 
	
	</div>
</body>
<%}

%>

</html>