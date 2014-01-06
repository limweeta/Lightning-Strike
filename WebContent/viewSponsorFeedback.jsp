<html>
<head>
<%@include file="template.jsp"%>
<script src="script.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  	<script src="./jquery-ui-1.10.3.custom/js/jquery-1.9.1.js"></script>
  	<script src="./jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
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
			 <%
	  UserDataManager udm = new UserDataManager();
	  ArrayList<String> facultyNameList = udm.retrieveFacultyFullname();
	  
	  ArrayList<User> suspendedUserList = udm.retrieveSuspendedUsers();
	  
	  StudentDataManager sdm = new StudentDataManager();
	  ArrayList<String> usernameList = sdm.retrieveUsernameList();
	  
	  TeamDataManager tdm = new TeamDataManager();
	  ArrayList<String> teamNameList = tdm.retrieveTeamNames();
	  
	  SponsorDataManager sponsordm = new SponsorDataManager();
	  ArrayList<String> sponsorUsernameList = sponsordm.retrieveSponsorUsernames();
  %>
  <%
	Calendar now = Calendar.getInstance();
	int currYear = now.get(Calendar.YEAR);
	int currMth = now.get(Calendar.MONTH);
%>	


</head>
<body>
	<div class="container" id="content-container">
		<div class="content">	
			<form name="viewTeamFeedback" action="#" method="post" class="form-horizontal">
						<fieldset>
						<legend>View Sponsor Feedback</legend>
						<div class="span7">
						<div class="control-group">
						  <label class="control-label" for="teamName">Sponsor Name</label>
						  <div class="controls">
						    <select id="sponsor" name="sponsor" class="input-large">
						    	  <%
						    	  SponsorDataManager sdm = new SponsorDataManager();
						    	  ArrayList<String> sponsors  = sdm.retrieveSponsorUsernames();
								  
						    	  for(int i = 0; i < sponsors.size(); i++){
						    		String sUsername = sponsors.get(i);
						    		%>
						    	  <option value="<%=sUsername%>" selected><%=sUsername%></option>
						    	 <%
						    	  }
						    	 %>
						    </select> 
						  </div>
						</div>
						
						<div class="control-group">
						  <div class="controls">
						    <input type="submit" value="View Sponsor Feedback" class="btn btn-success">
						  </div>
						</div>
						</br>
						</div>
						</fieldset>
					</form>
		</div>
	</div>
</body>
</html>