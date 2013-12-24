<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<html>
<style type="text/css">
	@import "./css/template.css";
	
	tr.odd{
		background-color: #E2E4FF;
	}
	
	tr.even{
		background-color: white;
	}
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
				
			<%}else if(type.equalsIgnoreCase("guest")){%>
			
				<%@ include file="navbarguest.jsp" %>
			
		<%} %>
	</br></br>
  </head>
<body>
<%
SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
Date date2 = new Date();
String currDate = sdf.format(date2);

TermDataManager termdm = new TermDataManager();
Term currTerm = null;
Term nextEligibleTerm = null;
try{
	currTerm = termdm.retrieve(termdm.retrieveCurrTerm(currDate));
	session.setAttribute("currTermId", termdm.retrieveCurrTerm(currDate));
}catch(Exception e){
	e.printStackTrace();
}

String message = (String) session.getAttribute("message"); 
if(message == null || message.isEmpty()){
	message = "";
}else{
%>
<%-- 			<font size=-1 color="red"><i><%=message %></i></font> --%>
<div class="alert alert-success">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong><%=message %></strong>
</div>

<%
session.removeValue("message");
} %>
<%
if(currTerm != null){
%>
<%="We are currently in " + currTerm.getAcadYear() + " T" + currTerm.getSem() %>
<%
}
%>
<div class="container">
		<%if(!type.equalsIgnoreCase("admin")||type.equalsIgnoreCase("course coordinator")){ %>
		<div class="panel panel-primary">
		<div class="panel-heading">
			<h7 class="panel-title">Getting Started</h7>
		</div>
		<div class="panel-body">
		<table>
		<%if(type.equals("Student")){ %>
				<th>Welcome to the IS480 Matching Site!</th>
				<tr>
					<td>Step 1: You need to have a team. There are several ways of doing so. You can create a team, join a team or match yourself to a team. (All under the Team tab)
					</td>
				</tr>
				<tr>
					<td>Step 2: You need to have a project. There are several ways of doing so. You can create a project (self-proposed), apply for a project or match yourself to a project. (All under the Project tab)
					</td>
				</tr>
				<tr>
					<td>You can check out more details about the teams, projects, sponsors and supervisors by using the available Searches. For help, you can click <a href="#">here</a>.
					</td>
				</tr>
		<%}else if(type.equals("Sponsor")){ %>
				<th>Welcome to the IS480 Matching Site!</th>
				
				<tr>
					<td>Step 1: You need to have a project. You can do so by going to Create Project under the Project tab.
					</td>
				</tr>
				
				<tr>
					<td>Step 2: You can invite teams to take on your projects by going to the Search Team page. If the teams are interested to take on the projects, you will receive their requests to take on your projects. You can then choose whether to accept or reject their request.
					</td>
				</tr>
				
				<tr>
					<td>You can check out more details about the teams and projects by using the available Searches. For help, you can click <a href="#">here</a>.
					</td>
				</tr>
		<%}else if(type.equals("Supervisor")){ %>
			
				<th>Welcome to the IS480 Matching Site!</th>
				<tr>
					<td>You can check out the teams that you are supervising by clicking on My Teams under the Team tab.
					</td>
				</tr>
				<tr>
					<td>You can check out more details about the teams and projects by using the available Searches. For help, you can click <a href="#">here</a>.
					</td>
				</tr>
			
		<%} %>
			</table>
			</div>
		</div>
		<%} %>
		<div class="panel panel-primary">
		<div class="panel-heading">
			<h7 class="panel-title">Announcements</h7>
		</div>
		<div class="panel-body">
		
			<table>
				<th>Number</th>
				<th>Date/Time</th>
				<th>Announcement</th>
				<%
				AnnouncementDataManager adm = new AnnouncementDataManager();
				ArrayList<Announcement> announcements = adm.retrieveAll();
				int count=0;
				for(int i=0; i < announcements.size(); i++){
					Announcement ann = announcements.get(i);
					String fullTimestamp = ann.getTimestamp();
					String date = fullTimestamp.substring(0, 10);
					String year = date.substring(0, 4);
					String month = date.substring(5, 7);
					String day = date.substring(8, 10);
					String datefmt = day + "/" + month + "/" + year;
					String time = fullTimestamp.substring(11, 16);
					
					String timestampStr = datefmt + " " + time + " ";
					
					String rowclass="";
					count++;
					if(count % 2 == 0){
						rowclass = "even";
					}else{
						rowclass = "odd";
					}
					
					%>
					<tr class=<%=rowclass %>>
						<td align="center"><%=i+1 %></td>
						<td align="center" style="padding: 5px; padding-right:20px"><%=timestampStr %></td>
						<td align="center"><%=ann.getAnnouncement() %></td>
					</tr>
					<%
				}
				%>
				
			</table>
			
		</div>
	</div>
		<% if(type.equalsIgnoreCase("admin")){ %>
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h7 class="panel-title">Add Announcements</h7>
		</div>
		<div class="panel-body">
			<form action="addAnn" method="post">
			<textarea class = "announcement" name="announcement" rows="3" cols="1500"></textarea><br />
			<input type="submit" value="Add Announcement" class="btn btn-success">
			</form>
		</div>
		</div>
		</div>
	<% } %>
</body>
</html>