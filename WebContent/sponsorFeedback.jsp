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

<head>

	<%@ include file="template.jsp" %>
	
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

</head>
<%
DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
Date date = new Date();

String currDateStr = dateFormat.format(date);
%>
	<body>
		<div id="container">
			<div id="content">
					<form class="form-horizontal" method="post" name="sponsorFeedback">

						<!-- Form Name -->
						<legend>Sponsor Feedback</legend>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="teamname">Team Name</label>
						  <div class="controls">
						    <input id="teamname" name="teamname" type="text" placeholder="Team Name" class="input-large" >
						 </div>
 						</div>
 						<div class="control-group">
						  <label class="control-label" for="mentorname">Name</label>
						  <div class="controls">
						    <input id="mentorname" name="mentorname" type="text" placeholder="Mentor Name" class="input-large" >
						 </div>
 						</div>
 						<div class="control-group">
						  <label class="control-label" for="org">Organization</label>
						  <div class="controls">
						    <input id="org" name="org" type="text" placeholder="Organization" class="input-large" >
						 </div>
 						</div>
						<div class="control-group">
						  <label class="control-label" for="date">Date</label>
						  <div class="controls">
						    <input id="date" name="date" type="text" placeholder="Date(DDMMYYYY)" class="input-large" >
						    
						 </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="contactNo">Contact Number</label>
						  <div class="controls">
						    <input id="contactNo" name="contactNo" type="text" placeholder="Contact Number" class="input-large" >
						    
						 </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="email">Email</label>
						  <div class="controls">
						    <input id="email" name="email" type="text" placeholder="Email" class="input-large" >
						    
						 </div>
						</div>
						<legend><small>Grading Criteria</small></legend>
						
						<div class="feedback">
							<table class="table table-bordered">
							<tr>
							<td><font face="Arial" size="3">1</font></td><td>Outstanding performance. The team consistently exceeded your expectations.</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">2</font></td><td>Good performance. The team exceeded your expectations at times.</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">3</font></td><td>Satisfactory performance. The team generally met your expectations.</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">4</font></td><td>Unsatisfactory performance. The team generally did not meet your expectations.</td>
							</tr>
							<tr>
							<td><font face="Arial" size="3">5</font></td><td>Completely unsatisfactory performance. The team consistently failed to meet your expectations.</td>
							</tr>
							</table>
						</div>
						<legend><small>Assessment</small></legend>
						
						<div class="feedback">
							<table class="table table-bordered">
							<tr>
							<td><input id="pro" name="pro" type="text" class="input-mini" ></td>
							<td><font face="Arial"  size="3"><b>Professionalism</b></font></br>
							<font face="Arial"  size="3">
							<ul>
							<li>The team conducted the meetings in a professional manner.</li>
							<li>They were well prepared, helpful, cooperative, respectful and clear in their communications.</li>
							</ul>
							</font>
							</td>
							</tr>
							<tr>
							<td><input id="dev" name="dev" type="text" class="input-mini" ></td>
							<td><font face="Arial"  size="3"><b>Developing an innovative idea</b></font></br>
							<font face="Arial"  size="3">
							<ul>
							<li>The team is dedicated to developing an innovative idea.</li>
							<li>The team builds a prototype, tested the ideas and iterated with improvements.</li>
							</ul>
							</font>
							</td>
							</tr>
							<tr>
							<td><input id="att" name="att" type="text" class="input-mini" ></td>
							<td><font face="Arial"  size="3"><b>Attention to quality and detail</b></font></br>
							<font face="Arial"  size="3">
							<ul>
							<li>The team's deliverables (software, documentation, support services, reports etc) were carefully prepared, useful and user friendly.</li>
							<li>Materials delivered are of high quality and appropriate to your needs.</li>
							</ul>
							</font>
							</td>
							</tr>
							<tr>
							<td><input id="overall" name="overall" type="text" class="input-mini" ></td>
							<td><font face="Arial"  size="3"><b>Overall usefulness of the idea</b></font></br>
							<font face="Arial"  size="3">
							<ul>
							<li>The team's project proves the concept of the innovative idea. This is a project that you would consider investing in</li>
							</ul>
							</br>
							<b>Current Status of the Application (Please Choose)</b>
							<table class="table table-bordered">
							<tr>
							<td><font face="Arial" size="2">Fully Deployed</font></td>
							<td><font face="Arial" size="2">To-Be Deployed</font></td>
							<td><font face="Arial" size="2">To-Be Developed</font></td>
							<td><font face="Arial" size="2">Proof of Concept</font></td>
							<td><font face="Arial" size="2">Aborted</font></td>
							</tr>
							<tr>
							<td><input type="radio" name="appStatus" id="dep" value="deployed"></td>
							<td><input type="radio" name="appStatus" id="tobedep" value="tobedeployed"></td>
							<td><input type="radio" name="appStatus" id="tobedev" value="tobedeveloped"></td>
							<td><input type="radio" name="appStatus" id="proof" value="proof"></td>
							<td><input type="radio" name="appStatus" id="aborted" value="aborted"></td>
							</tr>
							</table>
							</font>
							</td>
							</tr>
							<tr>
							<td><input id="overallScore" name="overallScore" type="text" class="input-mini" ></td>
							<td><font face="Arial"  size="3"><b>Overall Assessment</b></font></br>
							<font face="Arial"  size="3">
							<ul>
							<li>Overall, the team's final grade should be</li>
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
							<font face="Arial"  size="3"><b>How often do you meet with the team? (Please Choose)</b></font>
							<table class="table table-bordered">
							<tr>
							<td><font face="Arial" size="2">Daily</font></td>
							<td><font face="Arial" size="2">2-3 Times a Week</font></td>
							<td><font face="Arial" size="2">Once a Week</font></td>
							<td><font face="Arial" size="2">2-3 Times a Month</font></td>
							<td><font face="Arial" size="2">Once a Month</font></td>
							</tr>
							<tr>
							<td><input type="radio" name="often" id="often" value="daily"></td>
							<td><input type="radio" name="often" id="often" value="23timesw"></td>
							<td><input type="radio" name="often" id="often" value="weekly"></td>
							<td><input type="radio" name="often" id="often" value="23timesm"></td>
							<td><input type="radio" name="often" id="often" value="monthly"></td>
							</tr>
							</table>
							</tr>
							<tr>
							<td><font face="Arial"  size="3"><b>What is your main mode of meetings with Students? (Please Choose)</b></font>
							<table class="table table-bordered">
							<tr>
							<td><font face="Arial" size="2">Face to face</font></td>
							<td><font face="Arial" size="2">Voice Communication</font></td>
							<td><font face="Arial" size="2">Video Conferencing</font></td>
							</tr>
							<tr>
							<td><input type="radio" name="comm" id="comm" value="face"></td>
							<td><input type="radio" name="comm" id="comm" value="voice"></td>
							<td><input type="radio" name="comm" id="comm" value="weekly"></td>
							</tr>
							</table>
							</td>
							</tr>
							<tr>
							<td><font face="Arial"  size="3"><b>How much time do you and your colleagues spend on this Project? (Meetings, emails, providing&gathering requirements)</b></font></br><input id="hours" name="hours" type="text" class="input-mini">&nbsp;<font face="Arial" size="3">hours</font></td>
							</tr>
						   </table>
						</div>
						<legend><small>Misc</small></legend>
						
						<div class="feedback">
						   <font face="Arial" size="3" style="white-space:nowrap;"><b>Are there any factors that we should consider in assigning the team's final grade?</b></font>
						   </br></br>
						   <textarea id="factors" name="factors"></textarea>
						   </br>
						   </br>
						   <font face="Arial"  size="3" style="white-space:nowrap;"><b>Would you consider mentoring another project team next year?</b></font></br></br>
						   <font face="Arial" size="3">Yes</font>&nbsp;<input type="radio" name="another" id="another" value="yes">&nbsp;<font face="Arial" size="3">No</font>&nbsp;<input type="radio" name="another" id="another" value="no"></td>
						   </br>
						   </br>
						   <font face="Arial" size="3" style="white-space:nowrap;"><b>Please help us by telling us how we can improve the program to make this a better </br>experience for you or your organization.</b></font>
						   </br></br>
						   <textarea id="feedback" name="feedback"></textarea>
						</div>
						</br>
						<!-- Button -->
						<table>
							<tr></tr>
							<tr>
							<td class = "space" align = "justify">&nbsp;
						    <input type="submit" id="sponsorFeedback" value="Submit Feedback" class="btn btn-success" disabled="disabled">
						    </td>

						    </tr>
						</table> 
						</form>
					</div>
					<br/>
				</div>
	</body>
</html>