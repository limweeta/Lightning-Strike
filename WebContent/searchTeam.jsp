<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
	<head>
	<%@include file="template.jsp"%>
		<% Calendar now = Calendar.getInstance();
	int currYear = now.get(Calendar.YEAR);
	int currMth = now.get(Calendar.MONTH);
	%>
	<%
	TeamDataManager tdm = new TeamDataManager();
	ProjectDataManager pdm = new ProjectDataManager();
	ArrayList<Team> teams = tdm.retrieveAll();
	UserDataManager udm = new UserDataManager();
	StudentDataManager stdm = new StudentDataManager();
	
	String usertype = (String) session.getAttribute("type");
	
	if(usertype == null){
		usertype = "";
	}
	%>

		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link rel="shortcut icon" type="image/ico" href="http://www.sprymedia.co.uk/media/images/favicon.ico">
		
		<title>Search Team</title>
		<style type="text/css" title="currentStyle">
			@import "./DataTables-1.9.4/media/css/demo_page.css";
			@import "./DataTables-1.9.4/media/css/demo_table.css";
			@import "./DataTables-1.9.4/examples/examples_support/jquery.tooltip.css";
/* 			@import "./css/style.css"; */
/* 			@import "./css/searchstyle.css"; */
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
				<% String message = (String) session.getAttribute("message"); 
			if(message == null || message.isEmpty()){
				message = "";
			}else{
		%>
<%-- 			<font size=-1 color="red"><i><%=message %></i></font> --%>
			<div class="alert alert-success" align="center">
			  <button type="button" class="close" data-dismiss="alert">&times;</button>
			  <strong><%=message %></strong>
			</div>
			
			<%
			session.removeValue("message");
			} %>
			<div class="full_width big">
				<h3>Search Teams </h3>
				<% if(usertype.equalsIgnoreCase("Student")){ %>
				<p align="right" style="float:right;"><form action="matchTeam" method="post"><input type=submit value="Match me to a team!" class="btn btn-success"/></form></p>
				<% } %>
			</div>
			<a href="#advSearchModal" style="float:right; font-family:Arial, sans-serif;font-size: 14px; line-height: 20px;" data-toggle="modal">Advanced Search</a>
			<% 
				String errmessage = (String) session.getAttribute("message"); 
				if(errmessage == null || errmessage.isEmpty()){
					errmessage = "";
				}else{
			%>
				<font size="-1" color="red"><i><%=message %></i></font>
			<%
				session.removeValue("message");
				} 
			%>
			<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
			
			<div id="demo">
<div id="example_wrapper" class="dataTables_wrapper" role="grid"><table cellpadding="0" cellspacing="0" border="0" class="display dataTable" id="example" aria-describedby="example_info">
	<thead>
		<tr role="row">
			<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-sort="ascending" style="width: 128px;">Team Name</th>
			<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-sort="ascending" style="width: 128px;">Term</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 177px;">Project</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 200px;">Members</th>	
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Supervisor</th>
			<%
			if(usertype.equalsIgnoreCase("Sponsor")){
			%>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Invite</th>
			<%
			}
			%>
		</tr>
	</thead>
	
	<tfoot>
		<tr>
			<th rowspan="1" colspan="1">Team Name</th>
			<th rowspan="1" colspan="1">Term</th>
			<th rowspan="1" colspan="1">Project</th>
			<th rowspan="1" colspan="1">Members</th>
			<th rowspan="1" colspan="1">Supervisor</th>
			<%
			if(usertype.equalsIgnoreCase("Sponsor")){
			%>
			<th rowspan="1" colspan="1">Invite</th>
			<%
			}
			%>
		</tr>
	</tfoot>
<tbody role="alert" aria-live="polite" aria-relevant="all">
<%
RoleDataManager roledm = new RoleDataManager();
TermDataManager termdm = new TermDataManager();

int sponsorId = 0;

try{
	sponsorId = udm.retrieve(username).getID();
	
}catch(Exception e){
	sponsorId = 0;
}

int count = 0;
for(int i = 0; i < teams.size(); i++){
	Team team = teams.get(i);
	String name = team.getTeamName();
	String sup = "";
	int supId = 0;
	int termId = team.getTermId();
	Term term = termdm.retrieve(termId);
	String termname = "";
	String project = "";
	
	boolean hasInvited = tdm.hasInvited(team.getId(), sponsorId);
	
	int projId = 0;
	try{
		project = pdm.retrieveProjectsByTeam(team.getId()).getProjName();
		projId = pdm.retrieveProjectsByTeam(team.getId()).getId();
	}catch(Exception e){
		project = "No registered project yet";
		projId = 0;
	}
	
	try{
		termname = term.getAcadYear() + " T" + term.getSem();
	}catch(Exception e){
		termname = "Not specified";
	}
	
	try{
		sup = udm.retrieve(team.getSupId()).getFullName();
		supId = udm.retrieve(team.getSupId()).getID();
	}catch(Exception e){
		sup = "No supervisor registered";
		supId = 0;
	}
	
	ArrayList<Student> members = tdm.retrieveAllStudents(team);
	
	int teamLimit = team.getTeamLimit();
	int pmId = team.getPmId();
	
	count++;
	String rowclass = "";
	
	if(count % 2 == 0){
		rowclass = "gradeA even";
	}else{
		rowclass = "gradeA odd";
	}
	
%>
	<tr class="">
			<td class="sorting_1"><a href ="teamProfile.jsp?id=<%=team.getId()%>"><%=name %></a></td>
			<td class="center "><%=term.getAcadYear() + " T" + term.getSem() %></a></td>
			<td class="center" style="word-wrap:break-word;">
			<%if(projId != 0){ %>
			<a href="projectProfile.jsp?id=<%=projId%>" style="color:#005580;">
			<%} %>
			<%=project %></a>
			
			</td>
			<td valign="top" style="width:200px;">
				<%
				if(members.size() < 1){
					%>
					No team members yet
					<%
				}else{
					for(int j = 0; j < members.size(); j++){
						Student std = members.get(j);
						String role = "";
						int num = j+1;
						String no = num + ". ";
						if(std.getRole() == 1){
							role = "(PM)";
						}
						%>
						<%=no %><a href="userProfile.jsp?id=<%=std.getID()%>" style="color:#005580;"><%=std.getFullName() %></a><font size=-2><%=role %></font><br />
						<%
					}
				}
				%>
			</td>
			<td class="center ">
			  <a href="#"  style="color:#005580;">
			  <%if(supId != 0){ %>
			<a href="userProfile.jsp?id=<%=supId%>"  style="color:#005580;">
			<%} %>
			  <%=sup %>
			  </a>
			  </a>
			</td>
			<%
			if(usertype.equalsIgnoreCase("Sponsor")){
			%>
			<td class="center">
				<form action="inviteTeam" method="post">
					<input type="hidden" name="teamId" value="<%=team.getId() %>" />
					<%
					if(!hasInvited){
						if(!tdm.hasProj(team)){
					%>
					<input type="submit" value="Invite Team to view your projects" class="btn btn-primary" /> 
					<%
						}else{
							%>
					Team is already undertaking a project
							<%
						}
					}else{
						%>
					You have already invited this team to view your project
						<%
					}
					%>
				</form>
			</td>
			<%
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
			     	 <label class="control-label" for="industrytype">Project Industry</label>
					    <select id="ind" name="ind" class="input-large">
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
						   <label class="control-label" for="tech">Project Technology</label>
					    <select id="tech" name="tech" class="input-large">
								 <%
											  TechnologyDataManager techdm = new TechnologyDataManager();
											  ArrayList<Technology> technologies = techdm.retrieveAll();
											 
											  for(int i = 0; i < technologies.size(); i++){
												  Technology tech = technologies.get(i);
												  %>
												  <option value="<%=tech.getId()%>"><%=tech.getTechName() %></option>
												  <% }
											  %>
						  </select>
						  <label class="control-label" for="skills">Project Skills</label>
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
		