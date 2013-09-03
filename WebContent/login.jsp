<html>
	<head>
		<title>SMU480 Matching System</title>
	</head>
	<body>	
	<div id="content-container" class="shadow">
			<div id="content">
				<div class="login-area">
					<form name="loginFrm" id="loginFrm" action="authenticate">
						<fieldset class="login-fieldset">
							<legend>Enter your SMU email and password:</legend>
							<div class="field-container">
								<label for="userName" >Username:</label>
								<input type="text" class="right rounded" name="userName" id="userName"/>
							</div>
							<div class="field-container">
								<label for='password' >Password:</label>
								<input type="password" class="right rounded" name="password" id="password" />
							</div>
							<div id="loginError" class="error"></div><br/>
							<input type="submit" id="loginBtn" name="loginBtn" value="Sign me in"/>
							<br/>
						</fieldset>
					</form>
					<a href="./register.jsp">Need to register?</a>
				</div>
			</div>
		</div>
	</body>
</html>