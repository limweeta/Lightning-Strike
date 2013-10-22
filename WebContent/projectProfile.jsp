<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>

<style type="text/css">
/* 	h1{
		font-family:Impact;
		font-size:1.75em;
	}
	#teamName{
		width:49.8em;
		font-size:1em;
	}
	#createTeam{
		font-size:1em;
	}
	#teamLimit{
		width:5em;
	}*/
	textarea{
		resize: none;
		font-size: 1em;
	} 
</style>

<head>
    	<%@include file="template.jsp" %> 
    		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <script src="./jquery-ui-1.10.3.custom/js/jquery-1.9.1.js"></script>
  <script src="./jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
  <%
	  UserDataManager udm = new UserDataManager();
	  ArrayList<String> facultyNameList = udm.retrieveFacultyFullname();
  %>
  <script type="text/javascript">
    $(function() {
        var facultyNameList = [
                <%
                for(int i = 0; i < facultyNameList.size(); i++){
                	out.println("\""+facultyNameList.get(i)+"\",");
                }
                %>
                               ];
        
        $( "#assignSup" ).autocomplete({
          source: facultyNameList
        });
        
        $( "#assignRev1" ).autocomplete({
            source: facultyNameList
          });
        
        $( "#assignRev2" ).autocomplete({
            source: facultyNameList
          });
        
      });
    
    function toggleTech(source) {
  	  checkboxes = document.getElementsByName('technology');
  	  for(var i=0, n=checkboxes.length;i<n;i++) {
  	    checkboxes[i].checked = source.checked;
  	  }
  	}

    function toggleSkill(source) {
    	  checkboxes = document.getElementsByName('skill');
    	  for(var i=0, n=checkboxes.length;i<n;i++) {
    	    checkboxes[i].checked = source.checked;
    	  }
    	}
	</script>	
    	<%
    		User user = null;
    		int userId = 0;
			String type = "";
			try{
				type = udm.retrieve(username).getType();
				System.out.println(type);
				user = udm.retrieve(username);	
				userId = user.getID();
			}catch(Exception e){
				userId = 0;
				type= "";
			}
		%>

	</head>
	<body>
	<%
	String reqIdStr = request.getParameter("id");
	int reqId = 0;
	try{
		reqId = Integer.parseInt(reqIdStr);
	}catch(Exception e){
		session.setAttribute("message", "Invalid address");
		response.sendRedirect("searchProject.jsp");
	}
	
	if(reqId == 0){
		session.setAttribute("message", "You need to have a project to view that page.");
		response.sendRedirect("searchProject.jsp");
	}else{
	
	StudentDataManager stdm = new StudentDataManager();	
	
	String sessionUsername = (String) session.getAttribute("username");
	User sessionUser = udm.retrieve(sessionUsername);
	int userTeamId = 0;
	
	TermDataManager 	termdm = new TermDataManager();
	TeamDataManager 	tdm = new TeamDataManager();
	ProjectDataManager pdm = new ProjectDataManager();
	SponsorDataManager sdm = new SponsorDataManager();
	CompanyDataManager cdm = new CompanyDataManager();
	
	boolean eligibleToApply = false;
	
	try{
		userTeamId = stdm.retrieve(sessionUser.getID()).getTeamId();
		eligibleToApply = pdm.isEligibleForApplication(userTeamId);
	}catch(Exception e){
		userTeamId = 0;
		eligibleToApply = false;
	}
	
	ArrayList<Team> teams = tdm.retrieveAll();
	ArrayList<User> users = udm.retrieveAll();
	ArrayList<Term> terms = termdm.retrieveAll();
	
	Project reqProj = pdm.retrieve(reqId);
	String reqProjName = reqProj.getProjName();
	
	Team projTeam = null; 
	String projTeamName = "";
	int projTeamId = 0;
	String strTerm = "";
	String supervisor = "";
	
	Term term = null;
	try{
		term = termdm.retrieve(reqProj.getTermId());
		strTerm = term.getAcadYear() + " " + term.getSem();
	}catch(Exception e){
		
	}
	Company coy = null;
	
	try{
		projTeam = tdm.retrieve(reqProj.getTeamId());
		projTeamName = projTeam.getTeamName();
		projTeamId = projTeam.getId();
		
	}catch(Exception e){
		projTeamName = "No Team Yet";
	}
	
	try{
		supervisor = udm.retrieve(projTeam.getSupId()).getFullName();	
	}catch(Exception e){
		supervisor = "No Supervisor Yet";
	}

	User projSponsor = null;
	String company = "";
	String sponsorName = "";
	int sponsorId = 0;
	int coyId = 0;
	try{
		projSponsor = udm.retrieve(sdm.retrieve(reqProj.getSponsorId()).getUserid());
		
		sponsorName = projSponsor.getFullName();
		SponsorDataManager spdm = new SponsorDataManager();
		company = cdm.retrieve(spdm.retrieve(projSponsor.getID()).getCoyId()).getCoyName();
		sponsorId = projSponsor.getID();
		coyId = cdm.retrieve(sponsorId).getID();
	}catch(Exception e){
		sponsorName = "No Sponsor Yet";
		company = "Not Applicable";
	}
	
	String projManager = "";
	
	try{
		projManager = udm.retrieve(projTeam.getPmId()).getFullName();
	}catch(Exception e){
		projManager = "Not Applicable";
	}
	
	
	String reviewers = "";
	String rev1 = "";
	String rev2 = "";
	
	try{
		rev1 = udm.retrieve(reqProj.getReviewer1Id()).getFullName();;
	}catch(Exception e){
		rev1 = "";
	}
	
	try{
		rev2 = udm.retrieve(reqProj.getReviewer2Id()).getFullName();;
	}catch(Exception e){
		rev2 = "";
	}
	
	reviewers = rev1 + ", " + rev2;
	
	int creatorId = reqProj.getCreatorId();
	
	IndustryDataManager idm = new IndustryDataManager();
	Industry ind  = idm.retrieve(reqProj.getIndustry());
	
	TechnologyDataManager techdm = new TechnologyDataManager();
	ArrayList<String> tech = techdm.retrieveByProjId(reqProj.getId());
	
	SkillDataManager skdm = new SkillDataManager();
	ArrayList<String> skill = skdm.getProjSkills(reqProj.getId());

	ArrayList<Team> appliedTeams = null;
	
	try{
		appliedTeams = tdm.retrieveTeamsByAppliedProj(reqId);
	}catch(Exception e){
		appliedTeams = new ArrayList<Team>();
	}finally{}
	%>
		
	<div class="span12 well">
		
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
		<form action="updateProject" method="post" onsubmit = "return validateFormOnSubmit(this)" class="form-horizontal">	
		<div class="span11">
		<h5>Project Profile &nbsp;&nbsp;
				<%if(reqProj.getStatus().equals("Open")){ %>
					<span class="label label-success" style="padding:10px;">Open</span></br>
				<%}else if(reqProj.getStatus().equals("Closed")){ %>
					<span class="label label-danger" style="padding:10px;">Closed</span></br>
				<%} %>
		</h5>
			
			<% if(creatorId == userId){ %>	
				<div class="panel-group" id="accordion">
				  <div class="panel panel-default">
				    <div class="panel-heading">
				      <h4 class="panel-title">
				        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
				          Teams Applied (<%=appliedTeams.size() %>)
				        </a>
				      </h4>
				    </div>
				<div id="collapseOne" class="panel-collapse collapse">
				      <div class="panel-body">
				 			<table width="100%">
						    	<tr class="spaceunder">
									 <%
				  if(appliedTeams.size() == 0){
					  out.println("None");
				  }else{
				  	for(int i = 0; i < appliedTeams.size(); i++){
				  		Team team = appliedTeams.get(i);
				  		%>
				  		<td>
				  		<a href="teamProfile.jsp?id=<%=team.getId()%>"><%=team.getTeamName() %></a> <br /><br />
				  		<form method="post" action="acceptTeam">
				  		<input type="hidden" name="projId" value="<%=reqId %>">
				  		<input type="hidden" name="teamId" value="<%=team.getId() %>">
				  		<input type="submit" value="Accept Team" class="btn btn-warning">
				  		</form>
				  		<form method="post" action="rejectTeam">	
				  		<input type="hidden" name="projId" value="<%=reqId %>">
				  		<input type="hidden" name="teamId" value="<%=team.getId() %>">
				  		<input type="submit" value="Reject Team" class="btn btn-danger">
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
				 </div> 
				  <br />
			<% } %>	
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="projectname">Project Name</label>
		  <div class="controls">
		  <%
		  if(user != null){
				if(userId == reqProj.getCreatorId()){
			  %>
			 		<input type="text" id="projName" name="projName" value="<%=reqProj.getProjName() %>" class="input-large"/>
			  <%
				}else{
					%>
					<input type="text" id="projName" name="projName" value="<%=reqProj.getProjName() %>" readonly="readonly" class="input-large"/>
					<%
				}
		  }else{
			  %>
			  <input type="text" id="projName" name="projName" value="<%=reqProj.getProjName() %>" readonly="readonly" class="input-large"/>
			  <%
		  }
		  %>
		    
		  </div>
		</div>
		
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="projectDesc">Project Description</label>
		  <div class="controls">
		   <%
				if(userId == reqProj.getCreatorId()){
			  %>
		    <textarea id="projectDesc" name="projectDesc"><%=reqProj.getProjDesc() %></textarea>
		     <%
				}else{
					%>
				 <textarea id="projectDesc" name="projectDesc" readonly="readonly"><%=reqProj.getProjDesc() %></textarea>
					<%
				}
		  %>
		  </div>
		</div>

		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="sponsor">Sponsor</label>
		  <div class="controls">
		  <input type=hidden name="projId" value="<%=reqId%>">
		  	<input type="hidden" name="sponsorId" value="<%=sponsorId%>">
		    <input id="sponsor" name="sponsor" type="text" value="<%=sponsorName %>" class="input-large" readonly="readonly">
		  </div>
		</div>
		
		<div class="control-group">
		  <label class="control-label" for="company">Company</label>
		  <div class="controls">
		   <input type="hidden" name="coyId" value="<%=coyId%>">
			<input id="company" name="company" type="text" value=" <%=company %>" class="input-large" readonly="readonly">
			
		  </div>
		</div>
		
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="team">Team</label>
		  <div class="controls">
		    <%
			if(type.equalsIgnoreCase("admin")){
			  %>
		    <input id="team" name="team" type="text" value=" <%=projTeamName %>" class="input-large">
		     <%
				}else{
					%>
			<input id="team" name="team" type="text" value=" <%=projTeamName %>" class="input-large" readonly="readonly">
					<%
				}
		  %>
		  </div>
		</div>
		<!-- </div> -->
		<!-- <div class="span5"> -->
		<!-- Text input-->
		<input type=hidden name="teamId" value="<%=projTeamId%>">
		<div class="control-group">
		  <label class="control-label" for="supervisor">Team Supervisor</label>
		  <div class="controls">
		  <form method="post" action="assignSupervisor">
		    <%
	            if(type.equalsIgnoreCase("admin")){ 
			%>
			 
	            
				<%-- 	<%=projTeamId %> --%>
            	 <input type=hidden name="projId" value="<%=reqProj.getId()%>">  
	            	<input id="assignSup" name="assignSup" type="text" placeholder="<%=supervisor%>"  class="input-large">
	            	<% if(projTeamId == 0){ %>
	            	<input type="submit" value="Assign" class = "btn btn-success" disabled="disabled">
	            	<% }else{ %>
	            	<input type="submit" value="Assign" class = "btn btn-success">
	            	<% } %>
	            	<%
	            }else{
	            	%>
	            	<input id="assignSup" name="assignSup" type="text" value="<%=supervisor%>"  class="input-large" disabled="disabled" />
	            	<%
	            }
	            %>
		    </form>
		  </div>
		</div>
		<!-- Textarea -->
		<div class="control-group">
		  <label class="control-label" for="reviewer">Reviewer(s)</label>
		  <div class="controls">   
		  <form method="post" action="assignReviewer">    
		  <%
            if(type.equals("Admin")){
            	%>   
            	<input type=hidden name="projId" value="<%=reqProj.getId()%>">  
            	
	            	<input type="text" id="assignRev1" name="assignRev1" value="<%=rev1%>" class="input-large"><br /><br />
	            	<input type="text" id="assignRev2" name="assignRev2" value="<%=rev2%>" class="input-large">
	            	<input type="submit" value="Assign" class="btn btn-success">
	            <%
            }else{
            	%>
            	<input type="text" name="assignRev1" value="<%=rev1%>" readonly="readonly" class="input-large"> <br /><br />
            	<input type="text" name="assignRev2" value="<%=rev2%>" readonly="readonly" class="input-large"> 
            	<%
            }
            %>
			</form>
		  </div>
		</div>
		<div class="control-group">
		  <label class="control-label" for="term">Term</label>
		  <div class="controls">
		  <%
		try{
		  if(username.equals(udm.retrieve(creatorId).getUsername())){
		  %>
		  	<select id="term" name="term" class="input-large">
		    	  <%
		    	  for(int i = 0; i < terms.size(); i++){
		    		Term showTerm = terms.get(i); 
		    		
		    		if(term.getId() == showTerm.getId()){
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
		 <%
			}else{
		 %>
		  	<input type="text" value="<%=term.getAcadYear() + " T" + term.getSem() %>" id="term" name="term" class="input-large" disabled="disabled"> 
		 <%
			}
		}catch(Exception e){
			%>
			<input type="text" value="<%=term.getAcadYear() + " T" + term.getSem() %>" id="term" name="term" class="input-large" disabled="disabled"> 
			<%
		}
		 %> 
		    </div>
		</div>
		
		<div class="control-group">
		  <label class="control-label" for="industry">Industry</label>
		  <div class="controls">
		   <%
		  if(user != null){
				if(userId == reqProj.getCreatorId()){
			  %>
		    <select id="industry" name="industry" class="input-large">
		    	 <%
					  ArrayList<Industry> industries = idm.retrieveAll();
					  boolean specified = false;
					  for(int i = 0; i < industries.size(); i++){
						  Industry ind2 = industries.get(i);
						  if(reqProj.getIndustry() == ind2.getIndustryId()){
							  specified = true;
						  %>
						  <option value="<%=ind2.getIndustryId()%>" selected><%=ind2.getIndustryName() %></option>
						  <%
						  }else{
							 %>
						 <option value="<%=ind2.getIndustryId()%>"><%=ind2.getIndustryName() %></option>	 
							 <% 
						  }
				  }
					  if(!specified){
						  %>
						   <option value="0" selected>Not Specified</option>	
						  <%
					  }
				  %>
		    </select>
			<%
				}else{
					%>
			 <select id="industry" name="industry" class="input-large" readonly="readonly">
		    	 <%
					  ArrayList<Industry> industries = idm.retrieveAll();
					  boolean specified = false;
					  for(int i = 0; i < industries.size(); i++){
						  Industry ind2 = industries.get(i);
						  if(reqProj.getIndustry() == ind2.getIndustryId()){
							  specified = true;
						  %>
						  <option value="<%=ind2.getIndustryId()%>" selected><%=ind2.getIndustryName() %></option>
						  <%
						  }else{
							 %>
						 <option value="<%=ind2.getIndustryId()%>"><%=ind2.getIndustryName() %></option>	 
							 <% 
						  }
				  }
					  if(!specified){
						  %>
						   <option value="0" selected>Not Specified</option>	
						  <%
					  }
				  %>
		    </select>
					<%
				}
		  }else{
			  %>
			 <select id="industry" name="industry" class="input-large" readonly="readonly">
		    	<%
					  ArrayList<Industry> industries = idm.retrieveAll();
					  boolean specified = false;
					  for(int i = 0; i < industries.size(); i++){
						  Industry ind2 = industries.get(i);
						  if(reqProj.getIndustry() == ind2.getIndustryId()){
							  specified = true;
						  %>
						  <option value="<%=ind2.getIndustryId()%>" selected><%=ind2.getIndustryName() %></option>
						  <%
						  }else{
							 %>
						 <option value="<%=ind2.getIndustryId()%>"><%=ind2.getIndustryName() %></option>	 
							 <% 
						  }
				  	}
					  if(!specified){
						  %>
						   <option value="0" selected>Not Specified</option>	
						  <%
					  }
				  %>
		    </select>
			  <%
		  }
		  %>
		  
		  </div>
		</div>
		<div class="panel-group" id="accordion">
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
		          Preferred Skills
		        </a>
		      </h4>
		    </div>
		    <div id="collapseOne" class="panel-collapse collapse">
		      <div class="panel-body">
		 			<table>
						<tr class="spaceunder">
						     <td><input type="checkbox" onclick="toggleSkill(this)" />&nbsp;<span class="label label-default">Select All</span></td>
					     </tr>
				    	<tr class="spaceunder">
							<%
							  ArrayList<Skill> skills = skdm.retrieveAll();
							  
							  for(int i = 0; i < skills.size(); i++){
								  Skill skill2 = skills.get(i);
								  
								  if(skdm.hasSkill(skill, skill2)){
								  %><td>
								  <input type="checkbox" name="skill" value="<%=skill2.getId()%>" checked="checked">&nbsp;<span class="label label-default"><%=skill2.getSkillName() %></span>&nbsp;&nbsp;
								  </td><td></td>
								   <%
								  }else{
								  %><td>
								  <input type="checkbox" name="skill" value="<%=skill2.getId()%>">&nbsp;<span class="label label-default"><%=skill2.getSkillName() %></span>&nbsp;&nbsp;
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
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
		          Technology
		        </a>
		      </h4>
		    </div>
		    <div id="collapseTwo" class="panel-collapse collapse">
		      <div class="panel-body">
			    	<table>
						<tr class="spaceunder">
						     <td><input type="checkbox" onclick="toggleTech(this)" />&nbsp;<span class="label label-default">Select All</span></td>
					     </tr>
				    	<tr class="spaceunder">
							<%
							 ArrayList<Technology> technologies = techdm.retrieveAll();
							  
							  for(int i = 0; i < technologies.size(); i++){
								  Technology tech2 = technologies.get(i);
								  
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
		</br></br>
<!-- 		<div class="control-group">
		  <label class="control-label" for="applyproject"></label>
		  <div class="controls"> -->
		  <table>			  <tr>
			  <td class = "space" align = "center">
				  <form action="applyProj" method="post">
				  	<input type="hidden" name="projId" value="<%=reqProj.getId() %>" />
				  	<input type="hidden" name="teamId" value="<%=userTeamId%>" />
				  	<%if(eligibleToApply){ %>
				  		</br><input type="submit" id="apply" value="Apply for Project" class="btn btn-warning">
				  	<%
				  	}else{
				  		String errMsg = "";
				  		if(udm.isSponsor(username)){
				  			errMsg = "Only students can apply for a project";
			  		}
			  		%>
				  		</br><input type="submit" id="apply" value="Apply for Project" class="btn btn-warning" disabled="disabled">
				 		<font color=red size=-1><i><%=errMsg %></i></font>
			  		<%
				  	}
				  	%>
				  </form>
				</td>  
<!-- 		  </div>
		</div> -->
		<%
		try{
			if(username.equals(udm.retrieve(creatorId).getUsername())){
				%>
				<td class = "space" align = "justify">
				<input type="hidden" name="projId" value="<%=reqProj.getId() %>">
				<!-- Button -->
			    <input type="submit" id="update" value="Update" class="btn btn-success">
				</td>
				<td class = "space" align = "center">
				<form method="post" action="deleteProject" >
					<input type="hidden" name="projId" value="<%=reqProj.getId() %>">
					<!-- Button -->
					    </br><input type="submit" id="delete" value="Delete" onclick="return confirm('Do you wish to delete this project?');return false;" class="btn btn-danger">
				</form>
				</td>
		<%
			}
			}catch(Exception e){}
		}
		%>
		</tr>
		</table>
				
		</div>
	</form>
	</div>

	</body>

</html>