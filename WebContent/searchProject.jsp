<html>
	<head>

	</head>
	<body>
		<div id="content-container" class="shadow">
			<div id="content">
				<div class="searchteam">
					<form name="searchteam" id="searchteam" action="/searchProjects">
						<fieldset class="login-fieldset">
							<div class="field-container">
								<label for="projectName" >Project Name:</label>
								<input type="text" class="right rounded" name="projectName" id="projectName"/>
									  <select name="year" id = "year">
									        <option value="0">Year:</option>
									        <option value="1">All</option>									        
									        <option value="2">2013</option>
									        <option value="3">2012</option>
									        <option value="4">2011</option>

									   </select>	
									   <select name="term" id = "term">
									        <option value="0">Term:</option>
									    	<option value="1">All</option>
									        <option value="1">1</option>
									        <option value="2">1A</option>
									        <option value="3">2</option>
									        <option value="4">2A</option>

									   </select>
									   <select name="industrytype" id = "industrytype">
									        <option value="0">Industry Type:</option>
									        <option value="1">Banking</option>
									        <option value="2">Information Technology</option>
									        <option value="2">Supply Chain</option>

									   </select>									   <br>								
							</div>
							<br/>
						</fieldset>
					</form>
					<br/>
					<input type="submit" id="searchbutton" name="searchbutton" value="Search"/>
				</div>
			</div>
		</div>
	</body>
</html>