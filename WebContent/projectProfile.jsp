<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>

<style type="text/css">
/* 	h1{
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
	}*/
	textarea{
		resize: none;
		font-size: 1em;
	} 
</style>
<head>
	<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
    <script src="js/jquery.autocomplete.js"></script> 
    	<%@ include file="profileTemplate.jsp" %> 
<%--     
	<% 	
		String fullName = (String) session.getAttribute("fullname");
		String username = (String) session.getAttribute("username");
		
	%>
		
	<div id="welcome">Welcome, <%=fullName %></div>
		
		<%@include file="navbar.jsp"%>
	    <div id="profilepic"><a href="#"><img src="http://db.tt/Cfe7G4Z5" width="50" height="50" /></a></div>
	    <div id="profilelogout"><a href="./index.jsp">Logout</a></div>
	    <div id="notifications"><a href="#"><img src="http://db.tt/YtzsJnpm" width="30" height="20" /></a></div> --%>

	</head>
	<body>
	<%
	int reqId = Integer.parseInt(request.getParameter("id"));
	
	if(reqId == 0){
		response.sendRedirect("searchProjects.jsp");
	}else{
	
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
	int projTeamId = 0;
	
	try{
		projTeam = tdm.retrieve(reqProj.getTeamId());
		projTeamName = projTeam.getTeamName();
		projTeamId = projTeam.getId();
	}catch(Exception e){
		projTeamName = "No Team Yet";
	}
	
	User projSponsor = null;
	String company = "";
	String sponsorName = "";
	int sponsorId = 0;
	try{
		projSponsor = udm.retrieve(sdm.retrieve(reqProj.getSponsorId()).getUserid());
		company = sdm.retrieve(reqProj.getSponsorId()).getCoyName();
		sponsorName = projSponsor.getFullName();
		sponsorId = projSponsor.getID();
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
			 <textarea id="about" rows="10" cols="75" disabled><%=reqProj.getProjDesc().trim() %>
			 </textarea>
        </div>
             </br>
            <font size="4" face="Courier">Sponsor: <%=sponsorName %></font></br></br>
            <font size="4" face="Courier">Team: <%=projTeamName %></font></br></br>
            <font size="4" face="Courier">Supervisor: </font>
            <%
	            if(supervisor.equalsIgnoreCase("No Supervisor Yet")){ //TO-DO:check for admin status
	            	%>
	            	<form method=post action="/assignSupervisor">
	            	<input type=hidden name="teamId" value="<%=projTeam.getId()%>">
	            	<input type=hidden name="projId" value="<%=reqId%>">
	            	<input type="text" name="assignSup">
	            	<input type="submit" value="Assign">
	            	</form>
	            	<%
	            }else{
	            	out.print(supervisor);
	            }
            %>
            </br></br>
            <font size="4" face="Courier">Reviewer(s): 
            <%
            if(projTeam != null){
	            if(rev1.isEmpty() && rev2.isEmpty()){ //TO-DO: check for admin status
	            	%>
	            	<form method=post action="/assignReviewer">
	            	<input type=hidden name="teamId" value="<%=projTeam.getId()%>">
	            	<input type=hidden name="projId" value="<%=reqId%>">
	            	<input type="text" name="assignRev1">
	            	<input type="text" name="assignRev2">
	            	<input type="submit" value="Assign">
	            	</form>
	            	<%
	            }else if(!rev1.isEmpty() && rev2.isEmpty()){
	            	out.print(rev1);
	            	%>
	            	<form method=post action="/assignReviewer">
	            	<input type=hidden name="teamId" value="<%=projTeam.getId()%>">
	            	<input type=hidden name="projId" value="<%=reqId%>">
	            	<input type="text" name="assignRev1">
	            	<input type="submit" value="Assign">
	            	</form>
	            	<%
	            }else if(rev1.isEmpty() && !rev2.isEmpty()){
	            	out.print(rev2);
	            	%>
	            	<form method=post action="/assignReviewer">
	            	<input type=hidden name="teamId" value="<%=projTeam.getId()%>">
	            	<input type=hidden name="projId" value="<%=reqId%>">
	            	<input type="text" name="assignRev1">
	            	<input type="submit" value="Assign">
	            	</form>
	            	<%
	            }else{
	            	out.println(rev1 + ", " + rev2);
	            }
            }
            %>
         	</font></br></br>
            <font size="4" face="Courier">Term: <%=reqProj.getTermId() %></font></br></br>
            <font size="4" face="Courier">Company: <%=company %></font></br></br>
            <font size="4" face="Courier">Industry: <%=ind.getIndustryName() %></font></br></br>
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
	            <%=technology.getTechName() + " | " %>
	            <%
	            	if((i+1)% 5 == 0){
	            	%>
	            	</br>
	            	<%	
	            	}
	            }
            }
            %>
            </font></br></br>
            <font size="4" face="Courier">Project Status: <%=reqProj.getStatus() %></font></br> <br>
		
		<%if(username != null){ %>
		<a href="#">Apply for Project</a></br></form>
		<%
		}
		try{
			if(username.equals(udm.retrieve(creatorId).getUsername())){
				%>
     <font size="4" face="Courier">Project Status: <%=reqProj.getStatus() %></font></br> <br>
					
			<form method="post" action="updateProject">
				<input type="hidden" name="projId" value="<%=reqProj.getId() %>">
			<input type=submit value="Update">
			</form>	
					
			<form method="post" action="deleteProject">
				<input type="hidden" name="projId" value="<%=reqProj.getId() %>">
			<input type=submit value="Delete">
			</form>
				<%
			}
		}catch(Exception e){}
	}
		%>

	
	</body>

</html>