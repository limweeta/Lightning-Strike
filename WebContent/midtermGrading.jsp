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
					<form class="form-horizontal" method="post" name="midGrading">

						<!-- Form Name -->
						<legend>FYP Midterm Grading</legend>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="teamname">Team Name</label>
						  <div class="controls">
						    <input id="teamname" name="teamname" type="text" placeholder="Team Name" class="input-large" >
						    
						 </div>
 						</div>
						<div class="control-group">
						  <label class="control-label" for="reviewer">Reviewer</label>
						  <div class="controls">
						    <input id="reviewer" name="reviewer" type="text" placeholder="Reviewer" class="input-large" >
						    
						 </div>
						</div>
						<legend><small>Project Management</small><input id="pmscore" name="pmscore" placeholder="/30" type="text" style="float:right" class="input-mini"></legend>
						
						<div class="feedback">
						   <font face="Arial" size="3">Evidence of proper project management</font>
						    <input id="evidence" name="evidence" type="text" style="float:right" placeholder="/15"class="input-mini" >
							</br></br>
							
						   <font face="Arial" size="3">Stakeholder management</font>
						    <input id="stakeholder" name="stakeholder" type="text" style="float:right" placeholder="/10"class="input-mini" >
							</br></br>
							
						   <font face="Arial" size="3">Scope/Risk management</font>
						    <input id="scope" name="scope" type="text" style="float:right" placeholder="/5"class="input-mini" >
						
						</div>
						
						<legend><small>Product Quality</small><input id="pqscore" name="pqscore" placeholder="/50" type="text" style="float:right" class="input-mini"></legend>
						
						<div class="feedback">
						   <font face="Arial" size="3">Technical complexity and Quality attributes(Design)</font>
						    <input id="design" name="design" type="text" style="float:right" placeholder="/20"class="input-mini" >
							</br></br>
					
						   <font face="Arial" size="3">User Testing</font>
						    <input id="usert" name="usert" type="text" style="float:right" placeholder="/10"class="input-mini" >
							</br></br>
					
						   <font face="Arial" size="3">Demo and deployment</font>
						    <input id="stakeholder" name="stakeholder" type="text" style="float:right" placeholder="/20"class="input-mini" >

						</div>
						<legend><small>Discretionary</small><input id="dscore" name="dscore" placeholder="/20" type="text" style="float:right" class="input-mini"></legend>
						
						<div class="feedback">
						   <font face="Arial" size="3">Presentation</font>
						    <input id="pres" name="pres" type="text" style="float:right" placeholder="/10"class="input-mini" >
							</br></br>
					
						   <font face="Arial" size="3">X Factor & Team effort</font>
						    <input id="xfactor" name="xfactor" type="text" style="float:right" placeholder="/5"class="input-mini" >
							</br></br>
					
						   <font face="Arial" size="3">Learning</font>
						    <input id="learning" name="learning" type="text" style="float:right" placeholder="/5"class="input-mini" >

						</div>
						
						<legend><small>Sponsor Evaluation (Supervisor's Section)</small><input id="dscore" name="dscore" placeholder="/grade" type="text" style="float:right" class="input-mini"></legend>
						
						<div class="feedback">
						   <font face="Arial" size="3">Sponsor's evaluation team grade</font>
						    <input id="sponsor" name="sponsor" type="text" style="float:right" class="input-mini" >
						</div>
						</br>
						<!-- Button -->
						<table>
							<tr></tr>
							<tr>
							<td class = "space" align = "justify">&nbsp;
						    <input type="submit" id="finalGrading" value="Grade Team" class="btn btn-success" disabled="disabled">
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