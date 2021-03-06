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
		int sessUserTeamId = 0;
		
		try{
			teamId = Integer.parseInt(teamIdStr);
		}catch(Exception e){
			session.setAttribute("message", "Invalid team");
			response.sendRedirect("searchTeam.jsp");
		}
		
		TeamDataManager tdm = new TeamDataManager();
		Team team = null;
		
		try{
			sessUserTeamId = tdm.retrievebyStudent(sessUser.getID());
		}catch(Exception e){
			sessUserTeamId = 0;
		}
	
		if(teamId == 0 || tdm.retrieve(teamId) == null){
			session.setAttribute("message", "Invalid team");
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
		<%
		StudentDataManager stdm = new StudentDataManager();
		if(usertype.equalsIgnoreCase("Student")){ 
			User std = udm.retrieve(username);
			if(!stdm.hasTeam(std) && !tdm.studentHasRequested(teamId, std)){
		%>
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
		<%
			}
		}
		%>
		<div class="panel-group" id="accordion">
		  <div class="panel panel-default">
		    <div class="panel-heading"  data-toggle="collapse" data-parent="#accordion" data-target="#collapseOne" style="cursor:pointer;">
		      <h4 class="panel-title">
		        <a class="accordion-toggle">
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
		    <div class="panel-heading"  data-toggle="collapse" data-parent="#accordion" data-target="#collapseTwo" style="cursor:pointer;">
		      <h4 class="panel-title">
		        <a class="accordion-toggle">
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
            	<a href="userProfile.jsp?id=<%=student.getID()%>"><%=student.getFullName() %></a> 
            	<%
            	RoleDataManager rdm = new RoleDataManager();
            	int roleId = student.getRole();
            	Role r = rdm.retrieve(roleId);
            	%>
            	| <%=r.getRoleName() %>  <br /><br />
	            	<%
	            		if(sessUserId == student.getID()){
	            	%>
	           
				<input type="hidden" name="userId" value="<%=student.getID()%>">
				<input type="hidden" name="teamId" value="<%=teamId%>">
				<input type="submit" value="Remove from Team" onclick="return confirm('Are you sure you want to remove <%=student.getFullName() %> from this team?');return false;" class="btn btn-danger"/>
				</form><br /><br/>
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
	           if(tdm.isPartOfTeam(team, sessUser) || usertype.equalsIgnoreCase("Admin")){
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
		    	  <option value="<%=showTerm.getId()%>" selected><%="AY" + showTerm.getAcadYear() + " T" + showTerm.getSem() %></option>
		    	 <%
		    		}else{
    			%>
		    	  <option value="<%=showTerm.getId()%>"><%="AY" + showTerm.getAcadYear() + " T" + showTerm.getSem() %></option>
		    	 <%	
		    		}
		    	  }
		    	 %>
		</select> 
		<%} else{ 
					Term term = termdm.retrieve(team.getTermId());%>
		  	<%="AY" + term.getAcadYear() + " T" + term.getSem()%>
		  	<input type="hidden" name="term" value="<%=term.getId() %>">
		  	<%} %>
		  	
		  </div>
		</div>
		<div class="control-group">
		  <label class="control-label" for="project">Project</label>
		  <div class="controls">
		  <%
			String projprofileLink = "#";
			  try{
				  teamProj = pdm.retrieve(projId);
				  projprofileLink = "projectProfile.jsp?id=" + projId;
			  }catch(Exception e){
				  projprofileLink = "#";
				  projName = "No Project yet";
			  }
			%>
		  	<a href="projectProfile.jsp?id=<%=projId%>"><%=projName %></a>
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
			<a href="<%=profileLink%>"><%=supervisorName %></a>
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
			<a href="<%=rev1ProfileLink%>"><%=rev1Name %></a><br /><br />
			
			<a href="<%=rev2ProfileLink%>"><%=rev2Name %></a><br />
			
		  </div>
		</div><br />
		
		<div class="control-group">
		  <label class="control-label" for="supervisor">Wiki Link</label>
		  <div class="controls">
			<%
			String wikiLink = wikiLink = team.getWikiLink();;
			
			if(wikiLink == null || wikiLink.equalsIgnoreCase("null")){
				wikiLink = "Not Specified";
			}else{
				wikiLink = team.getWikiLink();
			}
			if(sessUser != null){
				if(tdm.isPartOfTeam(team, sessUser)){
					%>
					<textarea name="link"><%=wikiLink%></textarea>
					<%
				}else{
					if(team.getWikiLink() == null){
						out.println(wikiLink);
					}else{
						%>
						<a href="<%=wikiLink %>"><%=wikiLink %></a>
						<%
					}
				}
			}else{
				if(team.getWikiLink() == null){
					out.println(wikiLink);
				}else{
					%>
					<a href="<%=wikiLink %>"><%=wikiLink %></a>
					<%
				}
			}
			%>
			
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
					            if(skillsetLang.size() < 1){
					            	out.println("No skills indicated");
					            }else{
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
					            }
								  %>
						  	</tr>
						</table>
						
						<table>
					    	<tr class="spaceunder">
					    	<h2>Others</h2>
								<%
					            ArrayList<Integer> skillsetOthers = tdm.retrieveTeamSkillsByOthers(team);
								 if(skillsetOthers.size() < 1){
						            	out.println("No skills indicated");
						     	}else{
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
							<%
						    IndustryDataManager idm = new IndustryDataManager();
							ArrayList<Industry> allInd = idm.retrieveAll();
						    int count = 0;
							boolean checked = false;
							
							if(sessUserTeamId == teamId){
								for(int i = 0; i < allInd.size(); i++){
									checked = false;
									
									Industry hasInd = allInd.get(i);
									count++;
									for(int j  = 0; j < allInd.size(); j++){
										if(idm.hasPrefInd(teamId, hasInd.getIndustryId())){
											checked=true;
										}
									}
									
									if(checked){
									%>
									<td>
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
								<input type="text" name="industry" placeholder="Others">
								<%
							}else{
								allInd = idm.retrieveIndustryByTeam(teamId);
								if(allInd.size() < 1){
									%>
									No preferred industry indicated
									<%
								}else{
									for(int i = 0; i < allInd.size(); i++){
										Industry ind = allInd.get(i);
										%>
										<td>
											&nbsp;<span class="label label-default"><%=ind.getIndustryName() %></span>&nbsp;&nbsp;
										</td>
										<%
										 if((i+1) % 3 == 0){
											  %>
											  </tr><tr class="spaceunder">
											  <%
										  }
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
			    	<%
			   ArrayList<String> tech = techdm.retrieveByTeamId(team.getId());
			  int numOfCat = techdm.retrieveNoOfTechCat();
			  int numOfSubCat = 0;
			  ArrayList<Technology> technologies = new ArrayList<Technology>();
			  ArrayList<Integer> subcatIdList = new ArrayList<Integer>();
				 if(tdm.isPartOfTeam(team, sessUser)){
								  for(int i = 1; i <= numOfCat; i++){
									  numOfSubCat = techdm.retrieveNumOfSubCat(i);
									  String catName = techdm.retrieveTechCatName(i);
									  %>
										<h2><%=catName %></h2>
										
									  <%
										subcatIdList = techdm.retrieveTechSubCatIdList(i);
										for(int k = 0; k <= subcatIdList.size(); k++){
											int subcatid = 0; 
											try{
												subcatid = subcatIdList.get(k);
											}catch(Exception e){
												subcatid = 0;
											}

											technologies = techdm.retrieveTechSubCatId(i, subcatid);
											String subcatName = techdm.retrieveTechSubCatName(subcatid);
											%>
												<table>
												<tr class="spaceunder"> 
												<h4><%=subcatName %></h4>
											<%
											if(technologies.size() > 0){
												for(int l = 0; l < technologies.size(); l++){
										  			Technology tech2 = technologies.get(l);
										  			if(techdm.hasTech(tech, tech2)){
											%><td>
												  <input type="checkbox" name="technology" value="<%=tech2.getId()%>" checked="checked">&nbsp;<span class="label label-default"><%=tech2.getTechName() %></span>&nbsp;&nbsp;
												 
											</td><td></td>
												   <%
												  }else{
												  %><td>
												  <input type="checkbox" name="technology" value="<%=tech2.getId()%>">&nbsp;<span class="label label-default"><%=tech2.getTechName() %></span>&nbsp;&nbsp;
												  </td><td></td>
											  <%
												  }
												  if((l+1) % 5 == 0){
												  %>
											  </tr><tr class="spaceunder">
											  <%
												  }
											 
										 }
								  }else{
									  out.println("None indicated");
								  }
								  %>
								   </tr></table>
								  <%
										}
								  }
								  %>
								 
								  <br />
								  <%
				 }else{
					 
					 for(int i = 1; i <= numOfCat; i++){
						  numOfSubCat = techdm.retrieveNumOfSubCat(i);
						  String catName = techdm.retrieveTechCatName(i);
						  %>
							<h2><%=catName %></h2>
							
						  <%
							subcatIdList = techdm.retrieveTechSubCatIdList(i);
							for(int k = 0; k <= subcatIdList.size(); k++){
								int subcatid = 0; 
								try{
									subcatid = subcatIdList.get(k);
								}catch(Exception e){
									subcatid = 0;
								}
								technologies = techdm.retrieveTechCatIdByTeam(i, subcatid, team.getId());
								String subcatName = techdm.retrieveTechSubCatName(subcatid);
								%>
									<table>
												<h4><%=subcatName %></h4>
												
												<tr class="spaceunder"> 
										  <%
										  if(technologies.size() < 1){
											  out.println("No technology indicated");
										  }else{
											  for(int j = 0; j < technologies.size(); j++){
											  Technology techPublic = technologies.get(j);
											  %>
											  <td>
											  	<span class="label label-default">
											  	<%=techPublic.getTechName() %></span>&nbsp;&nbsp;
											  </td>
											   <%
												  if((j+1) % 5 == 0){
												  %>
											  </tr><tr class="spaceunder">
											  <%
												  }
											 }
										  }
											  %>
										  </tr></table> 
								<%
							 }
					  }
					 
				}
					  
				 %>
				</div>
		    </div>
		  </div>
	  </div>
		
	  <br />
		<table>
		<tr>
		<%
		try{
			if(tdm.isPartOfTeam(team, sessUser) || usertype.equalsIgnoreCase("Admin")){
				%>
				<td class="space">
		    	<input type="submit" id="updateTeam" value="Save Profile" class="btn btn-success">
				</td>
</form>
			<%
			
				}
			}catch(Exception e){}
		
		try{
			if(udm.retrieve(username).getID() == team.getPmId() || usertype.equalsIgnoreCase("Admin")){
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
		
		<%-- <%
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
		%> --%>
		</tr>
		</table>
		</div>
		
		</div>
	</body>

</html>