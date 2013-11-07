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
		<div id="content-container">
			<div id="content">
				<div class="span10 well">
				<div class="span8">
					<form class="form-horizontal" method="post" name="teamFeedback">

						<!-- Form Name -->
						<legend>Team Feedback</legend>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="name">Name</label>
						  <div class="controls">
						    <input id="name" name="name" type="text" placeholder="Name" class="input-large" >
						 </div>
 						</div>
 						<div class="control-group">
						  <label class="control-label" for="team">Team #</label>
						  <div class="controls">
						    <input id="team" name="team" type="text" placeholder="Team #" class="input-large" >
						 </div>
 						</div>
 						<div class="control-group">
						  <label class="control-label" for="team">Date</label>
						  <div class="controls">
						    <input id="date" name="date" type="text" placeholder="Date(DDMMYYYY)" class="input-large" >
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
							<tr>
							<td><font face="Arial" size="3"><b>Name of member</b></font></td>
							<td><font face="Arial" size="3"><b>Rating(0-8)</b></font></td>
							<td><font face="Arial" size="3"><b>Comments </b></font></td>
							</tr>
							<tr>
							<td><input id="member1" name="member1" type="text" placeholder="Member's Name" class="input-large" ></td>
							<td> <input id="rating1" name="rating1" type="text" class="input-mini" ></td>
							<td><textarea name="comments1" id="comments1"></textarea></td>
							</tr>
							<tr>
							<td><input id="member2" name="member2" type="text" placeholder="Member's Name" class="input-large" ></td>
							<td> <input id="rating2" name="rating2" type="text" class="input-mini" ></td>
							<td><textarea name="comments2" id="comments2"></textarea></td>
							</tr>
							<tr>
							<td><input id="member3" name="member3" type="text" placeholder="Member's Name" class="input-large" ></td>
							<td> <input id="rating3" name="rating3" type="text" class="input-mini" ></td>
							<td><textarea name="comments3" id="comments3"></textarea></td>
							</tr>
							<tr>
							<td><input id="member4" name="member4" type="text" placeholder="Member's Name" class="input-large" ></td>
							<td> <input id="rating4" name="rating4" type="text" class="input-mini" ></td>
							<td><textarea name="comments4" id="comments4"></textarea></td>
							</tr>
							<tr>
							<td><input id="member5" name="member5" type="text" placeholder="Member's Name" class="input-large" ></td>
							<td> <input id="rating5" name="rating5" type="text" class="input-mini" ></td>
							<td><textarea name="comments5" id="comments5"></textarea></td>
							</tr>
							<tr>
							<td><input id="member6" name="member6" type="text" placeholder="Member's Name" class="input-large" ></td>
							<td> <input id="rating6" name="rating6" type="text" class="input-mini" ></td>
							<td><textarea name="comments6" id="comments6"></textarea></td>
							</tr>
							</table>
						</div>
						</br>
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
					<br/>
				</div>
			</div>
		</div>
	</body>
</html>