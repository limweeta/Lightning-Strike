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
    
	<%@ include file="template.jsp" %>
	<%	
		if(username == null){
			response.sendRedirect("index.jsp");
		}
	%>
	</head>
	<body>
			
		</br></br></br>
		<div id="content-container" class="shadow">
			<div id="content">
				<div class="createTeam">
					<form action="createProject" method="post" name="creatProj" onsubmit="return validateForm()">
						<font size="4" face="Courier">Project Name:</font></br>
						<input id="projectName" type="text" name="projectName"></br></br>	
						<font size="4" face="Courier">Project Term:</font></br>
						<select name="projectTerm">
						  <option value="2013/2014T1">2013/2014 T1</option>
						  <option value="2013/2014T2">2013/2014 T2</option>
						  <option value="2012/2013T1">2012/2013 T1</option>
						  <option value="2012/2013T2">2012/2013 T2</option>
						</select></br></br>
						<font size="4" face="Courier">Project Description:</font></br>
						<textarea name="projectDescription" cols="97" rows="10"></textarea></br></br>
						<font size="4" face="Courier">Project Status:</font></br>
						<select name="projectStatus" disabled>
						  <option value="Open" selected>Open</option>
						</select></br></br>
						<font size="4" face="Courier">Industry Type:</font></br>
						<select name="industryType">
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
						</select></br></br>
						
						<font size="4" face="Courier">Technology:</font></br>
						<select name="techType" size=5 multiple>
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
						</select></br></br>
						
						<!-- Company name to have autocomplete in accordance to database -->
						<!-- include hidden field for id -->
						<font size="4" face="Courier">Project Organization:</font></br>
						<input id="projectOrganization" type="text" name="projectOrganization"></br></br>
					<!-- 
						<font size="4" face="Courier">Contact Details: </font></br>
						<font size="4" face="Courier">Contact Name: </font>&nbsp;&nbsp;
						<input type="text" name="contactName">
						<font size="4" face="Courier">Contact Number: </font>&nbsp;&nbsp;<input type="text" name="contactNumber"></br></br>
						<font size="4" face="Courier">Team Name:</font></br>
						 -->
						<!-- Team name to be extracted from session -->
						<!-- include hidden field for id -->
						<!-- Team name field to be uneditable -->
					
					 <!--  
						<input id="teamName" type="text" name="teamName"></br></br>
						<font size="4" face="Courier">Project Diagrams:</font></br>
						<textarea id="projectDiagrams" cols="97" rows="10" disabled></textarea></br>
						</br>-->
						<input id="createProject" type="submit" value="Create Project"> 
					</form>
					<br/>
				</div>
			</div>
		</div>
	</body>
</html>