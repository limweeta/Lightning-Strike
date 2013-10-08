<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
	<head>
	<%@include file="template.jsp"%>
	<%
	ProjectDataManager pdm = new ProjectDataManager();
	ArrayList<Project> projects = pdm.retrieveAll();
	SponsorDataManager sdm = new SponsorDataManager();
	ArrayList<Sponsor> sponsors = sdm.retrieveAll();
	
	CompanyDataManager cdm = new CompanyDataManager();
	%>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link rel="shortcut icon" type="image/ico" href="http://www.sprymedia.co.uk/media/images/favicon.ico">
		
		<title>DataTables example</title>
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
				<h1>Search Projects <p style="float:right;"><form action="matchProj" method="post"><input type=submit value="Match my team to a project!" /></form></p></h1> 
			</div>
			
			<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
		<%
			String reqId = request.getParameter("id");
		
		if(reqId == null || reqId.isEmpty()){
		%>
			
			<h1>All Projects</h1>
			<div id="demo">
<div id="example_wrapper" class="dataTables_wrapper" role="grid"><table cellpadding="0" cellspacing="0" border="0" class="display dataTable" id="example" aria-describedby="example_info">
	<thead>
		<tr role="row">
			
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Term</th>
			<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-sort="ascending" style="width: 128px;">Project Name</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 177px;">Project Description</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Sponsor</th>
		</tr>
	</thead>
	
	<tfoot>
		<tr>
			<th rowspan="1" colspan="1">Term</th>
			<th rowspan="1" colspan="1">Project Name</th>
			<th rowspan="1" colspan="1">Project Description</th>
			<th rowspan="1" colspan="1">Sponsor</th>
		</tr>
	</tfoot>
<tbody role="alert" aria-live="polite" aria-relevant="all">
	<%
		int count = 0;
		for(int i = 0; i < projects.size(); i++){
			Project proj = projects.get(i);
			int id = proj.getId();
			String name = proj.getProjName();
			String desc = "";
			
			try{
				desc = proj.getProjDesc();
			}catch(Exception e){
				desc = "None";
			}
			
			int sponsorid = proj.getSponsorId();
			int term = proj.getTermId();
			
			TermDataManager tdm = new TermDataManager();
			String strTerm = tdm.retrieve(term).getAcadYear() + " T" + tdm.retrieve(term).getSem();
			
			count++;
			String rowclass = "";
			
			String sponsor = "";
			if(sponsorid == 0){
				sponsor = "Not Available";
			}else{
				SponsorDataManager spdm = new SponsorDataManager();
				//sponsor = cdm.retrieve(sdm.retrieve(sponsorid).getCoyId()).getCoyName();
				
			}
			
			if(count % 2 == 0){
				rowclass = "gradeA even";
			}else{
				rowclass = "gradeA odd";
			}
		
	%>
	<tr class="<%=rowclass %>">
			<td class="sorting_1"><%=strTerm %></td>
			<td class=" "><a href="projectProfile.jsp?id=<%=id %>"><%=name %></a></td>
			<td class="center "><%=desc %></td>
			<td class="center "><%=sponsor %></td>
	</tr>
	<%
	}
	%>
		</tbody></table>
<%
}%>
		<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
			</div>
			<div class="spacer"></div>
			
			
			
			</div></body></html>
		