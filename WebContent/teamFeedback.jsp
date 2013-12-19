<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<html>
<style type="text/css">
	h1{
		font-family:Impact;
		font-size:1.75em;
	}
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
/* 	#teamName{
		width:49.8em;
		font-size:1em;
	}
	#createTeam{
		font-size:1em;
	}
	#teamLimit{
		width:5em;
	} */

	
</style>

<head>

	<%@ include file="template.jsp" %>
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>  

</head>
<%
DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
Date date = new Date();

UserDataManager udm = new UserDataManager();

String currDateStr = dateFormat.format(date);

String sessionFullname = (String) session.getAttribute("fullname");
String sessionUser = (String) session.getAttribute("username");

StudentDataManager sdm = new StudentDataManager();
ArrayList<String> fullNameList = sdm.retrieveFullNameList();

TeamDataManager tdm = new TeamDataManager();
ArrayList<String> teamNameList = tdm.retrieveTeamNames();
ArrayList<String> teamMembers = new ArrayList<String>();

String teamName = "";

try{
	int teamId = tdm.retrieveTeamIdByUser(udm.retrieve(sessionUser));
	teamName = tdm.retrieve(teamId).getTeamName();
	
	teamMembers = tdm.retrieveStudentsInTeam(teamName);
}catch(Exception e){
	teamName = "No Team Yet";
	teamMembers = new ArrayList<String>();
}
%>
 <script type="text/javascript">
    $(function() {
    	
    	var studentNameList = [
    	                       <%
    	                       for(int i = 0; i < fullNameList.size(); i++){
    	                       	out.println("\""+fullNameList.get(i)+"\",");
    	                       }
    	                       %>
    	                                      ];

        
        $( "#username1" ).autocomplete({
            source: studentNameList
          });
        
        $( "#username2" ).autocomplete({
            source: studentNameList
          });
        
        $( "#username3" ).autocomplete({
            source: studentNameList
          });
        
        $( "#username4" ).autocomplete({
            source: studentNameList
          });
        
        $( "#username5" ).autocomplete({
            source: studentNameList
          });
        
        $( "#username6" ).autocomplete({
            source: studentNameList
          });
     
        
      });
	</script>	
	<body>
		<div id="container">
			<div id="content">
					<form class="form-horizontal" method="post" name="teamFeedback">

						<!-- Form Name -->
						<legend>Team Feedback</legend>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="name">Grader's Name</label>
						  <div class="controls">
						    <input id="name" name="name" type="text" value="<%=sessionFullname %>" class="input-large" readonly="readonly">
						 </div>
 						</div>
 						<div class="control-group">
						  <label class="control-label" for="team">Team </label>
						  <div class="controls">
						    <input id="teamName" name="teamName" type="text" class="input-large" value="<%=teamName%>" readonly="readonly">
						 </div>
 						</div>
 						<div class="control-group">
						  <label class="control-label" for="team">Date</label>
						  <div class="controls">
						    <input id="date" name="date" type="text" value="<%=currDateStr %>" class="input-large" readonly="readonly" >
						 </div>
 						</div>
						<legend><small>Grading Criteria</small></legend>
						
						<div class="feedback">
							<table class="table table-bordered">
							<tr>
							<td><font face="Arial" size="3">Excellent(8)</font></td><td>Consistently went above and beyond e.g. tutored teammates, carried more than his/her fair share of the load</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">Very Good(7)</font></td><td>Consistently did what he/she was supposed to do, very well prepared and cooperative</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">Satisfactory(6)</font></td><td>Usually did what he/she was supposed to do, acceptably prepared and cooperative</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">Ordinary(5)</font></td><td>Often did what he/she was supposed to do, minimally prepared and cooperative</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">Marginal(4)</font></td><td>Sometimes failed to show up or complete his/her share of the project, rarely prepared</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">Deficient(3)</font></td><td>Often failed to show up or complete his/her share of the project, rarely prepared</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">Unsatisfactory(2)</font></td><td>Consistently failed to show up or complete his/her share of the project, unprepared</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">Superficial(1)</font></td><td>Practically no participation</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">No show(0)</font></td><td>No participation at all</td>
							</tr>
							</table>
							
							<font face="Arial" size="3"><i>These ratings should reflect each individual's level of participation, effort and sense of responsibility, not his or her competence or academic ability.</i></font>							
							</br>
						</div>
						<legend><small>Assessment</small></legend>
						
						<div class="feedback">
							<table class="table table-bordered">
							<%
							if(teamMembers.size() == 0){
								%>
								<h2><font color="red">No team to assess</font></h2>
								<%
							}else{
								for(int j = 0; j < teamMembers.size(); j++){
									String memberName = teamMembers.get(j);
									%>
									<tr>
									<td><font face="Arial" size="3"><b>Name of member</b></font></td>
									<td><font face="Arial" size="3"><b>Rating(0-8)</b></font></td>
									<td><font face="Arial" size="3"><b>Comments </b></font></td>
									</tr>
									<tr>
									<td><input id="username<%=j+1%>" name="member<%=j+1%>" type="text" value="<%=memberName %>" class="input-large" readonly="readonly"></td>
									<td> 
										<select name="rating<%=j+1%>" id="rating<%=j+1%>">
											<% 
											for(int i = 1; i < 9; i++){
												%>
												<option value="<%=i%>"><%=i %></option>
												<%
											}
											%>
										</select>
									</td>
									<td><textarea name="comments<%=j+1%>" id="comments<%=j+1%>"></textarea></td>
									</tr>
									<%
								}
							}
					%>
							
							</table>
						</div>
						<br />
						<!-- Button -->
						<table>
							<tr></tr>
							<tr>
							<td class = "space" align = "justify">&nbsp;
						    <input type="submit" id="mentorFeedback" value="Submit Feedback" class="btn btn-success" disabled="disabled">
						    </td>

						    </tr>
						</table> 
						
						
						</form>
					</div>
				</div>

	</body>
</html>