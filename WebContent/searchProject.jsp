<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>

<style type="text/css">

</style>

	<head>
	<%@include file="template.jsp"%>
	<%
	OrganizationDataManager odm = new OrganizationDataManager();
	
	ProjectDataManager pdm = new ProjectDataManager();
	ArrayList<Project> projects = null;
	
	projects = (ArrayList<Project>) request.getAttribute("projectList");
	
	if(projects == null){
		projects = pdm.retrieveCurrent();
	}
	
	SponsorDataManager sdm = new SponsorDataManager();
	ArrayList<Sponsor> sponsors = sdm.retrieveAll();
	
	CompanyDataManager cdm = new CompanyDataManager();
	
	String usertype = (String) session.getAttribute("type");
	
	if(usertype == null){
		usertype = "";
	}
	%>
	<%
	Calendar now = Calendar.getInstance();
	int currYear = now.get(Calendar.YEAR);
	int currMth = now.get(Calendar.MONTH);
	%>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link rel="shortcut icon" type="image/ico" href="http://www.sprymedia.co.uk/media/images/favicon.ico">
		
		<title>Search Project</title>
		<style type="text/css" title="currentStyle">
			@import "./DataTables-1.9.4/media/css/demo_page.css";
			@import "./DataTables-1.9.4/media/css/demo_table.css";
			@import "./DataTables-1.9.4/examples/examples_support/jquery.tooltip.css";
			/* @import "./css/style.css";
			@import "./css/searchstyle.css"; */
		</style>
		
		<script type="text/javascript" charset="utf-8" src="./DataTables-1.9.4/media/js/jquery.js"></script>
		<script type="text/javascript" charset="utf-8" src="./DataTables-1.9.4/media/js/jquery.dataTables.js"></script>
		<script type="text/javascript" language="javascript" src="./jquery-ui-1.10.3.custom/development-bundle/ui/jquery.ui.tooltip.js"></script>
		<script type="text/javascript" language="javascript" src="./jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
		
		<script type="text/javascript" charset="utf-8">
			$(document).ready(function() {
				
				$('#example').dataTable();
			} );
		</script>

	</head>
	<body id="dt_example">
		
		<div id="container">
			<% String message = (String) session.getAttribute("message"); 
			if(message == null || message.isEmpty()){
				message = "";
			}else{
		%>
<%-- 			<font size=-1 color="red"><i><%=message %></i></font> --%>
			<div class="alert alert-success" align="center">
			  <button type="button" class="close" data-dismiss="alert">&times;</button>
			  <strong><%=message %></strong>
			</div>
			
			<%
			session.removeValue("message");
			} %>
			<div class="full_width big">
				<h3>Search Projects </h3>
				<% if(usertype.equalsIgnoreCase("Student")){ %>
				<p style="float:right;"><form action="matchProj" method="post"><input type=submit value="Match my team to a project!" class="btn btn-primary"/></form></p> 
				<% } %>
			</div>
			<a href="#advSearchModal" style="float:right;" data-toggle="modal">Advanced Search</a>
		<% 
			String errmessage = (String) session.getAttribute("message"); 
			if(errmessage == null || errmessage.isEmpty()){
				errmessage = "";
			}else{
		%>
			<font size=-1 color="red"><i><%=errmessage %></i></font>
		<%
			session.removeValue("message");
			} 
		%>
			<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
		<%
			String reqId = request.getParameter("id");
		
		if(reqId == null || reqId.isEmpty()){
		%>
	
			<div id="demo">
<div id="example_wrapper" class="dataTables_wrapper" role="grid"><table cellpadding="0" cellspacing="0" border="0" class="display dataTable" id="example" aria-describedby="example_info">
	<thead>
		<tr role="row">
			
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Projected Term</th>
			<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-sort="ascending" style="width: 128px;">Project Name</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 177px;">Project Description</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Sponsor</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Team</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Organization</th>
		</tr>
	</thead>
	
	<tfoot>
		<tr>
			<th rowspan="1" colspan="1">Projected Term</th>
			<th rowspan="1" colspan="1">Project Name</th>
			<th rowspan="1" colspan="1">Project Description</th>
			<th rowspan="1" colspan="1">Sponsor</th>
			<th rowspan="1" colspan="1">Team</th>
			<th rowspan="1" colspan="1">Organization</th>
		</tr>
	</tfoot>
<tbody role="alert" aria-live="polite" aria-relevant="all">
	<%
		int count = 0;
		for(int i = 0; i < projects.size(); i++){
			Project proj = projects.get(i);
			int id = proj.getId();
			String name = proj.getProjName();
			String desc = "";
			
			try{
				desc = proj.getProjDesc();
				
				if(desc.length() > 20){
					desc = desc.substring(0, 50) + "...";
				}
				
			}catch(Exception e){
				desc = "None";
			}
			
			int sponsorid = proj.getSponsorId();
			int term = proj.getIntendedTermId();
			
			TermDataManager tdm = new TermDataManager();
			String strTerm = tdm.retrieve(term).getAcadYear() + " T" + tdm.retrieve(term).getSem();
			
			count++;
			String rowclass = "";
			
			TeamDataManager teamdm = new TeamDataManager();
			String teamName = "";
			int teamid = 0;		
			try{
				teamName = teamdm.retrieve(proj.getTeamId()).getTeamName();
				teamid =  teamdm.retrieve(proj.getTeamId()).getId();
			}catch(Exception e){
				teamName = "No Team Yet";
			}

			String organization = "";
			String sponsor = "";
			
			int testSponsorId = 0 ;
			String testCoyName = ""; 
			
			if(sponsorid == 0){
				sponsor = "Not Available";
			}else{
				SponsorDataManager spdm = new SponsorDataManager();
				
				try{
					testSponsorId = proj.getSponsorId();
					testCoyName = cdm.retrieve(proj.getSponsorId()).getCoyName();
					sponsor = cdm.retrieve(proj.getSponsorId()).getCoyName();
					organization = odm.retrieve(cdm.retrieve(sponsorid).getOrgType()).getOrgType();
					
				}catch(Exception e){
					sponsor = "Not Available";
					organization = "Not Available";
				}
				
			}
			
			if(count % 2 == 0){
				rowclass = "gradeA even";
			}else{
				rowclass = "gradeA odd";
			}
		    System.out.println(testSponsorId);
		    System.out.println(testCoyName);
	%>
	<tr class="">
			<td class="sorting_1"><%=strTerm %></td>
			<td class="center"><a style="color:#000000" href="projectProfile.jsp?id=<%=id %>"><%=name %></a></td>
			<td class="center "><%=desc %></td>
			<td class="center "><a href="userProfile.jsp?id=<%=sponsorid%>"><%=sponsor %></a></td>
			<td class="center "><a href="teamProfile.jsp?id=<%=teamid%>"><%=teamName %></a></td>
			<td class="center "><%=sponsor %></td>
	</tr>
	<%
	}
	%>
		</tbody></table>
<%
}%>
		<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
			</div>
			
			<div class="spacer"></div>
			
			
			
			</div>
			
			<div id="advSearchModal" class="modal hide fade">
					    <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					        <h2>Advanced Search</h2>
					    </div>
					       <form action="searchProject" method="post" accept-charset="UTF-8">
					    <div class="modal-body">
					     <label class="control-label" for="projectterm">Project Term</label>
					    <select id="term" name="term" class="input-large">
					    <option value=0>Any</option>
						    	  <%
						    	  TermDataManager termdm = new TermDataManager();
						    	  ArrayList<Term> terms  = termdm.retrieveFromNextSem();
								  int currTermId = termdm.retrieveTermId(currYear, currMth);
								  
						    	  for(int i = 0; i < terms.size(); i++){
						    		Term showTerm = terms.get(i); 
						    		if((currTermId + 1) == showTerm.getId()){	
						    	%>
						    	  <option value="<%=showTerm.getId()%>" selected><%=showTerm.getAcadYear() + " T" + showTerm.getSem() %></option>
						    	 <%
						    		}else{
				    			%>
						    	  <option value="<%=showTerm.getId()%>"><%=showTerm.getAcadYear() + " T" + showTerm.getSem() %></option>
						    	 <%	
						    		}
						    	  }
						    	 %>
						    </select> 
			     	 <label class="control-label" for="industrytype">Project Industry</label>
					    <select id="ind" name="ind" class="input-large">
					    <option value=0>Any</option>
								 <%
								  IndustryDataManager idm = new IndustryDataManager();
								  ArrayList<Industry> industries = idm.retrieveAll();
								  
								  for(int i = 0; i < industries.size(); i++){
									  Industry ind = industries.get(i);
									  %>
									  <option value="<%=ind.getIndustryId()%>"><%=ind.getIndustryName() %></option>
									  <%
								  }
								  %>
						  </select>
						   <label class="control-label" for="tech">Project Technology</label>
					    <select id="tech" name="tech" class="input-large">
					    <option value=0>Any</option>
								 <%
											  TechnologyDataManager tdm = new TechnologyDataManager();
											  ArrayList<Technology> technologies = tdm.retrieveAll();
											 
											  for(int i = 0; i < technologies.size(); i++){
												  Technology tech = technologies.get(i);
												  %>
												  <option value="<%=tech.getId()%>"><%=tech.getTechName() %></option>
												  <% }
											  %>
						  </select>
						  <label class="control-label" for="skills">Project Skills</label>
						  <select id="skills" name="skills" class="input-large">
						  <option value=0>Any</option>
						 		 <%
										  SkillDataManager skdm = new SkillDataManager();
										  ArrayList<Skill> skills = skdm.retrieveAll();
										  
										  for(int i = 0; i < skills.size(); i++){
											  Skill skill = skills.get(i);
											  %>
											  <option value="<%=skill.getId()%>"><%=skill.getSkillName() %></option>
										<%
										  }
									  %>
						  </select>
						  <hr />
						  <label class="control-label" for="skills">Keyword Search</label>
						  <select id="keywordType" name="keywordType" class="input-large">
						  	<option>Industry</option>
						 	<option>Skill</option>
						 	<option>Technology</option>
						  </select>
						  
						  <input type=text name="keyword" placeholder="Keyword">
						  
						</div>
					    <div class="modal-footer">
					        <input class="btn btn-primary" style="clear: left;  height: 32px; font-size: 13px;" type="submit" name="search" value="Search" />
					    </div>
					   	 </form>
			</div>
			
			</body>
			</html>
		