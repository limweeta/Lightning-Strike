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
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <script src="./jquery-ui-1.10.3.custom/js/jquery-1.9.1.js"></script>
  <script src="./jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
  <%
	String type 					= (String) session.getAttribute("type");
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
        
        $( "#secondmajor" ).autocomplete({
            source: majorList
          });
        
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
	<form action="updateCurrentProfile" method="post" onsubmit = "return validateFormOnSubmit(this)" class="form-horizontal">
		<input type="hidden" name="userId" value="<%=u.getID()%>">
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
		<legend>User Profile</legend>
		
			<div class="span1"><a href="#" class="thumbnail"><img src="https://db.tt/8gUG7CxQ" alt=""></a>
			</div>
		<div class="span8">
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="fullname">Name</label>
		  <div class="controls">
		 <%if(type.equalsIgnoreCase("sponsor")){ %>
		    <input id="fullname" name="fullname" type="text" value="<%=u.getFullName()%>" class="input-large">
		 <% }else{%>
		    <input id="fullname" name="fullname" type="text" readonly="readonly"  value="<%=u.getFullName()%>" class="input-large">
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
		  <%if(type.equalsIgnoreCase("sponsor")){ %>
		    <input id="email" name="email" type="text" value="<%=u.getEmail()%>" class="input-xlarge">
		     <% }else{%>
		    <input id="email" name="email" type="text" value="<%=u.getEmail()%>" readonly="readonly" class="input-xlarge">
		 <% 	
		 }	 
		%>
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
				
				<%
				}else{
					%>
				<li>
				<input id="skills" type="checkbox" name="skills" value="<%=allSkills.get(i).getId() %>" />
						<%=allSkills.get(i).getSkillName() %>
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
		Company company = cdm.retrieve(u.getID());
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