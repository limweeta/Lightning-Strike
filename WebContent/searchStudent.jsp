<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
	<head>
	<%@include file="template.jsp"%>
	<%
	Calendar now = Calendar.getInstance();
	int currYear = now.get(Calendar.YEAR);
	int currMth = now.get(Calendar.MONTH);
	
	StudentDataManager sdm = new StudentDataManager();
	TeamDataManager tdm = new TeamDataManager();
	ProjectDataManager pdm = new ProjectDataManager();
	UserDataManager udm = new UserDataManager();
	
	ArrayList<Student> students = sdm.retrieveAllCurrent();
	
	Team userTeam = null;
	try{
		User u = udm.retrieve(username);
		userTeam = tdm.retrieve(tdm.retrievebyStudent(u.getID()));
	}catch(Exception e){}
	%>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link rel="shortcut icon" type="image/ico" href="http://www.sprymedia.co.uk/media/images/favicon.ico">
		
		<title>Search Student</title>
		<style type="text/css" title="currentStyle">
			@import "./DataTables-1.9.4/media/css/demo_page.css";
			@import "./DataTables-1.9.4/media/css/demo_table.css";
			@import "./DataTables-1.9.4/examples/examples_support/jquery.tooltip.css";
			/* @import "./css/style.css";
			@import "./css/searchstyle.css"; */
		</style>
		
		<script type="text/javascript" charset="utf-8" src="./DataTables-1.9.4/media/js/jquery.js"></script>
		<script type="text/javascript" charset="utf-8" src="./DataTables-1.9.4/media/js/jquery.dataTables.js"></script>
		<script type="text/javascript" language="javascript" src="./jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.tooltip.js"></script>
		<script type="text/javascript" language="javascript" src="./jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
		
		<script type="text/javascript" charset="utf-8">
			$(document).ready(function() {
				
				$('#example').dataTable();
			} );
		</script>
	</head>
	<body id="dt_example">
		<div id="container">
			<div class="full_width big">
				<h3>Search Student</h3>
				
			</div>
			<a href="#advSearchModal" style="float:right;" data-toggle="modal">Advanced Search</a>
			<% String message = (String) session.getAttribute("message"); 
			if(message == null || message.isEmpty()){
				message = "";
			}else{
		%>
			<div class="alert alert-success">
			  <button type="button" class="close" data-dismiss="alert">&times;</button>
			  <strong><%=message %></strong>
			</div>
			
			<%
			session.removeValue("message");
			} %>
			<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
			
			<div id="demo">
<div id="example_wrapper" class="dataTables_wrapper" role="grid"><table cellspacing="0" border="0" class="display dataTable" id="example" aria-describedby="example_info">
	<thead>
		<tr role="row">
			<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-sort="ascending" style="width: 150px;">Full Name</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 177px;">Email</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Team Name</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 150px;">Project</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Supervisor</th>
			<% 
			if(tdm.emptySlots(userTeam)){
			%>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Invite</th>
			<%
			}
			%>
		</tr>
	</thead>
	
<tbody role="alert" aria-live="polite" aria-relevant="all">
<%
int count = 0;
int visitorTeamId = 0;

try{
	visitorTeamId = tdm.retrievebyStudent(udm.retrieve(username).getID());
}catch(Exception e){
	visitorTeamId = 0;
}

User u = null;
String supname = "";
int supId = 0;

Team t = null;
String teamName = "";
int teamId = 0;

Project p = null;
String projName = "";
int projId = 0;

for(int i = 0; i < students.size(); i++){
	Student student = students.get(i);
	String fullname = student.getFullName();
	String email = student.getEmail();
	count++;
	
	try{
		t =  tdm.retrieve(student.getTeamId());
		teamName = t.getTeamName();
		teamId = t.getId();
	}catch(Exception e){
		teamId = 0;
		teamName = "No Registered Team";
	}
	
	try{
		p = pdm.retrieveProjectsByTeam(t.getId());
		projName = p.getProjName();
		projId = p.getId();
	}catch(Exception e){
		projId = 0;
		projName = "N/A";
	}
	
	try{
		u = udm.retrieve(t.getSupId());
		supname = u.getFullName();
		supId = u.getID();
	}catch(Exception e){
		supId = 0;
		supname = "N/A";
	}
%>
	<tr class="">
			<td class="sorting_1"><a href="userProfile.jsp?id=<%=student.getID()%>"><%=fullname %></a></td>
			<td class="center"><a href="mailto:<%=email%>" target="_top"><%=email %></a></td>
			<td class="center">
			<%if(teamId != 0){ %>
			<a href="teamProfile.jsp?id=<%=teamId%>">
			<%} %>
			<%=teamName %></a></td>
			<td class="center">
			<%if(projId != 0){ %>
			<a href="projectProfile.jsp?id=<%=projId%>">
			<%} %>
			<%=projName %></a></td>
			<td class="center">
			<%if(supId != 0){ %>
			<a href="userProfile.jsp?id=<%=supId%>">
			<%} %>
			<%=supname %></a></td>
			<% 
			if(tdm.emptySlots(userTeam)){
				if(visitorTeamId != 0 && !sdm.hasTeam(student)){
			%>
				<td class="center">
				<form action="inviteStudent" method="post">
				<input type="hidden" name="userid" value="<%=student.getID()%>">
				<input type="hidden" name="visitorTeamId" value="<%=visitorTeamId%>">
				<input type="submit" value ="Invite to team" class="btn btn-info" />
				</form>
				</td>
			<%
				}else{
					%>
					<td class="center">Ineligible</td>
					<%
				}
			}
			%>
	</tr>
<%
}
%>
		</tbody></table>
		<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
			</div>
			<div class="spacer"></div>
			</div>
			
			<div id="advSearchModal" class="modal hide fade">
					    <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					        <h2>Advanced Search</h2>
					    </div>
					       <form action="" method="post" accept-charset="UTF-8">
					    <div class="modal-body">
					     <label class="control-label" for="projectterm">Project Term</label>
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
						    <label class="control-label" for="secMaj">Second Major</label>
						  <select id="secMaj" name="secMaj" class="input-large">
						 		<%
			
						    	  SecondMajorDataManager secondMajordm = new SecondMajorDataManager();
							    	  ArrayList<SecondMajor> secondMajors  = secondMajordm.retrieveAll();
								  
						    	  for(int i = 0; i < secondMajors.size(); i++){
						    		SecondMajor showSecondMajor = secondMajors.get(i);
						    		String secMaj = showSecondMajor.getSecondMajor();
							%>
								   <option value="<%=secMaj%>" selected="selected"><%=secMaj%></option>
								   <%} %>
						  </select>
						  <label class="control-label" for="skills">Skills</label>
						  <select id="skills" name="skills" class="input-large">
						 		 <%
										  SkillDataManager skdm = new SkillDataManager();
										  ArrayList<Skill> skills = skdm.retrieveAll();
										  
										  for(int i = 0; i < skills.size(); i++){
											  Skill skill = skills.get(i);
											  %>
											  <option value="<%=skill.getId()%>"><%=skill.getSkillName() %></option>
										<%
										  }
									  %>
						  </select>
						  <label class="control-label" for="others">Others</label>
						  <input type="text" name="others" id="others" class="input-large">
						</div>
					    <div class="modal-footer">
					        <input class="btn btn-primary" style="clear: left;  height: 32px; font-size: 13px;" type="submit" name="search" value="Search" />
					    </div>
					   	 </form>
			</div>
			</body></html>
		