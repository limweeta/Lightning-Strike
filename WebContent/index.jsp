<html>
<head>

    <script src="script.js"></script>
    <%@ include file="maintemplate.jsp" %>
</head>
<body>

	<% if(type.equalsIgnoreCase("admin")){ %>
	<form action="addAnn" method="post">
		<textarea name="announcement" rows="3" cols="500"></textarea><br />
		<input type="submit" value="Add Announcement">
	</form>
	<% } %>
</body>
</html>