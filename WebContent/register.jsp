<html>
	<head>
		<title>SMU480 Matching System</title>
	</head>
	<body>	
	<div id="content-container" class="shadow">
			<div id="content">
				<div class="login-area">
					<form name="loginFrm" id="loginFrm" action="register">
						<fieldset class="login-fieldset">
							<div class="field-container">
								<label for="userName" >Username:</label>
								<input type="text" class="right rounded" name="userName" id="userName"/>
							</div>
							<div class="field-container">
								<label for='fullName' >Full Name:</label>
								<input type="text" class="right rounded" name="fullName" id="fullName" />
							</div>
							<div class="field-container">
								<label for='contactNum' >Contact Number:</label>
								<input type="text" class="right rounded" name="contactNum" id="contactNum" />
							</div>
							<div class="field-container">
								<label for='email' >Email:</label>
								<input type="text" class="right rounded" name="email" id="email" />
							</div>
							<div class="field-container">
								<label for='coyName' >Company Name:</label>
								<input type="text" class="right rounded" name="coyName" id="coyName" />
							</div>
							<div class="field-container">
								<label for='coyName' >Company Address:</label>
								<input type="text" class="right rounded" name="coyAdd" id="coyAdd" />
							</div>
							<div class="field-container">
								<label for='coyName' >Company Contact:</label>
								<input type="text" class="right rounded" name="coyContact" id="coyContact" />
							</div>
							<div class="field-container">
								<input type="hidden" class="right rounded" name="type" id="type" value="sponsor" />
							</div>
							<div class="field-container">
								<label for='password' >Password:</label>
								<input type="password" class="right rounded" name="password" id="password" />
							</div>
							<div id="loginError" class="error"></div><br/>
							<input type="submit" id="register" name="register" value="Register"/>
							<br/>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>