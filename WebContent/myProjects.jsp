<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<style type="text/css">
	.container > .content {
	
	background-color: #ffffff;
	padding: 20px;
	margin: 0 -20px;
	-webkit-border-radius: 10px 10px 10px 10px;
	-moz-border-radius: 10px 10px 10px 10px;
	border-radius: 10px 10px 10px 10px;
	-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.15);
	-moz-box-shadow: 0 1px 2px rgba(0,0,0,.15);
	box-shadow: 0 1px 2px rgba(0,0,0,.15);
	}
</style>
	<link rel="stylesheet" type="text/css" href="./css/bootstrap.css" />
    <script src="./js/bootstrap.js"></script>
    <link type="text/css" href="./css/bootstrap-responsive.css" rel="stylesheet">
<%
String sessionUsername = (String) session.getAttribute("username");
UserDataManager udm = new UserDataManager();
User userS = udm.retrieve(sessionUsername);
int uId = userS.getID();
SponsorDataManager sdm = new SponsorDataManager();
Sponsor sponsor = sdm.retrieve(sessionUsername);
if(sessionUsername == null || sessionUsername.isEmpty()){
	sessionUsername = "";
}
%>
<%@ include file="template.jsp" %>
<body>
	<div class="container">
	<div class="content">
		<h3>My Projects</h3>
		
		<div class="control-group">
		  <label class="control-label" for="coyName">Sponsored Projects </label>
		  <div class="controls">
		    <%
		    ProjectDataManager pdm = new ProjectDataManager();
			ArrayList<Project> projects = pdm.retrieveAllFromSponsor(sponsor);
			
			if(projects.size() < 1){
				out.println("No projects");
			}else{
				for(int i = 0; i < projects.size(); i++){
					Project p = projects.get(i);
					%>
					<a href="projectProfile.jsp?id=<%=p.getId()%>"><%=p.getProjName() %></a><br />
					<%
				}
			}
			%>
		  </div>
		</div>
	</div>
	</div>
</body>
</html>