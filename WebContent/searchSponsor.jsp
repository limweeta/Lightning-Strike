<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
	<head>
	<%@include file="template.jsp"%>
	<%
	SponsorDataManager spdm = new SponsorDataManager();
	CompanyDataManager cdm =  new CompanyDataManager();
	TeamDataManager tdm =  new TeamDataManager();
	ProjectDataManager pdm =  new ProjectDataManager();
	ArrayList<Sponsor> sponsors = spdm.retrieveAll();
	%>
	
	<%
	Calendar now = Calendar.getInstance();
	int currYear = now.get(Calendar.YEAR);
	int currMth = now.get(Calendar.MONTH);
	%>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link rel="shortcut icon" type="image/ico" href="http://www.sprymedia.co.uk/media/images/favicon.ico">
		
		<title>Search Sponsor</title>
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
			<div class="full_width big">
				<h3>Search Sponsor</h3>
			</div>
				<a href="#advSearchModal" style="float:right;" data-toggle="modal">Advanced Search</a>
			<% String message = (String) session.getAttribute("message"); 
						if(message == null || message.isEmpty()){
							message = "";
						}else{
						%>
						<font size=-1 color="red"><i><%=message %></i></font>
						<%
						session.removeValue("message");
						} %>
			
			<div id="demo">
<div id="example_wrapper" class="dataTables_wrapper" role="grid"><table cellspacing="0" border="0" class="display dataTable" id="example" aria-describedby="example_info">
	<thead>
		<tr role="row">
			<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" aria-sort="ascending" style="width: 128px;">Username</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 177px;">Full Name</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Email</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Company</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Projects</th>
			<th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 170px;">Team</th>	
		</tr>
	</thead>
	
<tbody role="alert" aria-live="polite" aria-relevant="all">
<%
int count = 0;
Company coy = null;
String coyName = "";
ArrayList<Project> sponsorProjects = new ArrayList<Project>();
for(int i = 0; i < sponsors.size(); i++){
	Sponsor sponsor = sponsors.get(i);
	sponsorProjects = pdm.retrieveAllFromSponsor(sponsor);
	coy = cdm.retrieve(sponsor.getCoyId());
	try{
		coyName = coy.getCoyName();
	}catch(Exception e){
		coyName = "N/A";
	}
	String name = sponsor.getUsername();
	String fullname = sponsor.getFullName();
	String email = sponsor.getEmail();
	count++;
	
%>
	<tr class="">
			<td class="sorting_1"><a href="userProfile.jsp?id=<%=sponsor.getID()%>"><%=name %></td>
			<td class="center"><%=fullname %></td>
			<td class="center"><a href="mailto:<%=email%>" target="_top"><%=email %></a></td>
			<td class="center"><%=coyName %></td>
			<td align=left valign="top">
				<%
				
				if(sponsorProjects.size() < 1){
					out.println("No projects yet");
				}else{
					for(int j = 0; j < sponsorProjects.size(); j++){
						Project proj = sponsorProjects.get(j);
						String projName = proj.getProjName();
						%>
						<%=j+1 %>.<a href="projectProfile.jsp?id=<%=proj.getId()%>"><%=projName %></a><br />
						<%
					}
				}
				%>
			</td>
		<td align=left valign="top">
				<%
				if(sponsorProjects.size() < 1){
					out.println("N/A");
				}else{
					for(int j = 0; j < sponsorProjects.size(); j++){
						Project proj = sponsorProjects.get(j);
						Team team = tdm.retrieve(proj.getTeamId());
						String teamName = "";
						int teamId = 0;
						try{
							teamName = team.getTeamName();
							teamId = team.getId();
						}catch(Exception e){
							teamName = "N/A";
						}
						%>
						<%=j+1 %>.
						<%if(team != null){ %>
							<a href="teamProfile.jsp?id=<%=teamId%>">
						<%} %>
						<%=teamName %></a><br />
						<%
					}
				}
				%>
				
			</td> 
	</tr>
<%
}
%>
		</tbody></table>
		<!-- DO NOT TOUCH BETWEEN THE COMMENTS (DANIAL) -->
			</div>
			<div class="spacer"></div>
			
			
			
			</div>
			
			<div id="advSearchModal" class="modal hide fade">
					    <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					        <h2>Advanced Search</h2>
					    </div>
					       <form action="" method="post" accept-charset="UTF-8">
					    <div class="modal-body">
					     <label class="control-label" for="term">Term</label>
					    <select id="term" name="term" class="input-large">
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
			     	 <label class="control-label" for="industrytype">Industry</label>
					    <select id="ind" name="ind" class="input-large">
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
						   <label class="control-label" for="orgType">Organization Type</label>
					    <select id="orgType" name="orgType" class="input-large">
								 <%
								  OrganizationDataManager odm = new OrganizationDataManager();
								  ArrayList<Organization> orgs = odm.retrieveAll();
								  
								  for(int i = 0; i < orgs.size(); i++){
									  Organization org = orgs.get(i);
									  %>
									  <option value="<%=org.getId()%>"><%=org.getOrgType() %></option>
									  <%
								  }
								  %>
						  </select>
						  <label class="control-label" for="others">Others</label>
						  <input type="text" name="others" id="others" class="input-large">
						</div>
					    <div class="modal-footer">
					        <input class="btn btn-primary" style="clear: left;  height: 32px; font-size: 13px;" type="submit" name="search" value="Search" />
					    </div>
					   	 </form>
			</div>
			
			</body></html>
		