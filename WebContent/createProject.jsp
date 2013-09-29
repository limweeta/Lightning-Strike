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
<%-- 	<%	
		if(username == null){
			response.sendRedirect("index.jsp");
		}
	%> --%>
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
						    <select id="projectterm" name="projectterm" class="input-large">
						      <option>2013/2014 T1</option>
						      <option>2013/2014 T2</option>
						      <option>2014/2015 T1</option>
						      <option>2014/2015 T2</option>
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
						    <select id="technology" name="technology" class="input-large">
								 <%
								  TechnologyDataManager tdm = new TechnologyDataManager();
								  ArrayList<Technology> technologies = tdm.retrieveAll();
								  
								  for(int i = 0; i < technologies.size(); i++){
									  Technology tech = technologies.get(i);
									  %>
									  <option value="<%=tech.getId()%>"><%=tech.getTechName() %></option>
									  <%
								  }
								  %>
						    </select>
						  </div>
						</div>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="organization">Project Organization</label>
						  <div class="controls">
						    <input id="organization" name="organization" type="text" placeholder="Project Organization" class="input-large">
						    
						  </div>
						</div>
						
						<!-- Button -->
						<div class="control-group">
						  <label class="control-label" for="createproject"></label>
						  <div class="controls">
						    <button id="createproject" name="createproject" class="btn btn-success">Create Project</button>
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