<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<style type="text/css">
	@import "./css/template.css";
</style>
<head>
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>  
	<%
		String fullName = (String)session.getAttribute("fullname");
		String username = (String) session.getAttribute("username");
	%>
	<div id="topbanner">
	<div class="headercontainer">
		<a href="./index.jsp">
		<!-- <img id="banner" src="http://db.tt/mjn0dKYe" alt="index"></a> -->
		<%
			if(fullName == null){
				fullName = "guest";
			}
		%>
		<table id="profile">
			<tr>
				<td><div id="welcome">Welcome, <%=fullName %></div></td><!-- 
				<td><a href="#"><img src="http://db.tt/YtzsJnpm" id="notifications" width="30" height="20" /></a></td>
				<td><a href="#"><img src="http://db.tt/Cfe7G4Z5" id="profilepic" width="50" height="50" /></a></td>	 -->
			   	<td></td> 
			   	<td></td>
		   	<%
			if(!fullName.equals("guest")){
			%>
		   		<td>
		   		</br>
		   		<form action="logout" method="post">
		   			<!-- <input type="submit" id="profilelogout" value="Logout"> -->
		   			<div class="control-group">
						  <div class="controls">
						   <!-- <button id="logout" name="logout" class="btn btn-danger">Logout</button><br /> -->
							&nbsp;&nbsp;<input type="submit" id="logout" value="Logout" class="btn btn-danger">
						  </div>
					</div>
		   		</form>
		   		</td>
		   		<td>&nbsp;&nbsp;&nbsp;</td>
		   	<%
			}
			%>
			</tr> 
	   	</table>
	</div>	
	</div>
	</br>
		<%if(!fullName.equals("guest")){ %>
		<div class="navcontainer">
			<%@include file="navbar3.jsp"%>
		</div>
		 	<%
			}else{
		%>
			<div class="navcontainer">
			<%@include file="navbar2.jsp"%>
			</div>
		<%
			}
		%></br>
  </head>

</html>