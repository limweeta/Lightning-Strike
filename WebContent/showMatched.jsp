<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<html>
	<head>
	<%@include file="template.jsp"%>
	<%
	TeamDataManager tdm = new TeamDataManager();
	ArrayList<Team> teams = tdm.retrieveAll();
	UserDataManager udm = new UserDataManager();
	
	ArrayList<ProjectScore> matchedProjs = (ArrayList<ProjectScore>) request.getAttribute("combinedProjMatches");
	%>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link rel="shortcut icon" type="image/ico" href="http://www.sprymedia.co.uk/media/images/favicon.ico">
		
		<title>Matched Projects</title>
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
			<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-sort="ascending" style="width: 128px;">Term</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 177px;">Project</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Sponsor</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Matching Accuracy</th>		
		</tr>
	</thead>
	
	<tfoot>
		<tr>
			<th rowspan="1" colspan="1">Term</th>
			<th rowspan="1" colspan="1">Project</th>
			<th rowspan="1" colspan="1">Sponsor</th>
			<th rowspan="1" colspan="1">Matching Accuracy</th>
		</tr>
	</tfoot>
<tbody role="alert" aria-live="polite" aria-relevant="all">
<%
int count = 0;
CompanyDataManager cdm = new CompanyDataManager();
DecimalFormat df = new DecimalFormat("#.##");
for(int i = 0; i < matchedProjs.size(); i++){
	ProjectScore projectScore = matchedProjs.get(i);
	Project project = projectScore.getProject();
	double score = projectScore.getScore();
	double totalScore = projectScore.getTotalScore();
	
	double accuracy = (score/totalScore) * 100;
	
	String name = project.getProjName();
	int sponsorId = project.getSponsorId();
	int termId = project.getIntendedTermId();
	
	TermDataManager termdm = new TermDataManager();
	Term term = termdm.retrieve(termId);
	String strTerm = term.getAcadYear() + " T" + term.getSem();
	
	SponsorDataManager spdm = new SponsorDataManager();
	String sponsor = "";
	
	try{
		sponsor = cdm.retrieve(spdm.retrieve(sponsorId).getCoyId()).getCoyName();
	}catch(Exception e){
		sponsor = "No Sponsor yet";
	}
	
	count++;
	String rowclass = "";
	
	if(count % 2 == 0){
		rowclass = "gradeA even";
	}else{
		rowclass = "gradeA odd";
	}
	
%>
	<tr class="">
			<td class="sorting_1"><%=strTerm %></td>
			<td class=" "><a href="projectProfile.jsp?id=<%=project.getId()%>"><%=name %></td>
			<td class="center "><%=sponsor %></td>
			<td class="center "><%=df.format(accuracy)%>%</td>
	</tr>
<%
}
%>
		</tbody></table>
		
			</div>
			<div class="spacer"></div>
			
			
			
			</div></body></html>
		