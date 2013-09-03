<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<style type='text/css'>
#header{
    font-family:"Impact";
    font-size: 40px;
    left: 75%;
    top: 5%;
    position: absolute; 
}

#pic{
	width: 300px;
    height: 150px;
}

#div-1{
	font-family:"Impact";
	font-size: 40px;
	right:5%;
	top:5%;
	position: absolute;
}

#div-1a{
	 position:relative;
	 left:75%;
	 top:50%;
}

#div-1b{
	 position:relative;
	 left:82%;
	 top:10%;
}

#div-1c{
	 position:relative;
	 left:90%;
	 top:10%;
}
</style>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="style.css">
    <script src="script.js"></script>
    <img src="http://db.tt/r4taMQoX" id="pic"/>
</head>
<body>
<div id="div-1">SIS IS480 System</div>
	<script type="text/javascript">
		// Popup window code
		function newPopup(url) {
			popupWindow = window.open(
				url,'popUpWindow','height=250,width=250,left=10,top=10,resizable=no,scrollbars=no,toolbar=no,menubar=no,location=no,directories=no,status=yes')
		}
	</script>
	
				<div id="div-1a">
					<div class="login-area">
						<div id="loginError" class="error"></div><br/>
						<input type="button" id="loginBtn" name="loginBtn" value="SSO Login" onclick="document.location.href='http://elearntools.smu.edu.sg/Tools/SSO/login.ashx?id=IS480MSvm';"/>
					</div>
				</div>
			
			
	
				<div id="div-1b">
					<div class="login-area">
						<div id="loginError" class="error"></div><br/>
						<input type="button" id="loginBtn" name="loginBtn" value="Normal Login" onclick="JavaScript:newPopup('./login.jsp');"/>
					</div>
				</div>
			
			<div class="design_box">
    <div data-role="header" data-theme="b">
        <h1>Announcements</h1>
    </div>
    <div id="updates">
       <iframe src="http://" style="border:1px #000000 solid;" name="updates" scrolling="yes" frameborder="1" marginheight="1000px" marginwidth="1000px" height="600px" width="1000px"></iframe>
    </div>
    <div data-role="footer" class="ui-bar" data-theme="b">
    </div>
	</div>
</body>
</html>