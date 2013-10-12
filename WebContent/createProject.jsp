<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<script type="text/javascript">
function validateForm()
{
var projectName=document.forms["creatProj"]["projectName"].value;
if (projectName==null || projectName=="")
  {
  alert("Project name must be filled out");
  return false;
  }

var projectDescription = document.forms["details"]["projectDescription"].value;
if (projectDescription==null || projectDescription=="")
	{
		alert("Project description must be filled out");
		return false;
	}

var projectOrganization = document.forms["details"]["projectOrganization"].value;
if (projectOrganization==null || projectOrganization=="")
	{
		alert("Project organization must be filled out");
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
	%> 
	</head>
	<body>
		<div id="content-container" class="shadow">
			<div id="content">
				<div class="createTeam">
					<form class="form-horizontal" action="createProject" onsubmit="return validateForm()">
						<fieldset>
						
						<!-- Form Name -->
						<legend>Create Project</legend>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="projectname">Project Name</label>
						  <div class="controls">
						    <input id="projectname" name="projectname" type="text" placeholder="Project Name" class="input-large">
						    
						  </div>
						</div>
						
						<!-- Select Basic -->
						<div class="control-group">
						  <label class="control-label" for="projectterm">Project Term</label>
						  <div class="controls">
						   <select id="term" name="term" class="input-large">
						    	  <%
						    	  TermDataManager termdm = new TermDataManager();
						    	  ArrayList<Term> terms  = termdm.retrieveAll();
								  
						    	  for(int i = 0; i < terms.size(); i++){
						    		Term showTerm = terms.get(i); 
						    	%>
						    	  <option value="<%=showTerm.getId()%>"><%=showTerm.getAcadYear() + " T" + showTerm.getSem() %></option>
						    	 <%
						    	  }
						    	 %>
						    </select> 
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
						   	 <tr><td colspan=3 align=center><input type="checkbox" onclick="toggleTech(this)" />Select All</td></tr><tr>
								 <%
								  TechnologyDataManager tdm = new TechnologyDataManager();
								  ArrayList<Technology> technologies = tdm.retrieveAll();
								  
								  for(int i = 0; i < technologies.size(); i++){
									  Technology tech = technologies.get(i);
									  %>
								<td style="padding: 1px">
									<input type="checkbox" id="technology" name="technology" value="<%=tech.getId()%>">&nbsp;<%=tech.getTechName() %></option>
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
						   	 <tr><td colspan=3 align=center><input type="checkbox" onclick="toggleSkill(this)" />Select All</td></tr><tr>
								 <%
								  SkillDataManager skdm = new SkillDataManager();
								  ArrayList<Skill> skills = skdm.retrieveAll();
								  
								  for(int i = 0; i < skills.size(); i++){
									  Skill skill = skills.get(i);
									  %>
								<td style="padding: 1px">
									<input type="checkbox" id="skill" name="skill" value="<%=skill.getId()%>">&nbsp;<%=skill.getSkillName() %></option>
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
						    <input type="submit" id="createproject" Value="Create" class="btn btn-success">
						    
					  </div>
						  </div>
						</div>
						
						</fieldset>
						</form>
					
					<br/>
				</div>
			</div>
		</div>
	</body>
</html>