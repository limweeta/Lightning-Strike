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
	
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

</head>
<%
StudentDataManager stdm = new StudentDataManager();
TeamDataManager tdm = new TeamDataManager();
SponsorDataManager spdm = new SponsorDataManager();
CompanyDataManager coydm = new CompanyDataManager();

Student student = null;

try{
	student = stdm.retrieve(username);
}catch(Exception e){
	session.setAttribute("message", "Only students may leave feedback for sponsors");
	response.sendRedirect("index.jsp");
}

String teamName = "";
String sponsorName = "";
String coy = "";
String email = "";
String contactno = "";

int sponsorid = 0;

Team team = null;
Sponsor sponsor = null;
Company company = null;
try{
	team = tdm.retrieve(tdm.retrievebyStudent(student.getID()));
	
	teamName = team.getTeamName();
	
}catch(Exception e){
	session.setAttribute("message", "You need to a team to leave feedback for sponsors");
}

try{
	sponsor = spdm.retrieveSponsorByTeam(team.getId());
	
	sponsorid = sponsor.getID();
	sponsorName = sponsor.getFullName();
	email = sponsor.getEmail();
	contactno = sponsor.getContactNum();
}catch(Exception e){
	session.setAttribute("message", "You need to have completed a project to leave feedback for sponsors");
}

try{
	company = coydm.retrieve(sponsor.getCoyId());
	
	coy = company.getCoyName();
}catch(Exception e){
	if(coy == null && sponsor != null){
		coy = "N/A";
	}else{
		session.setAttribute("message", "You need to have a sponsor to leave this feedback");
	}
}

String status = "";

try{
	status = tdm.getTeamStatus(team);
}catch(Exception e){
	status = "";
}

Calendar now = Calendar.getInstance();
int currYear = now.get(Calendar.YEAR);
int currMth = now.get(Calendar.MONTH);
int currDay = now.get(Calendar.DAY_OF_MONTH);

String dateStr = Integer.toString(currDay) + "/" + Integer.toString(currMth) + "/" + Integer.toString(currYear);
%>
	<body>
		<div id="container">
			<div id="content">
					<form class="form-horizontal" method="post" action="sponsorFeedback" name="sponsorFeedback" id="sponsorFeedback">

						<!-- Form Name -->
						<legend>Sponsor Feedback</legend>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="teamname">Team Name</label>
						  <div class="controls">
						    <input id="teamname" name="teamname" type="text" value="<%=teamName %>" class="input-large" readonly="readonly"  >
						 </div>
 						</div>
 						<div class="control-group">
						  <label class="control-label" for="sponsorname">Sponsor Name</label>
						  <div class="controls">
						  	<input type="hidden" name="sponsorid" value="<%=sponsorid%>">
						    <input id="sponsorname" name="sponsorname" type="text" value="<%=sponsorName %>" class="input-large" readonly="readonly"  >
						 </div>
 						</div>
						<div class="control-group">
						  <label class="control-label" for="date">Date</label>
						  <div class="controls">
						    <input id="date" name="date" type="text" value="<%=dateStr %>" class="input-large" readonly="readonly" >
						    
						 </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="contactNo">Contact Number</label>
						  <div class="controls">
						    <input id="contactNo" name="contactNo" type="text" value="<%=contactno %>" class="input-large" readonly="readonly"  >
						    
						 </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="email">Email</label>
						  <div class="controls">
						    <input id="email" name="email" type="text" value="<%=email %>" class="input-large" readonly="readonly"  >
						    
						 </div>
						</div>
						<legend><small>Grading Criteria</small></legend>
						
						<div class="feedback">
							<table class="table table-bordered">
							<tr>
							<td><font face="Arial" size="3">1</font></td><td>Outstanding performance.</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">2</font></td><td>Good performance.</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">3</font></td><td>Satisfactory performance.</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">4</font></td><td>Unsatisfactory performance.</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">5</font></td><td>Completely unsatisfactory performance.</td>
							</tr>
							</table>
						</div>
						<legend><small>Assessment</small></legend>
						
						<div class="feedback">
							<table class="table table-bordered">
							<tr>
							<td>
								<select name=tech style="width:60px">
							<%
							for (int i = 1; i < 6; i++){
								%>
								<option value="<%=i%>"><%=i %></option>
								<%
							}
							%>
								</select>
							</td>
							<td><font face="Arial"  size="3"><b>Technical Knowledge</b></font></br>
							<font face="Arial"  size="3">
							<ul>
							<li>Sponsor is able to provide technical information needed for your project (e.g. Server configuration)</li>
							</ul>
							</font>
							</td>
							</tr>
							<tr>
							<td>
								<select name=domain style="width:60px">
							<%
							for (int i = 1; i < 6; i++){
								%>
								<option value="<%=i%>"><%=i %></option>
								<%
							}
							%>
								</select>
							</td>
							<td><font face="Arial"  size="3"><b>Domain Knowledge</b></font></br>
							<font face="Arial"  size="3">
							<ul>
							<li>Sponsor is able to share domain knowledge about the industry (e.g. Best practices)</li>
							</ul>
							</font>
							</td>
							</tr>
							<tr>
							<td>
								<select name=project style="width:60px">
							<%
							for (int i = 1; i < 6; i++){
								%>
								<option value="<%=i%>"><%=i %></option>
								<%
							}
							%>
								</select>
							</td>
							<td><font face="Arial"  size="3"><b>Project Knowledge</b></font></br>
							<font face="Arial"  size="3">
							<ul>
							<li>Sponsor is able to share the specific needs of the project (e.g. Current business process)</li>
							</ul>
							</font>
							</td>
							</tr>
							<tr>
							<td>
								<select name=company style="width:60px">
							<%
							for (int i = 1; i < 6; i++){
								%>
								<option value="<%=i%>"><%=i %></option>
								<%
							}
							%>
								</select>
							</td>
							<td><font face="Arial"  size="3"><b>Company Knowledge</b></font></br>
							<font face="Arial"  size="3">
							<ul>
							<li>Sponsor is able to get the right resource to assist in the project (e.g. Infrastructure or business unit)</li>
							</ul>
							</font>
							</td>
							</tr>
							</table>
						</div>
						
						<legend><small>Communication</small></legend>
						
						<div class="feedback">
						   <table>
						   <tr>
							<font face="Arial"  size="3"><b>How often do you meet with the sponsor? (Please Choose)</b></font>
							<table class="table table-bordered">
							<tr>
							<td><font face="Arial" size="2">Daily</font></td>
							<td><font face="Arial" size="2">2-3 Times a Week</font></td>
							<td><font face="Arial" size="2">Once a Week</font></td>
							<td><font face="Arial" size="2">2-3 Times a Month</font></td>
							<td><font face="Arial" size="2">Once a Month</font></td>
							</tr>
							<tr>
							<td><input type="radio" name="often" id="often" value="Daily"></td>
							<td><input type="radio" name="often" id="often" value="2-3 Times a Week"></td>
							<td><input type="radio" name="often" id="often" value="Weekly"></td>
							<td><input type="radio" name="often" id="often" value="2-3 Times a Month"></td>
							<td><input type="radio" name="often" id="often" value="Monthly"></td>
							</tr>
							</table>
							</tr>
							<tr>
							<td><font face="Arial"  size="3"><b>What is your main mode of meetings with Sponsor? (Please Choose)</b></font>
							<table class="table table-bordered">
							<tr>
							<td><font face="Arial" size="2">Face to face</font></td>
							<td><font face="Arial" size="2">Voice Communication</font></td>
							<td><font face="Arial" size="2">Video Conferencing</font></td>
							</tr>
							<tr>
							<td><input type="radio" name="comm" id="comm" value="Face to face"></td>
							<td><input type="radio" name="comm" id="comm" value="Voice Communication"></td>
							<td><input type="radio" name="comm" id="comm" value="Video Conferencing"></td>
							</tr>
							</table>
							</td>
							</tr>
							<tr>
							<td><font face="Arial"  size="3"><b>How helpful or understanding is your sponsor in accommodating to the IS480 requirements?</b></font></br>
								<textarea id="how" name="how"></textarea>
							</td>
							</tr>
						   </table>
						</div>
						<legend><small>Misc</small></legend>
						
						<div class="feedback">
						   <font face="Arial" size="3" style="white-space:nowrap;"><b>Do you feel the sponsor is exploiting you for free labour?</b></font>
						   </br></br>
						   <textarea id="free" name="free"></textarea>
						   </br>
						   </br>
						   <font face="Arial"  size="3" style="white-space:nowrap;"><b>Would you recommend this sponsor to other IS480 teams?</b></font></br></br>
						   <font face="Arial" size="3">Yes</font>&nbsp;<input type="radio" name="another" id="another" value="yes">&nbsp;<font face="Arial" size="3">No</font>&nbsp;<input type="radio" name="another" id="another" value="no"></td>
						   </br>
						   </br>
						   <font face="Arial" size="3" style="white-space:nowrap;"><b>Please help us by telling us how we can improve the program to make this a better </br>experience for you or your team.</b></font>
						   </br></br>
						   <textarea id="feedback" name="feedback"></textarea>
						</div>
						</br>
						<!-- Button -->
						<table>
							<tr></tr>
							<tr>
							<td class = "space" align = "justify">&nbsp;
							<%
							if(!status.equalsIgnoreCase("Completed")){
							%>
						    <input type="submit" id="teamSponsorFeedback" value="Submit Feedback" class="btn btn-success">
						    <br />
						    <font size=-2 color=red>You have yet to complete your project</font>
						    <%
							}else{
								%>
							<input type="submit" id="teamSponsorFeedback" value="Submit Feedback" class="btn btn-success">	
								<%
							}
						    %>
						    </td>

						    </tr>
						</table> 
						</form>
					</div>
					<br/>
				</div>
	</body>
</html>