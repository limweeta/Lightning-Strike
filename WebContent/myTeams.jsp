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

if(sessionUsername == null || sessionUsername.isEmpty()){
	sessionUsername = "";
}
%>
<body>
	<div class="container">
	<div class="content">
		<h3>My Teams</h3>
		
		<div class="control-group">
		  <label class="control-label" for="coyName">Supervising Teams </label>
		  <div class="controls">
		    <%
		    TeamDataManager tdm = new TeamDataManager();
			ArrayList<Team> teams = tdm.retrieveSupervisingTeams(sessionUsername);
			
			if(teams.size() < 1){
				out.println("No teams under supervision");
			}else{
				for(int i = 0; i < teams.size(); i++){
					Team t = teams.get(i);
					%>
					<a href="teamProfile.jsp?id=<%=t.getId()%>"><%=t.getTeamName() %></a><br />
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