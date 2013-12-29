<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<%
UserDataManager udm = new UserDataManager();
ProjectDataManager pdm = new ProjectDataManager();

ArrayList<String> projNameList = pdm.retrieveProjName();
%>
<script type="text/javascript">
function validateForm()
{
var projectName=document.forms["createProj"]["projectname"].value;
if (projectName==null || projectName=="")
  {
  alert("Project name must be filled out");
  return false;
  }

var projectDescription = document.forms["createProj"]["projectdescription"].value;
if (projectDescription==null || projectDescription=="")
	{
		alert("Project description must be filled out");
		return false;
	}

}

function toggleTech(source) {
	  checkboxes = document.getElementsByName('technology');
	  for(var i=0, n=checkboxes.length;i<n;i++) {
	    checkboxes[i].checked = source.checked;
	  }
	}
	
function toggleSkill(source) {
	  checkboxes = document.getElementsByName('skill');
	  for(var i=0, n=checkboxes.length;i<n;i++) {
	    checkboxes[i].checked = source.checked;
	  }
	}
	
function toggleSkillOthers(source) {
	  checkboxes = document.getElementsByName('skillOthers');
	  for(var i=0, n=checkboxes.length;i<n;i++) {
	    checkboxes[i].checked = source.checked;
	  }
	}
	
</script>

<style type="text/css">
	h1{
		font-family:Impact;
		font-size:1.75em;
	}
	.container > .content {
	
	background-color: #ffffff;
	padding: 20px;
	margin: 0 -20px;
	-webkit-border-radius: 10px 10px 10px 10px;
	-moz-border-radius: 10px 10px 10px 10px;
	border-radius: 10px 10px 10px 10px;
	-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.15);
	-moz-box-shadow: 0 1px 2px rgba(0,0,0,.15);
	box-shadow: 0 1px 2px rgba(0,0,0,.15);
	}
	
.panel-title .accordion-toggle:after {
    /* symbol for "collapsed" panels */
    font-family:FontAwesome;
	font-size:16px;
    content: '\f067'; 
    float:right; 
	}
</style>
<%
Calendar now = Calendar.getInstance();
int currYear = now.get(Calendar.YEAR);
int currMth = now.get(Calendar.MONTH);
%>
<head>

    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>

    <link rel="stylesheet" href="./css/bootstrap.css"  type="text/css"/>
	
	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<%@ include file="template.jsp" %>
	<script type="text/javascript">
	$(document).ready(function(){
        var next = 1;
        $(".add-more").click(function(e){
            e.preventDefault();
            var addto = "#skillOthersNew";
            next = next + 1;
            var newIn = '<br /><br /><input id="skillOthersNew" name="skillOthersNew" type="text">';
            var newInput = $(newIn);
            $(addto).after(newInput);
        });
    });
	
	$(document).ready(function(){
        var next = 1;
        $(".add-more2").click(function(e){
            e.preventDefault();
            var addto = "#skillLangNew";
            next = next + 1;
            var newIn = '<br /><br /><input id="skillLangNew" name="skillLangNew" type="text">';
            var newInput = $(newIn);
            $(addto).after(newInput);
        });
    });
	
	$(document).ready(function(){
        var next = 1;
        $(".add-more3").click(function(e){
            e.preventDefault();
            var addto = "#techNew";
            next = next + 1;
            var newIn = '<br /><br /><input id="techNew" name="techNew" type="text">';
            var newInput = $(newIn);
            $(addto).after(newInput);
        });
    });
	</script>
	
	<%	boolean invalidAccess = false;
		if(username == null){
			session.setAttribute("message", "You need to be logged in to create a project");
			invalidAccess = true;
			response.sendRedirect("searchProject.jsp");
		}
	
	User u = udm.retrieve(username);
	String usertype = (String) session.getAttribute("type");
	
	if(usertype == null){
		usertype = "";	
	}
	boolean hasProj = false;
	
	try{
		hasProj = pdm.hasProj(u);
	}catch(Exception e){
		hasProj = false;
	}
	%> 
	</head>
<% if(!invalidAccess){ %>
	<body>
		<div id="content-container" class="container">
			<div class="content" align = "justify">
					<form class="form-horizontal" method=post action="createProject" onsubmit="return validateForm()">
						<%
						String message = (String) session.getAttribute("message"); 
						if(message == null || message.isEmpty()){
							message = "";
						}else{
					%>
						<div class="alert alert-success" align="center">
									  <button type="button" class="close" data-dismiss="alert">&times;</button>
									  <strong><%=message %></strong>
									</div>
					<%
						session.removeAttribute("message");
						}
					%>
						<!-- Form Name -->
						<legend>Create Project&nbsp;<font size="3" color="red">*Fields are mandatory</font></legend>
						<%
						if(usertype.equalsIgnoreCase("sponsor")){
							CompanyDataManager cdm = new CompanyDataManager();
							SponsorDataManager spdm = new SponsorDataManager();
							Company company = cdm.retrieve(u.getID());	
							Sponsor sponsor = spdm.retrieve(u.getID());
							
							String sponsorName = sponsor.getFullName();
							String coyName = company.getCoyName();
						%>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="projectname">Sponsor</label>
						  <div class="controls"><input type="hidden" name="sponsorId" value="<%=sponsor.getID()%>">
						    <input id="sponsor" name="sponsor" type="text" value="<%=sponsorName %>" class="input-xlarge" readonly="readonly" maxlength="50">
						    
						  </div>
						</div>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="projectname">Company</label>
						  <div class="controls"><input type="hidden" name="coyId" value="<%=company.getID()%>">
						    <input id="company" name="company" type="text" value="<%=coyName %>" class="input-xlarge" readonly="readonly" maxlength="60">
						    
						  </div>
						</div>
						<%
						}
						%>
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="projectname"><font color="red">*</font>Project Name</label>
						  <div class="controls">
						    <input id="projectname" name="projectname" type="text" onkeyup="validateProjName()" placeholder="Project Name" class="input-xlarge" maxlength="30">
						    
						  </div>
						</div>
						
						<!-- Select Basic -->
						<div class="control-group">
						  <label class="control-label" for="projectterm"><font color="red">*</font>Project Term</label>
						  <div class="controls">
						   <select id="term" name="term" class="input-xlarge">
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
						    <input type=hidden name="eligibleTerm" value="<%=currTermId+1%>" >
						  </div>
						</div>
						
						<!-- Textarea -->
						<div class="control-group">
						  <label class="control-label" for="projectdescription"><font color="red">*</font>Project Description</label>
						  <div class="controls">                     
						    <textarea id="projectdescription" name="projectdescription"></textarea>
						  </div>
						</div>
						
						<!-- Select Basic -->
						<div class="control-group">
						  <label class="control-label" for="projectstatus">Project Status</label>
						  <div class="controls">
						    <select id="projectstatus" name="projectstatus" class="input-xlarge" disabled>
						      <option>Open</option>
						      <option>Closed</option>
						      <option>Completed</option>
						    </select>
						  </div>
						</div>
						
						<!-- Select Basic -->
						<div class="control-group">
						  <label class="control-label" for="industrytype">Industry Type</label>
						  <div class="controls">
						    <select id="industrytype" name="industrytype" class="input-xlarge">
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
						  </div>
						</div>
						<!-- Select Basic -->
					
					  <div class="panel panel-default">
						    <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#collapseTwo" style="cursor:pointer;">
						      <h4 class="panel-title">
						        <a class="accordion-toggle">
						          Technology
						        </a>
						      </h4>
						    </div>
						    <div id="collapseTwo" class="panel-collapse collapse in">
						      <div class="panel-body">
							    	<%
								  TechnologyDataManager tdm = new TechnologyDataManager();
								  int numOfCat = tdm.retrieveNoOfTechCat();
								  int numOfSubCat = 0;
								  ArrayList<Technology> technologies = new ArrayList<Technology>();
								  ArrayList<Integer> subcatIdList = new ArrayList<Integer>();
								  for(int i = 1; i <= numOfCat; i++){
									  numOfSubCat = tdm.retrieveNumOfSubCat(i);
									  String catName = tdm.retrieveTechCatName(i);
									  %>
										<h2><%=catName %></h2>
										
									  <%
										subcatIdList = tdm.retrieveTechSubCatIdList(i);
										for(int k = 0; k <= subcatIdList.size(); k++){
											int subcatid = 0; 
											try{
												subcatid = subcatIdList.get(k);
											}catch(Exception e){
												subcatid = 0;
											}

											technologies = tdm.retrieveTechSubCatId(i, subcatid);
											String subcatName = tdm.retrieveTechSubCatName(subcatid);
											%>
												<table>
												<tr class="spaceunder"> 
												<h4><%=subcatName %></h4>
											<%
											if(technologies.size() > 0){
												for(int l = 0; l < technologies.size(); l++){
										  			Technology tech = technologies.get(l);
										  %>
										  <td>
										  	<input type="checkbox" name="technology" value="<%=tech.getId()%>">&nbsp;<span class="label label-default"><%=tech.getTechName() %></span>&nbsp;&nbsp;
										  </td>
										   <%
											  if((l+1) % 5 == 0){
											  %>
										  </tr><tr class="spaceunder">
										  <%
											  	}
											  }
											}else{
												%>
											<td>
											No data recorded
										   </td>	
												<%
											}
											%>
											 </tr></table> 
											<%
										 }
									 
								  }
								  %>
								  <br />
								  
								  <h3>Not in the list? Add here</h3>
								<div id="profs"> 
					                <div class="input-append">
					                    <input autocomplete="off" id="techNew" name="techNew" type="text" />
					                    <button id="b1" class="btn btn-info add-more3" type="button">+</button>
					                </div>
						            <br>
						            <small>Press + to add another field</small>
						            </div>
								</div>
						    </div>
						  </div>
					  </div>
						
						<%
						SponsorDataManager spdm = new SponsorDataManager();
						Sponsor sponsor = null;
						
						try{
							sponsor = spdm.retrieve(username);
							
							CompanyDataManager cdm = new CompanyDataManager();
							Company coy = cdm.retrieve(sponsor.getID());
						
						}catch(Exception e){}
						%>
						</br></br>
						<!-- Button -->
						<table>
						<tr>
						  <%
							if(!hasProj || usertype.equalsIgnoreCase("Sponsor")){
						  %>
						    <td class="space" align="justify">	
								<input type="submit" id="createproject" Value="Create Project" class="btn btn-success" />
							</td>
						  <%
							}else{
								%>
							You are not eligible to create a project.
								<%
							}
						  %>
						  </tr>
					 	</table>
						</form>
						</div>
						
						</div>
					<br/>
	</body>
<% } %>
</html>