<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
	<head>
	<%@include file="template.jsp"%>
	<%
	StudentDataManager sdm = new StudentDataManager();
	TeamDataManager tdm = new TeamDataManager();
	ProjectDataManager pdm = new ProjectDataManager();
	UserDataManager udm = new UserDataManager();
	
	ArrayList<Student> students = sdm.retrieveAll();
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
				<h3>Search User</h3>
			</div>
			<% String message = (String) session.getAttribute("message"); 
						if(message == null || message.isEmpty()){
							message = "";
						}else{
						%>
						<font size=-1 color="red"><i><%=message %></i></font>
						<%
						session.removeValue("message");
						} %>
			<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
			
			<div id="demo">
<div id="example_wrapper" class="dataTables_wrapper" role="grid"><table cellspacing="0" border="0" class="display dataTable" id="example" aria-describedby="example_info">
	<thead>
		<tr role="row">
			<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-sort="ascending" style="width: 128px;">Full Name</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 177px;">Email</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Team Name</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Project</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Supervisor</th>
		</tr>
	</thead>
	
<tbody role="alert" aria-live="polite" aria-relevant="all">
<%
	int count = 0;

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
			<%=teamName %></td>
			<td class="center">
			<%if(projId != 0){ %>
			<a href="projectProfile.jsp?id=<%=projId%>">
			<%} %>
			<%=projName %></td>
			<td class="center">
			<%if(supId != 0){ %>
			<a href="userProfile.jsp?id=<%=supId%>">
			<%} %>
			<%=supname %></td>
	</tr>
<%
}
%>
		</tbody></table>
		<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
			</div>
			<div class="spacer"></div>
			
			
			
			</div></body></html>
		