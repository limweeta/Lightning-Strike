<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<html>
<script type="text/javascript">
function validateForm()
{
var fullName=document.forms["details"]["fullName"].value;
if (fullName==null || fullName=="")
  {
  alert("Full name must be filled out");
  return false;
  }

var contact = document.forms["details"]["contact"].value;
if(isNaN(contact) || contact.length != 8){
	alert("Not a valid contact number");
	  return false;
}

var email=document.forms["details"]["email"].value;
var atpos=email.indexOf("@");
var dotpos=email.lastIndexOf(".");
if (atpos<1 || dotpos<atpos+2 || dotpos+2>=email.length)
  {
  alert("Not a valid e-mail address");
  return false;
  }
}

function toggleTech(source) {
	  checkboxes = document.getElementsByName('skills');
	  for(var i=0, n=checkboxes.length;i<n;i++) {
	    checkboxes[i].checked = source.checked;
	  }
	}
</script>
<head>
<%
	String type = (String) session.getAttribute("type");
%>
<%@include file="template.jsp" %>
</head>
<body>
	<div id="content-container" class="shadow">
		<div id="content">
			<div class="updateProfile">
				<form action="updateProfile" method="post" onsubmit="return validateForm()" name="details">
					<font size="4" face="Courier">Username:</font> <input type="text"
						id="username" name="username" value="<%=username%>" readonly="readonly"><br />
					<font size="4" face="Courier">Full Name:</font> <input
						id="fullName" type="text" name="fullname"></br>
					</br> <font size="4" face="Courier">Contact Number:</font> <input
						id="contactno" type="text" name="contactno"></br> <font
						size="4" face="Courier">Email:</font> <input id="email"
						type="text" name="email"></br> </br> <font size="4" face="Courier">Type:</font>
						<input type=text value="<%=type %>" name="type" readonly="readonly" />
					
					<br />
					<font size="4" face="Courier">Second Major:</font> 
					<input type="text" id="secondMajor" id="secondMajor" name="secondMajor"><br>
						Skills: 
					<input type=checkbox onclick="toggle(this)" />Select All<br />
						<%
						SkillDataManager skdm = new SkillDataManager();
						ArrayList<Skill> skills = skdm.retrieveAll();
						
						for(int i = 0; i < skills.size(); i++){
							Skill skill = skills.get(i);
							%>
	<input type="checkbox" name="skills" id="skills" value="<%=skill.getId()%>">&nbsp;<%=skill.getSkillName() %>
							<%
							if((i+1) % 3 == 0){
								%>
								<br />
								<%
							}
						}
						%>
					
					<br />
					<font size="4" face="Courier">Preferred Role:</font> 
					<select name="prefRole" id="prefRole">
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
					
					</br> <input type="submit" id="updateProfile" name="updateProfile"
						value="Update Profile" />
				</form>
				<br />
			</div>
		</div>
	</div>
</body>
</html>

