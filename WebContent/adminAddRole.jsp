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
<script type="text/javascript">
/* function validateForm(theForm) {
	var reason = "";

	  reason += validateRole(theForm.role);	
	  if (reason != "") {
	    alert("Some fields need correction:\n" + reason);
	    return false;
	  }

	  return true;
}

function validateRole(fld) {
    var error = "";
  
    if (fld.value.length == 0) {
        fld.style.background = 'Yellow'; 
        error = "Please enter a role to add.\n";
    } else {
        fld.style.background = 'White';
    }
    return error;   
}	 */
</script>
	<%
	  UserDataManager udm = new UserDataManager();
	  ArrayList<String> usernameList = udm.retrieveAllSchoolUsernames();
	  

	Calendar now = Calendar.getInstance();
	int currYear = now.get(Calendar.YEAR);
	int currMth = now.get(Calendar.MONTH);
%>
<script type="text/javascript">
    $(function() {
    	var usernameList = [
    	                       <%
    	                       for(int i = 0; i < usernameList.size(); i++){
    	                       	out.println("\""+usernameList.get(i)+"\",");
    	                       }
    	                       %>
    	                                      ];
    	
        
        $( "#user" ).autocomplete({
            source: usernameList
          });
    
        
      });
    
	</script>	
</head>
<body>
	<div class="container" id="content-container">
		<div class="content">	
		<!-- DISPLAY FEEDBACK MESSAGE -->
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
			<form name="addRole" action="addRole" method="post" class="form-horizontal" onsubmit="return validateForm(this)">
						<fieldset>
						<legend>Add Role</legend>
						<div class="span7">
						<div class="control-group">
						  <label class="control-label" for="role">User</label>
						  <div class="controls">
						   <input type="text" class="input-large" name="user" id="user">
						  </div> 
						</div>
						<div class="control-group">
						  <label class="control-label" for="role">Role</label>
						  <div class="controls">
						   <select name="role">
						   	<option value="0">Choose One</option>
						   	<option value="Admin">Admin</option>
						   	<option value="Sponsor">Sponsor</option>
						   </select>
						  </div> 
						</div>
						<div class="control-group">
						  <div class="controls">
						    <input type="submit" value="Add Role" class="btn btn-success">
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