<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<%
UserDataManager udm = new UserDataManager();
ProjectDataManager pdm = new ProjectDataManager();

ArrayList<String> projNameList = pdm.retrieveProjName();
%>
<script type="text/javascript">
function validateForm()
{
var projectName=document.forms["createProj"]["projectname"].value;
if (projectName==null || projectName=="")
  {
  alert("Project name must be filled out");
  return false;
  }

var projectDescription = document.forms["createProj"]["projectdescription"].value;
if (projectDescription==null || projectDescription=="")
	{
		alert("Project description must be filled out");
		return false;
	}

}

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

<style type="text/css">
	h1{
		font-family:Impact;
		font-size:1.75em;
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
	
	.panel-title .accordion-toggle.collapsed:after {
    /* symbol for "collapsed" panels */
    font-family:FontAwesome;
	font-size:16px;
    content: '\f067';  
    float:right;
	}
</style>
<%
Calendar now = Calendar.getInstance();
int currYear = now.get(Calendar.YEAR);
int currMth = now.get(Calendar.MONTH);
%>
<head>
		<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>  
    <link rel="stylesheet" href="./css/bootstrap.css"  type="text/css"/>
	
	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<script src="./js/bootstrap.js"></script>
	<%@ include file="template.jsp" %>
	<%	boolean invalidAccess = false;
		if(username == null){
			session.setAttribute("message", "You need to be logged in to create a project");
			invalidAccess = true;
			response.sendRedirect("searchProject.jsp");
		}
	
	User u = udm.retrieve(username);
	String usertype = (String) session.getAttribute("type");
	
	if(usertype == null){
		usertype = "";
	}
	boolean hasProj = false;
	
	try{
		hasProj = pdm.hasProj(u);
	}catch(Exception e){
		hasProj = false;
	}
	%> 
	</head>
<% if(!invalidAccess){ %>
	<body>
		<div id="content-container" class="container">
			<div class="content" align = "justify">
					<form class="form-horizontal" method=post action="createProject" onsubmit="return validateForm()">
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
						<legend>Create Project</legend>
						<%
						if(usertype.equalsIgnoreCase("sponsor")){
							CompanyDataManager cdm = new CompanyDataManager();
							SponsorDataManager spdm = new SponsorDataManager();
							Company company = cdm.retrieve(u.getID());	
							Sponsor sponsor = spdm.retrieve(u.getID());
							
							String sponsorName = sponsor.getFullName();
							String coyName = company.getCoyName();
						%>
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="projectname">Sponsor</label>
						  <div class="controls"><input type="hidden" name="sponsorId" value="<%=sponsor.getID()%>">
						    <input id="sponsor" name="sponsor" type="text" value="<%=sponsorName %>" class="input-large" readonly="readonly">
						    
						  </div>
						</div>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="projectname">Company</label>
						  <div class="controls"><input type="hidden" name="coyId" value="<%=company.getID()%>">
						    <input id="company" name="company" type="text" value="<%=coyName %>" class="input-large" readonly="readonly">
						    
						  </div>
						</div>
						<%
						}
						%>
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="projectname">Project Name</label>
						  <div class="controls">
						    <input id="projectname" name="projectname" type="text" onkeyup="validateProjName()" placeholder="Project Name" class="input-large">
						    
						  </div>
						</div>
						
						<!-- Select Basic -->
						<div class="control-group">
						  <label class="control-label" for="projectterm">Project Term</label>
						  <div class="controls">
						   <select id="term" name="term" class="input-large">
						    	  <%
						    	  TermDataManager termdm = new TermDataManager();
						    	  ArrayList<Term> terms  = termdm.retrieveFromNextSem();
								  int currTermId = termdm.retrieveTermId(currYear, currMth);
								  
						    	  for(int i = 0; i < terms.size(); i++){
						    		Term showTerm = terms.get(i); 
						    		if((currTermId + 1) == showTerm.getId()){	
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
						    <input type=hidden name="eligibleTerm" value="<%=currTermId+1%>" >
						  </div>
						</div>
						
						<!-- Textarea -->
						<div class="control-group">
						  <label class="control-label" for="projectdescription">Project Description</label>
						  <div class="controls">                     
						    <textarea id="projectdescription" name="projectdescription"></textarea>
						  </div>
						</div>
						
						<!-- Select Basic -->
						<div class="control-group">
						  <label class="control-label" for="projectstatus">Project Status</label>
						  <div class="controls">
						    <select id="projectstatus" name="projectstatus" class="input-large" disabled>
						      <option>Open</option>
						      <option>Closed</option>
						      <option>Completed</option>
						    </select>
						  </div>
						</div>
						
						<!-- Select Basic -->
						<div class="control-group">
						  <label class="control-label" for="industrytype">Industry Type</label>
						  <div class="controls">
						    <select id="industrytype" name="industrytype" class="input-large">
								 <%
								  IndustryDataManager idm = new IndustryDataManager();
								  ArrayList<Industry> industries = idm.retrieveAll();
								  
								  for(int i = 0; i < industries.size(); i++){
									  Industry ind = industries.get(i);
									  %>
									  <option value="<%=ind.getIndustryId()%>"><%=ind.getIndustryName() %></option>
									  <%
								  }
								  %>
						    </select>
						  </div>
						</div>
						<!-- Select Basic -->
					<div class="panel-group" id="accordion">
					  <div class="panel panel-default">
						    <div class="panel-heading">
						      <h4 class="panel-title">
						        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
						          Technology
						        </a>
						      </h4>
						    </div>
						    <div id="collapseOne" class="panel-collapse collapse">
						      <div class="panel-body">
							    	<table>
										<tr class="spaceunder">
										     <td><input type="checkbox" onclick="toggleTech(this)" />&nbsp;<span class="label label-default">Select All</span></td>
									     </tr>
								    	<tr class="spaceunder">
											<%
											  TechnologyDataManager tdm = new TechnologyDataManager();
											  ArrayList<Technology> technologies = tdm.retrieveAll();
											 
											  for(int i = 0; i < technologies.size(); i++){
												  Technology tech = technologies.get(i);
												  %><td>
												  <input type="checkbox" name="technology" value="<%=tech.getId()%>">&nbsp;<span class="label label-default"><%=tech.getTechName() %></span>&nbsp;&nbsp;
												  </td><td></td>
												   <%
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
					          Preferred Skills
					        </a>
					      </h4>
					    </div>
					    <div id="collapseTwo" class="panel-collapse collapse">
					      <div class="panel-body">
					 			<table>
									<tr class="spaceunder">
									     <td><input type="checkbox" onclick="toggleSkill(this)" />&nbsp;<span class="label label-default">Select All</span></td>
								     </tr>
							    	<tr class="spaceunder">
							    	<h2>Language</h2>
										<%
											  SkillDataManager skdm = new SkillDataManager();
											  ArrayList<Skill> skills = skdm.retrieveAllLang();
											  
											  for(int i = 0; i < skills.size(); i++){
												  Skill skill = skills.get(i);
												  %><td>
												  <input type="checkbox" name="skill" value="<%=skill.getId()%>">&nbsp;<span class="label label-default"><%=skill.getSkillName() %></span>&nbsp;&nbsp;
												  </td><td></td>
												  <%
												  if((i+1) % 3 == 0){
													  %></tr><tr class="spaceunder">
											<%
												  }
											  }
											  %>
								  	</tr>
								  	<tr class="spaceunder">
							    	<h2>Others</h2>
										<%
											  ArrayList<Skill> otherSkills = skdm.retrieveAllLang();
											  
											  for(int i = 0; i < otherSkills.size(); i++){
												  Skill skill = otherSkills.get(i);
												  %><td>
												  <input type="checkbox" name="skill" value="<%=skill.getId()%>">&nbsp;<span class="label label-default"><%=skill.getSkillName() %></span>&nbsp;&nbsp;
												  </td><td></td>
												  <%
												  if((i+1) % 3 == 0){
													  %></tr><tr class="spaceunder">
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
						
						<%
						SponsorDataManager spdm = new SponsorDataManager();
						Sponsor sponsor = null;
						
						try{
							sponsor = spdm.retrieve(username);
							
							CompanyDataManager cdm = new CompanyDataManager();
							Company coy = cdm.retrieve(sponsor.getID());
						%>
						<!--  
						<div class="control-group">
						  <label class="control-label" for="organization">Project Organization</label>
						  <div class="controls">
						    <input id="organization" name="coyName" type="text" value="<%=coy.getCoyName() %>" class="input-large" disabled="disabled" />
						    <input type="hidden" name="organization" value="<%=sponsor.getID()%>" />
						  </div>
						</div>
						<br />
						-->
						<%
						}catch(Exception e){}
						%>
						</br></br>
						<!-- Button -->
						<table>
						<tr>
						  <%
							if(hasProj){
						  %>
						  <td class = "space" align = "justify">
						    <input type="submit" id="createproject" Value="Create Project" class="btn btn-success" disabled="disabled"><br />
						  </td>	
						    <font color=red size=-1><i>You are already undertaking a project</i></font>
						  <%
							}else{
								%>
								<td class="space" align="justify">	
								<input type="submit" id="createproject" Value="Create Project" class="btn btn-success" />
								</td>
								<%
							}
						  %>
						  </tr>
					 	</table>
						</form>
						</div>
						
						</div>
					<br/>
	</body>
<% } %>
</html>