<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
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
					
					%>
					<tr>
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