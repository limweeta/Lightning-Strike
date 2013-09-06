<html>
<style type="text/css" title="currentStyle"> 	
	nav ul ul {
		display: none;
	}
	nav ul li:hover > ul {
		display: block;
	}
   	nav ul {
		background: #efefef; 
		background: linear-gradient(top, #efefef 0%, #bbbbbb 100%);  
		background: -moz-linear-gradient(top, #efefef 0%, #bbbbbb 100%); 
		background: -webkit-linear-gradient(top, #efefef 0%,#bbbbbb 100%); 
		box-shadow: 0px 0px 9px rgba(0,0,0,0.15);
		padding: 0 30px;
		border-radius: 10px;  
		list-style: none;
		position: relative;
		display: inline-table;
	}
	nav ul:after {
		content: ""; clear: both; display: block;
	}
   	nav ul li {
		float: left;
	}
	nav ul li:hover {
		background: #C0C0C0;
		background: linear-gradient(top, #C0C0C0 0%, #9AA6B5 40%);
		background: -moz-linear-gradient(top, #C0C0C0 0%, #9AA6B5 40%);
		background: -webkit-linear-gradient(top, #C0C0C0 0%,#9AA6B5 40%);
	}
	nav ul li:hover a {
		color: #fff;
	}
	nav ul li a {
		display: block; padding: 10px 30px;
		color: #757575; text-decoration: none;
	}
	nav ul ul {
		background: #C0C0C0; border-radius: 0px; padding: 0px;
		position: absolute; top: 100%;
	}
	nav ul ul li {
		float: none; 
		border-top: 1px solid #C0C0C0;
		border-bottom: 1px solid #C0C0C0;
		position: relative;
	}
	nav ul ul li a {
		padding: 10px 35px;
		color: #fff;
	}	
	nav ul ul li a:hover {
		background: #7B899A;
	}
	a{
		font-family: Impact;
		font-size: 20px;
	}
</style>

<nav>
	<ul>
		<li><a href="#">Projects</a>
			<ul>
				<li><a href="./searchProjects.jsp">Search</a></li>
				<li><a href="./createProject.jsp">Create</a></li>
		</li>
			</ul>
		<li><a href="#">Teams</a>
			<ul>
				<li><a href="./searchTeam.jsp">Search</a></li>
				<li><a href="./createTeam.jsp">Create</a></li>
		</li>
			</ul>
		</li>
		<li><a href="#">Users</a>
			<ul>
				<li><a href="./searchUser.jsp">Search</a></li>
			</ul>
		</li>
		<li><a href="#">Schedule</a></li>
		<li><a href="#">Analytics</a></li>
	</ul>
</nav>
</html>