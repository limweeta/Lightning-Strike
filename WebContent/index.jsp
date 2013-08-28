<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div id="content-container" class="shadow">
				<div id="content">
					<div class="login-area">
						<div id="loginError" class="error"></div><br/>
						<input type="button" id="loginBtn" name="loginBtn" value="SSO Login" onclick="document.location.href='http://elearntools.smu.edu.sg/Tools/SSO/login.ashx?id=IS480PSAS'"/>
					</div>
				</div>
			</div>
			
	<div id="content-container" class="shadow">
				<div id="content">
					<div class="login-area">
						<div id="loginError" class="error"></div><br/>
						<input type="button" id="loginBtn" name="loginBtn" value="Normal Login" onclick="document.location.href='login.jsp'"/>
					</div>
				</div>
			</div>
</body>
</html>