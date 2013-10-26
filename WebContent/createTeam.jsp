<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<style type="text/css">
	h1{
		font-family:Impact;
		font-size:1.75em;
	}
/* 	#teamName{
		width:49.8em;
		font-size:1em;
	}
	#createTeam{
		font-size:1em;
	}
	#teamLimit{
		width:5em;
	} */

</style>

<head>

	<%@ include file="template.jsp" %>
	<%
  StudentDataManager sdm = new StudentDataManager();
  ArrayList<String> usernameList 	= sdm.retrieveUsernameList();
  
	RoleDataManager rdm = new RoleDataManager();
	ArrayList<Role> roles = rdm.retrieveAll();
	UserDataManager udm = new UserDataManager();
	boolean invalidAccess = false;
	
	boolean hasTeam = false;
		String type = "";
		try{

			if(sdm.hasTeam(udm.retrieve(username))){
				hasTeam = true;
			}
			
			type = udm.retrieve(username).getType();
			
			if(type.equalsIgnoreCase("Sponsor")){
				session.setAttribute("message", "Only students can create teams");
				invalidAccess = true;
				response.sendRedirect("searchTeam.jsp");
			}else if(type.equalsIgnoreCase("Faculty")){
				session.setAttribute("message", "Only students can create teams");
				invalidAccess = true;
				response.sendRedirect("searchTeam.jsp");
			}else if(type.equalsIgnoreCase("Admin")){
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
    	  alert("Team name must be filled out");
    	  return false;
    	  }
    	
    	var teamDesc = document.forms["createTeam"]["teamdesc"].value;
    	if (teamDesc == null || teamDesc == "")
    	  {
    	  alert("Team description must be filled out");
    	  return false;
    	  }
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
  $('#teamlimit').on('change',function(){
	    if( $(this).val()==="5"){
        $("#mem5").show();
        }
        else if($(this).val()==="6"){
        $("#mem5").show();
        $("#mem6").show();
        }else{
        	$("#mem5").hide();
        	$("#mem6").hide();
        }
	});
	</script>	
	</head>
<% if(!invalidAccess){ %>
	<body>
		<div id="content-container">
			<div id="content">
				<div class="span12 well">
					<form class="form-horizontal" action="createTeam" method="post" name="createTeam" onsubmit="return validateForm()">
						<div class="span11">
						<% String message = (String) session.getAttribute("message"); 
						if(message == null || message.isEmpty()){
							message = "";
						}else{
						%>
						<font size=-1 color="red"><i><%=message %></i></font>
						<%
						session.removeValue("message");
						} %>
						<!-- Form Name -->
						<legend>Create Team</legend>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="teamname">Team Name</label>
						  <div class="controls">
						    <input id="teamname" name="teamname" type="text" placeholder="Team Name" class="input-large" >
						    
						  </div>
						</div>
						
						<!-- Textarea -->
						<div class="control-group">
						  <label class="control-label" for="teamdesc">Team Description</label>
						  <div class="controls">                     
						    <textarea id="teamdesc" name="teamdesc"></textarea>
						  </div>
						</div>
						
						<!-- Select Basic -->
						<div class="control-group">
						  <label class="control-label">Team Limit</label>
						  <div class="controls">
						    <select id="teamlimit" name="teamlimit" class="input-large">
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
						  <label class="control-label" for="projectmanager">Project Manager</label>
						  <div class="controls">
						    <input id="projectmanager" name="projectmanager" type="text" placeholder="<%=username%>" class="input-large" disabled>
						    <input type="hidden" id="username" name="username" value="<%=username%>">
						  	<input type="hidden" name="memberRole" value="1" />
						  </div>
						</div>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="textinput">Member</label>
						  <div id="members" class="controls">
						    <input id="username2" name="username" type="text" placeholder="User Name" class="input-large">
						  </div>
						  <label class="control-label" for="selectbasic">Role</label>
						  <div class="controls">
						    <select id="memberRole" name="memberRole" class="input-large">
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
						  <label class="control-label" for="textinput">Member</label>
						  <div class="controls">
						    <input id="username3" name="username" type="text" placeholder="User Name" class="input-large">
						  </div>
						  <label class="control-label" for="selectbasic">Role</label>
						  <div class="controls">
						    <select id="memberRole" name="memberRole" class="input-large">
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
						  <label class="control-label" for="textinput">Member</label>
						  <div class="controls">
						    <input id="username4" name="username" type="text" placeholder="User Name" class="input-large">
						  </div>
						  <label class="control-label" for="selectbasic">Role</label>
						  <div class="controls">
						    <select id="memberRole" name="memberRole" class="input-large">
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
						  <label class="control-label" for="textinput">Member</label>
						  <div class="controls">
						    <input id="username5" name="username" type="text" placeholder="User Name" class="input-large">
						  </div>
						  <label class="control-label" for="selectbasic">Role</label>
						  <div class="controls">
						    <select id="memberRole" name="memberRole" class="input-large">
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
						  <label class="control-label" for="textinput">Member</label>
						  <div class="controls">
						    <input id="username6" name="username" type="text" placeholder="User Name" class="input-large">
						  </div>
						  <label class="control-label" for="selectbasic">Role</label>
						  <div class="controls">
						    <select id="memberRole" name="memberRole" class="input-large">
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
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
		          Preferred Industry
		        </a>
		      </h4>
		    </div>
		    <div id="collapseOne" class="panel-collapse collapse">
		      <div class="panel-body">
		 			<table>
						<tr class="spaceunder">
						     <td><input type="checkbox" onclick="toggleInd(this)" />&nbsp;<span class="label label-default">Select All</span></td>
					     </tr>
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
		 	  </div>
		    </div>
		  </div>
		  <div class="panel panel-default">
			    <div class="panel-heading">
			      <h4 class="panel-title">
			        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
			          Preferred Technology
			        </a>
			      </h4>
			    </div>
			    <div id="collapseTwo" class="panel-collapse collapse">
			      <div class="panel-body">
				    	<table>
							<tr class="spaceunder">
							     <td><input type="checkbox" onclick="toggleTech(this)" />&nbsp;<span class="label label-default">Select All</span></td>
						     </tr>
					    	<tr class="spaceunder">
								<%
								  TechnologyDataManager tdm = new TechnologyDataManager();
								  ArrayList<Technology> technologies = tdm.retrieveAll();
								 
								  for(int i = 0; i < technologies.size(); i++){
									  Technology tech = technologies.get(i);
									  %><td>
									  <input type="checkbox" name="technology" value="<%=tech.getId()%>">&nbsp;<span class="label label-default"><%=tech.getTechName() %></span>&nbsp;&nbsp;
									  </td><td></td>
									   <%
									  if((i+1) % 3 == 0){
									  %>
								  </tr><tr class="spaceunder">
								  <%
									  }
								  }
								  %>
						  	</tr>
						</table> 
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
						
						
						</div>
						</form>
					
					<br/>
				</div>
			</div>
		</div>
	</body>
<% } %>
</html>