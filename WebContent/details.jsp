<html>
<style type="text/css">
#welcome {
	font-size: 15px;
	font-family: Courier;
}

#profilepic {
	position: fixed;
	top: 15px;
	right: 15px;
}

#profilelogout {
	position: fixed;
	top: 80px;
	right: 20px;
}

#notifications {
	position: fixed;
	top: 15px;
	right: 80px;
}

nav ul ul {
	display: none;
}

nav ul li:hover>ul {
	display: block;
}

nav ul {
	background: #efefef;
	background: linear-gradient(top, #efefef 0%, #bbbbbb 100%);
	background: -moz-linear-gradient(top, #efefef 0%, #bbbbbb 100%);
	background: -webkit-linear-gradient(top, #efefef 0%, #bbbbbb 100%);
	box-shadow: 0px 0px 9px rgba(0, 0, 0, 0.15);
	padding: 0 20px;
	border-radius: 10px;
	list-style: none;
	position: relative;
	display: inline-table;
}

nav ul:after {
	content: "";
	clear: both;
	display: block;
}

nav ul li {
	float: left;
}

nav ul li:hover {
	background: #4b545f;
	background: linear-gradient(top, #4f5964 0%, #5f6975 40%);
	background: -moz-linear-gradient(top, #4f5964 0%, #5f6975 40%);
	background: -webkit-linear-gradient(top, #4f5964 0%, #5f6975 40%);
}

nav ul li:hover a {
	color: #fff;
}

nav ul li a {
	display: block;
	padding: 10px 30px;
	color: #757575;
	text-decoration: none;
}

nav ul ul {
	background: #5f6975;
	border-radius: 0px;
	padding: 0px;
	position: absolute;
	top: 100%;
}

nav ul ul li {
	float: none;
	border-top: 1px solid #6b727c;
	border-bottom: 1px solid #575f6a;
	position: relative;
}

nav ul ul li a {
	padding: 10px 30px;
	color: #fff;
}

nav ul ul li a:hover {
	background: #4b545f;
}

h1 {
	font-family: Impact;
	font-size: 1.75em;
}

#teamName {
	width: 49.8em;
	font-size: 1em;
}

#createTeam {
	font-size: 1em;
}

#teamLimit {
	width: 5em;
}
</style>
<head>
<%
	String fullName = (String) session.getAttribute("fullname");
	String username = (String) session.getAttribute("username");
	String type = (String) session.getAttribute("type");
%>
<div id="welcome">
	Welcome,
	<%=fullName%></div>
<div id="profilepic">
	<a href="#"><img src="http://db.tt/Cfe7G4Z5" width="50" height="50" /></a>
</div>
<div id="profilelogout">
	<a href="./index.jsp">Logout</a>
</div>
<div id="notifications">
	<a href="#"><img src="http://db.tt/YtzsJnpm" width="30" height="20" /></a>
</div>
</head>
<body>
	<nav>
		<ul>
			<li><a href="#">Projects</a>
				<ul>
					<li><a href="#">Search</a></li>
					<li><a href="./createProject.jsp">Create</a></li></li>
		</ul>
		<li><a href="#">Teams</a>
			<ul>
				<li><a href="./searchTeam.jsp">Search</a></li>
				<li><a href="./createTeam.jsp">Create</a></li></li>
		</ul>
		</li>
		<li><a href="#">Users</a>
			<ul>
				<li><a href="./searchUser.jsp">Search</a></li>
			</ul></li>
		<li><a href="#">Schedule</a></li>
		<li><a href="#">Analytics</a></li>
		</ul>
	</nav>
	</br>
	</br>
	</br>
	<div id="content-container" class="shadow">
		<div id="content">
			<div class="updateProfile">
				<form action="updateProfile" method="post">
					<font size="4" face="Courier">Username:</font> <input type="text"
						id="username" name="username" value="<%=username%>"><br />
					<font size="4" face="Courier">Full Name:</font> <input
						id="fullName" type="text" name="fullName"></br>
					</br> <font size="4" face="Courier">Contact Number:</font> <input
						id="contactNum" type="text" name="contactNum"></br> <font
						size="4" face="Courier">Email:</font> <input id="email"
						type="text" name="email"></br> </br> <font size="4" face="Courier">Type:</font>
					<input type="text" id="type" name="type" value="<%=type%>"><br />
					<font size="4" face="Courier">Second Major:</font> <input
						type="text" id="secondMajor" id="secondMajor" name="secondMajor">
					<input type="hidden" id="role" name="role" value="role"> <input
						type="hidden" id="team_id" name="team_id" value="team_id">
					</br>
					</br> <input type="submit" id="updateProfile" name="updateProfile"
						value="Update Profile" />
				</form>
				<br />
			</div>
		</div>
	</div>
</body>
</html>
a
