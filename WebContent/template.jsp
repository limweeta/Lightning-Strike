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
		String type = (String) session.getAttribute("type");
		if(type == null){
			type = "";
		}	
	
		UserDataManager um = new UserDataManager();
		String fullName = (String)session.getAttribute("fullname");
		String username = (String) session.getAttribute("username");
		User user = um.retrieve(username);
	%>
	</br>
			<% if(type.equalsIgnoreCase("admin")){ %>
			
				<%@ include file="navbaradmin.jsp" %>
			
			<%} else if(type==""){%>
				
				<%@ include file="navbarguest.jsp" %>
				
			<%} else if(type.equalsIgnoreCase("student")){%>
			
				<%@ include file="navbarstudent.jsp" %>
				
			<%} else if(type.equalsIgnoreCase("sponsor")){ %>
			
				<%@ include file="navbarsponsor.jsp" %>
				
			<%}else if(type.equalsIgnoreCase("supervisor")){%>
			
				<%@ include file="navbarsup.jsp" %>
				
			<%}else if(type.equalsIgnoreCase("faculty")){%>
			
			<%@ include file="navbarsup.jsp" %>
			
			<%} %>
</br>
  </head>

</html>