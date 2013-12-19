<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>

<style type="text/css">
	h1{
		font-family:Impact;
		font-size:1.75em;
	}

	textarea{
		resize: none;
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
	<head>
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>  
    
	<% 	
		User sessUser = null;
		String usertype = (String) session.getAttribute("type");
	
		Calendar now = Calendar.getInstance();
		int currYear = now.get(Calendar.YEAR);
		int currMth = now.get(Calendar.MONTH);
	
	if(usertype == null || usertype.isEmpty()){
		usertype = "";
	}
		
		String teamIdStr = request.getParameter("id");
		int sessUserId = 0;
		int teamId = 0;
		
		try{
			teamId = Integer.parseInt(teamIdStr);
		}catch(Exception e){
			session.setAttribute("message", "Invalid address");
			response.sendRedirect("searchTeam.jsp");
		}
		
		TeamDataManager tdm = new TeamDataManager();
		Team team = null;
		
	
		if(teamId == 0 || (!usertype.equalsIgnoreCase("admin") && !usertype.equalsIgnoreCase("sponsor") && !usertype.equalsIgnoreCase("student"))){
			session.setAttribute("message", "You need to have a team to view that page.");
			response.sendRedirect("searchTeam.jsp");
		}else if(tdm.retrieve(teamId) == null || (!usertype.equalsIgnoreCase("admin") && !usertype.equalsIgnoreCase("sponsor") && !usertype.equalsIgnoreCase("student"))){
			session.setAttribute("message", "Not a valid team");
			response.sendRedirect("searchTeam.jsp");
		}else{
			
			ProjectDataManager pdm = new ProjectDataManager();
			ArrayList<Project> projs = pdm.retrieveAll();
			String status = "";
			
			try{
				status = tdm.getTeamStatus(team);
			}catch(Exception e){}
			
			StudentDataManager sdm = new StudentDataManager();
			ArrayList<Student> members = sdm.getTeamListFromTeamId(teamId);
			
			UserDataManager udm = new UserDataManager();
			
			team = tdm.retrieve(teamId);
			TechnologyDataManager techdm = new TechnologyDataManager();
			
			ArrayList<Student> studentRequests = sdm.retrieveStudentRequests(teamId);
			ArrayList<Student> studentInvites = sdm.retrieveStudentsInvitedByTeam(teamId);
			
			Project teamProj = pdm.getProjFromTeam(teamId);
			String projName = "";
			int projId = 0;
			try{
				projName = teamProj.getProjName();
				projId = teamProj.getId();
			}catch(Exception e){
				projName = "No Project Yet";
			}

		   	String sessionUsername = (String) session.getAttribute("username");
		  	
			
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
	function validateFormOnSubmit(theForm) {
		var reason = "";

		  reason += validateTeamname(theForm.teamName);
      
		  if (reason != "") {
		    alert("Some fields need correction:\n" + reason);
		    return false;
		  }

		  return true;
	}

	function validateTeamname(fld) {
	    var error = "";
	 
	    if (fld.value == "") {
	        fld.style.background = 'Yellow'; 
	        error = "Team name cannot be blank.\n";
	    } else {
	        fld.style.background = 'White';
	    } 
	    return error;
	}
	
	</script>
	<body>
	<div class="container">
	<div class="content">
				<% String message = (String) session.getAttribute("message"); 
						if(message == null || message.isEmpty()){
							message = "";
						}else{
				%>
						<div class="alert alert-success" align="center">
						  <button type="button" class="close" data-dismiss="alert">&times;</button>
						  <strong><%=message %></strong>
						</div>
				<%
				session.removeValue("message");
				} %>
<%-- 			<font size=-1 color="red"><i><%=message %></i></font> --%>
			
		
		<h5><%=team.getTeamName()%>&nbsp;&nbsp;
				<%if(status.equals("Started")||status.equals("Accepted")||status.equals("Registered")){ %>
					<span class="label label-success" style="padding:10px;"><%=status %></span></br>
				<%}else if(status.equals("Rejected")||status.equals("Removed")){ %>
					<span class="label label-danger" style="padding:10px;"><%=status %></span></br>
				<%}else if(status.equals("Suspended")){%>
					<span class="label label-warning" style="padding:10px;"><%=status %></span></br>
				<%}else if(status.equals("Completed")){%>
					<span class="label label-default" style="padding:10px;"><%=status %></span></br>
				<%} %>
				</h5>
		
		<div class="panel-group" id="accordion">
		  <div class="panel panel-default">
		    <div class="panel-heading"  data-toggle="collapse" data-parent="#accordion" data-target="#collapseOne" style="cursor:pointer;">
		      <h4 class="panel-title">
		        <a class="accordion-toggle">
		          Students Request (<%=studentInvites.size() %>)
		        </a>
		      </h4>
		    </div>
		<div id="collapseOne" class="panel-collapse collapse">
		      <div class="panel-body">
		 			<table width="100%">
				    	<tr class="spaceunder">
							 <%
		  if(studentInvites.size() == 0){
			  out.println("None");
		  }else{
		  	for(int i = 0; i < studentInvites.size(); i++){
		  		Student student = studentInvites.get(i);
		  		%>
		  		<td>
		  		<a href="userProfile.jsp?id=<%=student.getID()%>"><%=student.getFullName() %></a> <br /><br />
		  		<form method="post" action="acceptStudent">
		  		<input type="hidden" name="stdId" value="<%=student.getID() %>">
		  		<input type="hidden" name="teamId" value="<%=team.getId() %>">
		  		<input type="submit" value="Accept Student" class="btn btn-warning">
		  		</form>
		  		<form method="post" action="rejectStudent">	
		  		<input type="hidden" name="stdId" value="<%=student.getID() %>">
		  		<input type="hidden" name="teamId" value="<%=team.getId() %>">
		  		<input type="submit" value="Reject Student" class="btn btn-danger">
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
		    <div class="panel-heading"  data-toggle="collapse" data-parent="#accordion" data-target="#collapseTwo" style="cursor:pointer;">
		      <h4 class="panel-title">
		        <a class="accordion-toggle">
		          Students Invited (<%=studentRequests.size() %>)
		        </a>
		      </h4>
		    </div>
		<div id="collapseTwo" class="panel-collapse collapse">
		      <div class="panel-body">
		 			<table width="100%">
				    	<tr class="spaceunder">
							 <%
		  if(studentRequests.size() == 0){
			  out.println("None");
		  }else{
		  	for(int i = 0; i < studentRequests.size(); i++){
		  		Student student = studentRequests.get(i);
		  		%>
		  		<td>
		  		<a href="userProfile.jsp?id=<%=student.getID()%>"><%=student.getFullName() %></a> <br /><br />
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

		<%-- <div class="control-group">
		  <label class="control-label" for="fullname">About Us</label>
		  <div class="controls">
		  <%if(sessUserId == team.getPmId()){ %>
		    <textarea id="teamDesc" name="teamDesc"><%=team.getTeamDesc() %></textarea>
		  <%}else{ %>
		  	<textarea id="teamDesc" name="teamDesc" readonly="readonly"><%=team.getTeamDesc() %></textarea>
		  <%}%>
		  </div>
		</div> --%>
		<!-- </div></br> --></br>
		<!-- <div class="span3"> -->
		<!-- Text input-->
		
	<form action="removeMember" method="post" class="form-horizontal">
		<div class="control-group">
		  <label class="control-label" for="members">Members</label>
		  <div class="controls">
		  <!-- add control to edit if it's the pm -->
		   <%
            for(int i=0; i < members.size(); i++){
            	Student student = members.get(i);
            	%>
            	<span class = "label label-info"><a href="userProfile.jsp?id=<%=student.getID()%>" style="color: #FFFFFF"><%=student.getFullName() %></a> &nbsp;| 
            	<%
            	RoleDataManager rdm = new RoleDataManager();
            	int roleId = student.getRole();
            	Role r = rdm.retrieve(roleId);
            	%>
            	<%=r.getRoleName() %>  </span></br></br>
	            	<%
	            		if(sessUserId == team.getPmId()){
	            	%>
	           
				<input type="hidden" name="userId" value="<%=student.getID()%>">
				<input type="hidden" name="teamId" value="<%=teamId%>">
				<input type="submit" value="Remove from Team" onclick="return confirm('Are you sure you want to remove <%=student.getFullName() %> from this team?');return false;" class="btn btn-danger"/>
				<br />
				</form>
					<%
	            		}
					%>
            	<%
            }
            %>
		  </div>
		</div>
	<form action="updateTeam" class="form-horizontal" method=post onsubmit = "return validateFormOnSubmit(this)">
		<input type="hidden" name="pmId" value="<%=team.getPmId()%>">
		<!-- Form Name -->
		<input type="hidden" name="teamId" value="<%=teamId %>">
		
		<!-- Text input-->
		<input type="hidden" name="teamLimit" value="<%=team.getTeamLimit() %>">
		
		<div class="control-group">
		  <label class="control-label" for="project">Term</label>
		  <div class="controls">
		  <%
    	  TermDataManager termdm = new TermDataManager();
	            		if(sessUserId == team.getPmId()){
	       %>
		  <select id="term" name="term" class="input-large">
		    	  <%
		    	  ArrayList<Term> terms  = termdm.retrieveFromNextSem();
					Term term = termdm.retrieve(team.getTermId());
					int termId = term.getId();
				  
		    	  for(int i = 0; i < terms.size(); i++){
		    		Term showTerm = terms.get(i); 
		    		if((termId) == showTerm.getId()){	
		    	%>
		    	  <option value="<%=showTerm.getId()%>" selected><%=showTerm.getAcadYear() + " T" + showTerm.getSem() %></option>
		    	 <%
		    		}else{
    			%>
		    	  <option value="<%=showTerm.getId()%>"><%=showTerm.getAcadYear() + " T" + showTerm.getSem() %></option>
		    	 <%	
		    		}
		    	  }
		    	 %>
		</select> 
		<%} else{ 
					Term term = termdm.retrieve(team.getTermId());%>
		  	<span class="label label-info"><%=term.getAcadYear() + " T" + term.getSem()%></span>
		  	<input type="hidden" name="termId" value="<%=term.getId() %>">
		  	<%} %>
		  	
		  </div>
		</div>
		<div class="control-group">
		  <label class="control-label" for="project">Project</label>
		  <div class="controls">
		  	<span class="label label-info"><a href="projectProfile.jsp?id=<%=projId%>" style="color: #FFFFFF"><%=projName %></a></span>
		  </div>
		</div>
		<div class="control-group">
		  <label class="control-label" for="supervisor">Supervisor</label>
		  <div class="controls">
			<%
			int supId = team.getSupId(); 
			String supervisorName = "";
			String profileLink = "#";
			  try{
				  supervisorName = udm.retrieve(supId).getFullName();
				  profileLink = "userProfile.jsp?id=" + supId;
			  }catch(Exception e){
				  profileLink = "#";
				  supervisorName = "No supervisor yet";
			  }
			%>
			<span class="label label-info"><a href="<%=profileLink%>" style="color: #FFFFFF"><%=supervisorName %></a></span>
		  </div>
		</div><br />
		
		<div class="control-group">
		  <label class="control-label" for="supervisor">Reviewers</label>
		  <div class="controls">
			<%
			int rev1Id = team.getRev1Id(); 
			int rev2Id = team.getRev2Id(); 
			String rev1Name = "Not assigned";
			String rev1ProfileLink = "#";
			String rev2Name = "Not assigned";
			String rev2ProfileLink = "#";
			  try{
				  rev1Name = udm.retrieve(rev1Id).getFullName();
				  rev1ProfileLink = "userProfile.jsp?id=" + rev1Id;
			  }catch(Exception e){
				  rev1ProfileLink = "#";
				  rev1Name = "Not assigned";
			  }
			  
			  try{
				  rev2Name = udm.retrieve(rev2Id).getFullName();
				  rev2ProfileLink = "userProfile.jsp?id=" + rev2Id;
			  }catch(Exception e){
				  rev2ProfileLink = "#";
				  rev2Name = "Not assigned";
			  }
			%>
			<span class="label label-info"><a href="<%=rev1ProfileLink%>" style="color: #FFFFFF"><%=rev1Name %><br /><br />
			
			<span class="label label-info"><a href="<%=rev2ProfileLink%>" style="color: #FFFFFF"><%=rev2Name %><br />
			</a></span>
		  </div>
		</div><br />
		<!-- @CHLOE PUT SKILLS IN THE SAME AS INDUSTRY AND TECH -->
		
	<div class="panel-group" id="accordion">
		<div class="panel panel-default">
			    <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#collapseFive" style="cursor:pointer;">
			      <h4 class="panel-title">
			        <a class="accordion-toggle">
			          Team Skills 
			        </a>
			      </h4>
			    </div>
			    <div id="collapseFive" class="panel-collapse collapse in">
			      <div class="panel-body">
				    	<table>
					    	<tr class="spaceunder">
					    	<h2>Language</h2>
								<%
					            SkillDataManager skdm = new SkillDataManager();
					            ArrayList<Integer> skillsetLang = tdm.retrieveTeamSkillsByLanguage(team);
					            System.out.println(skillsetLang.size());
					            for(int k = 0; k < skillsetLang.size(); k++){
					            	int count2 = k + 1;
					            	int skillId = skillsetLang.get(k);
					            	Skill skill = skdm.retrieve(skillId);
					            	%><td>
									 <span class = "label label-default"><%=skill.getSkillName()%></span>&nbsp;&nbsp;
									  </td><td></td>
									   <%
									  if((k+1) % 3 == 0){
									  %>
								  </tr><tr class="spaceunder">
								  <%
									  }
					            }
								  %>
						  	</tr>
						</table>
						
						<table>
					    	<tr class="spaceunder">
					    	<h2>Others</h2>
								<%
					            ArrayList<Integer> skillsetOthers = tdm.retrieveTeamSkillsByOthers(team);
					            System.out.println(skillsetOthers.size());
					            for(int k = 0; k < skillsetOthers.size(); k++){
					            	int count2 = k + 1;
					            	int skillId = skillsetOthers.get(k);
					            	Skill skill = skdm.retrieve(skillId);
					            	%><td>
									 <span class = "label label-default"><%=skill.getSkillName()%></span>&nbsp;&nbsp;
									  </td><td></td>
									   <%
									  if((k+1) % 3 == 0){
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
			  </br>
		  <div class="panel panel-default">
		    <div class="panel-heading"  data-toggle="collapse" data-parent="#accordion" data-target="#collapseThree" style="cursor:pointer;">
		      <h4 class="panel-title">
		        <a class="accordion-toggle">
		          Preferred Industry
		        </a>
		      </h4>
		    </div>
		    <div id="collapseThree" class="panel-collapse collapse in">
		      <div class="panel-body">
		 			<table>
						<tr class="spaceunder">
						     <td><input type="checkbox" onclick="toggleInd(this)" />&nbsp;<span class="label label-default">Select All</span></td>
					     </tr>
				    	<tr class="spaceunder">
							<%
						    IndustryDataManager idm = new IndustryDataManager();
						    ArrayList<Industry> allInd = idm.retrieveAll();
						    int count = 0;
							boolean checked = false;
							for(int i = 0; i < allInd.size(); i++){
								checked = false;
								%>
								
								<%
								Industry hasInd = allInd.get(i);
								count++;
								for(int j  = 0; j < allInd.size(); j++){
									if(idm.hasPrefInd(teamId, hasInd.getIndustryId())){
										checked=true;
									}
									%>
									<%
								}
								if(checked){
								%><td>
								  <input type="checkbox" name="industry" value="<%=allInd.get(i).getIndustryId() %>" checked="checked">&nbsp;<span class="label label-default"><%=allInd.get(i).getIndustryName() %></span>&nbsp;&nbsp;
								  </td><td></td>
								   <%
								  }else{
								  %><td>
								  <input type="checkbox" name="industry" value="<%=allInd.get(i).getIndustryId() %>">&nbsp;<span class="label label-default"><%=allInd.get(i).getIndustryName() %></span>&nbsp;&nbsp;
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
					<input type="text" name="industry" placeholder="Others">
		 	  </div>
		    </div>
		  </div>
		  <br />
		  <div class="panel panel-default">
		    <div class="panel-heading"  data-toggle="collapse" data-parent="#accordion" data-target="#collapseFour" style="cursor:pointer">
		      <h4 class="panel-title">
		        <a class="accordion-toggle">
		          Preferred Technology
		        </a>
		      </h4>
		    </div>
		    <div id="collapseFour" class="panel-collapse collapse in">
		      <div class="panel-body">
			    	<table>
						<tr class="spaceunder">
						     <td><input type="checkbox" onclick="toggleTech(this)" />&nbsp;<span class="label label-default">Select All</span></td>
					     </tr>
				    	<tr class="spaceunder">
							<%
							    ArrayList<Technology> allTech= techdm.retrieveAll();
							    int count1 = 0;
								boolean checked1 = false;
								for(int i = 0; i < allTech.size(); i++){
									checked1 = false;
									%>
									
									<%
									Technology hasTech = allTech.get(i);
									count1++;
									for(int j  = 0; j < allTech.size(); j++){
										if(techdm.hasPrefTech(teamId, hasTech.getId())){
											checked1=true;
										}
									}
									if(checked1){
								%>
								<td>
								  <input type="checkbox" name="technology" value="<%=allTech.get(i).getId() %>" checked="checked">&nbsp;<span class="label label-default"><%=allTech.get(i).getTechName() %></span>&nbsp;&nbsp;
								  </td><td></td>
								   <%
								  }else{
								  %><td>
								  <input type="checkbox" name="technology" value="<%=allTech.get(i).getId() %>">&nbsp;<span class="label label-default"><%=allTech.get(i).getTechName() %></span>&nbsp;&nbsp;
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
					<input type="text" name="technology" placeholder="Others">
				</div>
		    </div>
		  </div>
	  </div>
		
	  <br />
		<table>
		<tr>
		<%
		try{
			if(udm.retrieve(username).getID() == team.getPmId()){
				%>
				<td class="space">
		    	<input type="submit" id="updateTeam" value="Save Profile" class="btn btn-success">
				</td>
</form>
			<%
			
				}
			}catch(Exception e){}
		
		try{
			if(udm.retrieve(username).getID() == team.getPmId()){
				%>
				<form method="post" action="deleteTeam">
					<input type="hidden" name="teamId" value="<%=teamId %>">
					<td class="space">
					   <input type="submit" id="delete" value="Delete" onclick="return confirm('Do you wish to delete this team?');return false;" class="btn btn-danger">
					</td>
				</form>
				<%
				}
			}catch(Exception e){}
		}
		%>
		
		<%
		StudentDataManager stdm = new StudentDataManager();
		if(usertype.equalsIgnoreCase("Student")){ 
		%>
			<td class="space">
			<form action="stdRequest" method="post">
				<input type="hidden" name="teamId" value="<%=teamId %>">
				<input type="hidden" name="userId" value="<%=sessUserId %>">
				<% 
				try{
					if(tdm.emptySlots(team) && !stdm.hasTeam(sessUser)){ %>
			  		<input type="submit" value="Request to Join" class="btn btn-warning" onclick="this.disabled=true;this.value='Request Sent';">
			  		<% }
				}catch(Exception e){}
		  		%>
		  		
		  	</form>
		  	</td>
		<%
		}
		%>
		</tr>
		</table>
		</div>
		
		</div>
	</body>

</html>