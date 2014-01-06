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
	  
	  TechnologyDataManager techdm = new TechnologyDataManager();
	  ArrayList<Technology> techList = techdm.retrieveAll();
  %>
  <%
	Calendar now = Calendar.getInstance();
	int currYear = now.get(Calendar.YEAR);
	int currMth = now.get(Calendar.MONTH);
%>
<script type="text/javascript">
/* function validateForm(theForm) {
	var reason = "";

	  reason += validateTech(theForm.tech);	
	  if (reason != "") {
	    alert("Some fields need correction:\n" + reason);
	    return false;
	  }

	  return true;
}

function validateTech(fld) {
    var error = "";
  
    if (fld.value.length == 0) {
        fld.style.background = 'Yellow'; 
        error = "Please enter a role to add.\n";
    } else {
        fld.style.background = 'White';
    }
    return error;   
}	 */
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
    function trim(s)
    {
      return s.replace(/^\s+|\s+$/, '');
    } 
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
			<form name="addTech" action="addTech" method="post" class="form-horizontal" onsubmit="return validateForm(this)">
						<fieldset>
						<legend>Add Technology</legend>
						<div class="span7">
						<div class="control-group">
						  <label class="control-label" for="tech">Technology</label>
						  <div class="controls">
						   <input type="text" class="input-large" name="tech" id="tech">
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="tech">Category</label>
						  <div class="controls">
						   <select name="techCat" id="techCat" class="input-large">
						   		<option value="default" selected>Choose One</option>
						   		<%
					   	 		int numOfCat = techdm.retrieveNoOfTechCat();
							  	int numOfSubCat = 0;
								
						   		for(int i = 0; i <= numOfCat; i++){
						   			numOfSubCat = techdm.retrieveNumOfSubCat(i);
									String catName = techdm.retrieveTechCatName(i);
						   		if(!catName.trim().equals("")){%>
						   		<optgroup label="<%=catName %>">
						   		<%
						   		ArrayList<Technology> subcatIdList = techdm.retrieveSubCatFromCat(i);
						   		for(int k = 0; k < subcatIdList.size(); k++){
						   			Technology tech = subcatIdList.get(k);
						   			int catid = techdm.retrieveCatIdFromSubCatId(tech.getId());
								%>
								<option value="<%=catid + " " +tech.getId() %>"><%=tech.getTechName() %></option>
						   		
						   		<%}
						   		%>
						   		<option value="0">None</option>
						   		</optgroup>
						   		<%
						   		}
						   		}%>
						   </select>
						  </div>
						</div>
						<div class="control-group">
						  <div class="controls">
						    <input type="submit" value="Add Tech" class="btn btn-success">
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