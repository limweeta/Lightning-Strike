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
<script type="text/javascript">
$(function() {
	var studentNameList = [
	                       <%
	                       for(int i = 0; i < usernameList.size(); i++){
	                       	out.println("\""+usernameList.get(i)+"\",");
	                       }
	                       %>
	                                      ];
	
	var sponsorNameList = [
	                       <%
	                       for(int i = 0; i < sponsorUsernameList.size(); i++){
	                       	out.println("\""+sponsorUsernameList.get(i)+"\",");
	                       }
	                       %>
	                                      ];
	
    var facultyNameList = [
            <%
            for(int i = 0; i < facultyNameList.size(); i++){
            	out.println("\""+facultyNameList.get(i)+"\",");
            }
            %>
                           ];
    
    var teamNameList = [
                           <%
                           for(int i = 0; i < teamNameList.size(); i++){
                           	out.println("\""+teamNameList.get(i)+"\",");
                           }
                           %>
                                          ];
    
    $( "#username" ).autocomplete({
        source: studentNameList
      });
    
    $( "#teamName" ).autocomplete({
        source: teamNameList
      });
    
    $( "#sponsorUsername" ).autocomplete({
        source: sponsorNameList
      });
    
    $( "#teamName2" ).autocomplete({
        source: teamNameList
      });
    
    $( "#teamName3" ).autocomplete({
        source: teamNameList
      });
    
    $( "#assignSupName" ).autocomplete({
      source: facultyNameList
    });
    
    $( "#assignRev1" ).autocomplete({
        source: facultyNameList
      });
    
    $( "#assignRev2" ).autocomplete({
        source: facultyNameList
      });
    
  });

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
						}else if(message.equalsIgnoreCase("Oops! An error occurred somewhere. Please try again")){
						%>
						<div class="alert alert-danger" align="center">
									  <button type="button" class="close" data-dismiss="alert">&times;</button>
									  <strong><%=message %></strong>
									</div>
						<%
						session.removeAttribute("message");
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
			<form action="assignReviewer" method="post" class="form-horizontal">
						<fieldset>
						
						<!-- Form Name -->
						<legend>Assign Reviewers</legend>
					
						<div class="span7">
						<!-- Text input--><!-- 
						<div class="control-group">
						  <label class="control-label" for="teamId">Team Name</label>
						  <div class="controls">
						    <input id="teamName" name="teamName" type="text" class="input-large">
						  </div>
						</div> -->
						<!-- </div></br> -->
						<!-- <div class="span3"> -->
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="projName">Team Name</label>
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
						<!-- </div> -->
						<!-- <div class="span4"> -->
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="assignRev1">Reviewer 1</label>
						  <div class="controls">
						  	<select name="assignRev1">
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
						<!-- <div class="span5"> -->
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="assignRev2">Reviewer 2</label>
						  <div class="controls">
						   <select name="assignRev2">
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
						<!-- <div class="span7"> -->
						<!-- Button -->
						<div class="control-group">
						  <div class="controls">
						    <button id="assignReviewer" name="assignReviewer" class="btn btn-success">Assign</button>
						  </div>
						</div>
						</div>
						</fieldset>
					</form>
					
		</div>

	</div>
	
</body>
</html>