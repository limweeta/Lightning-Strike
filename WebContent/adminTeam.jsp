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
			<form name="moveTeam" action="moveTeam" method="post" class="form-horizontal">
						<fieldset>
						<legend>Move Team</legend>
						<div class="span7">
						<div class="control-group">
						  <label class="control-label" for="teamName">Team Name</label>
						  <div class="controls">
						    <select id="team" name="team" class="input-large">
						    	  <%
						    	  TeamDataManager teamdm = new TeamDataManager();
						    	  ArrayList<Team> teams  = teamdm.retrieveAll();
								  
						    	  for(int i = 0; i < teams.size(); i++){
						    		Team showTeam = teams.get(i);
						    		%>
						    	  <option value="<%=showTeam.getTeamName()%>" selected><%=showTeam.getTeamName()%></option>
						    	 <%
						    	  }
						    	 %>
						    </select> 
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="projectterm">Term</label>
						  <div class="controls">
						   <select id="term" name="term" class="input-large">
						    	  <%
						    	  TermDataManager termDm = new TermDataManager();
						    	  ArrayList<Term> ts  = termDm.retrieveFromNextSem();
								  int currTId = termDm.retrieveTermId(currYear, currMth);
								  
						    	  for(int i = 0; i < ts.size(); i++){
						    		Term showTerm = ts.get(i); 
						    		if((currTId + 1) == showTerm.getId()){	
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
						    <input type=hidden name="eligibleTerm" value="<%=currTId+1%>" >
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
</body>
</html>