<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>

<head>
<%@include file="template.jsp"%>
<script src="script.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  	<script src="./jquery-ui-1.10.3.custom/js/jquery-1.9.1.js"></script>
  	<script src="./jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
 <style type="text/css">
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
		String usertype 				= (String) session.getAttribute("type");
		StudentDataManager sdm 			= new StudentDataManager();
		ArrayList<String> majorList 	= sdm.retrieveAllMajors();
	%>	

  
    <script type="text/javascript">
    function toggleSkill(source) {
  	  checkboxes = document.getElementsByName('skills');
  	  for(var i=0, n=checkboxes.length;i<n;i++) {
  	    checkboxes[i].checked = source.checked;
  	  }
  	}
    
    $(function() {
        var majorList = [
                <%
                for(int i = 0; i < majorList.size(); i++){
                	out.println("\""+majorList.get(i)+"\",");
                }
                %>
                               ];
        
        $( "#secondMajor" ).autocomplete({
            source: majorList
          });
	</script>	
	</head>

	<body>
		<div class="container" id="content-container">
			<div class="content">
					<form class="form-horizontal" action="updateProfile" method="post" onsubmit="return validateForm()" name="details">
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
						<legend>Details</legend>
						
						<!-- Text input-->
						<div class="control-group">
						  <label class="control-label" for="username">Username</label>
						  <div class="controls">
						    <input id="username" name="username" type="text" value="<%=username%>" class="input-large" maxlength="30" >
						    
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="fullName">Full Name</label>
						  <div class="controls">
						    <input id="fullname" name="fullname" type="text" value="<%=fullName%>" class="input-large" maxlength="30" >
						    
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="contactno">Contact Number</label>
						  <div class="controls">
						    <input id="contactno" name="contactno" type="text" placeholder="Contact Number" class="input-large" maxlength="30" >
						    
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="email">Email</label>
						  <div class="controls">
						    <input id="email" name="email" type="text" value="<%=username + "@smu.edu.sg" %>" class="input-large" maxlength="30" >
						    
						  </div>
						</div>
						
						<div class="control-group">
						  <label class="control-label" for="type">Type</label>
						  <div class="controls">
						    <input id="type" name="type" type="text" value="<%=type %>" class="input-large" maxlength="30" >
						    
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="secondMajor">Second Major</label>
						  <div class="controls">
				<select id="secondmaj" name="secondmajor" class="input-large">
				<%
		    	  SecondMajorDataManager secondMajordm = new SecondMajorDataManager();
			    	ArrayList<SecondMajor> secondMajors  = secondMajordm.retrieveAll();
					  
			    	  for(int i = 0; i < secondMajors.size(); i++){
			    		SecondMajor secMaj = secondMajors.get(i);
			    		
					%>
					<option value="<%=secMaj.getSecondMajor()%>"><%=secMaj.getSecondMajor()%></option>
					    <%
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
							          Skills
							        </a>
							      </h4>
							    </div>
							    <div id="collapseOne" class="panel-collapse collapse in">
							      <div class="panel-body">
							 			<table>
											
									    	<tr class="spaceunder">
												<%
												SkillDataManager skdm = new SkillDataManager();
												ArrayList<Skill> skills = skdm.retrieveAll();
													 
												for(int i = 0; i < skills.size(); i++){
													Skill skill = skills.get(i);
													%><td>
														  <input type="checkbox" name="skills" value="<%=skill.getId()%>">&nbsp;<span class="label label-default"><%=skill.getSkillName() %></span>&nbsp;&nbsp;
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
						</div>
						</br>
						<div class="control-group">
						  <label class="control-label" for="prefRole">Preferred Role</label>
						  <div class="controls">
						   <select id="prefRole" name="prefRole" class="input-large">
						    	  <%
								RoleDataManager roledm = new RoleDataManager();
								ArrayList<Role> roles = roledm.retrieveAll();
								
								for(int i = 0; i < roles.size(); i++){
									Role role = roles.get(i);
									%>
									<option value="<%=role.getId()%>"><%=role.getRoleName() %></option>
									<%
								}
								%>
						    </select> 
						  </div>
						</div>
						<input type="submit" id="updateProfile" name="updateProfile" value="Update Profile" class="btn btn-success" />
						</form>
					<br/>
			</div>
		</div>
	</body>
</html>