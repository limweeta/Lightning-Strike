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
<%@include file="template.jsp"%>

</head>
<body>
	<div class="container" id="content-container">
		<div class="content">
			<legend>Suspended Users</legend>
					<div class="panel panel-primary">
					<div class="panel-heading">
						<h7 class="panel-title">Suspended Users</h7>
					</div>
					<div class="panel-body">
						<table width="100%">
							<th>Username</th>
							<th>Full Name</th>
							<th>Type</th>
						<%
							for(int i = 0; i < suspendedUserList.size(); i++){
								User u1 = suspendedUserList.get(i);
								%>
								<tr align=center>
									<td><a href="userProfile.jsp?id=<%=u1.getID()%>"><%=u1.getUsername() %></a></td>
									<td><%=u1.getFullName() %></td>
									<td><%=u1.getType() %></td>
								</tr>
								<%
							}
						%>
						</table>
					</div>
					</div>
		</div>
	</div>
</body>
</html>