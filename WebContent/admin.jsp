<html>
<head>
    <script src="script.js"></script>
    <%@ include file="template.jsp" %>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  	<script src="./jquery-ui-1.10.3.custom/js/jquery-1.9.1.js"></script>
  	<script src="./jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
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
        <li><a href="#suspend" data-toggle="tab">Suspend User</a></li>
        <li><a href="#suspended" data-toggle="tab">Suspended Users</a></li>
        <li><a href="#term" data-toggle="tab">Term</a></li>
        <li><a href="#team" data-toggle="tab">Team</a></li>
        <li><a href="#deleteSponsor" data-toggle="tab">Delete Sponsor</a></li>
    </ul>
  <%
	  UserDataManager udm = new UserDataManager();
	  ArrayList<String> facultyNameList = udm.retrieveFacultyFullname();
	  
	  ArrayList<User> suspendedUserList = udm.retrieveSuspendedUsers();
	  
	  StudentDataManager sdm = new StudentDataManager();
	  ArrayList<String> usernameList = sdm.retrieveUsernameList();
	  
	  TeamDataManager tdm = new TeamDataManager();
	  ArrayList<String> teamNameList = tdm.retrieveTeamNames();
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
						    <input id="teamName3" name="teamName" type="text" class="input-large">
						  </div>
						</div>
						<!-- </div> -->
						<!-- <div class="span4"> -->
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="assignRev1">Reviewer 1</label>
						  <div class="controls">
						    <input id="assignRev1" name="assignRev1" type="text" class="input-large">
						  </div>
						</div>
						<!-- </div> -->
						<!-- <div class="span5"> -->
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="assignRev2">Reviewer 2</label>
						  <div class="controls">
						    <input id="assignRev2" name="assignRev2" type="text" class="input-large">
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
        </div>
        <div class="tab-pane" id="assignSup">
            <h1>Assign Supervisor</h1>
            <div class="span8 well">
					<div class="row">
					<form action="assignSupervisor" method="post" class="form-horizontal">
						<fieldset>
						
						<!-- Form Name -->
						<legend>Assign Supervisor</legend>
					
						<div class="span7">
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="teamId">Team Name</label>
						  <div class="controls">
						    <input id="teamName" name="teamName" type="text" class="input-large">
						  </div>
						</div>
						
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="assignSup">Supervisor</label>
						  <div class="controls">
						    <input id="assignSupName" name="assignSup" type="text" class="input-large">
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
            
        </div>
        <div class="tab-pane" id="suspend">
            <h1>Suspend User</h1>
            <div class="span8 well">
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
						<h2 class="panel-title">Suspended Users</h2>
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
<!-- 
        <div class="tab-pane" id="assignTeam">
            <h1>Assign Team to Project</h1>
            <div class="span8 well">
				<div class="row">
					
						<form action="" method="post" class="form-horizontal">
						<fieldset>
						<legend>Assign Team</legend>
						<div class="span7">
						Form Name
						
						Text input
						<div class="control-group">
						  <label class="control-label" for="teamname">Team Name</label>
						  <div class="controls">
						    <input id="teamname" name="teamname" type="text" class="input-large">
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="projname">Project Name</label>
						  <div class="controls">
						    <input id="projname" name="projname" type="text" class="input-large">
						  </div>
						</div>
						Button
						<div class="control-group">
						  <div class="controls">
						    <input type="submit" value="Assign Team" class="btn btn-success">
						  </div>
						</div>
						</br>
						</div>
						</fieldset>
					</form>
					</div>
				</div>	
			</div> -->
			<div class="tab-pane" id="term">
            <h1>Manage Terms</h1>
            <div class="span8 well">
				<div class="row">
					
						<form name="addTerm" action="addTerm" method="post" class="form-horizontal">
						<fieldset>
						<legend>Add Term</legend>
						<div class="span7">
						<div class="control-group">
					
						  	 <label class="control-label" for="teamName">Academic Year</label>
							  <div class="controls">
							    <input id="acadYear" name="acadYear" type="text" class="input-large">
							  </div>
						  	<br />
						  	 <label class="control-label" for="teamName">Semester</label>
							  <div class="controls">
							    <input id="semester" name="semester" type="text" class="input-large">
							  </div><br />
						  <div class="controls">
						    <input type="submit" value="Add Term" class="btn btn-success">
						  </div>
						</div>
						</br>
						</div>
						</fieldset>
					</form>
					<form name="manageTerm" action="" method="post" class="form-horizontal">
						<fieldset>
						<legend>Manage Term</legend>
						<div class="span7">
						<div class="control-group">
						  <div class="controls">
						    <input type="submit" value="Manage Term" class="btn btn-success">
						  </div>
						</div>
						</br>
						</div>
						</fieldset>
					</form>
					</div>
				</div>	
			</div>
			<div class="tab-pane" id="team">
            <h1>Manage Teams</h1>
            <div class="span8 well">
				<div class="row">
					
						<form name="moveTeam" action="moveTeam" method="post" class="form-horizontal">
						<fieldset>
						<legend>Move Team</legend>
						<div class="span7">
						<div class="control-group">
						  <label class="control-label" for="teamName">Team Name</label>
						  <div class="controls">
						    <select id="term" name="term" class="input-large">
						    	  <%
						    	  TeamDataManager teamdm = new TeamDataManager();
						    	  ArrayList<Team> teams  = teamdm.retrieveAll();
								  
						    	  for(int i = 0; i < teams.size(); i++){
						    		Team showTeam = teams.get(i);
						    		%>
						    	  <option value="<%=showTeam.getId()%>" selected><%=showTeam.getTeamName()%></option>
						    	 <%
						    	  }
						    	 %>
						    </select> 
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="projectterm">Project Term</label>
						  <div class="controls">
						   <select id="term" name="term" class="input-large">
						    	  <%
						    	  TermDataManager termdm = new TermDataManager();
						    	  ArrayList<Term> terms  = termdm.retrieveFromNextSem();
								  int currTermId = termdm.retrieveTermId(currYear, currMth);
								  
						    	  for(int i = 0; i < terms.size(); i++){
						    		Term showTerm = terms.get(i); 
						    		if((currTermId + 1) == showTerm.getId()){	
						    	%>
						    	  <option value="<%=showTerm.getId()%>" selected><%=showTerm.getAcadYear() + " T" + showTerm.getSem() %></option>
						    	 <%
						    		}else{
				    			%>
						    	  <option value="<%=showTerm.getId()%>"><%=showTerm.getAcadYear() + " T" + showTerm.getSem() %></option>
						    	 <%	
						    		}
						    	  }
						    	 %>
						    </select> 
						    <input type=hidden name="eligibleTerm" value="<%=currTermId+1%>" >
						  </div>
						</div>
						<div class="control-group">
						  <div class="controls">
						    <input type="submit" value="Move Team" class="btn btn-success">
						  </div>
						</div>
						</br>
						</div>
						</fieldset>
					</form>
					</div>
				</div>	
			</div>
			<div class="tab-pane" id="deleteSponsor">
            <h1>Delete Sponsor</h1>
            <div class="span8 well">
				<div class="row">
					
						<form name="deleteSponsor" action="" method="post" class="form-horizontal">
						<fieldset>
						<legend>Delete Sponsor</legend>
						<div class="span7">
						<div class="control-group">
						  <label class="control-label" for="deleteSponsor">Delete Sponsor</label>
						  <div class="controls">
						   		<input type="text" value="Sponsor Username" name="sponsorUsername">
						  </div>
						</div>
						<div class="control-group">
						  <div class="controls">
						    <input type="submit" value="Remove" class="btn btn-warning">
						  </div>
						</div>
						</br>
						</div>
						</fieldset>
					</form>
					</div>
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