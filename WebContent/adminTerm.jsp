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
			<form name="addTerm" action="addTerm" method="post" class="form-horizontal">
						<fieldset>
						<legend>Add Term</legend>
						<div class="span7">
						<div class="control-group">
					
						  	 <label class="control-label" for="acadYear">Term Name</label>
							  <div class="controls">
							    <input id="year" name="acadYear" type="text" placeholder="Academic Year" class="input-large">
							  </div>
							  </br>
							  <div class="controls">
							    <input id="sem" name="semester" type="text" placeholder="Semester" class="input-large">
							  </div>
						<br />
						<div class="control-group">
					
						  	 <label class="control-label" for="acadYear">Academic Year</label>
							  <div class="controls">
							    <input id="from" name="startDate" type="text" placeholder="Start Date" class="input-large">
							  </div>
							  </br>
							  <div class="controls">
							    <input id="to" name="endDate" type="text" placeholder="End Date" class="input-large">
							  </div>
						</div>
						<br />
						  <div class="controls">
						    <input type="submit" value="Add Term" class="btn btn-success">
						  </div>
						</div>
						
						</div>
						</fieldset>
					</form>
					<form name="manageTerm" action="" method="post" class="form-horizontal">
						<fieldset>
						<legend>Manage Term</legend>
						<div class="span7">
						 <label class="control-label" for="acadTerm">Academic Term</label>
						<div class="control-group">
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
						    </div>
						    </br>
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
</body>
</html>