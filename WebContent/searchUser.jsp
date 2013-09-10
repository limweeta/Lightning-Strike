<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
	<head>

	<%@include file="template.jsp"%>
	<%
	StudentDataManager sdm = new StudentDataManager();
	ArrayList<Student> students = sdm.retrieveAll();
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
				<h1>Search User</h1>
			</div>
			
			<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
			<h1>All Projects</h1>
			<div id="demo">
<div id="example_wrapper" class="dataTables_wrapper" role="grid"><table cellspacing="0" border="0" class="display dataTable" id="example" aria-describedby="example_info">
	<thead>
		<tr role="row">
			<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-sort="ascending" style="width: 128px;">Username</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 177px;">Full Name</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Email</th>
		</tr>
	</thead>
	
	<tfoot>
		<tr>
			<th rowspan="1" colspan="1">Username</th>
			<th rowspan="1" colspan="1">Full Name</th>
			<th rowspan="1" colspan="1">Email</th>
		</tr>
	</tfoot>
<tbody role="alert" aria-live="polite" aria-relevant="all">
<%
int count = 0;
for(int i = 0; i < students.size(); i++){
	Student student = students.get(i);
	String name = student.getUsername();
	String fullname = student.getFullName();
	String email = student.getEmail();
	count++;
	String rowclass = "";
	
	if(count % 2 == 0){
		rowclass = "gradeA even";
	}else{
		rowclass = "gradeA odd";
	}
	
%>
	<tr class="<%=rowclass %>">
			<td class="sorting_1"><a href="userProfile.jsp?id=<%=student.getID()%>"><%=name %></td>
			<td class=" "><%=fullname %></td>
			<td class="center "><%=email %></td>
	</tr>
<%
}
%>
		</tbody></table>
		<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
			</div>
			<div class="spacer"></div>
			
			
			
			</div></body></html>
		