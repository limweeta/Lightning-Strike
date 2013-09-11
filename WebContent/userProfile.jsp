<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<style type="text/css">
	h1{
		font-family:"Courier";
		font-weight: bold;
		font-size:20px;
	}

</style>
<head>	
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>  
	<%@ include file="template.jsp" %>
</head>
<body>
 
</br></br></br>
	<div id="profilepic2"><a href="./ViewProfile.html"><img src="http://db.tt/Cfe7G4Z5" width="100" height="100" /></a></div>
	<a href="#">Edit Profile Picture</a>
	</br></br></br>
	<%
	int profileid = 0;
	
	try{
		profileid = Integer.parseInt(request.getParameter("id"));
	}catch(Exception e){
		response.sendRedirect("searchUser.jsp");
	}
	
	UserDataManager udm = new UserDataManager();
	User u = udm.retrieve(profileid);
	String userType = u.getType();
	//In case of Sponsor
	SponsorDataManager sponsordm = new SponsorDataManager();
	CompanyDataManager cdm = new CompanyDataManager();
	
	//For student
	StudentDataManager sdm = new StudentDataManager();
	Student student = sdm.retrieve(profileid);
	
	TeamDataManager tdm = new TeamDataManager();
	
	ProjectDataManager pdm = new ProjectDataManager();
	
	%>
	<div class="container" id="userdetails">
	<%-- <% if(userType.equals("Student")){%>
			<%@include file="studentprofiletemplate.jsp" %>	
	<%}else if(userType.equals("Sponsor")){%>
			<%@include file="sponsorprofiletemplate.jsp" %>
	<%}else{%>
			<%@include file="userprofiletemplate.jsp" %>
	<%}
	%> --%>
	<form id="userprofile">
	<font size="4" face="Courier">Name:</font>
	<input type="text" id="username" value="<%=u.getFullName()%>"></br>
	<font size="4" face="Courier">Contact Number:</font>
	<input type="text" id="contactno" value="<%=u.getContactNum()%>"></br>
	<font size="4" face="Courier">Email:</font>
	<input type="text" id="email" value="<%=u.getEmail()%>"></br>
	<h1>About Me:</h1>
	<!-- if user is a student -->
	<%if(userType.equals("Student")){%>
	<font size="4" face="Courier">Second Major:</font></br>
	<input type="text" id="email" value="<%=student.getSecondMajor()%>">
	</br>
	<%} %>
	</form>
	</div>
</body>
</html>