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
	#teamName{
		width:49.8em;
		font-size:1em;
	}
	#createTeam{
		font-size:1em;
	}
	#teamLimit{
		width:5em;
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
	<%	
		if(username == null){
			response.sendRedirect("index.jsp");
		}
	
	User u = udm.retrieve(username);
	String type = (String) session.getAttribute("type");
	
	if(type == null){
		type = "";
	}
	boolean hasProj = false;
	
	try{
		hasProj = pdm.hasProj(u);
	}catch(Exception e){
		hasProj = false;
	}
	%> 
	</head>
	<body>
		<div id="content-container" class="shadow">
			<div id="content" align = "justify">
				<div class="createTeam">
					<form class="form-horizontal" method=post action="createProject" onsubmit="return validateForm()">
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
						<legend>Create Project</legend>
						<%
						if(type.equalsIgnoreCase("sponsor")){
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
						<div class="control-group">
						  <label class="control-label" for="technology">Technology</label>
						  
						  <div class="controls">
						    <table border=0>
						   	 <tr>
						   	 <td><input type="checkbox" onclick="toggleTech(this)" />&nbsp;Select All</td>
						   	 </tr>
						   	 <tr>
								 <%
								  TechnologyDataManager tdm = new TechnologyDataManager();
								  ArrayList<Technology> technologies = tdm.retrieveAll();
								  
								  for(int i = 0; i < technologies.size(); i++){
									  Technology tech = technologies.get(i);
									  %>
								<td style="padding: 1px">
									<input type="checkbox" id="technology" name="technology" value="<%=tech.getId()%>">&nbsp;<%=tech.getTechName() %>&nbsp;&nbsp;
								</td>
									  <%
									  if((i+1) % 3 == 0){
										  %>
										  </tr><tr>
										  <%
									  }
								  }
								  %>
							 </tr>
						    </table>
						  </div>
						</div>
						
						<div class="control-group">
						  <label class="control-label" for="technology">Preferred Skills</label>
						  
						  <div class="controls">
						    <table border=0>
						   	 <tr>
						   	 <td><input type="checkbox" onclick="toggleSkill(this)" />&nbsp;Select All</td>
						   	 </tr>
						   	 <tr>
								 <%
								  SkillDataManager skdm = new SkillDataManager();
								  ArrayList<Skill> skills = skdm.retrieveAll();
								  
								  for(int i = 0; i < skills.size(); i++){
									  Skill skill = skills.get(i);
									  %>
								<td style="padding: 1px">
									<input type="checkbox" id="skill" name="skill" value="<%=skill.getId()%>">&nbsp;<%=skill.getSkillName() %>&nbsp;&nbsp;
								</td>
									  <%
									  if((i+1) % 3 == 0){
										  %>
										  </tr><tr>
										  <%
									  }
								  }
								  %>
							 </tr>
						    </table>
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
						
						<!-- Button -->
						<div class="control-group">
						  <label class="control-label" for="createproject"></label>
						  <div class="controls">
						  <%
							if(hasProj){
						  %>
						    <input type="submit" id="createproject" Value="Create" class="btn btn-success" disabled="disabled"><br />
						    <font color=red size=-1><i>You are already undertaking a project</i></font>
						  <%
							}else{
								%>
							<input type="submit" id="createproject" Value="Create" class="btn btn-success" />
								<%
							}
						  %>
					 	  </div>
						</div>
						</fieldset>
						</form>
						</div>
					<br/>
				</div>
			</div>
	</body>
</html>