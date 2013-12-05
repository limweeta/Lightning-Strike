<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>

<style type="text/css">
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

	textarea{
		resize: none;
		font-size: 1em;
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

    function toggleSkillLang(source) {
    	  checkboxes = document.getElementsByName('skillLang');
    	  for(var i=0, n=checkboxes.length;i<n;i++) {
    	    checkboxes[i].checked = source.checked;
    	  }
    	}
    
    function toggleSkillOthers(source) {
  	  checkboxes = document.getElementsByName('skillOthers');
  	  for(var i=0, n=checkboxes.length;i<n;i++) {
  	    checkboxes[i].checked = source.checked;
  	  }
  	}
	</script>	
    	<%
    		User sessUser = null;
    		int userId = 0;
			String usertype = "";
			try{
				usertype = udm.retrieve(username).getType();
				sessUser = udm.retrieve(username);	
				userId = sessUser.getID();
			}catch(Exception e){
				userId = 0;
				usertype= "";
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
	User sessionUser2 = udm.retrieve(sessionUsername);
	int userTeamId = 0;

	OrganizationDataManager odm = new OrganizationDataManager();
	ArrayList<Organization> orgs = odm.retrieveAll();
	
	TermDataManager 	termdm = new TermDataManager();
	TeamDataManager 	tdm = new TeamDataManager();
	ProjectDataManager pdm = new ProjectDataManager();
	SponsorDataManager spdm = new SponsorDataManager();
	CompanyDataManager cdm = new CompanyDataManager();
	
	boolean eligibleToApply = false;
	
	try{
		userTeamId = stdm.retrieve(sessionUser2.getID()).getTeamId();
		eligibleToApply = pdm.isEligibleForApplication(userTeamId, sessionUser2.getID(), reqId);
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
		term = termdm.retrieve(reqProj.getIntendedTermId());
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
	String orgType = "";
	try{
		projSponsor = udm.retrieve(reqProj.getSponsorId());
		
		sponsorName = projSponsor.getFullName();
		
		Company comp = cdm.retrieve(reqProj.getSponsorId());
		
		try{
			company = comp.getCoyName();
		}catch(Exception e){
			company = "Not Applicable";
		}
		
		sponsorId = projSponsor.getID();
		coyId = cdm.retrieve(sponsorId).getID();
		
		orgType = odm.retrieve(cdm.retrieve(sponsorId).getOrgType()).getOrgType();
		
	}catch(Exception e){
		sponsorName = "No Sponsor Yet";
		company = "Not Applicable";
		orgType = "N/A";
	}
	
	String projManager = "";
	
	try{
		projManager = udm.retrieve(projTeam.getPmId()).getFullName();
	}catch(Exception e){
		projManager = "Not Applicable";
	}
	
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
		
	<div class="container">
		<div class="content">
		<% String message = (String) session.getAttribute("message"); 
			if(message == null || message.isEmpty()){
				message = "";
			}else{
		%>
			<font size=-1 color="red"><i><%=message %></i></font>
			<%
			session.removeValue("message");
			} %>
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
			<!-- Form Name -->
		<form action="updateProject" method="post" onsubmit = "return validateFormOnSubmit(this)" class="form-horizontal">	
		
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="projectname">Project Name</label>
		  <div class="controls">
		  <%
		  if(sessUser != null){
				if(userId == reqProj.getCreatorId()){
			  %>
			 		<input type="text" id="projName" name="projName" value="<%=reqProj.getProjName() %>" class="input-large"/>
			  <%
				}else{
					%>
					<%=reqProj.getProjName() %>
					<%
				}
		  }else{
			  %>
			 <%=reqProj.getProjName() %>
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
				<%=reqProj.getProjDesc() %>
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
		    <%=sponsorName %>
		  </div>
		</div>
		
		<div class="control-group">
		  <label class="control-label" for="company">Company</label>
		  <div class="controls">
		   <input type="hidden" name="coyId" value="<%=coyId%>">
			<%=company %>
			
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
			<%=projTeamName %>
					<%
				}
		  %>
		  </div>
		</div>
		
		<div class="control-group">
		  <label class="control-label" for="term">Projected Term</label>
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
		  	<%=term.getAcadYear() + " T" + term.getSem() %>
		 <%
			}
		}catch(Exception e){
			%>
			<%=term.getAcadYear() + " T" + term.getSem() %>
			<%
		}
		 %> 
		    </div>
		</div>
		
		<div class="control-group">
		  <label class="control-label" for="industry">Industry</label>
		  <div class="controls">
		   <%
		  if(sessUser != null){
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
					String indName = idm.retrieve(reqProj.getIndustry()).getIndustryName();
					%>
					<%=indName %>
					<%
				}
		  }else{
			  String indName = idm.retrieve(reqProj.getIndustry()).getIndustryName();
				%>
				<%=indName %>
				<%
		  }
		  %>
		  
		  </div>
		</div>
		<div class="control-group">
		  <label class="control-label" for="org">Organization</label>
		  <div class="controls">
		   <%
		  if(sessUser != null){
				if(userId == reqProj.getCreatorId()){
			  %>
		    <select id="org" name="org" class="input-large">
		    	 <%
					  boolean specified = false;
					  for(int i = 0; i < orgs.size(); i++){
						  Organization org1 = orgs.get(i);
						  Company comp = null;
						  try{
							  comp = cdm.retrieve(spdm.retrieve(reqProj.getSponsorId()).getCoyId());
						  
							  if(comp.getOrgType() == org1.getId()){
								  specified = true;
							  %>
							  <option value="<%=org1.getId()%>" selected><%=org1.getOrgType() %></option>
							  <%
							  }else{
								 %>
							 <option value="<%=org1.getId()%>"><%=org1.getOrgType() %></option>	 
								 <% 
							  }
							}catch(Exception e){
							  %>
							  <option value="<%=org1.getId()%>"><%=org1.getOrgType() %></option>
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
				}else{%>
				 <%=orgType %>
		  <%}
		  }else{%>
				 <%=orgType %>
		  <%} %>
		  </div>
		</div>
		<div class="panel-group" id="accordion">
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
		          Preferred Skills
		        </a>
		      </h4>
		    </div>
		    <div id="collapseTwo" class="panel-collapse collapse">
		      <div class="panel-body">
		 			<table>
						<tr class="spaceunder">
						     <td><input type="checkbox" onclick="toggleSkillLang(this)" />&nbsp;<span class="label label-default">Select All</span></td>
					     </tr>
				    	<tr class="spaceunder">
				    	<h2>Language</h2>
							<%
							  ArrayList<Skill> skills = skdm.retrieveAllLang();
							  
							  for(int i = 0; i < skills.size(); i++){
								  Skill skill2 = skills.get(i);
								  
								  if(skdm.hasSkill(skill, skill2)){
								  %><td>
								  <input type="checkbox" name="skillLang" value="<%=skill2.getId()%>" checked="checked">&nbsp;<span class="label label-default"><%=skill2.getSkillName() %></span>&nbsp;&nbsp;
								  </td><td></td>
								   <%
								  }else{
								  %><td>
								  <input type="checkbox" name="skillLang" value="<%=skill2.getId()%>">&nbsp;<span class="label label-default"><%=skill2.getSkillName() %></span>&nbsp;&nbsp;
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
					
					<table>
						<tr class="spaceunder">
						     <td><input type="checkbox" onclick="toggleSkillOthers(this)" />&nbsp;<span class="label label-default">Select All</span></td>
					     </tr>
				    	<tr class="spaceunder">
				    	<h2>Others</h2>
							<%
							  ArrayList<Skill> otherSkills = skdm.retrieveAllOthers();
							  
							  for(int i = 0; i < otherSkills.size(); i++){
								  Skill skill2 = otherSkills.get(i);
								  
								  if(skdm.hasSkill(skill, skill2)){
								  %><td>
								  <input type="checkbox" name="skillOthers" value="<%=skill2.getId()%>" checked="checked">&nbsp;<span class="label label-default"><%=skill2.getSkillName() %></span>&nbsp;&nbsp;
								  </td><td></td>
								   <%
								  }else{
								  %><td>
								  <input type="checkbox" name="skillOthers" value="<%=skill2.getId()%>">&nbsp;<span class="label label-default"><%=skill2.getSkillName() %></span>&nbsp;&nbsp;
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
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
		          Technology
		        </a>
		      </h4>
		    </div>
		    <div id="collapseThree" class="panel-collapse collapse">
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
				  <%
		try{
			if(username.equals(udm.retrieve(creatorId).getUsername())){
				%>
				<td class = "space" align = "justify">
				<input type="hidden" name="projId" value="<%=reqProj.getId() %>">
				<!-- Button -->
			    <input type="submit" id="update" value="Update" class="btn btn-success"></form>
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
		
		%>
				</td> 
				</form>
				<form action="applyProj" method="post">
				  	<input type="hidden" name="projId" value="<%=reqProj.getId() %>" />
				  	<input type="hidden" name="teamId" value="<%=userTeamId%>" />
				  	<%if(eligibleToApply){ %>
				  		</br><input type="submit" id="apply" value="Apply for Project" class="btn btn-warning"></form>
				  	<%
				  	}
	}
				  	%>
				  </form>
		
		</tr>
		</table>
				
		</div>
		</div>
	</body>

</html>