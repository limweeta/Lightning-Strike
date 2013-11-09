<html>
<head>
<link rel="stylesheet" href="./css/bootstrap.css"/>
	
	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<script src="./js/bootstrap.js"></script>

</head>

<style type="text/css">
a:hover,
a:focus {
  color: #005580;
  text-decoration: none;
}
.div{
	display: block;
}
html, body {
background-color: #eeeeee;
}
.container {
width: 600px !important;
}

.space-container {
height: 100px;
}
.container > .content {
text-align: center;
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
<body>
<div class="navbar navbar-inverse navbar-fixed-top">
	<div class="navbar-inner">
	<div class="container">
	</div>
	</div>
</div>
<div class="space-container">
</div>
<div class="container">
	<div class="content">
		<div>
			<a href="./index.jsp"><img src="https://db.tt/XeqJvapD" style="height:150px; width:450px; display: inline-block;"></a>
		</div>
		<div class="row">
			<h1>IS480 Matching System</h1>
			
							<a href="http://elearntools.smu.edu.sg/Tools/SSO/login.ashx?id=IS480MSvm">
							<button type="button" id="SSO" class="btn btn-primary">Single Sign On</button>
							</a>
			
		   		
							  <a href="#myModal" data-toggle="modal">
							  <button type="button" id="external" class="btn btn-primary">External Sign In</button>&nbsp;&nbsp;
							  </a>
						 
<!-- 					<a href="#myModal" role="button" class="btn btn-large btn-primary" data-toggle="modal">Launch Demo Modal</a> -->
					<!-- Modal HTML -->
					<div id="myModal" class="modal hide fade">
					    <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					        <h3>Sign In</h3>
					    </div>
					       <form action="authenticate" method="post" onsubmit = "return validateSignInOnSubmit(this)" accept-charset="UTF-8">
					    <div class="modal-body">
					     	  <input type="text" name="userName" id="user_username" style="margin-bottom: 20px; height:30px;" type="text" name="user[username]" placeholder="Username" size="45" />
							  <input type="password" name="password" id="user_password" style="margin-bottom: 20px; height:30px;" type="password" name="user[password]" placeholder="Password" size="45" />
					    </div>
					    <div class="modal-footer">
					        <input class="btn btn-primary" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="commit" value="Sign In" />
					    </div>
					   	 </form>
					</div>
		</div>
	</div>
</div>
</body>
</html>