<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
	<head>
	<%@include file="template.jsp"%>
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
		
			<div class="full_width big">
				<h3>Search Teams </h3>
				<% if(usertype.equalsIgnoreCase("Student")){ %>
				<p align="right" style="float:right;"><form action="matchTeam" method="post"><input type=submit value="Match me to a team!" class="btn btn-primary"/></form></p>
				<% } %>
			</div>
			<% 
				String message = (String) session.getAttribute("message"); 
				if(message == null || message.isEmpty()){
					message = "";
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
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 177px;">Project</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Members</th>	
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Supervisor</th>
		</tr>
	</thead>
	
	<tfoot>
		<tr>
			<th rowspan="1" colspan="1">Team Name</th>
			<th rowspan="1" colspan="1">Project</th>
			<th rowspan="1" colspan="1">Members</th>
			<th rowspan="1" colspan="1">Supervisor</th>
		</tr>
	</tfoot>
<tbody role="alert" aria-live="polite" aria-relevant="all">
<%
RoleDataManager roledm = new RoleDataManager();
int count = 0;
for(int i = 0; i < teams.size(); i++){
	Team team = teams.get(i);
	String name = team.getTeamName();
	String sup = "";
	int supId = 0;
	
	String project = "";
	int projId = 0;
	try{
		project = pdm.retrieveProjectsByTeam(team.getId()).getProjName();
		projId = pdm.retrieveProjectsByTeam(team.getId()).getId();
	}catch(Exception e){
		project = "No registered project yet";
		projId = 0;
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
			<td class="center ">
			<%if(projId != 0){ %>
			<a href="projectProfile.jsp?id=<%=projId%>" style="color:#005580;">
			<%} %>
			<%=project %></a>
			
			</td>
			<td class="center " valign="top">
				<%
				for(int j = 0; j < members.size(); j++){
					Student std = members.get(j);
					String role = "";
					
					if(std.getRole() == 1){
						role = "(Project Manager)";
					}
					%>
					<a href="userProfile.jsp?id=<%=std.getID()%>" style="color:#005580;"><%=std.getFullName() %></a><font size=-2><%=role %></font><br />
					<%
				}
				%>
				 <button type="button" id="external" class="btn btn-primary">Add Member</button>
			</td>
			<td class="center ">
			  <a href="#"  style="color:#005580;">
			  <%if(supId != 0){ %>
			<a href="userProfile.jsp?id=<%=supId%>"  style="color:#005580;">
			<%} %>
			  <%=sup %>
			  </a>
			</td>
	</tr>
<%
}
%>
		</tbody></table>
		<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
			</div>
			<div class="spacer"></div>
			
			
			
			</div></body></html>
		