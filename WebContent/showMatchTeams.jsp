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
	
	ArrayList<Team> matchedTeams = (ArrayList<Team>) request.getAttribute("matchedTeams");
	%>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link rel="shortcut icon" type="image/ico" href="http://www.sprymedia.co.uk/media/images/favicon.ico">
		
		<title>Matched Teams</title>
		<style type="text/css" title="currentStyle">
			@import "./DataTables-1.9.4/media/css/demo_page.css";
			@import "./DataTables-1.9.4/media/css/demo_table.css";
			@import "./DataTables-1.9.4/examples/examples_support/jquery.tooltip.css";
			@import "./css/style.css";
			@import "./css/searchstyle.css";
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
				
			</div>
			
			<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
			<h1>Matched Projects</h1>
			<div id="demo">
<div id="example_wrapper" class="dataTables_wrapper" role="grid"><table cellpadding="0" cellspacing="0" border="0" class="display dataTable" id="example" aria-describedby="example_info">
	<thead>
		<tr role="row">
			<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-sort="ascending" style="width: 128px;">Team</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 177px;">Project Manager</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Supervisor</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Matching Accuracy</th>		
		</tr>
	</thead>
	
	<tfoot>
		<tr>
			<th rowspan="1" colspan="1">Team</th>
			<th rowspan="1" colspan="1">Project Manager</th>
			<th rowspan="1" colspan="1">Supervisor</th>
			<th rowspan="1" colspan="1">Matching Accuracy</th>
		</tr>
	</tfoot>
<tbody role="alert" aria-live="polite" aria-relevant="all">
<%
int count = 0;
CompanyDataManager cdm = new CompanyDataManager();
for(int i = 0; i < matchedTeams.size(); i++){
	Team team = matchedTeams.get(i);
	String name = team.getTeamName();
	int supId = team.getSupId();
	int pmId = team.getPmId();
	
	String supervisor = "";
	String supProfile ="#";
	
	try{
		supervisor = udm.retrieve(supId).getFullName();
		supProfile = "userProfile.jsp?id=" + Integer.toString(supId);
	}catch(Exception e){
		supervisor = "No supervisor yet";
		supProfile ="#";
	}
	String pm = udm.retrieve(pmId).getFullName();
	count++;
	String rowclass = "";
	
	if(count % 2 == 0){
		rowclass = "gradeA even";
	}else{
		rowclass = "gradeA odd";
	}
	
%>
	<tr class="<%=rowclass %>">
			<td class="sorting_1"><a href="teamProfile.jsp?id=<%=team.getId()%>"><%=name %></a></td>
			<td class=" "><a href="userProfile.jsp?id=<%=pmId%>"><%=pm %></a></td>
			<td class="center "><a href="<%=supProfile%>"><%=supervisor %></a></td>
			<td class="center ">0%</td>
	</tr>
<%
}
%>
		</tbody></table>
		<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
			</div>
			<div class="spacer"></div>
			
			
			
			</div></body></html>
		