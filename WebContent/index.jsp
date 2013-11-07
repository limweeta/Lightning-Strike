<html>

<head>
<style type="text/css">
	.announcement{
		width: 600px;
	}
</style>
    <script src="script.js"></script>
    <%@ include file="maintemplate.jsp" %>
</head>
<body>
	<% if(type.equalsIgnoreCase("admin")){ %>
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h2 class="panel-title">Add Announcements</h2>
		</div>
		<div class="panel-body">
			<form action="addAnn" method="post">
			<textarea class = "announcement" name="announcement" rows="3" cols="1500"></textarea><br />
			<input type="submit" value="Add Announcement" class="btn btn-success">
			</form>
		</div>
	<% } %>
</body>
</html>