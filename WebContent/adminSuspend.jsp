<html>
<head>
<%@include file="template.jsp"%>
<script src="script.js"></script>
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
	  ArrayList<String> overallNameList = udm.retrieveAllUsernames();
	  
 
	Calendar now = Calendar.getInstance();
	int currYear = now.get(Calendar.YEAR);
	int currMth = now.get(Calendar.MONTH);
%>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="./jquery-ui-1.10.3.custom/js/jquery-1.9.1.js"></script> 
 <script src="./jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
<script type="text/javascript">
    $(function() {
    	var overallNameList = [
    	                       <%
    	                       for(int i = 0; i < overallNameList.size(); i++){
    	                       	out.println("\""+overallNameList.get(i)+"\",");
    	                       }
    	                       %>
    	                                      ];
    	
  
        
        $( "#username" ).autocomplete({
            source: overallNameList
          });
        
        
      });
    
   
	</script>	

</head>
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
			<form action="suspendUser" method="post" class="form-horizontal">
						<fieldset>
						
						<!-- Form Name -->
						<legend>Suspend User</legend>
					
						<div class="span7">
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="userName">User Name</label>
						  <div class="controls">
						    <input id="username" name="username" type="text" class="input-large">
						  </div>
						</div>
						
						<div class="control-group">
						  <label class="control-label" for="userName">Reason</label>
						  <div class="controls">
						    <input id="reason" name="reason" type="text" class="input-large">
						  </div>
						</div>
						<!-- Button -->
						<div class="control-group">
						  <div class="controls">
						    <input type="submit" value="Suspend User" class="btn btn-warning">
						  </div>
						</div>
						</div></br>
						</fieldset>
					</form>
					<a href="adminSuspended.jsp">View List of Suspended Users</a>
					
		</div>
	</div>
</body>
</html>