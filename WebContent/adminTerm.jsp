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
        $( "#startDate" ).datepicker({
          defaultDate: "+1w",
          changeMonth: true,
          numberOfMonths: 3,
          onClose: function( selectedDate ) {
            $( "#endDate" ).datepicker( "option", "minDate", selectedDate );
          }
        });
        $( "#endDate" ).datepicker({
          defaultDate: "+1w",
          changeMonth: true,
          numberOfMonths: 3,
          onClose: function( selectedDate ) {
            $( "#startDate" ).datepicker( "option", "maxDate", selectedDate );
          }
        });
      });
	</script>	
<%@include file="template.jsp"%>
 <style type="text/css" title="currentStyle">
			@import "./DataTables-1.9.4/media/css/demo_page.css";
			@import "./DataTables-1.9.4/media/css/demo_table.css";
			@import "./DataTables-1.9.4/examples/examples_support/jquery.tooltip.css";
/* 			@import "./css/style.css"; */
/* 			@import "./css/searchstyle.css"; */
		</style>
		<script type="text/javascript" charset="utf-8" src="./DataTables-1.9.4/media/js/jquery.js"></script>
		<script type="text/javascript" charset="utf-8" src="./DataTables-1.9.4/media/js/jquery.dataTables.js"></script>
		<script type="text/javascript" language="javascript" src="./jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.tooltip.js"></script>
		<script type="text/javascript" language="javascript" src="./jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
		
		<script type="text/javascript" charset="utf-8">
			$(document).ready(function() {
				
				$('#example').dataTable();
			} );
		</script>
</head>
<body>
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
					
						  	 <label class="control-label" for="acadYear">Period</label>
							  <div class="controls">
							    <input id="startDate" name="startDate" type="text" placeholder="Start Date" class="input-large">
							  </div>
							  </br>
							  <div class="controls">
							    <input id="endDate" name="endDate" type="text" placeholder="End Date" class="input-large">
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
					<form name="deleteTerm" action="deleteTerm" method="post" class="form-horizontal">
						<fieldset>
						<legend>Academic Terms</legend>
<%
TermDataManager termdm = new TermDataManager();
ArrayList<Term> allTerms = termdm.retrieveAll();
%>
						<div class="span7">
						 
						<div class="control-group">
							
			<div id="demo">
<div id="example_wrapper" class="dataTables_wrapper" role="grid"><table cellpadding="0" cellspacing="0" border="0" class="display dataTable" id="example" aria-describedby="example_info">
	<thead>
		<tr role="row">
			<th class="center" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 10px;">Delete</th>
			<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-sort="ascending" style="width: 12px;">Term</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 10px;">Start Date</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 10px;">End Date</th>	
			
		</tr>
	</thead>
	
	<tfoot>
		<tr>
			<th rowspan="1" colspan="1">Delete</th>
			<th rowspan="1" colspan="1">Term</th>
			<th rowspan="1" colspan="1">Start Date</th>
			<th rowspan="1" colspan="1">End Date</th>
			
		</tr>
	</tfoot>
<tbody role="alert" aria-live="polite" aria-relevant="all">
<%
for(int i = 0; i < allTerms.size(); i++){
	Term term = allTerms.get(i);
	int termId = term.getId();
	String termName = "AY" + term.getAcadYear() + " T" + term.getSem();
	String startDate = term.getStartDate();
	String endDate = term.getEndDate();
%>
	<tr class="">
			<td class="center"><input type="checkbox" name="termId" value="<%=termId%>" /></td>
			<td class="center "><%=termName %></td>
			<td class="center">
			<%=startDate %>
			</td>
			<td class="center">
			<%=endDate %>	
			</td>
			
	</tr>
<%
}
%>

		</tbody></table> 
		<br />
		<input type="submit" value="Delete selected terms" class="btn btn-success" />

						    </div>
						    </br>
						  
						</div>
						</br>
						</fieldset>
					</form>
		</div>
	</div>
</body>
</html>