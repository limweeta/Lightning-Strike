<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
	<head>
	<%@include file="template.jsp"%>
	<%
	TeamDataManager tdm = new TeamDataManager();
	ArrayList<Team> teams = tdm.retrieveAll();
	UserDataManager udm = new UserDataManager();
	
	String type = (String) session.getAttribute("type");
	
	if(type == null){
		type = "";
	}
	%>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link rel="shortcut icon" type="image/ico" href="http://www.sprymedia.co.uk/media/images/favicon.ico">
		
		<title>DataTables example</title>
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
				<% if(type.equalsIgnoreCase("Student")){ %>
				<p align="right" style="float:right;"><form action="matchTeam" method="post"><input type=submit value="Match me to a team!" /></form></p>
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
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 177px;">Team Description</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Max Members</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Project Manager</th>		
		</tr>
	</thead>
	
	<tfoot>
		<tr>
			<th rowspan="1" colspan="1">Team Name</th>
			<th rowspan="1" colspan="1">Team Description</th>
			<th rowspan="1" colspan="1">Max Members</th>
			<th rowspan="1" colspan="1">Project Manager</th>
		</tr>
	</tfoot>
<tbody role="alert" aria-live="polite" aria-relevant="all">
<%
int count = 0;
for(int i = 0; i < teams.size(); i++){
	Team team = teams.get(i);
	String name = team.getTeamName();
	String desc = team.getTeamDesc();
	int teamLimit = team.getTeamLimit();
	int pmId = team.getPmId();
	
	String pm = udm.retrieve(pmId).getFullName();
	
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
			<td class="center"><%=desc %></td>
			<td class="center "><%=teamLimit %></td>
			<td class="center "><%=pm %></td>
	</tr>
<%
}
%>
		</tbody></table>
		<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
			</div>
			<div class="spacer"></div>
			
			
			
			</div></body></html>
		