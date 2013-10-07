<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<style type="text/css">
	@import "./css/template.css";
	#username{
		position:absolute;
		left:20%;
		top:55%;
	}
	#email{
		position:absolute;
		left:40%;
		top:55%;
	}
	#contactno{
		position:absolute;
		left:20%;
		top:63%;
	}
</style>
<head>
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>  
	<%
		String fullName = (String)session.getAttribute("fullname");
		String username = (String) session.getAttribute("username");
		String id=(String)session.getAttribute("profileid");
		int iD = Integer.parseInt(id);
		SponsorDataManager sdm = new SponsorDataManager();
		Sponsor sponsor= sdm.retrieve(iD);
	%>
<div id="topbanner">
	<div class="headercontainer">
		<%
			if(fullName == null){
				fullName = "guest";
			}
		%>
		<table id="profile">
			<tr>
				<td><div id="welcome">Welcome, <%=fullName %></div></td>
				<td><a href="#"><img src="http://db.tt/YtzsJnpm" id="notifications" width="30" height="20" /></a></td>
				<td><a href="#"><img src="http://db.tt/Cfe7G4Z5" id="profilepic" width="50" height="50" /></a></td>	
		   	</tr>
		   	<tr> 
			   	<td></td> 
			   	<td></td>
		   	<%
			if(!fullName.equals("guest")){
			%>
		   		<td>
		   		<form action="logout" method="post">
		   			<input type="submit" id="profilelogout" value="Logout">
		   		</form>
		   		</td>
		   	<%
			}
			%>
			   	
			</tr> 
			<tr>
		   	<td></td>
		   	<td></td>
		   	
		   	</tr>
	   	</table>
	</div>	
	</div>
	<div class="navcontainer">
		<%@include file="navbar2.jsp"%>
	</div></br></br></br>
  </head>
<body>
<%
CompanyDataManager cdm = new CompanyDataManager();
%>
 	<form id="userprofile">
	<input type="text" id="username" value="<%=sponsor.getFullName()%>">
	<input type="text" id="contactno" value="<%=sponsor.getContactNum()%>"> 
	<input type="text" id="email" value="<%=sponsor.getEmail()%>">
	<font size="4" face="Courier">Company:</font></br>
	<input type="text" id="companyname" value="<%=cdm.retrieve(sponsor.getCoyId()).getCoyName()%>"></br>
	</br>
	</form> 
</body>
</html>