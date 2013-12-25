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
	  
	  ArrayList<User> suspendedUserList = udm.retrieveSuspendedUsers();
	  

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
							<th>Unsuspend</th>
							<th>Full Name</th>
							<th>Type</th>
							<th>Reason</th>
							<th>Date Suspended</th>
							<form method="post" action="unsuspendUser">
						<%
							for(int i = 0; i < suspendedUserList.size(); i++){
								User u1 = suspendedUserList.get(i);
								String reason = udm.getReason(u1.getUsername());
								String dateSuspended = udm.getDateSuspended(u1.getUsername());
								%>
								<tr align=center>
									<td><input type="checkbox" value="<%=u1.getID() %>" name="userId" /></td>
									<td><a href="userProfile.jsp?id=<%=u1.getID()%>"><%=u1.getFullName() %></a></td>
									<td><%=u1.getType() %></td>
									<td><%=reason %></td>
									<td><%=dateSuspended %></td>
								</tr>
								<%
							}
						%>
						
						</table><br />
						<input type="submit" value="Unsuspend" class="btn btn-warning">
						</form>
					</div>
					</div>
					<a href="adminSuspend.jsp">Suspend Users</a>
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
		</div>
	</div>
</body>
</html>