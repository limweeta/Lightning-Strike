<html>
<head>
    <script src="script.js"></script>
    <%@ include file="template.jsp" %>
</head>
<body>
<div class="container">
<%--  <%
 String userType = (String) session.getAttribute("type");
 
 if(!userType.equals("Admin")){
	 session.setAttribute("message", "You are not authorized to view that page");
	 response.sendRedirect("index.jsp");
 }	
 %> --%>
<!-------->
<div id="content">
    <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
        <li class="active"><a href="#assignRev" data-toggle="tab">Assign Reviewer</a></li>
        <li><a href="#assignSup" data-toggle="tab">Assign Supervisor</a></li>
        <li><a href="#assignTeam" data-toggle="tab">Assign Team to Project</a></li>
        <li><a href="#suspend" data-toggle="tab">Suspend User</a></li>
        <li><a href="#suspended" data-toggle="tab">Suspended Users</a></li>
    </ul>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <script src="./jquery-ui-1.10.3.custom/js/jquery-1.9.1.js"></script>
  <script src="./jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
  <%
	  UserDataManager udm = new UserDataManager();
	  ArrayList<String> facultyNameList = udm.retrieveFacultyFullname();
	  
	  ArrayList<User> suspendedUserList = udm.retrieveSuspendedUsers();
	  
	  StudentDataManager sdm = new StudentDataManager();
	  ArrayList<String> usernameList = sdm.retrieveUsernameList();
	  
	  TeamDataManager tdm = new TeamDataManager();
	  ArrayList<String> teamNameList = tdm.retrieveTeamNames();
	  
	  ProjectDataManager pdm = new ProjectDataManager();
	  ArrayList<String> projectNameList = pdm.retrieveProjName();
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
        
        var projectNameList = [
                            <%
                            for(int i = 0; i < projectNameList.size(); i++){
                            	out.println("\""+projectNameList.get(i)+"\",");
                            }
                            %>
                                           ];
        
        $( "#userName" ).autocomplete({
            source: studentNameList
          });
        
        $( "#projName" ).autocomplete({
            source: projectNameList
          });
        
        $( "#teamName" ).autocomplete({
            source: teamNameList
          });
        
        $( "#assignSup" ).autocomplete({
          source: facultyNameList
        });
        
        $( "#assignRev1" ).autocomplete({
            source: facultyNameList
          });
        
        $( "#assignRev2" ).autocomplete({
            source: facultyNameList
          });
        
      });
	</script>	
    <div id="my-tab-content" class="tab-content">
        <div class="tab-pane active" id="assignRev">
            <h1>Assign Reviewers</h1>
           		<div class="span8 well">
					<div class="row">
					<form action="assignReviewer" method="post" class="form-horizontal">
						<fieldset>
						
						<!-- Form Name -->
						<legend>Assign Reviewers</legend>
					
						<div class="span8">
						<!-- Text input--><!-- 
						<div class="control-group">
						  <label class="control-label" for="teamId">Team Name</label>
						  <div class="controls">
						    <input id="teamName" name="teamName" type="text" class="input-large">
						  </div>
						</div> -->
						<!-- </div></br> --></br>
						<!-- <div class="span3"> -->
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="projName">Project Name</label>
						  <div class="controls">
						    <input id="projName" name="projName" type="text" class="input-large">
						  </div>
						</div>
						<!-- </div> --></br>
						<!-- <div class="span4"> -->
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="assignRev1">Reviewer 1</label>
						  <div class="controls">
						    <input id="assignRev1" name="assignRev1" type="text" class="input-large">
						  </div>
						</div>
						<!-- </div> --></br>
						<!-- <div class="span5"> -->
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="assignRev2">Reviewer 2</label>
						  <div class="controls">
						    <input id="assignRev2" name="assignRev2" type="text" class="input-large">
						  </div>
						</div></br>
						<!-- <div class="span7"> -->
						<!-- Button -->
						<div class="control-group">
						  <div class="controls">
						    <button id="assignReviewer" name="assignReviewer" class="btn btn-success">Assign</button>
						  </div>
						</div>
						</div></br>
						</fieldset>
					</form>
					</div>
					</div>
        </div>
        <div class="tab-pane" id="assignSup">
            <h1>Assign Supervisor</h1>
            <div class="span8 well">
					<div class="row">
					<form action="assignSupervisor" method="post" class="form-horizontal">
						<fieldset>
						
						<!-- Form Name -->
						<legend>Assign Supervisor</legend>
					
						<div class="span8">
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="teamId">Team Name</label>
						  <div class="controls">
						    <input id="teamName" name="teamName" type="text" class="input-large">
						  </div>
						</div>
						<!-- </div></br> -->
						<!-- <div class="span3"> -->
						<!-- Text input--><!-- 
						<div class="control-group">
						  <label class="control-label" for="projId">Project Name</label>
						  <div class="controls">
						    <input id="projName" name="projName" type="text" class="input-large">
						  </div>
						</div> -->
						<!-- </div> --></br>
						<!-- <div class="span4"> -->
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="assignSup">Supervisor</label>
						  <div class="controls">
						    <input id="assignSup" name="assignSup" type="text" class="input-large">
						  </div>
						</div>
						<!-- </div> --></br>
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
            
        </div>
        <div class="tab-pane" id="suspend">
            <h1>Suspend User</h1>
            <div class="span7 well">
					<div class="row">
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
						<!-- Button -->
						<div class="control-group">
						  <div class="controls">
						    <input type="submit" value="Suspend User" class="btn btn-warning">
						  </div>
						</div>
						</div></br>
						</fieldset>
					</form>
					</div>
					</div>
        </div>
         <div class="tab-pane" id="suspended">
            <h1>Suspended Users</h1>
					<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">Suspended Users</h3>
					</div>
					<div class="panel-body">
						<table width="100%">
							<th>Username</th>
							<th>Full Name</th>
							<th>Type</th>
						<%
							for(int i = 0; i < suspendedUserList.size(); i++){
								User u = suspendedUserList.get(i);
								%>
								<tr align=center>
									<td><a href="userProfile.jsp?id=<%=u.getID()%>"><%=u.getUsername() %></a></td>
									<td><%=u.getFullName() %></td>
									<td><%=u.getType() %></td>
								</tr>
								<%
							}
						%>
						</table>
					</div>
					</div>
		</div>

        <div class="tab-pane" id="assignTeam">
            <h1>Assign Team to Project</h1>
            <div class="span8 well">
				<div class="panel-heading">Assign Team</h3>
				</div>
				<div class="panel-body">
					<div class="span8"></div>
				</div>	
			</div>
        </div>
    </div>
</div>
 
 
<script type="text/javascript">
    jQuery(document).ready(function ($) {
        $('#tabs').tab();
    });
</script>    
</div> <!-- container -->
 
 
<script type="text/javascript" src="./js/bootstrap.js"></script>
</body>
</html>