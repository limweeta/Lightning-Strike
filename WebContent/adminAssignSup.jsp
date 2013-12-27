<html>
<head>
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
	  
	  TeamDataManager tdm = new TeamDataManager();

	Calendar now = Calendar.getInstance();
	int currYear = now.get(Calendar.YEAR);
	int currMth = now.get(Calendar.MONTH);
%>
<script type="text/javascript">
    
    $(function() {
        $( "#from" ).datepicker({
          defaultDate: "+1w",
          changeMonth: true,
          numberOfMonths: 3,
          onClose: function( selectedDate ) {
            $( "#to" ).datepicker( "option", "minDate", selectedDate );
          }
        });
        $( "#to" ).datepicker({
          defaultDate: "+1w",
          changeMonth: true,
          numberOfMonths: 3,
          onClose: function( selectedDate ) {
            $( "#from" ).datepicker( "option", "maxDate", selectedDate );
          }
        });
      });
	</script>	
<%@include file="template.jsp"%>
</head>
<%
ArrayList<User> allFaculty = udm.retrieveAllFaculty();
ArrayList<Team> currentTeams = tdm.retrieveAllCurrentTeams();
%>
<body>
	<div class="container" id="content-container">
		<div class="content">
			<%
						String message = (String) session.getAttribute("message"); 
						if(message == null || message.isEmpty()){
							message = "";
						}else{
					%>
						<div class="alert alert-success" align="center">
									  <button type="button" class="close" data-dismiss="alert">&times;</button>
									  <strong><%=message %></strong>
									</div>
					<%
						session.removeAttribute("message");
						}
					%>
			<form action="assignSupervisor" method="post" class="form-horizontal">
						<fieldset>
						
						<!-- Form Name -->
						<legend>Assign Supervisor</legend>
					
						<div class="span7">
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="teamId">Team Name</label>
						  <div class="controls">
						    <select name="teamId">
						  		<option value="0">Choose one</option>
						  	<%
						  		for(int i = 0; i < currentTeams.size(); i++){
						  			Team t = currentTeams.get(i);
						  			%>
						  			<option value="<%=t.getId()%>"><%=t.getTeamName() %></option>
						  			<%
						  		}
						  	%>
						    </select>
						  </div>
						</div>
						
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="assignSup">Supervisor</label>
						  <div class="controls">
						    	<select name="assignSup">
						  		<option value="0">Choose one</option>
						  	<%
						  		for(int i = 0; i < allFaculty.size(); i++){
						  			User u = allFaculty.get(i);
						  			%>
						  			<option value="<%=u.getID()%>"><%=u.getFullName() %></option>
						  			<%
						  		}
						  	%>
						    </select>
						  </div>
						</div>
						<!-- </div> -->
						<!-- Button -->
						<div class="control-group">
						  <div class="controls">
						    <button id="assignSupervisor" name="assignSupervisor" class="btn btn-success">Assign</button>
						  </div>
						</div>
						</div></br>
						</fieldset>
					</form>
					
		</div>

	</div>
	
</body>
</html>