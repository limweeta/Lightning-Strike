<html>
<head>
    <script src="script.js"></script>
    <%@ include file="template.jsp" %>
</head>
<body>
<div class="container">
 
<!-------->
<div id="content">
    <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
        <li class="active"><a href="#red" data-toggle="tab">Assign Reviewer</a></li>
        <li><a href="#orange" data-toggle="tab">Assign Supervisor</a></li>
        <li><a href="#yellow" data-toggle="tab">Suspend User</a></li>
    </ul>
    <div id="my-tab-content" class="tab-content">
        <div class="tab-pane active" id="red">
            <h1>Assign Reviewers</h1>
           		<div class="span9 well">
					<div class="row">
					<form action="assignReviewer" method="post" class="form-horizontal">
						<fieldset>
						
						<!-- Form Name -->
						<legend>Assign Reviewers</legend>
					
						<div class="span8">
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="teamId">Team ID</label>
						  <div class="controls">
						    <input id="teamId" name="teamId" type="text" class="input-large">
						  </div>
						</div>
						<!-- </div></br> --></br>
						<!-- <div class="span3"> -->
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="projId">Project ID</label>
						  <div class="controls">
						    <input id="projId" name="projId" type="text" class="input-large">
						  </div>
						</div>
						<!-- </div> --></br>
						<!-- <div class="span4"> -->
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="assignRev1">Reviewer 1</label>
						  <div class="controls">
						    <input id="assignRev1" name="assignRev1" type="text" class="input-large">
						  </div>
						</div>
						<!-- </div> --></br>
						<!-- <div class="span5"> -->
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="assignRev2">Reviewer 2</label>
						  <div class="controls">
						    <input id="assignRev2" name="assignRev2" type="text" class="input-large">
						  </div>
						</div></br>
						<!-- <div class="span7"> -->
						<!-- Button -->
						<div class="control-group">
						  <div class="controls">
						    <button id="assignReviewer" name="assignReviewer" class="btn btn-success">Assign</button>
						  </div>
						</div>
						</div></br>
						</fieldset>
					</form>
					</div>
					</div>
        </div>
        <div class="tab-pane active" id="orange">
            <h1>Assign Supervisor</h1>
            <div class="span9 well">
					<div class="row">
					<form action="assignSupervisor" method="post" class="form-horizontal">
						<fieldset>
						
						<!-- Form Name -->
						<legend>Assign Supervisor</legend>
					
						<div class="span8">
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="teamId">Team ID</label>
						  <div class="controls">
						    <input id="teamId" name="teamId" type="text" class="input-large">
						  </div>
						</div>
						<!-- </div></br> --></br>
						<!-- <div class="span3"> -->
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="projId">Project ID</label>
						  <div class="controls">
						    <input id="projId" name="projId" type="text" class="input-large">
						  </div>
						</div>
						<!-- </div> --></br>
						<!-- <div class="span4"> -->
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="assignSup">Supervisor</label>
						  <div class="controls">
						    <input id="assignRev1" name="assignRev1" type="text" class="input-large">
						  </div>
						</div>
						<!-- </div> --></br>
						<!-- Button -->
						<div class="control-group">
						  <div class="controls">
						    <button id="assignReviewer" name="assignReviewer" class="btn btn-success">Assign</button>
						  </div>
						</div>
						</div></br>
						</fieldset>
					</form>
					</div>
					</div>
            
        </div>
        <div class="tab-pane" id="yellow">
            <h1>Suspend User</h1>
            <div class="span9 well">
					<div class="row">
					<form action="#" method="post" class="form-horizontal">
						<fieldset>
						
						<!-- Form Name -->
						<legend>Suspend User</legend>
					
						<div class="span8">
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="userName">User Name</label>
						  <div class="controls">
						    <input id="userName" name="userName" type="text" class="input-large">
						  </div>
						</div>
						<!-- Button -->
						<div class="control-group">
						  <div class="controls">
						    <button id="suspendUser" name="suspendUser" class="btn btn-warning">Suspend</button>
						  </div>
						</div>
						</div></br>
						</fieldset>
					</form>
					</div>
					</div>
        </div>
    </div>
</div>
 
 
<script type="text/javascript">
    jQuery(document).ready(function ($) {
        $('#tabs').tab();
    });
</script>    
</div> <!-- container -->
 
 
<script type="text/javascript" src="./js/bootstrap.js"></script>
</body>
</html>