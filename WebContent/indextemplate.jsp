<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<style type="text/css">
	@import "./css/indextemplate.css";
</style>
<head>
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>  
<!--     <script type="text/javascript">
		// Popup window code
		function newPopup(url) {
			popupWindow = window.open(
				url,'popUpWindow','height=250,width=250,left=10,top=10,resizable=no,scrollbars=no,toolbar=no,menubar=no,location=no,directories=no,status=yes')
		}
	</script> -->
	<%
		String fullName = (String)session.getAttribute("fullname");
		String username = (String) session.getAttribute("username");
	%>
	<div id="topbanner">
	<div class="headercontainer">
		<a href="./index.jsp">
		<img id="banner" src="http://db.tt/mjn0dKYe" alt="index"></a>
		<table id="profile">
		<tr>
		<td></td></tr>
		   	<tr>
		   	<td></td>
		   	<%
		   	if (username == null){
		   	%>
		   	<td><a onclick="document.location.href='http://elearntools.smu.edu.sg/Tools/SSO/login.ashx?id=IS480MSvm';" id="ssologin">SSO Login</a></td>
		   	<td><a href="./login.jsp" id="login">Login</a></td>
		   	<%
		   	}else{
		   	%>
		   	<!-- put profile picture here -->
		   	<%
		   	}
		   	%>
		   	</tr>
	   	</table>
	</div>	
	</div>
	<div class="navcontainer">
		<%@include file="indexnavbar.jsp"%>
	</div></br></br>
  </head>
<body>
 
</br></br></br>
	
</body>
</html>