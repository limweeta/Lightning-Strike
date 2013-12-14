<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
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
						  <label class="control-label" for="sponsorname">Sponsor Name</label>
						  <div class="controls">
						    <input id="sponsorname" name="sponsorname" type="text" placeholder="Sponsor Name" class="input-large" >
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
							<td><input id="tech" name="tech" type="text" class="input-mini" ></td>
							<td><font face="Arial"  size="3"><b>Technical Knowledge</b></font></br>
							<font face="Arial"  size="3">
							<ul>
							<li>Sponsor is able to provide technical information needed for your project (e.g. Server configuration)</li>
							</ul>
							</font>
							</td>
							</tr>
							<tr>
							<td><input id="dom" name="dom" type="text" class="input-mini" ></td>
							<td><font face="Arial"  size="3"><b>Domain Knowledge</b></font></br>
							<font face="Arial"  size="3">
							<ul>
							<li>Sponsor is able to share domain knowledge about the industry (e.g. Best practices)</li>
							</ul>
							</font>
							</td>
							</tr>
							<tr>
							<td><input id="proj" name="proj" type="text" class="input-mini" ></td>
							<td><font face="Arial"  size="3"><b>Project Knowledge</b></font></br>
							<font face="Arial"  size="3">
							<ul>
							<li>Sponsor is able to share the specific needs of the project (e.g. Current business process)</li>
							</ul>
							</font>
							</td>
							</tr>
							<tr>
							<td><input id="com" name="com" type="text" class="input-mini" ></td>
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
							<td><input type="radio" name="often" id="often" value="daily"></td>
							<td><input type="radio" name="often" id="often" value="23timesw"></td>
							<td><input type="radio" name="often" id="often" value="weekly"></td>
							<td><input type="radio" name="often" id="often" value="23timesm"></td>
							<td><input type="radio" name="often" id="often" value="monthly"></td>
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
							<td><input type="radio" name="comm" id="comm" value="face"></td>
							<td><input type="radio" name="comm" id="comm" value="voice"></td>
							<td><input type="radio" name="comm" id="comm" value="weekly"></td>
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
						    <input type="submit" id="teamSponsorFeedback" value="Submit Feedback" class="btn btn-success" disabled="disabled">
						    </td>

						    </tr>
						</table> 
						</form>
					</div>
					<br/>
				</div>
	</body>
</html>