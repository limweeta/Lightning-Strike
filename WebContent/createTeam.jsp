<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
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
<head>

	<%@ include file="template.jsp" %>
	<%

	Calendar now = Calendar.getInstance();
	int currYear = now.get(Calendar.YEAR);
	int currMth = now.get(Calendar.MONTH);
	
  	StudentDataManager sdm = new StudentDataManager();
  	ArrayList<String> usernameList 	= sdm.retrieveUsernameList();
  
	RoleDataManager rdm = new RoleDataManager();
	ArrayList<Role> roles = rdm.retrieveAll();
	UserDataManager udm = new UserDataManager();
	boolean invalidAccess = false;
	
	boolean hasTeam = false;
		String usertype = "";
		try{

			if(sdm.hasTeam(udm.retrieve(username))){
				hasTeam = true;
			}
			
			usertype = udm.retrieve(username).getType();
			
			if(usertype.equalsIgnoreCase("Sponsor")){
				session.setAttribute("message", "Only students can create teams");
				invalidAccess = true;
				response.sendRedirect("searchTeam.jsp");
			}else if(usertype.equalsIgnoreCase("Supervisor")){
				session.setAttribute("message", "Only students can create teams");
				invalidAccess = true;
				response.sendRedirect("searchTeam.jsp");
			}else if(usertype.equalsIgnoreCase("Admin")){
				session.setAttribute("message", "Only students can create teams");
				invalidAccess = true;
				response.sendRedirect("searchTeam.jsp");
			}
			
		}catch(Exception e){
			session.setAttribute("message", "You need to be logged in to create a team");
			invalidAccess = true;
			response.sendRedirect("searchTeam.jsp");
		}
	%>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="./jquery-ui-1.10.3.custom/js/jquery-1.9.1.js"></script> 
 <script src="./jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
  
    <script type="text/javascript">
    
    function alterTeamLimit() {
    	var selected = $('#teamlimit').val();
    	if(selected==="5"){
    		$('#mem5').show();
    		$('#mem6').hide();
    	}else if(selected==="6"){
    		$('#mem5').show();
    		$('#mem6').show();
    	}else if(selected==="4"){
    		$('#mem5').hide();
    		$('#mem6').hide();
    	}
    }

    $(document).ready(function(){
        var next = 1;
        $(".add-more").click(function(e){
            e.preventDefault();
            var addto = "#technologyNew";
            next = next + 1;
            var newIn = '<br /><br /><input id="technologyNew" name="technologyNew" type="text">';
            var newInput = $(newIn);
            $(addto).after(newInput);
        });
    });

    $(document).ready(function(){
        var next = 1;
        $(".add-more2").click(function(e){
            e.preventDefault();
            var addto = "#industryNew";
            next = next + 1;
            var newIn = '<br /><br /><input id="industryNew" name="industryNew" type="text">';
            var newInput = $(newIn);
            $(addto).after(newInput);
        });
    });

    
    $(function() {
        var studentNameList = [
                <%
                for(int i = 0; i < usernameList.size(); i++){
                	out.println("\""+usernameList.get(i)+"\",");
                }
                %>
                               ];
        
        $( "#username2" ).autocomplete({
          source: studentNameList
        });
        
        $( "#username3" ).autocomplete({
            source: studentNameList
          });
        
        $( "#username4" ).autocomplete({
            source: studentNameList
          });
        
        $( "#username5" ).autocomplete({
            source: studentNameList
          });
        
        $( "#username6" ).autocomplete({
            source: studentNameList
          });
        
      });
    function toggleTech(source) {
  	  checkboxes = document.getElementsByName('technology');
  	  for(var i=0, n=checkboxes.length;i<n;i++) {
  	    checkboxes[i].checked = source.checked;
  	  }
  	}
  	
    function toggleInd(source) {
		  checkboxes = document.getElementsByName('industry');
		  for(var i=0, n=checkboxes.length;i<n;i++) {
		    checkboxes[i].checked = source.checked;
		  }
		}
    function validateForm()
    {
    	var teamName = document.forms["createTeam"]["teamname"].value;
    	if (teamName == null || teamName == "")
    	  {
    	  alert("Team name must be filled out");f
    	  return false;
    	  }
    	
    	/* var teamDesc = document.forms["createTeam"]["teamdesc"].value;
    	if (teamDesc == null || teamDesc == "")
    	  {
    	  alert("Team description must be filled out");
    	  return false;
    	  } */
    }
    
    /* function showHide(){
        var option=document.getElementById('teamlimit').value;

        if(option=="5"){
                document.getElementById('mem5').style="display:show";
        }
            else if(option=="6"){
            	document.getElementById('mem5').style="display:show";
            	document.getElementById('mem6').style="display:show";
            }

    }  */

    
    
    
	</script>	
	</head>
<% if(!invalidAccess){ %>
	<body>
		<div class="container" id="content-container">
			<div class="content">
					<form class="form-horizontal" action="createTeam" method="post" name="createTeam" onsubmit="return validateForm()">
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
						<legend>Create Team</legend>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="teamname">Team Name</label>
						  <div class="controls">
						    <input id="teamname" name="teamname" type="text" placeholder="Team Name" class="input-large" maxlength="30" >
						    
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="projectterm">Project Term</label>
						  <div class="controls">
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
						    <input type=hidden name="eligibleTerm" value="<%=currTermId+1%>" >
						  </div>
						</div>
						
						<!-- Select Basic -->
						<div class="control-group">
						  <label class="control-label">Team Limit</label>
						  <div class="controls">
						    <select id="teamlimit" name="teamlimit" class="input-large" onChange="alterTeamLimit()">
						      <option value="4" selected>4</option>
						      <option value="5">5</option>
						      <option value="6">6</option>
						    </select>
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="projectmanager">Team Members</label>
						</div>
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="projectmanager" style="font-weight:normal;">Project Manager</label>
						  <div class="controls">
						    <input id="projectmanager" name="projectmanager" type="text" placeholder="<%=username%>" class="input-large" disabled>
						    <input type="hidden" id="username" name="username" value="<%=username%>">
						  	<input type="hidden" name="memberRole" value="1" />
						  </div>
						</div>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="textinput" style="font-weight:normal;">Member</label>
						  <div id="members" class="controls">
						    <input id="username2" name="username" type="text" placeholder="User Name" class="input-large" maxlength="25">
						<!--   </div>
						  <label class="control-label" for="selectbasic" style="font-weight:normal;">Role</label>
						  <div class="controls"> -->
						    <select id="memberRole" name="memberRole" class="input-large">
						    <option value="#" selected>Role</option>
						     <%
						     for(int i = 0; i < roles.size(); i++){
						    	 Role role = roles.get(i);
						    	 if(role.getId() != 1){
						    	 %>
						    	 <option value="<%=role.getId() %>"><%=role.getRoleName() %></option>
						    	 <%
						    	 }
						     }
						     %>
						    </select>
						  </div>
						</div>
						<!-- Text input-->
						<div id="mem3" class="control-group">
						  <label class="control-label" for="textinput" style="font-weight:normal;">Member</label>
						  <div class="controls">
						    <input id="username3" name="username" type="text" placeholder="User Name" class="input-large" maxlength="25">
						<!--   </div>
						  <label class="control-label" for="selectbasic" style="font-weight:normal;">Role</label>
						  <div class="controls"> -->
						    <select id="memberRole" name="memberRole" class="input-large">
						    <option value="#" selected>Role</option>
						       <%
						     for(int i = 0; i < roles.size(); i++){
						    	 Role role = roles.get(i);
						    	 if(role.getId() != 1){
						    	 %>
						    	 <option value="<%=role.getId() %>"><%=role.getRoleName() %></option>
						    	 <% 
						    	 }
						     }
						     %>
						    </select>
						  </div>
						</div>
						<!-- Text input-->
						<div id="mem4" class="control-group">
						  <label class="control-label" for="textinput" style="font-weight:normal;">Member</label>
						  <div class="controls">
						    <input id="username4" name="username" type="text" placeholder="User Name" class="input-large" maxlength="25">
						 <!--  </div>
						  <label class="control-label" for="selectbasic" style="font-weight:normal;">Role</label>
						  <div class="controls"> -->
						    <select id="memberRole" name="memberRole" class="input-large">
						    <option value="#" selected>Role</option>
						       <%
						     for(int i = 0; i < roles.size(); i++){
						    	 Role role = roles.get(i);
						    	 if(role.getId() != 1){
						    	 %>
						    	 <option value="<%=role.getId() %>"><%=role.getRoleName() %></option>
						    	 <% 
						    	 }
						     }
						     %>
						    </select>
						  </div>
						</div>
						<!-- Text input-->
						<div id="mem5" class="control-group" style="display: none">
						  <label class="control-label" for="textinput" style="font-weight:normal;">Member</label>
						  <div class="controls">
						    <input id="username5" name="username" type="text" placeholder="User Name" class="input-large" maxlength="25">
						 <!--  </div>
						  <label class="control-label" for="selectbasic" style="font-weight:normal;">Role</label>
						  <div class="controls"> -->
						    <select id="memberRole" name="memberRole" class="input-large">
						    <option value="#" selected>Role</option>
						     <%
						     for(int i = 0; i < roles.size(); i++){
						    	 Role role = roles.get(i);
						    	 if(role.getId() != 1){
						    	 %>
						    	 <option value="<%=role.getId() %>"><%=role.getRoleName() %></option>
						    	 <% 
						    	 }
						     }
						     %>  
						    </select>
						  </div>
						</div>
						
						<!-- Text input-->
						<div id="mem6" class="control-group" style="display:none">
						  <label class="control-label" for="textinput" style="font-weight:normal;">Member</label>
						  <div class="controls">
						    <input id="username6" name="username" type="text" placeholder="User Name" class="input-large" maxlength="25">
						 <!--  </div>
						  <label class="control-label" for="selectbasic" style="font-weight:normal;">Role</label>
						  <div class="controls"> -->
						    <select id="memberRole" name="memberRole" class="input-large">
						    <option value="#" selected>Role</option>
						      <%
						     for(int i = 0; i < roles.size(); i++){
						    	 Role role = roles.get(i);
						    	 if(role.getId() != 1){
						    	 %>
						    	 <option value="<%=role.getId() %>"><%=role.getRoleName() %></option>
						    	 <% 
						    	 }
						     }	
						     %>
						    </select>
						  </div>
						</div>
						
		<div class="panel-group" id="accordion">
		  <div class="panel panel-default">
		    <div class="panel-heading"  data-toggle="collapse" data-parent="#accordion" data-target="#collapseOne" style="cursor:pointer;">
		      <h4 class="panel-title">
		        <a class="accordion-toggle">
		          Preferred Industry
		        </a>
		      </h4>
		    </div>
		    <div id="collapseOne" class="panel-collapse collapse in">
		      <div class="panel-body">
		 			<table>
						<!-- <tr class="spaceunder">
						     <td><input type="checkbox" onclick="toggleInd(this)" />&nbsp;<span class="label label-default">Select All</span></td>
					     </tr> -->
				    	<tr class="spaceunder">
							<%
								  IndustryDataManager idm = new IndustryDataManager();
								  ArrayList<Industry> industries = idm.retrieveAll();
								 
								  for(int i = 0; i < industries.size(); i++){
									  Industry ind = industries.get(i);
									  %><td>
									  <input type="checkbox" name="industry" value="<%=ind.getIndustryId()%>">&nbsp;<span class="label label-default"><%=ind.getIndustryName() %></span>&nbsp;&nbsp;
									  </td><td></td>
									  <%
									  if((i+1) % 3 == 0){
										  %></tr><tr class="spaceunder">
								<%
									  }
								  }
								  %>
					  	</tr>
					</table>
					<br />
					<h2>Not in the list? Add here</h2>
					<div id="profs"> 
                <div class="input-append">
                    <input autocomplete="off" id="industryNew" name="industryNew" type="text" />
                    <button id="b1" class="btn btn-info add-more2" type="button">+</button>
                </div>
	            <br>
	            <small>Press + to add another field</small>
	            </div>
					
		 	  </div>
		    </div>
		  </div>
		  <div class="panel panel-default">
			    <div class="panel-heading">
			      <h4 class="panel-title" data-toggle="collapse" data-parent="#accordion" data-target="#collapseTwo" style="cursor:pointer;">
			        <a class="accordion-toggle" >
			          Preferred Technology
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
								  
								  <h2>Not in the list? Add here</h2>
			<div id="profs"> 
                <div class="input-append">
                    <input autocomplete="off" id="technologyNew" name="technologyNew" type="text" />
                    <button id="b1" class="btn btn-info add-more" type="button">+</button>
                </div>
            <br>
            <small>Press + to add another field</small>
            </div>
          
					</div>
			    </div>
			  </div>
		  </div>
						</br></br>	
						<!-- Button -->
						<table>
						  	<%
								if(hasTeam){
							%>
							<tr>
							<td class = "space" align = "justify">
						    <input type="submit" id="createteam" value="Create Team" class="btn btn-success" disabled="disabled">
						    </td>
						    <font size=-1 color="red"><i>You already have a team</i></font>
						    <%
								}else{
									%> 
									<td class = "space" align = "justify">
									<input type="submit" id="createteam" value="Create Team" class="btn btn-success">
									</td>
									<%
								}
						    %>
						    </tr>
						</table> 
						
						
						
						</form>
					<br/>
			</div>
		</div>
	</body>
<% } %>
</html>