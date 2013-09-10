<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>

<style type="text/css">
	#smulogo{
	width: 600px;
    height: 200px;
	}
   	#welcome{
   		font-size: 15px;
   		font-family:Courier;
   	}
   	#profilepic{
      	position:fixed;
    	top:15px;
    	right:15px;
   	}
   	#profilelogout{
   		position:fixed;
   		top:80px;
   		right:20px;
   	}
   	#notifications{
    	position:fixed;
    	top:15px;
    	right:80px;
   	}
	h1{
		font-family:Impact;
		font-size:1.75em;
	}
	#teamName{
		width:49.8em;
		font-size:1em;
	}
	#createTeam{
		font-size:1em;
	}
	#teamLimit{
		width:5em;
	}
	textarea{
		resize: none;
	}
</style>
	<head>
	<img src="http://db.tt/mjn0dKYe" id="smulogo"/>
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script>  
    
	<% 	
		String fullName = (String)session.getAttribute("fullname");
		String username = (String) session.getAttribute("username");
		
		
	%>
		
	<div id="welcome">Welcome, <%=fullName %></div>
		
		<%@include file="navbar.jsp"%>
	    <div id="profilepic"><a href="#"><img src="http://db.tt/Cfe7G4Z5" width="50" height="50" /></a></div>
	    <div id="profilelogout"><a href="./index.jsp">Logout</a></div>
	    <div id="notifications"><a href="#"><img src="http://db.tt/YtzsJnpm" width="30" height="20" /></a></div>
	</head>
	<body>
	<%
	int reqId = Integer.parseInt(request.getParameter("id"));
	
	TeamDataManager tdm = new TeamDataManager();
	ArrayList<Team> teams = tdm.retrieveAll();
	UserDataManager udm = new UserDataManager();
	ArrayList<User> users = udm.retrieveAll();
	
	ProjectDataManager pdm = new ProjectDataManager();
	SponsorDataManager sdm = new SponsorDataManager();
	
	Project reqProj = pdm.retrieve(reqId);
	String reqProjName = reqProj.getProjName();
	System.out.println(reqProj.getTeamId());
	Team projTeam = null; 
	String projTeamName = "";
	
	try{
		projTeam = tdm.retrieve(reqProj.getTeamId());
		projTeamName = projTeam.getTeamName();
	}catch(Exception e){
		projTeamName = "No Team Yet";
	}
	
	User projSponsor = null;
	String company = "";
	String sponsorName = "";
	try{
		projSponsor = udm.retrieve(sdm.retrieve(reqProj.getSponsorId()).getUserid());
		company = sdm.retrieve(reqProj.getSponsorId()).getCoyName();
		sponsorName = projSponsor.getFullName();
	}catch(Exception e){
		sponsorName = "No Sponsor Yet";
		company = "Not Applicable";
	}
	
	String supervisor = "";
	
	try{
		supervisor = udm.retrieve(reqProj.getSupervisorId()).getFullName();
	}catch(Exception e){
		supervisor = "No Supervisor Yet";
	}

	String projManager = "";
	
	try{
		projManager = udm.retrieve(projTeam.getPmId()).getFullName();
	}catch(Exception e){
		projManager = "Not Applicable";
	}
	
	
	String reviewers = "";
	String rev1 = "";
	String rev2 = "";
	
	try{
		rev1 = udm.retrieve(reqProj.getReviewer1Id()).getFullName();;
	}catch(Exception e){
		rev1 = "";
	}
	
	try{
		rev2 = udm.retrieve(reqProj.getReviewer2Id()).getFullName();;
	}catch(Exception e){
		rev2 = "";
	}
	
	reviewers = rev1 + ", " + rev2;
	
	int creatorId = reqProj.getCreatorId();
	
	IndustryDataManager idm = new IndustryDataManager();
	Industry ind  = idm.retrieve(reqProj.getIndustry());
	
	TechnologyDataManager techdm = new TechnologyDataManager();
	ArrayList<String> tech = techdm.retrieveByProjId(reqProj.getId());
	
	%>
		<h1><%=reqProj.getProjName() %></h1>
		<div id="projectdescription">
			<font size="4" face="Courier">Project Description:</font></br>
			 <textarea id="about" rows="10" cols="75" disabled>
			 <%=reqProj.getProjDesc().trim() %>
			 </textarea>
        </div>
             </br>
            <font size="4" face="Courier">Sponsor: <%=sponsorName %></font></br>
            <font size="4" face="Courier">Team: <%=projTeamName %></font></br> 	
            <font size="4" face="Courier">Supervisor: <%=supervisor %></font></br>
            <font size="4" face="Courier">Reviewer(s): <%=reviewers %></font></br>
            <font size="4" face="Courier">Term: <%=reqProj.getTermId() %></font></br>
            <font size="4" face="Courier">Company: <%=company %></font></br>
            <font size="4" face="Courier">Industry: <%=ind.getIndustryName() %></font></br>
            <font size="4" face="Courier">Technology: 
            <%
            if(tech.size() < 1){
            	%>
            	Not specified
            	<%
            }else{
	            for(int i = 0; i< tech.size(); i++){
	            	Technology technology = techdm.retrieve(Integer.parseInt(tech.get(i)));
	            %>
	            <%=technology.getTechName() + " " %>
	            <%
	            	if((i+1)% 5 == 0){
	            	%>
	            	<br />
	            	<%	
	            	}
	            }
            }
            %>
            </font></br>
            <font size="4" face="Courier">Project Status: <%=reqProj.getStatus() %></font></br><br>
		
		<a href="#">Apply for Project</a></br></form>
		<%	
		try{
			if(username.equals(udm.retrieve(creatorId).getUsername())){
				%>
		<form method="post" action="deleteProject">
			<input type="hidden" name="projId" value="<%=reqProj.getId() %>">
		<input type=submit value="Delete">
		</form>
				<%
			
			}
		}catch(Exception e){}
		
		%>

	
	</body>

</html>