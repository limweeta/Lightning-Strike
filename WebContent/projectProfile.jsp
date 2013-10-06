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
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script> 
    	<%@include file="template.jsp" %> 
    	<%
			UserDataManager udm = new UserDataManager();
    		User user = null;
			String type = "";
			try{
				type = udm.retrieve(username).getType();
				user = udm.retrieve(username);	
			}catch(Exception e){
				type= "";
			}
		%>

	</head>
	<body>
	<%
	int reqId = Integer.parseInt(request.getParameter("id"));
	
	if(reqId == 0){
		response.sendRedirect("searchProject.jsp");
	}else{
	
	StudentDataManager stdm = new StudentDataManager();	
	
	String sessionUsername = (String) session.getAttribute("username");
	User sessionUser = udm.retrieve(sessionUsername);
	int userTeamId = stdm.retrieve(sessionUser.getID()).getTeamId();
	
	TermDataManager 	termdm = new TermDataManager();
	TeamDataManager 	tdm = new TeamDataManager();
	ProjectDataManager pdm = new ProjectDataManager();
	SponsorDataManager sdm = new SponsorDataManager();
	CompanyDataManager cdm = new CompanyDataManager();
	
	ArrayList<Team> teams = tdm.retrieveAll();
	ArrayList<User> users = udm.retrieveAll();
	ArrayList<Term> terms = termdm.retrieveAll();
	
	Project reqProj = pdm.retrieve(reqId);
	String reqProjName = reqProj.getProjName();
	System.out.println(reqProj.getTeamId());
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
		supervisor = udm.retrieve(projTeam.getSupId()).getFullName();
		
	}catch(Exception e){
		projTeamName = "No Team Yet";
		supervisor = "No Supervisor Yet";
	}
	

	User projSponsor = null;
	String company = "";
	String sponsorName = "";
	int sponsorId = 0;
	
	try{
		projSponsor = udm.retrieve(sdm.retrieve(reqProj.getSponsorId()).getUserid());
		
		//company = cdm.retrieve(Integer.parseInt(company)).getCoyName();
		
		sponsorName = projSponsor.getFullName();
		SponsorDataManager spdm = new SponsorDataManager();
		company = cdm.retrieve(Integer.parseInt(spdm.retrieve(projSponsor.getID()).getCoyName())).getCoyName();
		sponsorId = projSponsor.getID();
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
	
	
	%>
		
	<div class="span9 well">
	<div class="row">
	<form action="updateProject" class="form-horizontal">
		<fieldset>
		
		<!-- Form Name -->
		<legend>Project Profile </legend>

			<div class="span1"><a href="#" class="thumbnail"><img src="https://db.tt/8gUG7CxQ" alt=""></a>
			</div>
		<div class="span8">
		<form method="post" action="updateProject">
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="projectname">Project Name</label>
		  <div class="controls">
		  <%
		  if(user != null){
				if(user.getID() == reqProj.getCreatorId()){
			  %>
			 		<input type="text" id="projName" name="projName" value="<%=reqProj.getProjName() %>" />
			  <%
				}else{
					%>
					<input type="text" id="projName" name="projName" value="<%=reqProj.getProjName() %>" readonly="readonly" />
					<%
				}
		  }else{
			  %>
			  <input type="text" id="projName" name="projName" value="<%=reqProj.getProjName() %>" readonly="readonly" />
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
		  if(user != null){
				if(user.getID() == reqProj.getCreatorId()){
			  %>
		    <textarea id="projectDesc" name="projectDesc"><%=reqProj.getProjDesc() %></textarea>
		     <%
				}else{
					%>
				 <textarea id="projectDesc" name="projectDesc" readonly="readonly"><%=reqProj.getProjDesc() %></textarea>
					<%
				}
		  }else{
			  %>
			  <textarea id="projectDesc" name="projectDesc" readonly="readonly"><%=reqProj.getProjDesc() %></textarea>
			  <%
		  }
		  %>
		  </div>
		</div>
		<!-- </div></br> -->
		<!-- <div class="span3"> -->
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="sponsor">Sponsor</label>
		  <div class="controls">
		  <input type=hidden name="projId" value="<%=reqId%>">
		   <%
		  if(user != null){
				if(user.getID() == reqProj.getCreatorId()){
			  %>
		    <input id="sponsor" name="sponsor" type="text" placeholder="<%=sponsorName %>" class="input-large">
		     <%
				}else{
					%>
				  <input id="sponsor" name="sponsor" type="text" placeholder="<%=sponsorName %>" class="input-large" readonly="readonly">
					<%
				}
		  }else{
			  %>
			   <input id="sponsor" name="sponsor" type="text" placeholder="<%=sponsorName %>" class="input-large" readonly="readonly">
			  <%
		  }
		  %>
		  </div>
		</div>
		<!-- </div> -->
		<!-- <div class="span4"> -->
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="team">Team</label>
		  <div class="controls">
		    <%
		  if(user != null){
				if(user.getID() == reqProj.getCreatorId()){
			  %>
		    <input id="team" name="team" type="text" placeholder=" <%=projTeamName %>" class="input-xlarge">
		     <%
				}else{
					%>
			<input id="team" name="team" type="text" placeholder=" <%=projTeamName %>" class="input-xlarge" readonly="readonly">
					<%
				}
		  }else{
			  %>
			<input id="team" name="team" type="text" placeholder=" <%=projTeamName %>" class="input-xlarge" readonly="readonly">
			  <%
		  }
		  %>
		  </div>
		</div>
		<!-- </div> -->
		<!-- <div class="span5"> -->
		<!-- Text input-->
		<div class="control-group">
		  <label class="control-label" for="supervisor">Supervisor</label>
		  <div class="controls">
		  <form method=post action="/assignSupervisor">
		 
		    <%
            if(projTeam != null){
            	%>
            	 <input type=hidden name="teamId" value="<%=projTeam.getId()%>">
            	<%
	            if(supervisor.equalsIgnoreCase("No Supervisor Yet") && type.equals("admin")){ //TO-DO:check for admin status
	            	%>
	            	<input id="assignSup" name="assignSup" type="text" placeholder="<%=supervisor%>"  class="input-large">
	            	<input type="submit" value="Assign">
	            	<%
	            }else{
	            	%>
	            	<input id="assignSup" name="assignSup" type="text" placeholder="<%=supervisor%>"  class="input-large" disabled="disabled" />
	            	<%
	            }
            }else{
            	%>
            	<input id="assignSup" name="assignSup" type="text" placeholder="<%=supervisor%>"  class="input-large" disabled="disabled" />
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
		  <form method=post action="/assignReviewer">    
		  <%
            if(projTeam != null){
            	%>
            	<input type=hidden name="teamId" value="<%=projTeam.getId()%>">   
            	<% 
	            if(rev1.isEmpty() && rev2.isEmpty() && type.equals("admin")){ //TO-DO: check for admin status
	            	%>
	            	<input type="text" name="assignRev1" placeholder="<%=rev1%>"><br />
	            	<input type="text" name="assignRev2" placeholder="<%=rev2%>"><br />
	            	<input type="submit" value="Assign">
	            	
	            	<%
	            }else if(!rev1.isEmpty() && rev2.isEmpty() && type.equals("admin")){
	            	%>
	            	<input type="text" name="assignRev1" placeholder="<%=rev1%>"><br />
	            	<input type="submit" value="Assign">
	            	
	            	<%
	            }else if(rev1.isEmpty() && !rev2.isEmpty() && type.equals("admin")){
	            	%>
	            	<input type="text" name="assignRev1" placeholder="<%=rev2%>"><br />
	            	<input type="submit" value="Assign">
	            	
	            	<%
	            }else{
	            	%>
	            	<input type="text" name="assignRev1" placeholder="<%=rev1%>"><br /><br />
	            	<input type="text" name="assignRev2" placeholder="<%=rev2%>">
	            	<%
	            }
            }else{
            	%>
            	<input type="text" name="assignRev1" placeholder="<%=rev1%>" readonly="readonly"> <br />
            	<input type="text" name="assignRev2" placeholder="<%=rev2%>" readonly="readonly"> <br />
            	<%
            }
            %>
			</form>
		  </div>
		</div>
		<div class="control-group">
		  <label class="control-label" for="term">Term <% System.out.println("Term ID is: " + term.getId()); %></label>
		  <div class="controls">
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
		  	<%-- <input id="team" name="team" type="text" placeholder=" <%=reqProj.getTermId() %>" class="input-xlarge"> --%>
		  </div>
		</div>
		<div class="control-group">
		  <label class="control-label" for="company">Company</label>
		  <div class="controls">
		   <%
		  if(user != null){
				if(user.getID() == reqProj.getCreatorId()){
			  %>
		  	<input id="team" name="company" type="text" placeholder=" <%=company %>" class="input-xlarge">
		  	
		  	 <%
				}else{
					%>
			<input id="team" name="company" type="text" placeholder=" <%=company %>" class="input-xlarge" readonly="readonly">
					<%
				}
		  }else{
			  %>
			<input id="team" name="company" type="text" placeholder=" <%=company %>" class="input-xlarge" readonly="readonly">
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
				if(user.getID() == reqProj.getCreatorId()){
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

		<div class="control-group">
		  <label class="control-label" for="technology">Technology</label>
		  <div class="controls">
		    <select id="technology" name="technology" class="input-xlarge" multiple="multiple">
		      	<%
            if(tech.size() < 1){
            	%>
            	<option selected>Not specified</option>
            	<%
            }else{
            	ArrayList<Technology> technologies = techdm.retrieveAll();
				  
			  for(int i = 0; i < technologies.size(); i++){
				  Technology tech2 = technologies.get(i);
				 
					if(techdm.hasTech(tech, tech2)){
				  %>
				  <option value="<%=tech2.getId()%>" selected><%=tech2.getTechName() %></option>
				  <%
					}else{
						%>
				<option value="<%=tech2.getId()%>" ><%=tech2.getTechName() %></option>
						<%
					}
		  		}
            }
				System.out.println(tech.size());  
			  %>
		    </select>
		  </div>
		</div>
		<input type="hidden" name="projName" value="<%=reqProj.getProjName()%>">
		<div class="control-group">
		  <label class="control-label" for="status">Status</label>
		  <div class="controls">
		  	<span class="label label-info"><%=reqProj.getStatus() %></span></a>
		  	<input type="hidden" name="projStatus" value="<%=reqProj.getStatus() %>">
		  </div>
		</div>
		<%if(username != null){ %>
		<div class="control-group">
		  <label class="control-label" for="applyproject"></label>
		  <div class="controls">
		  <form action="applyProj" method="post">
		  	<input type="hidden" name="projId" value="<%=reqProj.getId() %>" />
		  	<input type="hidden" name="teamId" value="<%=userTeamId%>" />
		  	<button id="delete" name="delete" class="btn btn-warning">Apply for Project</button>
		  </form>
		  </div>
		</div>
		<%
		}
		try{
			if(username.equals(udm.retrieve(creatorId).getUsername())){
				%>
     <font size="4" face="Courier">Project Status: <%=reqProj.getStatus() %></font></br> <br>
					
			
				<input type="hidden" name="projId" value="<%=reqProj.getId() %>">
				<!-- Button -->
				<div class="control-group">
				  <label class="control-label" for="updateproject"></label>
				  <div class="controls">
				    <input type="submit" value="Update" class="btn btn-success">
				  </div>
				</div>
				</div>
			</form>	
					
			<form method="post" action="deleteProject"  >
				<input type="hidden" name="projId" value="<%=reqProj.getId() %>">
				<!-- Button -->
				<div class="control-group">
				  <label class="control-label" for="delete"></label>
				  <div class="controls">
				    <button id="delete" name="delete" class="btn btn-warning">Delete</button>
				  </div>
				</div>
				</div>
			</form>
		<%
			}
		}catch(Exception e){}
		}
		%>
		
		</div></br>

		</fieldset>
	</form>
	
	</div>
	</div>
	
	
	</body>

</html>