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

        function validatePhone(fld) {
            var error = "";
            var stripped = fld.value.replace(/[\(\)\.\-\ ]/g, '');     

           if (fld.value == "") {
                error = "You didn't enter a phone number.\n";
                fld.style.background = 'Yellow';
            } else if (isNaN(parseInt(stripped))) {
                error = "The phone number contains illegal characters.\n";
                fld.style.background = 'Yellow';
            } /* else if (!(stripped.length == 8)) {
                error = "The phone number is too short.\n";
                fld.style.background = 'Yellow';
            }  */
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
	</script>	
</head>
<%
	int profileid = 0;

	UserDataManager udm = new UserDataManager();
	User uProfile = null;
	String type = (String) session.getAttribute("type");
	
	SkillDataManager skdm = new SkillDataManager();
	ArrayList<Skill> allSkills = skdm.retrieveAll();
	ArrayList<String> userSkills = new ArrayList<String>(); 
	
	boolean invalidAccess = false;
	
	if(type == null || type.isEmpty()){
		type="";
	}
	
	try{
		profileid = Integer.parseInt(request.getParameter("id"));
		uProfile = udm.retrieve(profileid);
		type = uProfile.getType();
		userSkills = skdm.getUserSkills(uProfile);
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
	
	String teamName = "";
	
	try{
		teamId = tdm.retrievebyStudent(uProfile.getID());
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
		try{
			proj = pdm.retrieveProjIdFromCreator(profileid);
			projName = proj.getProjName();
			projId = proj.getId();
		}catch(Exception e){
			projName = "No project yet";
		}
	}
	
	ArrayList<Team> teamInvites = tdm.retrieveAllInvites(profileid);
	ArrayList<Team> teamRequests = tdm.retrieveStudentRequests(profileid);
	%>
	<div class="container" id="userdetails">
	
	<div class="span12 well">
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
		<div class="span11">
		<%if (type.equalsIgnoreCase("Student")){ %>
		<div class="panel-group" id="accordion">
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
		          Team Invitations (<%=teamInvites.size() %>)
		        </a>
		      </h4>
		    </div>
		<div id="collapseOne" class="panel-collapse collapse">
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
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
		          Team Requests (<%=teamRequests.size() %>)
		        </a>
		      </h4>
		    </div>
		<div id="collapseTwo" class="panel-collapse collapse">
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
		 <%if(type.equalsIgnoreCase("sponsor")){ %>
		    <input id="fullname" name="fullname" type="text" value="<%=uProfile.getFullName()%>" class="input-large">
		 <% }else{%>
		    <input id="fullname" name="fullname" type="text" readonly="readonly"  value="<%=uProfile.getFullName()%>" class="input-large">
		 <% 
		 	
		 }	 
		%>
		 
		 
		  </div>
		</div>
		<!-- </div></br> --></br>
		<!-- <div class="span3"> -->
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="contactno">Contact</label>
		  <div class="controls">
			<%
				if(sessionUsername.equals(uProfile.getUsername())){
			%>
		    	<input id="contactno" name="contactno" type="text" value="<%=uProfile.getContactNum()%>" class="input-large">
		    <%}else{ %>
		    	<input id="contactno" name="contactno" type="text" value="<%=uProfile.getContactNum()%>" class="input-large" readonly="readonly">
		    <%} %>
		  </div>
		</div>
		<!-- </div> --></br>
		<!-- <div class="span4"> -->
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="email">Email</label>
		  <div class="controls">
		  <%if(type.equalsIgnoreCase("sponsor")){ %>
		    <input id="email" name="email" type="text" value="<%=uProfile.getEmail()%>" class="input-xlarge">
		     <% }else{%>
		    <input id="email" name="email" type="text" value="<%=uProfile.getEmail()%>" readonly="readonly" class="input-xlarge">
		 <% 	
		 }	 
		%>
		    <input type="hidden" name="type" value="<%=type%>">
		  </div>
		</div>
	<% if(type.equalsIgnoreCase("faculty")){ 
		ArrayList<Team> supervisedTeams = tdm.retrievebyFaculty(profileid);
	%>
		<div class="control-group">
		  <label class="control-label" for="email">Teams Supervised:</label>
		  <div class="controls">
		  <% for(int i = 0; i < supervisedTeams.size(); i++){ 
		  		Team supervisedTeam = supervisedTeams.get(i);
		  		String supervisedTeamName = supervisedTeam.getTeamName();
		  		int supervisedTeamId = supervisedTeam.getId();
		  %>
		    <a href="teamProfile.jsp?id=<%=supervisedTeamId%>"><%=supervisedTeamName %></a>
		    <% } %>
		  </div>
		</div>
	<% } %>	
		<%if(type.equals("Student")){%>
		<!-- </div> --></br>
		<!-- <div class="span5"> -->
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="secondMajor">Second Major</label>
		  <div class="controls">
		  	<%
				if(sessionUsername.equals(uProfile.getUsername())){
			%>
		    <input id="secondmaj" name="secondmajor" type="text" value="<%=student.getSecondMajor()%>" class="input-large">
		     <%}else{ %>
		     <input id="secondmaj" name="secondmajor" type="text" value="<%=student.getSecondMajor()%>" class="input-large" readonly="readonly">
		    <%} %>
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
		    <div id="collapseThree" class="panel-collapse collapse">
		      <div class="panel-body">
		 			<table>
						<tr class="spaceunder">
						     <td><input type="checkbox" onclick="toggleSkill(this)" />&nbsp;<span class="label label-default">Select All</span></td>
					     </tr>
				    	<tr class="spaceunder">
							<%
							    int count = 0;
								boolean checked = false;
								for(int i = 0; i < allSkills.size(); i++){
									checked = false;
									%>
									
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
								<td>
								  <input type="checkbox" name="skills" value="<%=allSkills.get(i).getId() %>" checked="checked">&nbsp;<span class="label label-default"><%=allSkills.get(i).getSkillName() %></span>&nbsp;&nbsp;
								  </td><td></td>
								   <%
								  }else{
								  %><td>
								  <input type="checkbox" name="skills" value="<%=allSkills.get(i).getId() %>">&nbsp;<span class="label label-default"><%=allSkills.get(i).getSkillName() %></span>&nbsp;&nbsp;
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
					  	</tr>
					</table>
		 	  </div>
		    </div>
		  </div>
		  </div>
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
		<%}else if(type.equalsIgnoreCase("sponsor")){ 
		Company company = cdm.retrieve(profileid);
		%>
		<div class="control-group">
		  <label class="control-label" for="coyName">Company </label>
		  <div class="controls">
		    <input id="coyName" name="coyname" type="text" value="<%=company.getCoyName()%>" readonly="readonly" class="input-xlarge">
		  </div>
		</div>
		<%} %>
		
		<!-- Button -->
		<%
		if(sessionUsername.equals(uProfile.getUsername())){
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
		</form>
		</div></br>
	
<!-- 	</div> -->
	
	</div>
	
	</div>
</body>
<%}%>

</html>