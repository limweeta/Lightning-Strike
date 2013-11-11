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
		String usertype = (String) session.getAttribute("type");
	
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
		
	
		if(teamId == 0){
			session.setAttribute("message", "You need to have a team to view that page.");
			response.sendRedirect("searchTeam.jsp");
		}else if(tdm.retrieve(teamId) == null){
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
		  	User sessUser = null;
			
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
				<% String message = (String) session.getAttribute("message"); 
						if(message == null || message.isEmpty()){
							message = "";
						}else{
				%>
						<font size=-1 color="red"><i><%=message %></i></font>
						<%
						session.removeValue("message");
						} %>
		<div class="content">
		<h3><%=team.getTeamName()%>&nbsp;Status: <%=status %></h3>
		
		<div class="panel-group" id="accordion">
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
		          Students Request (<%=studentRequests.size() %>)
		        </a>
		      </h4>
		    </div>
		<div id="collapseOne" class="panel-collapse collapse">
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
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
		          Students Invited (<%=studentInvites.size() %>)
		        </a>
		      </h4>
		    </div>
		<div id="collapseTwo" class="panel-collapse collapse">
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
		<input type="hidden" name="teamName" value="<%=team.getTeamName()%>">
		<input type="hidden" name="teamId" value="<%=teamId %>">
		
		<!-- Text input-->
		<input type="hidden" name="teamLimit" value="<%=team.getTeamLimit() %>">
		<div class="control-group">
		  <label class="control-label" for="project">Term</label>
		  <div class="controls">
		  <%
			TermDataManager termdm = new TermDataManager();
			Term term = termdm.retrieve(team.getTermId());
		  %>
		  	<span class="label label-info"><%=term.getAcadYear() + " T" + term.getSem()%></span>
		  	<input type="hidden" name="termId" value="<%=term.getId() %>">
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
			<span class="label label-info"><a href="<%=profileLink%>" style="color: #FFFFFF"><%=supervisorName %>
			</a></span>
		  </div>
		</div><br />
		<!-- @CHLOE PUT SKILLS IN THE SAME AS INDUSTRY AND TECH -->
		
	<div class="panel-group" id="accordion">
		<div class="panel panel-default">
			    <div class="panel-heading">
			      <h4 class="panel-title">
			        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFive">
			          Team Skills 
			        </a>
			      </h4>
			    </div>
			    <div id="collapseFive" class="panel-collapse collapse">
			      <div class="panel-body">
				    	<table>
					    	<tr class="spaceunder">
								<%
					            SkillDataManager skdm = new SkillDataManager();
					            ArrayList<Integer> skillset = tdm.retrieveTeamSkills(team);
					            System.out.println(skillset.size());
					            for(int k = 0; k < skillset.size(); k++){
					            	int count2 = k + 1;
					            	int skillId = skillset.get(k);
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
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
		          Preferred Industry
		        </a>
		      </h4>
		    </div>
		    <div id="collapseThree" class="panel-collapse collapse">
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
		 	  </div>
		    </div>
		  </div>
		  <br />
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFour">
		          Preferred Technology
		        </a>
		      </h4>
		    </div>
		    <div id="collapseFour" class="panel-collapse collapse">
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
											checked=true;
										}
										%>
										<%
									}
									if(checked){
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
		
		<%if(usertype.equalsIgnoreCase("Student")){ %>
			<td class="space">
			<form action="stdRequest" method="post">
				<input type="hidden" name="teamId" value="<%=teamId %>">
				<input type="hidden" name="userId" value="<%=sessUserId %>">
				<% 
				try{
					if(!tdm.emptySlots(team)){ %>
			  		<input type="submit" value="Request to Join" class="btn btn-warning" disabled="disabled"><br />
			  		<font size=-1 color=red><i>Team is full</i></font>
			  		<% }else{
			  			%>
			  		<input type="submit" value="Request to Join" class="btn btn-warning">	
			  			<%
			  		}
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